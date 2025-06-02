import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV
set_option Elab.async true

/-!
This file contains the instruction lowering for the `llvm.select` instruction.

LLVM version 11.0 lowers `select` to a conditional branch regardless of the
optimization level used. However, our current setup does not support branches.

To handle this, we manually encode the semantics of the `select` instruction
using bitwise operations. While this results in a longer RISC-V instruction
sequence compared to LLVM's native lowering, it allows us to support lowering
the instruction within our framework.
-/

/-! # select, RiscV (leveraging bit-wise operations)  -/
def select_riscv := [LV| {
  ^entry (%cond : i1, %arg0: i64, %arg1: i64):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64 --propagating the condition bit to all bits within the 64 bit vector
    %5 = and %0, %4 : !i64 -- mask the value_true with the condition
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64 -- mask the value_false with the condition
    %9 = or %5, %8 : !i64 -- return either value_true or value_false
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i64)
    llvm.return %10 : i64
  }]

def select_llvm_64 := [LV| {
    ^entry (%cond : i1, %arg0: i64, %arg1: i64):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    llvm.return %0 : i64
  }]

def select_riscv_select_llvm_64 : LLVMPeepholeRewriteRefine 64
  [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_64
  rhs := select_riscv
  correct := by
    unfold select_riscv select_llvm_64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    case value.poison.poison =>
      intro x
      split <;> simp
    case value.poison.value =>
      simp [PoisonOr.toOption_getSome, PoisonOr.toOption_getNone, BitVec.and_zero,
        BitVec.or_zero, PoisonOr.if_then_poison_isRefinedBy_iff, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
      bv_decide
    case value.value.poison =>
      simp
      intro x x'
      split
      · simp only [PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp
    case value.value.value =>
      intro x x' x''
      simp only [PoisonOr.ite_value_value, PoisonOr.toOption_getSome,
        PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
      split
      · bv_decide
      · bv_decide

/- # select, RiscV (leveraging bit-wise operations)  -/
def select_riscv_32 := [LV| {
  ^entry (%cond : i1, %arg0: i32, %arg1: i32):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64 --propagating the condition bit to all bits within the 64 bit vector
    %5 = and %0, %4 : !i64 -- mask the value_true with the condition
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64 -- mask the value_false with the condition
    %9 = or %5, %8 : !i64 -- return either value_true or value_false
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i32)
    llvm.return %10 : i32
  }]

def select_llvm_32 := [LV| {
    ^entry (%cond : i1, %arg0: i32, %arg1: i32):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    llvm.return %0 : i32
  }]

def select_riscv_select_llvm_32 : LLVMPeepholeRewriteRefine 32
    [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_32
  rhs := select_riscv_32
  correct := by
    unfold select_llvm_32 select_riscv_32
    simp_peephole
    simp_riscv
    simp [LLVM.select]
    simp_alive_case_bash
    case value.poison.poison =>
      intro x
      split
      · simp
      · simp
    case value.poison.value =>
      intro x x'
      split
      · simp
      · simp only [PoisonOr.toOption_getSome, PoisonOr.toOption_getNone, BitVec.reduceSignExtend,
        BitVec.and_zero, BitVec.or_zero, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
    case value.value.poison =>
      intro x x'
      split
      · simp only [PoisonOr.toOption_getNone, BitVec.reduceSignExtend, PoisonOr.toOption_getSome,
        BitVec.zero_and, BitVec.zero_or, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp
    case value.value.value =>
      intro x x' x''
      split
      · simp only [PoisonOr.toOption_getSome, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp only [PoisonOr.toOption_getSome, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide

def select_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  [⟨[Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64),Ty.llvm (.bitvec 1)],
   Ty.llvm (.bitvec 64),(LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND select_riscv_select_llvm_64)⟩,
  ⟨[Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32),Ty.llvm (.bitvec 1)],
   Ty.llvm (.bitvec 32),(LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND select_riscv_select_llvm_32)⟩]
