//===-- RISCVFrameLowering.cpp - RISCV Frame Information ------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the RISCV implementation of TargetFrameLowering class.
//
//===----------------------------------------------------------------------===//

#include "RISCVFrameLowering.h"
#include "RISCVSubtarget.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/RegisterScavenging.h"

using namespace llvm;

bool RISCVFrameLowering::hasFP(const MachineFunction &MF) const { return true; }

// Determines the size of the frame and maximum call frame size.
void RISCVFrameLowering::determineFrameLayout(MachineFunction &MF) const {
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const RISCVRegisterInfo *RI = STI.getRegisterInfo();

  // Get the number of bytes to allocate from the FrameInfo.
  unsigned FrameSize = MFI.getStackSize();

  // Get the alignment.
  unsigned StackAlign = RI->needsStackRealignment(MF) ? MFI.getMaxAlignment()
                                                      : getStackAlignment();

  // Get the maximum call frame size of all the calls.
  unsigned MaxCallFrameSize = MFI.getMaxCallFrameSize();

  // If we have dynamic alloca then MaxCallFrameSize needs to be aligned so
  // that allocations will be aligned.
  if (MFI.hasVarSizedObjects())
    MaxCallFrameSize = alignTo(MaxCallFrameSize, StackAlign);

  // Update maximum call frame size.
  MFI.setMaxCallFrameSize(MaxCallFrameSize);

  // Include call frame size in total.
  if (!(hasReservedCallFrame(MF) && MFI.adjustsStack()))
    FrameSize += MaxCallFrameSize;

  // Make sure the frame is aligned.
  FrameSize = alignTo(FrameSize, StackAlign);

  // Update frame info.
  MFI.setStackSize(FrameSize);
}

void RISCVFrameLowering::emitPrologue(MachineFunction &MF,
                                      MachineBasicBlock &MBB) const {
  assert(&MF.front() == &MBB && "Shrink-wrapping not yet supported");

  if (!hasFP(MF)) {
    llvm_unreachable(
        "emitPrologue doesn't support framepointer-less functions");
  }

  MachineFrameInfo &MFI = MF.getFrameInfo();
  const RISCVInstrInfo *TII = STI.getInstrInfo();
  MachineBasicBlock::iterator MBBI = MBB.begin();

  unsigned FPReg = RISCV::X8_32;
  unsigned SPReg = RISCV::X2_32;

  // Debug location must be unknown since the first debug location is used
  // to determine the end of the prologue.
  DebugLoc DL;

  // Determine the correct frame layout
  determineFrameLayout(MF);

  // FIXME (note copied from Lanai): This appears to be overallocating.  Needs
  // investigation. Get the number of bytes to allocate from the FrameInfo.
  uint64_t StackSize = MFI.getStackSize();

  // Early exit if there is no need to allocate on the stack
  if (StackSize == 0 && !MFI.adjustsStack())
    return;

  // Allocate space on the stack if necessary
  if (StackSize != 0) {
    if (isInt<12>(StackSize)) {
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), SPReg)
        .addReg(SPReg)
        .addImm(-StackSize)
        .setMIFlag(MachineInstr::FrameSetup);
    } else {
      auto &MRI = MF.getRegInfo();
      unsigned Reg = MRI.createVirtualRegister(&RISCV::GPRRegClass);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::LUI), Reg)
        .addImm(StackSize & 0xFFFFF000)
        .setMIFlag(MachineInstr::FrameSetup);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), Reg)
        .addReg(Reg)
        .addImm(StackSize & 0xFFF)
        .setMIFlag(MachineInstr::FrameSetup);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::SUB), SPReg)
        .addReg(SPReg)
        .addReg(Reg)
        .setMIFlag(MachineInstr::FrameSetup);
    }
  }

  // The frame pointer is callee-saved, and code has been generated for us to
  // save it to the stack. We need to skip over the storing of callee-saved
  // registers as the frame pointer must be modified after it has been saved
  // to the stack, not before.
  MachineBasicBlock::iterator End = MBB.end();
  while (MBBI != End && MBBI->getFlag(MachineInstr::FrameSetup)) {
    ++MBBI;
  }

  // Generate new FP
  if (isInt<12>(StackSize)) {
    BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), FPReg)
      .addReg(SPReg)
      .addImm(StackSize)
      .setMIFlag(MachineInstr::FrameSetup);
  } else {
    // FIXME: Reg needs to be loaded twice since we don't
    // know if x5 was modified when saving fp to the stack.
    auto &MRI = MF.getRegInfo();
    unsigned Reg = MRI.createVirtualRegister(&RISCV::GPRRegClass);
    BuildMI(MBB, MBBI, DL, TII->get(RISCV::LUI), Reg)
      .addImm(StackSize & 0xFFFFF000)
      .setMIFlag(MachineInstr::FrameSetup);
    BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), Reg)
      .addReg(Reg)
      .addImm(StackSize & 0xFFF)
      .setMIFlag(MachineInstr::FrameSetup);
    BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADD), FPReg)
      .addReg(SPReg)
      .addReg(Reg)
      .setMIFlag(MachineInstr::FrameSetup);
  }
}

