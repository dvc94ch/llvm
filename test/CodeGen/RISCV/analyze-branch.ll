; RUN: llc -mtriple=riscv32 < %s | FileCheck %s

; This test checks that LLVM can do basic stripping and reapplying of branches
; to basic blocks.

declare void @test_true()
declare void @test_false()

; !0 corresponds to a branch being taken, !1 to not being taken.
!0 = !{!"branch_weights", i32 64, i32 4}
!1 = !{!"branch_weights", i32 4, i32 64}

define void @test_jal_fallthrough() nounwind {
; CHECK-LABEL: test_jal_fallthrough:
; CHECK: lui a0, %hi(test_true)
; CHECK-NEXT: addi a0, a0, %lo(test_true)
; CHECK-NEXT: jalr ra, a0
  br label %jump
jump:
  call void @test_true()
  ret void
}

define void @test_branch_fallthrough_taken(i32 %in) nounwind {
; CHECK-LABEL: test_branch_fallthrough_taken:
; CHECK: bne a0, zero, [[FALSE:.LBB[0-9]+_[0-9]+]]
; CHECK: jal zero, [[TRUE:.LBB[0-9]+_[0-9]+]]
; CHECK: [[TRUE]]:
; CHECK: [[FALSE]]:
  %bit = and i32 %in, 32768
  %tst = icmp eq i32 %in, 0
  br i1 %tst, label %true, label %false, !prof !0

true:
  call void @test_true()
  ret void

false:
  call void @test_false()
  ret void
}

define void @test_branch_fallthrough_nottaken(i32 %in) nounwind {
; CHECK-LABEL: test_branch_fallthrough_nottaken:
; CHECK: bne a0, zero, [[TRUE:.LBB[0-9]+_[0-9]+]]
; CHECK: jal zero, [[FALSE:.LBB[0-9]+_[0-9]+]]
; CHECK: [[TRUE]]:
; CHECK: [[FALSE]]:
  %bit = and i32 %in, 32768
  %tst = icmp eq i32 %bit, 0
  br i1 %tst, label %true, label %false, !prof !1

true:
  call void @test_true()
  ret void

false:
  call void @test_false()
  ret void
}