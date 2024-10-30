
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gudiv_select_to_select_shift_proof
theorem test_thm :
  ∀ (e : IntW 1) (e_1 : IntW 64),
    add (LLVM.udiv e_1 (select e (const? 16) (const? 8))) (LLVM.udiv e_1 (select e (const? 8) (const? 0))) ⊑
      add (lshr e_1 (const? 4)) (lshr e_1 (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


