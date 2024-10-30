
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophselect_proof
theorem and_sel_op0_thm : ∀ (e : IntW 1), LLVM.and (select e (const? 25) (const? 0)) (const? 1) ⊑ zext 32 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_sel_op0_thm :
  ∀ (e : IntW 32) (e_1 : IntW 1),
    mul (select e_1 (const? 0) (LLVM.udiv (const? 42) e)) e ⊑ select e_1 (const? 0) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_sel_op1_thm :
  ∀ (e : IntW 1),
    sub (const? 42) (select e (const? 42) (const? 41)) { «nsw» := true, «nuw» := false } ⊑
      zext 32 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_sel_op1_thm :
  ∀ (e : IntW 1), ashr (const? (-2)) (select e (const? 2) (const? 0)) ⊑ select e (const? (-1)) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


