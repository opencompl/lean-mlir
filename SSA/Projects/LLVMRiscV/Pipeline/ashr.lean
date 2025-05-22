import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.Pipeline.simpproc
import SSA.Projects.LLVMRiscV.Pipeline.simpriscv
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

-- REMEBER : TAGGED SIMP LEMMAS

/- # ASHR, not exact -/
def ashr_llvm_no_flag : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.ashr %x, %amount : i64
      llvm.return %1 : i64
  }]

/- # ASHR,  exact -/
def ashr_llvm_exact_flag : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.ashr exact %x, %amount : i64
      llvm.return %1 : i64
  }]
def ashr_riscv := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %base = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i64) -> !i64
       %res = sra %base, %shamt : !i64
       %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]

def llvm_ashr_lower_riscv_no_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64),
  Ty.llvm (.bitvec 64)] :=
  {lhs := ashr_llvm_no_flag , rhs := ashr_riscv ,
    correct :=  by
      unfold ashr_llvm_no_flag ashr_riscv -- think of adding these to simp peephole
      simp_peephole
      simp_alive_undef
      simp only [RTYPE_pure64_RISCV_SRA_bv, Bool.false_eq_true, false_and, ↓reduceIte, LLVM.sub?,
      castriscvToLLVM, RTYPE_pure64_RISCV_SUB, castLLVMToriscv, BitVec.setWidth_eq, BitVec.sub_eq,
      sub_self, LLVM.ashr ,LLVM.ashr?, BitVec.ofNat_eq_ofNat, BitVec.signExtend_eq]
      simp_alive_case_bash
      intro x x'
      split
      case value.value.isTrue ht =>
        simp
      case value.value.isFalse hf =>
        simp only [BitVec.sshiftRight_eq', Nat.sub_zero, Nat.reduceAdd, toOption_getSome,
        BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero, Nat.reducePow,
        PoisonOr.value_isRefinedBy_value]
        simp [Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, BitVec.not_le] at hf
        rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
        simp
        bv_omega
  }
-- to do come up with a strategy / structure
def llvm_ashr_lower_riscv_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64),
  Ty.llvm (.bitvec 64)] :=
  {lhs := ashr_llvm_exact_flag, rhs := ashr_riscv ,
    correct :=  by
      unfold ashr_llvm_exact_flag ashr_riscv -- think of adding these to simp peephole
      simp_peephole
      simp_riscv
      simp_alive_undef
      simp [LLVM.ashr?]
      simp_alive_case_bash
      intro x x'
      simp_alive_split
      simp
      rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
      bv_omega
  }
