; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s

%struct.key_t = type { i32, [16 x i8] }

; Function Attrs: nounwind uwtable
define i32 @test() {
; CHECK-LABEL: test:
; CHECK: addi sp, sp, -32
; CHECK: sw ra, 28(sp)
; CHECK: sw s0, 24(sp)
; CHECK: addi s0, sp, 32
; CHECK: sw zero, -16(s0)
; CHECK: sw zero, -20(s0)
; CHECK: sw zero, -24(s0)
; CHECK: sw zero, -28(s0)
; CHECK: sw zero, -32(s0)
; CHECK: addi a0, s0, -32
; CHECK: ori a0, a0, 4
; CHECK: lui a1, %hi(test1)
; CHECK: addi a1, a1, %lo(test1)
; CHECK: jalr ra, a1, 0
; CHECK: addi a0, zero, 0
; CHECK: lw s0, 24(sp)
; CHECK: lw ra, 28(sp)
; CHECK: addi sp, sp, 32
; CHECK: jalr zero, ra, 0
  %key = alloca %struct.key_t, align 4
  %1 = bitcast %struct.key_t* %key to i8*
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 20, i32 4, i1 false)
  %2 = getelementptr inbounds %struct.key_t, %struct.key_t* %key, i64 0, i32 1, i64 0
  call void @test1(i8* %2) #3
  ret i32 0
}

; Function Attrs: nounwind argmemonly
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1)

declare void @test1(i8*)


%struct.large_t = type { [4096 x i8] }

; Function Attrs: nounwind uwtable
define i32 @test2() {
; CHECK-LABEL: test2:
;; Adjust stack pointer
;; 4096 + ?? + fp
; CHECK: lui a0, 4096
; CHECK: addi a0, a0, 8
; CHECK: sub sp, sp, a0
;; Save frame pointer (s0)
; CHECK: lui a0, 4096
; CHECK: add a0, a0, sp
; CHECK: sw s0, 4(a0)
;; Adjust frame pointer (s0)
; CHECK: lui a0, 4096
; CHECK: addi a0, a0, 8
; CHECK: add s0, sp, a0
;; Set return value to 0
; CHECK: addi a0, zero, 0
;; Load frame pointer (s0)
; CHECK: lui a1, 4096
; CHECK: add a1, a1, sp
; CHECK: lw s0, 4(a1)
;; Reset stack pointer
; CHECK: lui a1, 4096
; CHECK: addi a1, a1, 8
; CHECK: add sp, sp, a1
;; Return
; CHECK: jalr zero, ra, 0
  %large = alloca %struct.large_t, align 4
  ret i32 0
}