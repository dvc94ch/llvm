; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)
declare i8 @llvm.cttz.i8(i8, i1)
declare i16 @llvm.cttz.i16(i16, i1)
declare i32 @llvm.cttz.i32(i32, i1)
declare i64 @llvm.cttz.i64(i64, i1)
declare i32 @llvm.ctlz.i32(i32, i1)
declare i32 @llvm.ctpop.i32(i32)

define i16 @test_bswap_i16(i16 %a) nounwind {
; RV32I-LABEL: test_bswap_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    lui a1, 4080
; RV32I-NEXT:    addi a1, a1, 0
; RV32I-NEXT:    slli a2, a0, 8
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 16
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i16 @llvm.bswap.i16(i16 %a)
  ret i16 %tmp
}

define i32 @test_bswap_i32(i32 %a) nounwind {
; RV32I-LABEL: test_bswap_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -256
; RV32I-NEXT:    srli a2, a0, 8
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    srli a2, a0, 24
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    lui a2, 4080
; RV32I-NEXT:    addi a2, a2, 0
; RV32I-NEXT:    slli a3, a0, 8
; RV32I-NEXT:    and a2, a3, a2
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i32 @llvm.bswap.i32(i32 %a)
  ret i32 %tmp
}

define i64 @test_bswap_i64(i64 %a) nounwind {
; RV32I-LABEL: test_bswap_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a3, a2, -256
; RV32I-NEXT:    srli a2, a1, 8
; RV32I-NEXT:    and a2, a2, a3
; RV32I-NEXT:    srli a4, a1, 24
; RV32I-NEXT:    or a2, a2, a4
; RV32I-NEXT:    lui a4, 4080
; RV32I-NEXT:    addi a4, a4, 0
; RV32I-NEXT:    slli a5, a1, 8
; RV32I-NEXT:    and a5, a5, a4
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    or a1, a1, a5
; RV32I-NEXT:    or a2, a1, a2
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    and a1, a1, a3
; RV32I-NEXT:    srli a3, a0, 24
; RV32I-NEXT:    or a1, a1, a3
; RV32I-NEXT:    slli a3, a0, 8
; RV32I-NEXT:    and a3, a3, a4
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    or a0, a0, a3
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    addi a0, a2, 0
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i64 @llvm.bswap.i64(i64 %a)
  ret i64 %tmp
}

define i8 @test_cttz_i8(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    andi a1, a0, 255
; RV32I-NEXT:    beq a1, zero, .LBB3_1
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    jal zero, .LBB3_3
; RV32I-NEXT:  .LBB3_1:
; RV32I-NEXT:    addi a0, zero, 8
; RV32I-NEXT:  .LBB3_3: # %cond.end
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i8 @llvm.cttz.i8(i8 %a, i1 false)
  ret i8 %tmp
}

define i16 @test_cttz_i16(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a1, a0, a1
; RV32I-NEXT:    beq a1, zero, .LBB4_1
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    jal zero, .LBB4_3
; RV32I-NEXT:  .LBB4_1:
; RV32I-NEXT:    addi a0, zero, 16
; RV32I-NEXT:  .LBB4_3: # %cond.end
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i16 @llvm.cttz.i16(i16 %a, i1 false)
  ret i16 %tmp
}

define i32 @test_cttz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    beq a0, zero, .LBB5_1
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    jal zero, .LBB5_3
; RV32I-NEXT:  .LBB5_1:
; RV32I-NEXT:    addi a0, zero, 32
; RV32I-NEXT:  .LBB5_3: # %cond.end
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i32 @llvm.cttz.i32(i32 %a, i1 false)
  ret i32 %tmp
}

define i32 @test_ctlz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_ctlz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    beq a0, zero, .LBB6_1
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    jal zero, .LBB6_3
; RV32I-NEXT:  .LBB6_1:
; RV32I-NEXT:    addi a0, zero, 32
; RV32I-NEXT:  .LBB6_3: # %cond.end
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i32 @llvm.ctlz.i32(i32 %a, i1 false)
  ret i32 %tmp
}

