
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddhshift_proof
theorem flip_add_of_shift_neg_thm (e✝ e✝¹ e✝² : IntW 8) :
  add (shl (sub (const? 0) e✝²) e✝¹ { «nsw» := true, «nuw» := true }) e✝ ⊑ sub e✝ (shl e✝² e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


