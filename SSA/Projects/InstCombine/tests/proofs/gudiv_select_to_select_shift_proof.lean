
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gudiv_select_to_select_shift_proof
theorem test_thm (e✝ : IntW 1) (e✝¹ : IntW 64) :
  add (LLVM.udiv e✝¹ (select e✝ (const? 16) (const? 8))) (LLVM.udiv e✝¹ (select e✝ (const? 8) (const? 0))) ⊑
    add (lshr e✝¹ (const? 4)) (lshr e✝¹ (const? 3)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


