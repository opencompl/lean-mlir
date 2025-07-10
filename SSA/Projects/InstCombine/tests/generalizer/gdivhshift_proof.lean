
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gdivhshift_proof
theorem t1_proof.t1_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  LLVM.sdiv (zext 32 e) (shl (const? 32 2) e_1) ⊑ lshr (zext 32 e) (add e_1 (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  LLVM.udiv e (zext 64 (shl (const? 32 1) e_1)) ⊑ lshr e (zext 64 e_1 { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_proof.t3_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  LLVM.udiv e (zext 64 (shl (const? 32 4) e_1)) ⊑ lshr e (zext 64 (add e_1 (const? 32 2)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t5_proof.t5_thm_1 (e e_1 : IntW 1) (e_2 : IntW 32) :
  LLVM.udiv e_2 (select e_1 (select e (const? 32 32) (const? 32 64)) (shl (const? 32 1) e_2)) ⊑
    lshr e_2 (select e_1 (select e (const? 32 5) (const? 32 6)) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_proof.t7_thm_1 (e : IntW 32) :
  LLVM.sdiv (shl e (const? 32 2) { «nsw» := true }) e ⊑ const? 32 4 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t10_proof.t10_thm_1 (e e_1 : IntW 32) :
  LLVM.sdiv (shl e e_1 { «nsw» := true }) e ⊑ shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t12_proof.t12_thm_1 (e : IntW 32) :
  LLVM.udiv (shl e (const? 32 2) { «nuw» := true }) e ⊑ const? 32 4 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t15_proof.t15_thm_1 (e e_1 : IntW 32) :
  LLVM.udiv (shl e e_1 { «nuw» := true }) e ⊑ shl (const? 32 1) e_1 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_mul_shl_nsw_proof.sdiv_mul_shl_nsw_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.sdiv (mul e e_1 { «nsw» := true }) (shl e e_2 { «nsw» := true }) ⊑
    LLVM.sdiv e_1 (shl (const? 5 1) e_2 { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_mul_shl_nsw_exact_commute1_proof.sdiv_mul_shl_nsw_exact_commute1_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.sdiv (mul e_1 e { «nsw» := true }) (shl e e_2 { «nsw» := true }) { «exact» := true } ⊑
    LLVM.sdiv e_1 (shl (const? 5 1) e_2 { «nuw» := true }) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_mul_shl_nuw_proof.udiv_mul_shl_nuw_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.udiv (mul e e_1 { «nuw» := true }) (shl e e_2 { «nuw» := true }) ⊑ lshr e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_mul_shl_nuw_exact_commute1_proof.udiv_mul_shl_nuw_exact_commute1_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.udiv (mul e_1 e { «nuw» := true }) (shl e e_2 { «nuw» := true }) { «exact» := true } ⊑
    lshr e_1 e_2 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_mul_nuw_proof.udiv_shl_mul_nuw_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e e_2 { «nuw» := true }) (mul e e_1 { «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 5 1) e_2 { «nuw» := true }) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_mul_nuw_swap_proof.udiv_shl_mul_nuw_swap_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e e_2 { «nuw» := true }) (mul e_1 e { «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 5 1) e_2 { «nuw» := true }) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_mul_nuw_exact_proof.udiv_shl_mul_nuw_exact_thm_1 (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e e_2 { «nuw» := true }) (mul e e_1 { «nuw» := true }) { «exact» := true } ⊑
    LLVM.udiv (shl (const? 5 1) e_2 { «nuw» := true }) e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_lshr_mul_nuw_proof.udiv_lshr_mul_nuw_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.udiv (lshr (mul e e_1 { «nuw» := true }) e_2) e ⊑ lshr e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_shl_shl_nsw2_nuw_proof.sdiv_shl_shl_nsw2_nuw_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.sdiv (shl e e_2 { «nsw» := true }) (shl e_1 e_2 { «nsw» := true, «nuw» := true }) ⊑ LLVM.sdiv e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_shl_nuw_nsw2_proof.udiv_shl_shl_nuw_nsw2_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.udiv (shl e e_2 { «nsw» := true, «nuw» := true }) (shl e_1 e_2 { «nsw» := true }) ⊑ LLVM.udiv e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_shl_pair_const_proof.sdiv_shl_pair_const_thm_1 (e : IntW 32) :
  LLVM.sdiv (shl e (const? 32 2) { «nsw» := true }) (shl e (const? 32 1) { «nsw» := true }) ⊑ const? 32 2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_pair_const_proof.udiv_shl_pair_const_thm_1 (e : IntW 32) :
  LLVM.udiv (shl e (const? 32 2) { «nuw» := true }) (shl e (const? 32 1) { «nuw» := true }) ⊑ const? 32 2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_shl_pair1_proof.sdiv_shl_pair1_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e e_1 { «nsw» := true }) (shl e e_2 { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_shl_pair2_proof.sdiv_shl_pair2_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e e_1 { «nsw» := true, «nuw» := true }) (shl e e_2 { «nsw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_shl_pair3_proof.sdiv_shl_pair3_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e e_1 { «nsw» := true }) (shl e e_2 { «nsw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_pair1_proof.udiv_shl_pair1_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e e_1 { «nuw» := true }) (shl e e_2 { «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_pair2_proof.udiv_shl_pair2_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e e_1 { «nsw» := true, «nuw» := true }) (shl e e_2 { «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_shl_pair3_proof.udiv_shl_pair3_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e e_1 { «nuw» := true }) (shl e e_2 { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nuw» := true }) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
