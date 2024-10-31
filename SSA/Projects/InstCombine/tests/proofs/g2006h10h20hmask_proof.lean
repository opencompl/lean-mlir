
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2006h10h20hmask_proof
theorem foo_thm (e✝ e✝¹ : IntW 64) :
  zext 64 (LLVM.and (trunc 32 e✝¹) (trunc 32 e✝)) ⊑ LLVM.and (LLVM.and e✝¹ e✝) (const? 4294967295) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


