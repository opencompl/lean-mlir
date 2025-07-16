
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gunsignedhsubhlackhofhoverflowhcheck_proof
theorem t0_basic_proof.t0_basic_thm_1 (e e_1 : IntW 8) : icmp IntPred.ule (sub e e_1) e ⊑ icmp IntPred.ule e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_commutative_proof.t2_commutative_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.uge e (sub e e_1) ⊑ icmp IntPred.uge e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n7_wrong_pred2_proof.n7_wrong_pred2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (sub e e_1) e ⊑ icmp IntPred.eq e_1 (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n8_wrong_pred3_proof.n8_wrong_pred3_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (sub e e_1) e ⊑ icmp IntPred.ne e_1 (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
