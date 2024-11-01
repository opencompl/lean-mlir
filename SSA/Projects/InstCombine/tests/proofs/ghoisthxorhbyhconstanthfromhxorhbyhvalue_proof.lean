
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghoisthxorhbyhconstanthfromhxorhbyhvalue_proof
theorem t0_scalar_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (LLVM.xor e✝¹ (const? 42)) e✝ ⊑ LLVM.xor (LLVM.xor e✝¹ e✝) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


