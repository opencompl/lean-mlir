
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmaskedhmergehor_proof
theorem n3_constmask_samemask_thm :
  ∀ (e e_1 : IntW 32),
    LLVM.or (LLVM.and e_1 (const? 65280)) (LLVM.and e (const? 65280)) ⊑ LLVM.and (LLVM.or e_1 e) (const? 65280) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


