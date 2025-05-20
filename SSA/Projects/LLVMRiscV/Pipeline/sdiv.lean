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

/-! # SDIV no exact   -/

def sdiv_llvm_no_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sdiv  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
-- at the moment unsure how the conversion cast will eliminate
def sdiv_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> !i64
      %2 = div  %0, %1 : !i64 -- value depends on wether to no overflow flag is present or not
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_sdiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64),
  Ty.llvm (.bitvec 64)] :=
  {lhs := sdiv_llvm_no_exact , rhs := sdiv_riscv, correct := by
    unfold sdiv_llvm_no_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp [castriscvToLLVM, DIV_pure64_signed_bv, castLLVMToriscv, LLVM.sdiv?]
    simp_alive_case_bash
    intro x x'
    by_cases onX2 :  x' = 0#64 <;>  simp [onX2]
    · by_cases h:  x = BitVec.intMin 64 ∧ x' = 18446744073709551615#64 <;> simp [h]
  }

/-! # SDIV exact   -/
def sdiv_llvm_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sdiv exact %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_sdiv_lower_riscv_exact : LLVMPeepholeRewriteRefine 64  [Ty.llvm (.bitvec 64),
  Ty.llvm (.bitvec 64)] :=
  {lhs := sdiv_llvm_exact, rhs := sdiv_riscv, correct := by
    unfold sdiv_llvm_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp [castriscvToLLVM, DIV_pure64_signed_bv, castLLVMToriscv, LLVM.sdiv?]
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x.smod x' = 0#64 <;>  simp [onX2]
    split
    case pos.isTrue ht =>
      simp[ht]
    case pos.isFalse hf =>
      simp at hf
      simp [hf]
    }
