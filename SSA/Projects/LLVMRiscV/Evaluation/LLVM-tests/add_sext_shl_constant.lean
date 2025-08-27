import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-! total exsit 12 test cases, we implement 6 of these because they are supported in our fragemnt
, where each has 2 version ,the ZBA and the non-ZBA supported version.
https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/RISCV/add_sext_shl_constant.ll
 -/

 /-# 1 -/
/-
define i64 @add_shl_moreOneUse_sh1add(i64 %x) {
; NO-ZBA-LABEL: add_shl_moreOneUse_sh1add:
; NO-ZBA:       # %bb.0:
; NO-ZBA-NEXT:    ori a1, a0, 1
; NO-ZBA-NEXT:    slli a0, a0, 1
; NO-ZBA-NEXT:    ori a0, a0, 2
; NO-ZBA-NEXT:    add a0, a0, a1
; NO-ZBA-NEXT:    ret
;
; ZBA-LABEL: add_shl_moreOneUse_sh1add:
; ZBA:       # %bb.0:
; ZBA-NEXT:    ori a0, a0, 1
; ZBA-NEXT:    sh1add a0, a0, a0
; ZBA-NEXT:    ret
;
  %or = or i64 %x, 1
  %mul = shl i64 %or, 1
  %add = add i64 %mul, %or
  ret i64 %add
}
-/
def add_shl_moreOneUse_sh1add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %0 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

def add_shl_moreOneUse_sh1add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 1 : !i64
    %2 = ori %1, 2 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

def add_shl_moreOneUse_sh1add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh1add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh1add_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh1add
  rhs := add_shl_moreOneUse_sh1add_riscv_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh1add add_shl_moreOneUse_sh1add_riscv_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

def add_shl_moreOneUse_sh1add_no_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh1add
  rhs := add_shl_moreOneUse_sh1add_riscv_no_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh1add add_shl_moreOneUse_sh1add_riscv_no_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

 /-# 2 -/

/-
define i64 @add_shl_moreOneUse_sh2add(i64 %x) {
; NO-ZBA-LABEL: add_shl_moreOneUse_sh2add:
; NO-ZBA:       # %bb.0:
; NO-ZBA-NEXT:    ori a1, a0, 1
; NO-ZBA-NEXT:    slli a0, a0, 2
; NO-ZBA-NEXT:    ori a0, a0, 4
; NO-ZBA-NEXT:    add a0, a0, a1
; NO-ZBA-NEXT:    ret
;
; ZBA-LABEL: add_shl_moreOneUse_sh2add:
; ZBA:       # %bb.0:
; ZBA-NEXT:    ori a0, a0, 1
; ZBA-NEXT:    sh2add a0, a0, a0
; ZBA-NEXT:    ret
  %or = or i64 %x, 1
  %mul = shl i64 %or, 2
  %add = add i64 %mul, %or
  ret i64 %add
}
-/
def add_shl_moreOneUse_sh2add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %c2 = llvm.mlir.constant (2) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %c2 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

def add_shl_moreOneUse_sh2add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 2 : !i64
    %2 = ori %1, 4 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

def add_shl_moreOneUse_sh2add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh2add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh2add_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh2add
  rhs := add_shl_moreOneUse_sh2add_riscv_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh2add add_shl_moreOneUse_sh2add_riscv_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

def add_shl_moreOneUse_sh2add_no_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh2add
  rhs := add_shl_moreOneUse_sh2add_riscv_no_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh2add add_shl_moreOneUse_sh2add_riscv_no_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-# 3 -/
/-
define i64 @add_shl_moreOneUse_sh3add(i64 %x) {
; NO-ZBA-LABEL: add_shl_moreOneUse_sh3add:
; NO-ZBA:       # %bb.0:
; NO-ZBA-NEXT:    ori a1, a0, 1
; NO-ZBA-NEXT:    slli a0, a0, 3
; NO-ZBA-NEXT:    ori a0, a0, 8
; NO-ZBA-NEXT:    add a0, a0, a1
; NO-ZBA-NEXT:    ret
;
; ZBA-LABEL: add_shl_moreOneUse_sh3add:
; ZBA:       # %bb.0:
; ZBA-NEXT:    ori a0, a0, 1
; ZBA-NEXT:    sh3add a0, a0, a0
; ZBA-NEXT:    ret
;
  %or = or i64 %x, 1
  %mul = shl i64 %or, 3
  %add = add i64 %mul, %or
  ret i64 %add
}
-/
def add_shl_moreOneUse_sh3add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %c2 = llvm.mlir.constant (3) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %c2 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

