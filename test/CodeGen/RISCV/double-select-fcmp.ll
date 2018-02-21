; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s

define double @select_fcmp_false(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_false:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    mv a1, a3
; RV32IFD-NEXT:    mv a0, a2
; RV32IFD-NEXT:    ret
  %1 = fcmp false double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_oeq(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_oeq:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft1, 16(sp)
; RV32IFD-NEXT:    fld ft0, 24(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft1
; RV32IFD-NEXT:    bnez a0, .LBB1_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft0, ft1
; RV32IFD-NEXT:  .LBB1_2:
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp oeq double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ogt(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ogt:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    fld ft0, 24(sp)
; RV32IFD-NEXT:    fld ft1, 16(sp)
; RV32IFD-NEXT:    flt.d a0, ft1, ft0
; RV32IFD-NEXT:    bnez a0, .LBB2_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft0, ft1
; RV32IFD-NEXT:  .LBB2_2:
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ogt double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_oge(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_oge:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    fld ft0, 24(sp)
; RV32IFD-NEXT:    fld ft1, 16(sp)
; RV32IFD-NEXT:    fle.d a0, ft1, ft0
; RV32IFD-NEXT:    bnez a0, .LBB3_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft0, ft1
; RV32IFD-NEXT:  .LBB3_2:
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp oge double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_olt(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_olt:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft1, 16(sp)
; RV32IFD-NEXT:    fld ft0, 24(sp)
; RV32IFD-NEXT:    flt.d a0, ft0, ft1
; RV32IFD-NEXT:    bnez a0, .LBB4_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft0, ft1
; RV32IFD-NEXT:  .LBB4_2:
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp olt double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ole(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ole:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft1, 16(sp)
; RV32IFD-NEXT:    fld ft0, 24(sp)
; RV32IFD-NEXT:    fle.d a0, ft0, ft1
; RV32IFD-NEXT:    bnez a0, .LBB5_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft0, ft1
; RV32IFD-NEXT:  .LBB5_2:
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ole double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_one(double %a, double %b) nounwind {
; TODO: feq.s+sltiu+bne sequence could be optimised
; RV32IFD-LABEL: select_fcmp_one:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    feq.d a1, ft1, ft0
; RV32IFD-NEXT:    not a1, a1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB6_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB6_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp one double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ord(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ord:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB7_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB7_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ord double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ueq(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ueq:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    feq.d a1, ft1, ft0
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB8_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB8_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ueq double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ugt(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ugt:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    flt.d a1, ft0, ft1
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB9_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB9_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ugt double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_uge(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_uge:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    fle.d a1, ft0, ft1
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB10_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB10_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp uge double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ult(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ult:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    flt.d a1, ft1, ft0
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB11_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB11_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ult double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_ule(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_ule:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    fle.d a1, ft1, ft0
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB12_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB12_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp ule double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_une(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_une:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    feq.d a1, ft1, ft0
; RV32IFD-NEXT:    xori a1, a1, 1
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    or a0, a1, a0
; RV32IFD-NEXT:    bnez a0, .LBB13_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB13_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp une double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_uno(double %a, double %b) nounwind {
; TODO: sltiu+bne could be optimized
; RV32IFD-LABEL: select_fcmp_uno:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw a3, 20(sp)
; RV32IFD-NEXT:    sw a2, 16(sp)
; RV32IFD-NEXT:    sw a1, 28(sp)
; RV32IFD-NEXT:    sw a0, 24(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    feq.d a0, ft0, ft0
; RV32IFD-NEXT:    fld ft1, 24(sp)
; RV32IFD-NEXT:    feq.d a1, ft1, ft1
; RV32IFD-NEXT:    and a0, a1, a0
; RV32IFD-NEXT:    seqz a0, a0
; RV32IFD-NEXT:    bnez a0, .LBB14_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    fmv.d ft1, ft0
; RV32IFD-NEXT:  .LBB14_2:
; RV32IFD-NEXT:    fsd ft1, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
  %1 = fcmp uno double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

define double @select_fcmp_true(double %a, double %b) nounwind {
; RV32IFD-LABEL: select_fcmp_true:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    ret
  %1 = fcmp true double %a, %b
  %2 = select i1 %1, double %a, double %b
  ret double %2
}

; Ensure that ISel succeeds for a select+fcmp that has an i32 result type.
define i32 @i32_select_fcmp_oeq(double %a, double %b, i32 %c, i32 %d) nounwind {
; RV32IFD-LABEL: i32_select_fcmp_oeq:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a3, 4(sp)
; RV32IFD-NEXT:    sw a2, 0(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    fld ft0, 0(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    feq.d a0, ft1, ft0
; RV32IFD-NEXT:    bnez a0, .LBB16_2
; RV32IFD-NEXT:  # %bb.1:
; RV32IFD-NEXT:    mv a4, a5
; RV32IFD-NEXT:  .LBB16_2:
; RV32IFD-NEXT:    mv a0, a4
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
  %1 = fcmp oeq double %a, %b
  %2 = select i1 %1, i32 %c, i32 %d
  ret i32 %2
}
