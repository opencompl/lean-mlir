
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhinhbittest_proof
theorem t0_const_lshr_shl_ne_proof.t0_const_lshr_shl_ne_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (shl e_1 (const? 32 1)) (lshr e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e (const? 32 2)) e_1) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_const_shl_lshr_ne_proof.t1_const_shl_lshr_ne_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e_1 (const? 32 1)) (shl e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e_1 (const? 32 2)) e) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_const_lshr_shl_eq_proof.t2_const_lshr_shl_eq_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl e_1 (const? 32 1)) (lshr e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (lshr e (const? 32 2)) e_1) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_const_after_fold_lshr_shl_ne_proof.t3_const_after_fold_lshr_shl_ne_thm_1 (e e_1 e_2 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e (sub (const? 32 32) e_2)) (shl e_1 (add e_2 (const? 32 (-1))))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e (const? 32 31)) e_1) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_const_after_fold_lshr_shl_ne_proof.t4_const_after_fold_lshr_shl_ne_thm_1 (e e_1 e_2 : IntW 32) :
  icmp IntPred.ne (LLVM.and (shl e (sub (const? 32 32) e_2)) (lshr e_1 (add e_2 (const? 32 (-1))))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e_1 (const? 32 31)) e) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
