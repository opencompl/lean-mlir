
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthdirectionhinhbithtest_proof
theorem t7_twoshifts2_proof.t7_twoshifts2_thm_1 (e_1 e_2 e_3 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl e_2 e_3) (shl (const? 32 1) e_1)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (shl e_2 e_3) (shl (const? 32 1) e_1 { «nuw» := true })) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t8_twoshifts3_proof.t8_twoshifts3_thm_1 (e e_1 e_3 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_3) (shl e e_1)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_3 { «nuw» := true }) (shl e e_1)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t12_shift_of_const0_proof.t12_shift_of_const0_thm_1 (e_1 e_2 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1) e_2) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) e_2) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t14_and_with_const0_proof.t14_and_with_const0_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl e e_1) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and e (lshr (const? 32 1) e_1)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t15_and_with_const1_proof.t15_and_with_const1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and e (shl (const? 32 1) e_1 { «nuw» := true })) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
