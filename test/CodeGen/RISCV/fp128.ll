; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s

@x = local_unnamed_addr global fp128 0xL00000000000000007FFF000000000000, align 16
@y = local_unnamed_addr global fp128 0xL00000000000000007FFF000000000000, align 16

define i32 @foo() {
; CHECK-LABEL: foo:
; TODO: add proper tests for the outpu
  %1 = load fp128, fp128* @x, align 16
  %2 = load fp128, fp128* @y, align 16
  %cmp = fcmp une fp128 %1, %2
  %3 = zext i1 %cmp to i32
  ret i32 %3
}
