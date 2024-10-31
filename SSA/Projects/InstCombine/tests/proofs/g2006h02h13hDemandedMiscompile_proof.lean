
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2006h02h13hDemandedMiscompile_proof
theorem test_thm (e✝ : IntW 8) : ashr (sext 32 e✝) (const? 8) ⊑ sext 32 (ashr e✝ (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


