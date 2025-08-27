import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-! This file verifies the LLVM RISCV test suite test case `add-imm.ll`. -/

/-- ### 1
  ; RV64I-LABEL: add_positive_low_bound_reject:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addiw a0, a0, 2047
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, 2047
    ret i32 %1
  }
-/
def add_positive_low_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2047) : i32
    %1 = llvm.add %a, %0 : i32
    llvm.return %1 :i32
  }]

def add_positive_low_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addiw %a, 2047 : !i64
    %1 =  "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 :i32
  }]

def add_positive_low_bound_reject: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_low_bound_reject_llvm
  rhs := add_positive_low_bound_reject_riscv
  correct := by
    unfold add_positive_low_bound_reject_llvm add_positive_low_bound_reject_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 2
define i32 @add_positive_low_bound_accept(i32 %a) nounwind {
; RV64I-LABEL: add_positive_low_bound_accept:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, 2047
; RV64I-NEXT:    addiw a0, a0, 1
; RV64I-NEXT:    ret
  %1 = add i32 %a, 2048
  ret i32 %1
}
-/
def add_positive_low_bound_accept_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2048) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

def add_positive_low_bound_accept_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addi %a, 2047 : !i64
    %1 = addiw %0, 1 : !i64
    %2 =  "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 :i32
  }]

def add_positive_low_bound_accept: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_low_bound_accept_llvm
  rhs := add_positive_low_bound_accept_riscv
  correct := by
    unfold  add_positive_low_bound_accept_llvm add_positive_low_bound_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 3
  sdefine i32 @add_positive_high_bound_accept(i32 %a) nounwind {
  ; RV64I-LABEL: add_positive_high_bound_accept:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addi a0, a0, 2047
  ; RV64I-NEXT:    addiw a0, a0, 2047
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, 4094
    ret i32 %1
  }
-/
def add_positive_high_bound_accept_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (4094) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

def add_positive_high_bound_accept_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addi %a, 2047 : !i64
    %1 = addiw %0, 2047 : !i64
    %2 =  "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 :i32
  }]

def add_positive_high_bound_accept: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_high_bound_accept_llvm
  rhs := add_positive_high_bound_accept_riscv
  correct := by
    unfold add_positive_high_bound_accept_llvm add_positive_high_bound_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 4
  define i32 @add_positive_high_bound_reject(i32 %a) nounwind {
  ; RV64I-LABEL: add_positive_high_bound_reject:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    lui a1, 1
  ; RV64I-NEXT:    addi a1, a1, -1
  ; RV64I-NEXT:    addw a0, a0, a1
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, 4095
    ret i32 %1
  }
-/
def add_positive_high_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (4095) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

def add_positive_high_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = li (843949575) : !i64
    %1 = "lui"  (%0) {imm = 1 : !i64} : (!i64) -> (!i64)
    %2 = "addi"  (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
    %3 = addw %2, %a: !i64
    %4 =  "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 :i32
  }]

def add_positive_high_bound_reject: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_high_bound_reject_llvm
  rhs := add_positive_high_bound_reject_riscv
  correct := by
    unfold add_positive_high_bound_reject_llvm add_positive_high_bound_reject_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 5
  define i32 @add_negative_high_bound_reject(i32 %a) nounwind {
  ; RV32I-LABEL: add_negative_high_bound_reject:
  ; RV32I:       # %bb.0:
  ; RV32I-NEXT:    addi a0, a0, -2048
  ; RV32I-NEXT:    ret
  ;
  ; RV64I-LABEL: add_negative_high_bound_reject:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addiw a0, a0, -2048
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, -2048
    ret i32 %1
  }
-/
def add_negative_high_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (-2048) : i32
    %1 = llvm.add  %a, %0 : i32
    llvm.return %1 :i32
  }]

def add_negative_high_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = "addiw"  (%a) {imm = -2048 : !i64} : (!i64) -> (!i64)
    %1 =  "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 :i32
  }]

def add_negative_high_bound_reject: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_high_bound_reject_llvm
  rhs := add_negative_high_bound_reject_riscv
  correct := by
    unfold add_negative_high_bound_reject_llvm add_negative_high_bound_reject_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 6 -/
/-
define i32 @add_negative_high_bound_accept(i32 %a) nounwind {
; RV32I-LABEL: add_negative_high_bound_accept:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -2048
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_negative_high_bound_accept:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -2048
; RV64I-NEXT:    addiw a0, a0, -1
; RV64I-NEXT:    ret
  %1 = add i32 %a, -2049
  ret i32 %1
}
-/
def add_negative_high_bound_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-2049) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

