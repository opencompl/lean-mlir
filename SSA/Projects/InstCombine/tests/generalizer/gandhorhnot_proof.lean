
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhorhnot_proof
theorem and_to_xor1_proof.and_to_xor1_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e e_1) (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_to_xor2_proof.and_to_xor2_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) (LLVM.or e e_1) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_to_xor3_proof.and_to_xor3_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e e_1) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_to_xor4_proof.and_to_xor4_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_to_nxor1_proof.or_to_nxor1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and e e_1) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_to_nxor2_proof.or_to_nxor2_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and e e_1) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_to_nxor3_proof.or_to_nxor3_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) (LLVM.and e e_1) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_to_nxor4_proof.or_to_nxor4_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) (LLVM.and e_1 e) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_to_xor1_proof.xor_to_xor1_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e e_1) (LLVM.or e e_1) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_to_xor2_proof.xor_to_xor2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e e_1) (LLVM.or e_1 e) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_to_xor3_proof.xor_to_xor3_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.and e e_1) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_to_xor4_proof.xor_to_xor4_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.and e_1 e) ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR32830_proof.PR32830_thm_1 (e e_1 e_2 : IntW 64) :
  LLVM.and (LLVM.or (LLVM.xor e_1 (const? 64 (-1))) e) (LLVM.or (LLVM.xor e (const? 64 (-1))) e_2) ⊑
    LLVM.and (LLVM.or e (LLVM.xor e_1 (const? 64 (-1)))) (LLVM.or e_2 (LLVM.xor e (const? 64 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_to_nxor_multiuse_proof.or_to_nxor_multiuse_thm_1 (e e_1 : IntW 32) :
  mul (mul (LLVM.and e e_1) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))))
      (LLVM.or (LLVM.and e e_1) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1)))) ⊑
    mul (mul (LLVM.and e e_1) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))))
      (LLVM.or (LLVM.and e e_1) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem simplify_or_common_op_commute0_proof.simplify_or_common_op_commute0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and e e_1) e_2) (const? 4 (-1))) e ⊑ const? 4 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem simplify_or_common_op_commute1_proof.simplify_or_common_op_commute1_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and e_1 e) e_2) (const? 4 (-1))) e ⊑ const? 4 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem simplify_or_common_op_commute2_proof.simplify_or_common_op_commute2_thm_1 (e e_1 e_2 e_3 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and (mul e_2 e_2) (LLVM.and e e_1)) e_3) (const? 4 (-1))) e ⊑ const? 4 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem simplify_and_common_op_commute1_proof.simplify_and_common_op_commute1_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.and (LLVM.xor (LLVM.or (LLVM.or e_1 e) e_2) (const? 4 (-1))) e ⊑ const? 4 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem simplify_and_common_op_commute2_proof.simplify_and_common_op_commute2_thm_1 (e e_1 e_2 e_3 : IntW 4) :
  LLVM.and (LLVM.xor (LLVM.or (LLVM.or (mul e_2 e_2) (LLVM.or e e_1)) e_3) (const? 4 (-1))) e ⊑ const? 4 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reduce_xor_common_op_commute0_proof.reduce_xor_common_op_commute0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.xor e e_1) e_2) e ⊑ LLVM.or (LLVM.xor e_1 e_2) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reduce_xor_common_op_commute1_proof.reduce_xor_common_op_commute1_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.xor e_1 e) e_2) e ⊑ LLVM.or (LLVM.xor e_1 e_2) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem annihilate_xor_common_op_commute2_proof.annihilate_xor_common_op_commute2_thm_1 (e e_1 e_2 e_3 : IntW 4) :
  LLVM.xor (LLVM.xor (LLVM.xor (mul e_2 e_2) (LLVM.xor e e_1)) e_3) e ⊑
    LLVM.xor (LLVM.xor e_1 (mul e_2 e_2)) e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
