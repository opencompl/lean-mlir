
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.Pipeline.simpproc
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/- # SRL, not exact
logical right shift operation
in LLVM: if exact flag is set, then returns poison if any non zero bit is shifted  -/

def lshr_llvm_no_flag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.lshr %x, %amount : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def srl_riscv := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %base = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i64) -> !i64
       %res = srl %base, %shamt : !i64
       %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
      llvm.return %y : i64
  }]

/-!
Remove bitvec lemmas from the simp-set that simplify bitvector operations into toNat operations.
Currently, the bit-shift operations all do this. Instead, these should probably be part of
the `toNat` simpset.
-/
attribute [-simp] BitVec.ushiftRight_eq' BitVec.shiftLeft_eq' BitVec.sshiftRight_eq'


def llvm_srl_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := lshr_llvm_no_flag , rhs := srl_riscv ,
    correct :=  by
      unfold lshr_llvm_no_flag srl_riscv
      simp_peephole
      simp_alive_undef
      simp [castriscvToLLVM, RTYPE_pure64_RISCV_SRL_bv, castLLVMToriscv,  LLVM.lshr?]
      simp_alive_case_bash
      intro x x'
      split
      · case value.value.isTrue htt =>
          simp
      · case value.value.isFalse hff =>
          simp at hff
          simp only [toOption_getSome, PoisonOr.value_isRefinedBy_value]
          bv_decide
    }

def lshr_llvm_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.lshr exact %x, %amount : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64 }]
-- TO DO !!!!!! USE ONE STYLE CONSISTENTL · vs cases 
def llvm_srl_lower_riscv_exact : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := lshr_llvm_exact, rhs := srl_riscv,
    correct :=  by
      unfold lshr_llvm_exact srl_riscv
      simp_peephole
      simp_alive_undef
      simp [castriscvToLLVM, RTYPE_pure64_RISCV_SRL_bv, castLLVMToriscv, LLVM.lshr?]
      simp_alive_case_bash
      intro x x'
      split
      case value.value.isTrue htt =>
          simp
          split
          · simp
          · simp
            bv_decide
      case value.value.isFalse hff =>
          simp
  }
