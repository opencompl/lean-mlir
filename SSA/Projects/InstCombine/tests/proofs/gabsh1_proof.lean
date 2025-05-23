
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gabsh1_proof
theorem abs_must_be_positive_thm (e : IntW 32) :
  icmp IntPred.sge
      (select (icmp IntPred.sge e (const? 32 0)) e (sub (const? 32 0) e { «nsw» := true, «nuw» := false }))
      (const? 32 0) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem abs_diff_signed_slt_swap_wrong_pred1_thm (e e_1 : IntW 32) :
  select (icmp IntPred.eq e_1 e) (sub e e_1 { «nsw» := true, «nuw» := false })
      (sub e_1 e { «nsw» := true, «nuw» := false }) ⊑
    sub e_1 e { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
