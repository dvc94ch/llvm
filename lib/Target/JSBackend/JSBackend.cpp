//===-- JSBackend.cpp - Library for converting LLVM code to JS       -----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements compiling of LLVM IR, which is assumed to have been
// simplified using the PNaCl passes, i64 legalization, and other necessary
// transformations, into JavaScript in asm.js format, suitable for passing
// to emscripten for final processing.
//
//===----------------------------------------------------------------------===//

#include "JSTargetMachine.h"
#include "MCTargetDesc/JSBackendMCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include "llvm/Target/TargetLowering.h"

using namespace llvm;

extern "C" void LLVMInitializeJSBackendTarget() {
  // Register the target.
  RegisterTargetMachine<JSTargetMachine> X(TheJSBackendTarget);
}

//===----------------------------------------------------------------------===//
//                       External Interface declaration
//===----------------------------------------------------------------------===//

bool JSTargetMachine::addPassesToEmitFile(
      PassManagerBase &PM, raw_pwrite_stream &Out, CodeGenFileType FileType,
      bool DisableVerify, AnalysisID StartBefore,
      AnalysisID StartAfter, AnalysisID StopBefore, AnalysisID StopAfter) {
  return false;
}
