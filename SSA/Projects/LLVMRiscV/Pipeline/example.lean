import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV
/- This file contains examples that are currently labour-intensive to create and verify due to redundancy.
At the moment, I need to provide a separate proof for each status flag. These proofs are often very similar
 across flags within a single instruction, but not across different instructions. (see the diffrent instruction in this
 folder) For example, in the case of division, the proofs for each flag are different from one another.
 But overall this is a bit annyoning and requires to wrtie a lot of similar code. -/


-- EXAMPLE 1 (there are additional examples at the end of this file e.g the third example is important))
def add_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
    %add1 = add %lhsr, %rhsr : !i64
    %addl = "builtin.unrealized_conversion_cast" (%add1) : (!i64) -> (i64)
    llvm.return %addl : i64
  }]

def add_llvm_no_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs : i64
    llvm.return %1 : i64
  }]

/- # ADD, with flags  -/
def add_llvm_nsw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i64
    llvm.return %1 : i64
  }]

def add_llvm_nuw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_add_lower_riscv_noflags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_no_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_no_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

def llvm_add_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nsw_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_nsw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

def llvm_add_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nuw_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_nuw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp


-- EXAMPLE 2

/- I also need to manually write proofs each time for different bit widths — e.g., provide a rewrite for
zero-extension from 16-bit to 64-bit, and then again from 16-bit to 32-bit. The same applies to other bit widths;
each time, I need to explicitly provide the pattern — e.g., i8 to i64, i16 to i64, etc. -/

def zext_riscv_i16_to_i64 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srli %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

def zext_llvm_i16_to_i64 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_i16_to_i64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_i16_to_i64, rhs:= zext_riscv_i16_to_i64,
   correct := by
    unfold zext_llvm_i16_to_i64 zext_riscv_i16_to_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [LLVM.zext?, BitVec.truncate_eq_setWidth, PoisonOr.toOption_getSome,
      BitVec.shiftLeft_eq', BitVec.toNat_ofNat, Nat.reducePow, Nat.reduceMod,
      BitVec.ushiftRight_eq', BitVec.signExtend_eq, PoisonOr.value_isRefinedBy_value,
      InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

def zext_riscv_i16_to_i32 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srli %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

def zext_llvm_i16_to_i32 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_i16_to_i32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_i16_to_i32, rhs:= zext_riscv_i16_to_i32,
   correct := by
    unfold zext_llvm_i16_to_i32 zext_riscv_i16_to_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [LLVM.zext?, BitVec.truncate_eq_setWidth, PoisonOr.toOption_getSome,
      BitVec.shiftLeft_eq', BitVec.toNat_ofNat, Nat.reducePow, Nat.reduceMod,
      BitVec.ushiftRight_eq', PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

-- EXAMPLE 3
/- To be able to use test cases from the RISC-V test suite in LLVM, I need to manually encode the
assembly code into SSA form and then prove it. This is a bit annoying and obviously doesn’t scale well.
Additionally, those test cases are written in LLVM IR, not in the LLVM IR dialect, which means
I also have to manually translate the LLVM part.

define i64 @add_lo_negone(i64 %0) {
; RV64I-LABEL: add_lo_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    slli a1, a1, 32
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
  %2 = add nsw i64 %0, -4294967297
  ret i64 %2
}

Would require me to manually translate it and then check it.


Steps required:
-- human effort to first translate LLVM IR sequence into corresponsing LLVM dialect
sequence for Lean-MLIR (1).

-- Then what is the actual effort is the convert the assembly sequence into SSA form
and from there into the dialect form and keep checking that it got translated into ssa correctly (2).

-- Finally add the cast at the beginning and at the end to convert the types
.-/

-- (1)
def test1_llvm_input := [LV| {
  ^entry (%arg: i64):
    %0 = llvm.mlir.constant(-4294967297) : i64
    %1 = llvm.add %arg, %0 overflow<nsw> : i64
    llvm.return %1: i64
  }]

-- (2)
def test1 := [LV| {
  ^entry (%arg: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i64) -> (!i64)
    %1 = "li"() {imm = -1 : !i64}  : (!i64) -> (!i64)
    %2 = slli  %1, 32 : !i64
    %3 = addi  %2, 32 : !i64
    %4 = add %0, %3 : !i64
    %res = "builtin.unrealized_conversion_cast"(%4) : (!i64) -> (i64)
    llvm.return %res : i64
  }]
