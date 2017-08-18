//===-- RISCVISelDAGToDAG.cpp - A dag to dag inst selector for RISCV ------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the RISCV target.
//
//===----------------------------------------------------------------------===//

#include "RISCV.h"
#include "MCTargetDesc/RISCVMCTargetDesc.h"
#include "RISCVTargetMachine.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/IR/Function.h" // To access function attributes.
#include "llvm/Support/Debug.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "riscv-isel"

// RISCV-specific code to select RISCV machine instructions for
// SelectionDAG operations.
namespace {
class RISCVDAGToDAGISel final : public SelectionDAGISel {
public:
  explicit RISCVDAGToDAGISel(RISCVTargetMachine &TargetMachine)
      : SelectionDAGISel(TargetMachine) {}

  StringRef getPassName() const override {
    return "RISCV DAG->DAG Pattern Instruction Selection";
  }

  void Select(SDNode *Node) override;

// Include the pieces autogenerated from the target description.
#include "RISCVGenDAGISel.inc"
};
}

void RISCVDAGToDAGISel::Select(SDNode *Node) {
  unsigned Opcode = Node->getOpcode();

  // Dump information about the Node being selected.
  DEBUG(errs() << "Selecting: "; Node->dump(CurDAG); errs() << "\n");

  // If we have a custom node, we have already selected
  if (Node->isMachineOpcode()) {
    DEBUG(errs() << "== "; Node->dump(CurDAG); errs() << "\n");
    Node->setNodeId(-1);
    return;
  }

  // Instruction Selection not handled by the auto-generated tablegen selection
  // should be handled here.
  EVT VT = Node->getValueType(0);
  switch (Opcode) {
  case ISD::Constant:
    if (VT == MVT::i32) {
      ConstantSDNode *ConstNode = cast<ConstantSDNode>(Node);
      // Materialize zero constants as copies from X0. This allows the coalescer
      // to propagate these into other instructions.
      if (ConstNode->isNullValue()) {
        SDValue New = CurDAG->getCopyFromReg(
            CurDAG->getEntryNode(), SDLoc(Node), RISCV::X0_32, MVT::i32);
        return ReplaceNode(Node, New.getNode());
      }
    }
    break;
  default:
    break;
  }

  // Select the default instruction.
  SelectCode(Node);
}

// This pass converts a legalized DAG into a RISCV-specific DAG, ready
// for instruction scheduling.
FunctionPass *llvm::createRISCVISelDag(RISCVTargetMachine &TM) {
  return new RISCVDAGToDAGISel(TM);
}