void RISCVFrameLowering::emitEpilogue(MachineFunction &MF,
                                      MachineBasicBlock &MBB) const {
  if (!hasFP(MF)) {
    llvm_unreachable(
        "emitEpilogue doesn't support framepointer-less functions");
  }

  MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
  const RISCVInstrInfo *TII = STI.getInstrInfo();
  const RISCVRegisterInfo *RI = STI.getRegisterInfo();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  DebugLoc DL = MBBI->getDebugLoc();
  unsigned FPReg = RISCV::X8_32;
  unsigned SPReg = RISCV::X2_32;

  // Skip to before the restores of callee-saved registers
  MachineBasicBlock::iterator Begin = MBB.begin();
  MachineBasicBlock::iterator LastFrameDestroy = MBBI;
  while (LastFrameDestroy != Begin) {
    if (!std::prev(LastFrameDestroy)->getFlag(MachineInstr::FrameDestroy))
      break;
    --LastFrameDestroy;
  }

  uint64_t StackSize = MFI.getStackSize();

  // Restore the stack pointer using the value of the frame pointer. Only
  // necessary if the stack pointer was modified, meaning the stack size is
  // unknown.
  if (RI->needsStackRealignment(MF) || MFI.hasVarSizedObjects()) {
    BuildMI(MBB, LastFrameDestroy, DL, TII->get(RISCV::ADDI), SPReg)
        .addReg(FPReg)
        .addImm(-StackSize)
        .setMIFlag(MachineInstr::FrameDestroy);
  }

  // Deallocate stack
  if (StackSize != 0) {
    if (isInt<12>(StackSize)) {
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), SPReg)
        .addReg(SPReg)
        .addImm(StackSize)
        .setMIFlag(MachineInstr::FrameDestroy);
    } else {
      auto &MRI = MF.getRegInfo();
      unsigned Reg = MRI.createVirtualRegister(&RISCV::GPRRegClass);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::LUI), Reg)
        .addImm(StackSize & 0xFFFFF000)
        .setMIFlag(MachineInstr::FrameDestroy);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADDI), Reg)
        .addReg(Reg)
        .addImm(StackSize & 0xFFF)
        .setMIFlag(MachineInstr::FrameDestroy);
      BuildMI(MBB, MBBI, DL, TII->get(RISCV::ADD), SPReg)
        .addReg(SPReg)
        .addReg(Reg)
        .setMIFlag(MachineInstr::FrameDestroy);
    }
  }
}

void RISCVFrameLowering::determineCalleeSaves(MachineFunction &MF,
                                              BitVector &SavedRegs,
                                              RegScavenger *RS) const {
  TargetFrameLowering::determineCalleeSaves(MF, SavedRegs, RS);
  SavedRegs.set(RISCV::X8_32);

  MachineFrameInfo &MFI = MF.getFrameInfo();
  // The CSR spill slots have not been allocated yet, so estimateStackSize
  // won't include them.
  uint64_t MaxSPOffset = MFI.estimateStackSize(MF) + 8 * SavedRegs.count();

  // Allocate emergency spill slot when necessary.
  // TODO: Don't allocate when a spill register is available.
  if (!isInt<12>(MaxSPOffset)) {
    const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
    const TargetRegisterClass &RC = RISCV::GPRRegClass;
    unsigned Size = TRI->getSpillSize(RC);
    unsigned Align = TRI->getSpillAlignment(RC);
    int FI = MFI.CreateSpillStackObject(Size, Align);
    RS->addScavengingFrameIndex(FI);
  }

  return;
}