define i64 @test_cttz_i64(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -48
; RV32I-NEXT:    sw ra, 44(sp)
; RV32I-NEXT:    sw s0, 40(sp)
; RV32I-NEXT:    sw s1, 36(sp)
; RV32I-NEXT:    sw s2, 32(sp)
; RV32I-NEXT:    sw s3, 28(sp)
; RV32I-NEXT:    sw s4, 24(sp)
; RV32I-NEXT:    sw s5, 20(sp)
; RV32I-NEXT:    sw s6, 16(sp)
; RV32I-NEXT:    sw s7, 12(sp)
; RV32I-NEXT:    sw s8, 8(sp)
; RV32I-NEXT:    addi s0, sp, 48
; RV32I-NEXT:    addi s2, a1, 0
; RV32I-NEXT:    addi s3, a0, 0
; RV32I-NEXT:    addi a0, s3, -1
; RV32I-NEXT:    xori a1, s3, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi s5, a1, 1365
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s5
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s6, a1, 819
; RV32I-NEXT:    and a1, a0, s6
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s4, a1, 257
; RV32I-NEXT:    lui a1, %hi(__mulsi3)
; RV32I-NEXT:    addi s7, a1, %lo(__mulsi3)
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s8, a1, -241
; RV32I-NEXT:    and a0, a0, s8
; RV32I-NEXT:    addi a1, s4, 0
; RV32I-NEXT:    jalr ra, s7, 0
; RV32I-NEXT:    addi s1, a0, 0
; RV32I-NEXT:    addi a0, s2, -1
; RV32I-NEXT:    xori a1, s2, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s5
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s6
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s8
; RV32I-NEXT:    addi a1, s4, 0
; RV32I-NEXT:    jalr ra, s7, 0
; RV32I-NEXT:    bne s3, zero, .LBB7_1
; RV32I-NEXT:  # %bb.2:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    jal zero, .LBB7_3
; RV32I-NEXT:  .LBB7_1:
; RV32I-NEXT:    srli a0, s1, 24
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    addi a1, zero, 0
; RV32I-NEXT:    lw s8, 8(sp)
; RV32I-NEXT:    lw s7, 12(sp)
; RV32I-NEXT:    lw s6, 16(sp)
; RV32I-NEXT:    lw s5, 20(sp)
; RV32I-NEXT:    lw s4, 24(sp)
; RV32I-NEXT:    lw s3, 28(sp)
; RV32I-NEXT:    lw s2, 32(sp)
; RV32I-NEXT:    lw s1, 36(sp)
; RV32I-NEXT:    lw s0, 40(sp)
; RV32I-NEXT:    lw ra, 44(sp)
; RV32I-NEXT:    addi sp, sp, 48
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i64 @llvm.cttz.i64(i64 %a, i1 false)
  ret i64 %tmp
}

define i8 @test_cttz_i8_zero_undef(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i8 @llvm.cttz.i8(i8 %a, i1 true)
  ret i8 %tmp
}

define i16 @test_cttz_i16_zero_undef(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i16 @llvm.cttz.i16(i16 %a, i1 true)
  ret i16 %tmp
}

define i32 @test_cttz_i32_zero_undef(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    xori a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i32 @llvm.cttz.i32(i32 %a, i1 true)
  ret i32 %tmp
}

define i64 @test_cttz_i64_zero_undef(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -48
; RV32I-NEXT:    sw ra, 44(sp)
; RV32I-NEXT:    sw s0, 40(sp)
; RV32I-NEXT:    sw s1, 36(sp)
; RV32I-NEXT:    sw s2, 32(sp)
; RV32I-NEXT:    sw s3, 28(sp)
; RV32I-NEXT:    sw s4, 24(sp)
; RV32I-NEXT:    sw s5, 20(sp)
; RV32I-NEXT:    sw s6, 16(sp)
; RV32I-NEXT:    sw s7, 12(sp)
; RV32I-NEXT:    sw s8, 8(sp)
; RV32I-NEXT:    addi s0, sp, 48
; RV32I-NEXT:    addi s2, a1, 0
; RV32I-NEXT:    addi s3, a0, 0
; RV32I-NEXT:    addi a0, s3, -1
; RV32I-NEXT:    xori a1, s3, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi s5, a1, 1365
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s5
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s6, a1, 819
; RV32I-NEXT:    and a1, a0, s6
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s4, a1, 257
; RV32I-NEXT:    lui a1, %hi(__mulsi3)
; RV32I-NEXT:    addi s7, a1, %lo(__mulsi3)
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s8, a1, -241
; RV32I-NEXT:    and a0, a0, s8
; RV32I-NEXT:    addi a1, s4, 0
; RV32I-NEXT:    jalr ra, s7, 0
; RV32I-NEXT:    addi s1, a0, 0
; RV32I-NEXT:    addi a0, s2, -1
; RV32I-NEXT:    xori a1, s2, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s5
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s6
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s8
; RV32I-NEXT:    addi a1, s4, 0
; RV32I-NEXT:    jalr ra, s7, 0
; RV32I-NEXT:    bne s3, zero, .LBB11_1
; RV32I-NEXT:  # %bb.2:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    jal zero, .LBB11_3
; RV32I-NEXT:  .LBB11_1:
; RV32I-NEXT:    srli a0, s1, 24
; RV32I-NEXT:  .LBB11_3:
; RV32I-NEXT:    addi a1, zero, 0
; RV32I-NEXT:    lw s8, 8(sp)
; RV32I-NEXT:    lw s7, 12(sp)
; RV32I-NEXT:    lw s6, 16(sp)
; RV32I-NEXT:    lw s5, 20(sp)
; RV32I-NEXT:    lw s4, 24(sp)
; RV32I-NEXT:    lw s3, 28(sp)
; RV32I-NEXT:    lw s2, 32(sp)
; RV32I-NEXT:    lw s1, 36(sp)
; RV32I-NEXT:    lw s0, 40(sp)
; RV32I-NEXT:    lw ra, 44(sp)
; RV32I-NEXT:    addi sp, sp, 48
; RV32I-NEXT:    jalr zero, ra, 0
  %tmp = call i64 @llvm.cttz.i64(i64 %a, i1 true)
  ret i64 %tmp
}

define i32 @test_ctpop_i32(i32 %a) nounwind {
; RV32I-LABEL: test_ctpop_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    sw s0, 8(sp)
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr ra, a2, 0
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw s0, 8(sp)
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    jalr zero, ra, 0
  %1 = call i32 @llvm.ctpop.i32(i32 %a)
  ret i32 %1
}
