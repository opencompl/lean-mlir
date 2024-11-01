
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gavghlsb_proof
theorem avg_lsb_thm (e✝ e✝¹ : IntW 8) :
  lshr (add (LLVM.and e✝¹ (const? 1)) (LLVM.and e✝ (const? 1)) { «nsw» := true, «nuw» := true }) (const? 1) ⊑
    LLVM.and e✝¹ (LLVM.and e✝ (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


