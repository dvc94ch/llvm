//===-- RISCVInstrInfo.cpp - RISCV Instruction Information ------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the RISCV implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#include "RISCVInstrInfo.h"
#include "RISCV.h"
#include "RISCVSubtarget.h"
#include "RISCVTargetMachine.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

#define GET_INSTRINFO_CTOR_DTOR
#include "RISCVGenInstrInfo.inc"

using namespace llvm;

RISCVInstrInfo::RISCVInstrInfo(const RISCVSubtarget &STI)
  : RISCVGenInstrInfo(RISCV::ADJCALLSTACKDOWN, RISCV::ADJCALLSTACKUP),
    RI(), Subtarget(STI) {}

void RISCVInstrInfo::copyPhysReg(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator Position,
                                 const DebugLoc &DL,
                                 unsigned DestinationRegister,
                                 unsigned SourceRegister,
                                 bool KillSource) const {
  if (!RISCV::GPRRegClass.contains(DestinationRegister, SourceRegister)) {
    llvm_unreachable("Impossible reg-to-reg copy");
  }

  BuildMI(MBB, Position, DL, get(RISCV::ADDI), DestinationRegister)
      .addReg(SourceRegister, getKillRegState(KillSource))
      .addImm(0);
}

void RISCVInstrInfo::storeRegToStackSlot(MachineBasicBlock &MBB,
                                         MachineBasicBlock::iterator I,
                                         unsigned SrcReg, bool IsKill, int FI,
                                         const TargetRegisterClass *RC,
                                         const TargetRegisterInfo *TRI) const {
  DebugLoc DL;
  if (I != MBB.end())
    DL = I->getDebugLoc();

  if (RC == &RISCV::GPRRegClass)
    BuildMI(MBB, I, DL, get(RISCV::SW_FI))
        .addReg(SrcReg, getKillRegState(IsKill))
        .addFrameIndex(FI)
        .addImm(0);
  else
    llvm_unreachable("Can't store this register to stack slot");
}

void RISCVInstrInfo::loadRegFromStackSlot(MachineBasicBlock &MBB,
                                          MachineBasicBlock::iterator I,
                                          unsigned DestReg, int FI,
                                          const TargetRegisterClass *RC,
                                          const TargetRegisterInfo *TRI) const {
  DebugLoc DL;
  if (I != MBB.end())
    DL = I->getDebugLoc();

  if (RC == &RISCV::GPRRegClass)
    BuildMI(MBB, I, DL, get(RISCV::LW_FI), DestReg).addFrameIndex(FI).addImm(0);
  else
    llvm_unreachable("Can't load this register from stack slot");
}

bool RISCVInstrInfo::analyzeBranch(MachineBasicBlock &MBB,
                                   MachineBasicBlock *&TrueBlock,
                                   MachineBasicBlock *&FalseBlock,
                                   SmallVectorImpl<MachineOperand> &Condition,
                                   bool AllowModify) const {
  // Iterator to current instruction being considered.
  MachineBasicBlock::iterator Instruction = MBB.end();

  // Start from the bottom of the block and work up, examining the
  // terminator instructions.
  while (Instruction != MBB.begin()) {
    --Instruction;

    // Skip over debug values.
    if (Instruction->isDebugValue())
      continue;

    // Working from the bottom, when we see a non-terminator
    // instruction, we're done.
    if (!Instruction->isTerminator())
      break;

    // Handle unconditional branches.
    if (Instruction->isUnconditionalBranch()) {
      if (!AllowModify) {
        TrueBlock = Instruction->getOperand(1).getMBB();
        continue;
      }

      // If the block has any instructions after a branch, delete them.
      while (std::next(Instruction) != MBB.end()) {
        std::next(Instruction)->eraseFromParent();
      }

      Condition.clear();
      FalseBlock = nullptr;

      // Delete the jump if it's equivalent to a fall-through.
      if (MBB.isLayoutSuccessor(Instruction->getOperand(1).getMBB())) {
        TrueBlock = nullptr;
        Instruction->eraseFromParent();
        Instruction = MBB.end();
        continue;
      }

      // TrueBlock is used to indicate the unconditional destination.
      TrueBlock = Instruction->getOperand(1).getMBB();
      continue;
    }

    // Handle conditional branches.
    if (Instruction->isConditionalBranch()) {
      unsigned Opcode = Instruction->getOpcode();

      // Multiple conditional branches are not handled here so only proceed if
      // there are no conditions enqueued.
      if (Condition.empty()) {
        // TrueBlock is the target of the previously seen unconditional branch.
        FalseBlock = TrueBlock;
        TrueBlock = Instruction->getOperand(2).getMBB();
        Condition.push_back(MachineOperand::CreateImm(Opcode));
        Condition.push_back(Instruction->getOperand(0));
        Condition.push_back(Instruction->getOperand(1));
        continue;
      }
    }

    return true;
  }

  // Return false indicating branch successfully analyzed.
  return false;
}


unsigned RISCVInstrInfo::removeBranch(MachineBasicBlock &MBB,
                                      int *BytesRemoved) const {
  assert(!BytesRemoved && "code size not handled");

  MachineBasicBlock::iterator Instruction = MBB.end();
  unsigned Count = 0;

  while (Instruction != MBB.begin()) {
    --Instruction;
    if (Instruction->isDebugValue())
      continue;

    if (!Instruction->isBranch())
      break;

    // Remove the branch.
    Instruction->eraseFromParent();
    Instruction = MBB.end();
    ++Count;
  }

  return Count;
}

unsigned RISCVInstrInfo::insertBranch(MachineBasicBlock &MBB,
                                      MachineBasicBlock *TrueBlock,
                                      MachineBasicBlock *FalseBlock,
                                      ArrayRef<MachineOperand> Condition,
                                      const DebugLoc &DL,
                                      int *BytesAdded) const {
  // Shouldn't be a fall through.
  assert(TrueBlock && "insertBranch must not be told to insert a fallthrough");
  assert(!BytesAdded && "code size not handled");

  // Unconditional branch.
  if (Condition.empty()) {
    BuildMI(&MBB, DL, get(RISCV::PseudoBR)).addMBB(TrueBlock);
    return 1;
  }

  // Conditional branch.
  BuildMI(&MBB, DL, get(Condition[0].getImm()))
    .addReg(Condition[1].getReg())
    .addReg(Condition[2].getReg())
    .addMBB(TrueBlock);

  if (FalseBlock) {
    // Two way conditional branch. (if Condition then TrueBlock else FalseBlock)
    BuildMI(&MBB, DL, get(RISCV::PseudoBR)).addMBB(FalseBlock);
    return 2;
  }

  // One way Conditional branch. (if Condition then TrueBlock)
  return 1;
}

bool RISCVInstrInfo::reverseBranchCondition(SmallVectorImpl<MachineOperand>
                                            &Condition) const {
  if (Condition.empty())
    return true;

  unsigned Opcode;
  switch (Condition[0].getImm()) {
  case RISCV::BEQ:
    Opcode = RISCV::BNE;
    break;
  case RISCV::BNE:
    Opcode = RISCV::BEQ;
    break;
  case RISCV::BLT:
    Opcode = RISCV::BGE;
    break;
  case RISCV::BGE:
    Opcode = RISCV::BLT;
    break;
  case RISCV::BLTU:
    Opcode = RISCV::BGEU;
    break;
  case RISCV::BGEU:
    Opcode = RISCV::BLTU;
    break;
  default:
    return true;
  }

  Condition[0].setImm(Opcode);
  return false;
}