def add_shl_moreOneUse_sh3add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 3 : !i64
    %2 = ori %1, 8 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

def add_shl_moreOneUse_sh3add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh3add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh3add_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh3add
  rhs := add_shl_moreOneUse_sh3add_riscv_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh3add add_shl_moreOneUse_sh3add_riscv_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

def add_shl_moreOneUse_sh3add_no_ZBA : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh3add
  rhs := add_shl_moreOneUse_sh3add_riscv_no_ZBA
  correct := by
    unfold add_shl_moreOneUse_sh3add add_shl_moreOneUse_sh3add_riscv_no_ZBA
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

 /-# 4 -/
/-
;; Covers a case which previously crashed (pr119527)
define i64 @add_shl_sext(i32 %1) {
; RV64-LABEL: add_shl_sext:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a1, a0, 3
; RV64-NEXT:    sllw a0, a1, a0
; RV64-NEXT:    ret
  %3 = add i32 %1, 3
  %4 = shl i32 %3, %1
  %5 = sext i32 %4 to i64
  ret i64 %5
}
-/
def add_shl_sext_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.add %a, %0 : i32
    %2 = llvm.shl %1, %a : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def add_shl_sext_riscv := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = addi %a0, 3 : !i64
    %1 = sllw %0, %a0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def add_shl_sext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_sext_llvm
  rhs := add_shl_sext_riscv
  correct := by
    unfold add_shl_sext_llvm add_shl_sext_riscv
    simp_lowering
    bv_decide

 /-# 5 -/
/-
define i64 @add_shl_moreOneUse_sh4add(i64 %x) {
; RV64-LABEL: add_shl_moreOneUse_sh4add:
; RV64:       # %bb.0:
; RV64-NEXT:    ori a1, a0, 1
; RV64-NEXT:    slli a0, a0, 4
; RV64-NEXT:    ori a0, a0, 16
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    ret
  %or = or i64 %x, 1
  %mul = shl i64 %or, 4
  %add = add i64 %mul, %or
  ret i64 %add
}
-/
def add_shl_moreOneUse_sh4add_llvm := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (1) : i64
    %c4 = llvm.mlir.constant (4) : i64
    %1 = llvm.or %a, %0 : i64
    %2 = llvm.shl %1, %c4 : i64
    %3 = llvm.add %1, %2 : i64
    llvm.return %3 : i64
  }]

def add_shl_moreOneUse_sh4add_riscv := [LV| {
    ^entry (%a: i64):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i64) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 4 : !i64
    %2 = ori %1, 16 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i64)
    llvm.return %4 : i64
  }]

def add_shl_moreOneUse_sh4add : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_shl_moreOneUse_sh4add_llvm
  rhs :=add_shl_moreOneUse_sh4add_riscv
  correct := by
    unfold add_shl_moreOneUse_sh4add_llvm add_shl_moreOneUse_sh4add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

 /-# 6 -/
/-
define i64 @add_shl_rhs_constant(i64 %x, i64 %y) {
; RV64-LABEL: add_shl_rhs_constant:
; RV64:       # %bb.0:
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    slli a0, a0, 3
; RV64-NEXT:    ret
  %a = add i64 %x, 1
  %b = add i64 %y, %a
  %c = shl i64 %b, 3
  %d = add i64 %c, -8
  ret i64 %d
}
-/
def add_shl_rhs_constant_llvm := [LV| {
    ^entry (%a0: i64, %a1: i64):
    %0 = llvm.mlir.constant (1) : i64
    %c3 = llvm.mlir.constant (3) : i64
    %c8 = llvm.mlir.constant (-8) : i64
    %1 = llvm.add %a0, %0 : i64
    %2 = llvm.add %a1, %1 : i64
    %3 = llvm.shl %2, %c3 : i64
    %4 = llvm.add %3, %c8 : i64
    llvm.return %4 : i64
  }]

def add_shl_rhs_constant_riscv := [LV| {
    ^entry (%a: i64, %b: i64):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i64) -> (!i64)
    %a1 = "builtin.unrealized_conversion_cast" (%b) : (i64) -> (!i64)
    %0 = add %a0, %a1 : !i64
    %1 = slli %0, 3 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def add_shl_rhs_constant : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64),Ty.llvm (.bitvec 64) ] where
  lhs := add_shl_rhs_constant_llvm
  rhs := add_shl_rhs_constant_riscv
  correct := by
    unfold  add_shl_rhs_constant_llvm add_shl_rhs_constant_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
