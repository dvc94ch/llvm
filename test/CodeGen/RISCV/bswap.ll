; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)

define i16 @test_bswap_i16(i16 %a) {
; CHECK-LABEL: test_bswap_i16:
  %tmp = call i16 @llvm.bswap.i16(i16 %a)
  ret i16 %tmp
}

define i32 @test_bswap_i32(i32 %a) {
; CHECK-LABEL: test_bswap_i32:
  %tmp = call i32 @llvm.bswap.i32(i32 %a)
  ret i32 %tmp
}

define i64 @test_bswap_i64(i64 %a) {
; CHECK-LABEL: test_bswap_i64:
  %tmp = call i64 @llvm.bswap.i64(i64 %a)
  ret i64 %tmp
}