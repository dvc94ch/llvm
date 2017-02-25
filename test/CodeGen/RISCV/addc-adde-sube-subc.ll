; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s

; Ensure that the ISDOpcodes ADDC, ADDE, SUBC, SUBE are handled correctly

define i64 @addc_adde(i64 %a, i64 %b) {
; CHECK-LABEL: addc_adde:
; CHECK: addi a5, zero, 1
; CHECK: bltu a0, a2, .LBB0_2
; CHECK: sltu a5, a0, a4
  %1 = add i64 %a, %b
  ret i64 %1
}

define i64 @subc_sube(i64 %a, i64 %b) {
; CHECK-LABEL: subc_sube:
; CHECK: sub a1, a1, a3
; CHECK: sltu a3, a0, a2
  %1 = sub i64 %a, %b
  ret i64 %1
}