def add_negative_high_bound_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addiw"  (%0) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %2 = "addiw"  (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add_negative_high_bound_accept : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_high_bound_accept_llvm
  rhs := add_negative_high_bound_accept_riscv
  correct := by
    unfold add_negative_high_bound_accept_llvm add_negative_high_bound_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 7
  define i32 @add_negative_low_bound_accept(i32 %a) nounwind {
  ; RV64I-LABEL: add_negative_low_bound_accept:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addi a0, a0, -2048
  ; RV64I-NEXT:    addiw a0, a0, -2048
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, -4096
    ret i32 %1
  }
-/
def add_negative_low_bound_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-4096) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

def  add_negative_low_bound_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addi"  (%0) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %2 = "addiw"  (%1) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def  add_negative_low_bound_accept : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_low_bound_accept_llvm
  rhs := add_negative_low_bound_accept_riscv
  correct := by
    unfold add_negative_low_bound_accept_llvm add_negative_low_bound_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 8
  define i32 @add_negative_low_bound_reject(i32 %a) nounwind {
  ; RV64I-LABEL: add_negative_low_bound_reject:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    lui a1, 1048575
  ; RV64I-NEXT:    addi a1, a1, -1
  ; RV64I-NEXT:    addw a0, a0, a1
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, -4097
    ret i32 %1
  }
-/
def add_negative_low_bound_reject_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-4097) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

def add_negative_low_bound_reject_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = li (843949575) : !i64 -- random value bc can make any assumption in the value of a1
  %1 = "lui" (%0) {imm = 1048575 : !i64} : (!i64) -> (!i64)
  %2 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %3 = "addi" (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
  %4 = addw %2, %3 : !i64
  %5 =  "builtin.unrealized_conversion_cast" (%4) : (!i64) -> (i32)
  llvm.return %5 : i32
}]

def add_negative_low_bound_reject : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_low_bound_reject_llvm
  rhs := add_negative_low_bound_reject_riscv
  correct := by
    unfold add_negative_low_bound_reject_llvm add_negative_low_bound_reject_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 9
  define i32 @add32_accept(i32 %a) nounwind {
  ; RV64I-LABEL: add32_accept:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addi a0, a0, 2047
  ; RV64I-NEXT:    addiw a0, a0, 952
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, 2999
    ret i32 %1
  }
-/
def add32_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (2999) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

def add32_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addi" (%0) {imm = 2047 : !i64} : (!i64) -> (!i64)
  %2 = addiw %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add32_accept : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add32_accept_llvm
  rhs := add32_accept_riscv
  correct := by
    unfold add32_accept_llvm add32_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 10
  define signext i32 @add32_sext_accept(i32 signext %a) nounwind {
  ; RV64I-LABEL: add32_sext_accept:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addi a0, a0, 2047
  ; RV64I-NEXT:    addiw a0, a0, 952
  ; RV64I-NEXT:    ret
    %1 = add i32 %a, 2999
    ret i32 %1
  }
-/
def add32_sext_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (2999) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

def add32_sext_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)-- sext performed here
  %1 = "addi" (%0) {imm = 2047 : !i64} : (!i64) -> (!i64)
  %2 = addiw %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add32_sext_accept : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add32_sext_accept_llvm
  rhs :=  add32_sext_accept_riscv
  correct := by
    unfold add32_sext_accept_llvm  add32_sext_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-- ### 11
  define i64 @add64_accept(i64 %a) nounwind {
  ; RV64I-LABEL: add64_accept:
  ; RV64I:       # %bb.0:
  ; RV64I-NEXT:    addi a0, a0, 2047
  ; RV64I-NEXT:    addi a0, a0, 952
  ; RV64I-NEXT:    ret
    %1 = add i64 %a, 2999
    ret i64 %1
  }
-/
def add64_accept_llvm := [LV| {
  ^entry (%a: i64):
  %0 = llvm.mlir.constant (2999) : i64
  %1 = llvm.add %a, %0 : i64
  llvm.return %1 : i64
}]

def add64_accept_riscv := [LV| {
  ^entry (%arg: i64):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)-- sext performed here
  %1 = addi %0, 2047 : !i64
  %2 = addi %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
  llvm.return %3 : i64
}]

def add64_accept : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add64_accept_llvm
  rhs := add64_accept_riscv
  correct := by
    unfold add64_accept_llvm add64_accept_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
