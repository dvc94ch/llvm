; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s

declare i32 @external_function(i32) nounwind

define i32 @test_call_external(i32 %a) {
; CHECK-LABEL: test_call_external:
; CHECK: lui a1, %hi(external_function)
; CHECK: addi a1, a1, %lo(external_function)
; CHECK: jalr ra, a1, 0
  %1 = call i32 @external_function(i32 %a) nounwind
  ret i32 %1
}

define i32 @defined_function(i32 %a) nounwind noinline {
  %1 = add i32 %a, 1
  ret i32 %1
}

define i32 @test_call_defined(i32 %a) {
; CHECK-LABEL: test_call_defined:
; CHECK: lui a1, %hi(defined_function)
; CHECK: addi a1, a1, %lo(defined_function)
; CHECK: jalr ra, a1, 0
  %1 = call i32 @defined_function(i32 %a) nounwind
  ret i32 %1
}

define i32 @test_call_indirect(i32 (i32)* %a, i32 %b) {
; CHECK-LABEL: test_call_indirect:
; CHECK: addi a2, a0, 0
; CHECK: addi a0, a1, 0
; CHECK: jalr ra, a2, 0
  %1 = call i32 %a(i32 %b)
  ret i32 %1
}

declare i32 @external_many_args(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) nounwind

define i32 @test_call_external_many_args(i32 %a) {
; CHECK-LABEL: test_call_external_many_args:
; CHECK: lui a0, %hi(external_many_args)
; CHECK: addi t0, a0, %lo(external_many_args)
; CHECK: jalr ra, t0, 0
  %1 = call i32 @external_many_args(i32 %a, i32 %a, i32 %a, i32 %a, i32 %a,
                                    i32 %a, i32 %a, i32 %a, i32 %a, i32 %a)
  ret i32 %a
}

define i32 @defined_many_args(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 %j) {
  %added = add i32 %j, 1
  ret i32 %added
}

define i32 @test_call_defined_many_args(i32 %a) {
; CHECK-LABEL: test_call_defined_many_args:
; CHECK: lui a1, %hi(defined_many_args)
; CHECK: addi t0, a1, %lo(defined_many_args)
; CHECK: jalr ra, t0, 0
  %1 = call i32 @defined_many_args(i32 %a, i32 %a, i32 %a, i32 %a, i32 %a,
                                   i32 %a, i32 %a, i32 %a, i32 %a, i32 %a)
  ret i32 %1
}
