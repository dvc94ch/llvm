; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

define void @jt(i32 %in, i32* %out) {
; RV32I-LABEL: jt:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a2, zero, 2
; RV32I-NEXT:    blt a2, a0, .LBB0_4
; RV32I-NEXT:  # %bb.1: # %entry
; RV32I-NEXT:    addi a3, zero, 1
; RV32I-NEXT:    beq a0, a3, .LBB0_8
; RV32I-NEXT:  # %bb.2: # %entry
; RV32I-NEXT:    bne a0, a2, .LBB0_10
; RV32I-NEXT:  # %bb.3: # %bb2
; RV32I-NEXT:    addi a0, zero, 3
; RV32I-NEXT:    sw a0, 0(a1)
; RV32I-NEXT:    jal zero, .LBB0_10
; RV32I-NEXT:  .LBB0_4: # %entry
; RV32I-NEXT:    addi a3, zero, 3
; RV32I-NEXT:    beq a0, a3, .LBB0_9
; RV32I-NEXT:  # %bb.5: # %entry
; RV32I-NEXT:    addi a2, zero, 4
; RV32I-NEXT:    bne a0, a2, .LBB0_10
; RV32I-NEXT:  # %bb.6: # %bb4
; RV32I-NEXT:    addi a0, zero, 1
; RV32I-NEXT:    sw a0, 0(a1)
; RV32I-NEXT:    jal zero, .LBB0_10
; RV32I-NEXT:  .LBB0_8: # %bb1
; RV32I-NEXT:    addi a0, zero, 4
; RV32I-NEXT:    sw a0, 0(a1)
; RV32I-NEXT:    jal zero, .LBB0_10
; RV32I-NEXT:  .LBB0_9: # %bb3
; RV32I-NEXT:    sw a2, 0(a1)
; RV32I-NEXT:  .LBB0_10: # %exit
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
entry:
  switch i32 %in, label %exit [
    i32 1, label %bb1
    i32 2, label %bb2
    i32 3, label %bb3
    i32 4, label %bb4
  ]
bb1:
  store i32 4, i32* %out
  br label %exit
bb2:
  store i32 3, i32* %out
  br label %exit
bb3:
  store i32 2, i32* %out
  br label %exit
bb4:
  store i32 1, i32* %out
  br label %exit
exit:
  ret void
}
