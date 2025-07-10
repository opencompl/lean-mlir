
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gabsh1_proof
theorem abs_must_be_positive_proof.abs_must_be_positive_thm_1 (e : IntW 32) :
  icmp IntPred.sge (select (icmp IntPred.sge e (const? 32 0)) e (sub (const? 32 0) e { «nsw» := true })) (const? 32 0) ⊑
    const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem abs_diff_signed_slt_swap_wrong_pred1_proof.abs_diff_signed_slt_swap_wrong_pred1_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq e e_1) (sub e_1 e { «nsw» := true }) (sub e e_1 { «nsw» := true }) ⊑
    sub e e_1 { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
