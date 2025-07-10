
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhor_proof
theorem or_and_not_constant_commute0_proof.or_and_not_constant_commute0_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.or e_1 e) (const? 32 1)) (LLVM.and e_1 (const? 32 (-2))) ⊑
    LLVM.or (LLVM.and e (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_not_constant_commute1_proof.or_and_not_constant_commute1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (const? 32 1) (LLVM.or e e_1)) (LLVM.and (const? 32 (-2)) e_1) ⊑
    LLVM.or (LLVM.and e (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_not_constant_commute2_proof.or_and_not_constant_commute2_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and e_1 (const? 32 (-2))) (LLVM.and (LLVM.or e_1 e) (const? 32 1)) ⊑
    LLVM.or (LLVM.and e (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_not_constant_commute3_proof.or_and_not_constant_commute3_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (const? 32 (-2)) e_1) (LLVM.and (const? 32 1) (LLVM.or e e_1)) ⊑
    LLVM.or (LLVM.and e (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or_hoist_mask_proof.and_or_hoist_mask_thm_1 (e e_1 : IntW 8) :
  LLVM.and (LLVM.or (lshr e (const? 8 6)) e_1) (const? 8 3) ⊑
    LLVM.or (lshr e (const? 8 6)) (LLVM.and e_1 (const? 8 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_xor_hoist_mask_commute_proof.and_xor_hoist_mask_commute_thm_1 (e e_1 : IntW 8) :
  LLVM.and (LLVM.xor (mul e_1 (const? 8 43)) (lshr e (const? 8 6))) (const? 8 3) ⊑
    LLVM.xor (LLVM.and (mul e_1 (const? 8 3)) (const? 8 3)) (lshr e (const? 8 6)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_complex_proof.or_or_and_complex_thm_1 (e : IntW 64) :
  LLVM.or
      (LLVM.or
        (LLVM.or
          (LLVM.or
            (LLVM.or
              (LLVM.or
                (LLVM.or (LLVM.and (lshr e (const? 64 8)) (const? 64 71776119061217280))
                  (LLVM.and (shl e (const? 64 8)) (const? 64 (-72057594037927936))))
                (LLVM.and (lshr e (const? 64 8)) (const? 64 1095216660480)))
              (LLVM.and (shl e (const? 64 8)) (const? 64 280375465082880)))
            (LLVM.and (lshr e (const? 64 8)) (const? 64 16711680)))
          (LLVM.and (shl e (const? 64 8)) (const? 64 4278190080)))
        (LLVM.and (lshr e (const? 64 8)) (const? 64 255)))
      (LLVM.and (shl e (const? 64 8)) (const? 64 65280)) ⊑
    LLVM.or (LLVM.and (lshr e (const? 64 8)) (const? 64 71777214294589695))
      (LLVM.and (shl e (const? 64 8)) (const? 64 (-71777214294589696))) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat1_proof.or_or_and_pat1_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e e_3)) (LLVM.and e e_1) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e (LLVM.or e_3 e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat2_proof.or_or_and_pat2_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_3 e)) (LLVM.and e e_1) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and (LLVM.or e_3 e_1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat3_proof.or_or_and_pat3_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_1 e_3)) (LLVM.and e e_1) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_1 (LLVM.or e_3 e)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat4_proof.or_or_and_pat4_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_3 e_1)) (LLVM.and e e_1) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and (LLVM.or e_3 e) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat5_proof.or_or_and_pat5_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.and e e_3) e_2) (LLVM.and e e_1) ⊑ LLVM.or (LLVM.and e (LLVM.or e_3 e_1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat6_proof.or_or_and_pat6_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.and e_3 e) e_2) (LLVM.and e e_1) ⊑ LLVM.or (LLVM.and (LLVM.or e_3 e_1) e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat7_proof.or_or_and_pat7_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.and e_1 e_3) e_2) (LLVM.and e e_1) ⊑ LLVM.or (LLVM.and e_1 (LLVM.or e_3 e)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_and_pat8_proof.or_or_and_pat8_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (LLVM.and e_3 e_1) e_2) (LLVM.and e e_1) ⊑ LLVM.or (LLVM.and (LLVM.or e_3 e) e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat1_proof.or_and_or_pat1_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e e_3)) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e (LLVM.or e_3 e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat2_proof.or_and_or_pat2_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_3 e)) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and (LLVM.or e_3 e_1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat3_proof.or_and_or_pat3_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_1 e_3)) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_1 (LLVM.or e_3 e)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat4_proof.or_and_or_pat4_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and e_3 e_1)) ⊑
    LLVM.or (LLVM.udiv (const? 8 42) e_2) (LLVM.and (LLVM.or e_3 e) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat5_proof.or_and_or_pat5_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.and e e_3) e_2) ⊑ LLVM.or (LLVM.and e (LLVM.or e_3 e_1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat6_proof.or_and_or_pat6_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.and e_3 e) e_2) ⊑ LLVM.or (LLVM.and (LLVM.or e_3 e_1) e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat7_proof.or_and_or_pat7_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.and e_1 e_3) e_2) ⊑ LLVM.or (LLVM.and e_1 (LLVM.or e_3 e)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_or_pat8_proof.or_and_or_pat8_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.and e e_1) (LLVM.or (LLVM.and e_3 e_1) e_2) ⊑ LLVM.or (LLVM.and (LLVM.or e_3 e) e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
