
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gabsh1_proof
theorem abs_must_be_positive_thm (e : IntW 32) :
  icmp IntPredicate.sge
      (select (icmp IntPredicate.sge e (const? 32 0)) e (sub (const? 32 0) e { «nsw» := true, «nuw» := false }))
      (const? 32 0) ⊑
    const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem abs_diff_signed_slt_swap_wrong_pred1_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq e_1 e) (sub e e_1 { «nsw» := true, «nuw» := false })
      (sub e_1 e { «nsw» := true, «nuw» := false }) ⊑
    sub e_1 e { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


