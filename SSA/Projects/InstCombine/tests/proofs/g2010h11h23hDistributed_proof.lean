
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2010h11h23hDistributed_proof
theorem foo_thm (e✝ e✝¹ : IntW 32) :
  sub (mul (add e✝¹ e✝ { «nsw» := true, «nuw» := false }) e✝¹ { «nsw» := true, «nuw» := false })
      (mul e✝¹ e✝¹ { «nsw» := true, «nuw» := false }) ⊑
    mul e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


