
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gandhxorhor_proof
theorem and_xor_common_op_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 43) e)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 43) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_common_op_commute1_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 43) e) (LLVM.udiv (const? 32 42) e_1)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 43) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_common_op_commute2_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.udiv (const? 32 43) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 43) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_not_common_op_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor e_1 (LLVM.xor e (const? 32 (-1)))) e_1 ⊑ LLVM.and e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_xor_common_op_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1))) e ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_thm (e e_1 : IntW 64) : add (LLVM.and e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or2_thm (e e_1 : IntW 64) : LLVM.or (LLVM.and e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or1_thm (e e_1 e_2 : IntW 64) :
  LLVM.or
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1)) (LLVM.udiv (const? 64 42) e))
      (LLVM.udiv (const? 64 42) e_1) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e) (LLVM.udiv (const? 64 42) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or2_thm (e e_1 e_2 : IntW 64) :
  LLVM.or
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1)) (LLVM.udiv (const? 64 42) e))
      (LLVM.udiv (const? 64 42) e_2) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e) (LLVM.udiv (const? 64 42) e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or3_thm (e e_1 e_2 : IntW 64) :
  LLVM.or
      (LLVM.xor (LLVM.udiv (const? 64 42) e_2) (LLVM.and (LLVM.udiv (const? 64 42) e_1) (LLVM.udiv (const? 64 42) e)))
      (LLVM.udiv (const? 64 42) e) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or4_thm (e e_1 e_2 : IntW 64) :
  LLVM.or
      (LLVM.xor (LLVM.udiv (const? 64 42) e_2) (LLVM.and (LLVM.udiv (const? 64 42) e_1) (LLVM.udiv (const? 64 42) e)))
      (LLVM.udiv (const? 64 42) e_1) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or5_thm (e e_1 e_2 : IntW 64) :
  LLVM.or (LLVM.udiv (const? 64 42) e_2)
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 64 42) e_1) (LLVM.udiv (const? 64 42) e_2)) (LLVM.udiv (const? 64 42) e)) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or6_thm (e e_1 e_2 : IntW 64) :
  LLVM.or (LLVM.udiv (const? 64 42) e_2)
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1)) (LLVM.udiv (const? 64 42) e)) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or7_thm (e e_1 e_2 : IntW 64) :
  LLVM.or (LLVM.udiv (const? 64 42) e_2)
      (LLVM.xor (LLVM.udiv (const? 64 42) e_1) (LLVM.and (LLVM.udiv (const? 64 42) e) (LLVM.udiv (const? 64 42) e_2))) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_or8_thm (e e_1 e_2 : IntW 64) :
  LLVM.or (LLVM.udiv (const? 64 42) e_2)
      (LLVM.xor (LLVM.udiv (const? 64 42) e_1) (LLVM.and (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e))) ⊑
    LLVM.or (LLVM.udiv (const? 64 42) e_2) (LLVM.udiv (const? 64 42) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_shl_thm (e e_1 e_2 e_3 : IntW 8) :
  LLVM.and (shl e_3 e_2) (LLVM.and (shl e_1 e_2) e) ⊑ LLVM.and (shl (LLVM.and e_1 e_3) e_2) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_shl_thm (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (LLVM.or (shl e_3 e_2) e_1) (shl e e_2) ⊑ LLVM.or (shl (LLVM.or e_3 e) e_2) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_lshr_thm (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (lshr e_3 e_2) (LLVM.or (lshr e_1 e_2) e) ⊑ LLVM.or (lshr (LLVM.or e_1 e_3) e_2) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_lshr_thm (e e_1 e_2 e_3 : IntW 8) :
  LLVM.xor (LLVM.xor (lshr e_3 e_2) e_1) (lshr e e_2) ⊑ LLVM.xor (lshr (LLVM.xor e_3 e) e_2) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_lshr_multiuse_thm (e e_1 e_2 e_3 : IntW 8) :
  LLVM.sdiv (LLVM.xor (lshr e_3 e_2) e_1) (LLVM.xor (LLVM.xor (lshr e_3 e_2) e_1) (lshr e e_2)) ⊑
    LLVM.sdiv (LLVM.xor (lshr e_3 e_2) e_1) (LLVM.xor (lshr (LLVM.xor e_3 e) e_2) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_not_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_not_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.and e_1 (LLVM.xor (LLVM.or e_2 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_not_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_not_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and e_2 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.and (LLVM.xor (LLVM.or e_2 e) (const? 32 (-1))) e_1) ⊑
    LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1))) e)
      (LLVM.and (LLVM.sdiv (const? 32 42) e_1) (LLVM.xor (LLVM.or e_2 e) (const? 32 (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) e) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.and (LLVM.xor (LLVM.or e_1 (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.and (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) e_2) ⊑
    LLVM.and (LLVM.xor e_2 e) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.and (LLVM.xor (LLVM.or e_1 (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.or
      (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_1) e) (const? 32 (-1))))
      (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_1) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2))
      (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute6_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.and (LLVM.xor (LLVM.or e e_2) (const? 32 (-1))) e_1) ⊑
    LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute7_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.and (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) e_2) ⊑
    LLVM.and (LLVM.xor e_2 e) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute8_thm (e e_1 e_2 : IntW 32) :
  LLVM.or
      (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1))) e)
      (LLVM.and (LLVM.sdiv (const? 32 42) e_1) (LLVM.xor (LLVM.or e (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) e)
      (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_commute9_thm (e e_1 e_2 : IntW 32) :
  LLVM.or
      (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1)))
        (LLVM.sdiv (const? 32 42) e))
      (LLVM.and (LLVM.sdiv (const? 32 42) e_1)
        (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e)) (const? 32 (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) (LLVM.sdiv (const? 32 42) e))
      (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_wrong_c_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))) e_1)
      (LLVM.and (LLVM.xor (LLVM.or e_3 e) (const? 32 (-1))) e_2) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))))
      (LLVM.and e_2 (LLVM.xor (LLVM.or e_3 e) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_wrong_b_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))) e_1)
      (LLVM.and (LLVM.xor (LLVM.or e_3 e_1) (const? 32 (-1))) e) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))))
      (LLVM.and e (LLVM.xor (LLVM.or e_3 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.or (LLVM.xor (LLVM.and e_2 e) (const? 32 (-1))) e_1) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1))) e)
      (LLVM.or (LLVM.sdiv (const? 32 42) e_1) (LLVM.xor (LLVM.and e_2 e) (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.or (LLVM.xor (LLVM.and e_1 (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.or (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) e_2) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.or (LLVM.xor (LLVM.and e_1 (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.and
      (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_1) e) (const? 32 (-1))))
      (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_1) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) (LLVM.sdiv (const? 32 42) e_1))
      (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute6_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.or (LLVM.xor (LLVM.and e e_2) (const? 32 (-1))) e_1) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute7_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.or (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) e_2) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute8_thm (e e_1 e_2 : IntW 32) :
  LLVM.and
      (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1))) e)
      (LLVM.or (LLVM.sdiv (const? 32 42) e_1) (LLVM.xor (LLVM.and e (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) e) (LLVM.sdiv (const? 32 42) e_2))
      (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_commute9_thm (e e_1 e_2 : IntW 32) :
  LLVM.and
      (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e_1)) (const? 32 (-1)))
        (LLVM.sdiv (const? 32 42) e))
      (LLVM.or (LLVM.sdiv (const? 32 42) e_1)
        (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.sdiv (const? 32 42) e)) (const? 32 (-1)))) ⊑
    LLVM.xor
      (LLVM.and (LLVM.xor (LLVM.sdiv (const? 32 42) e_1) (LLVM.sdiv (const? 32 42) e)) (LLVM.sdiv (const? 32 42) e_2))
      (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_wrong_c_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))) e_1)
      (LLVM.or (LLVM.xor (LLVM.and e_3 e) (const? 32 (-1))) e_2) ⊑
    LLVM.and (LLVM.or e_1 (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))))
      (LLVM.or e_2 (LLVM.xor (LLVM.and e_3 e) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_wrong_b_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))) e_1)
      (LLVM.or (LLVM.xor (LLVM.and e_3 e_1) (const? 32 (-1))) e) ⊑
    LLVM.and (LLVM.or e_1 (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))))
      (LLVM.or e (LLVM.xor (LLVM.and e_3 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.or e e_2) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e (LLVM.sdiv (const? 32 42) e_2)) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.or e e_2) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.or e_2 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) (LLVM.and (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) e_2) ⊑
    LLVM.xor (LLVM.or (LLVM.and e e_2) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute6_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_1 (LLVM.sdiv (const? 32 42) e_2)) e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_commute7_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_wrong_a_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))) e_1) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))))
      (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_not_not_wrong_b_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))) e_1) (LLVM.xor (LLVM.or e e_3) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor (LLVM.or e_3 e_2) (const? 32 (-1))))
      (LLVM.xor (LLVM.or e e_3) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.and e e_2) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e (LLVM.sdiv (const? 32 42) e_2)) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.and e e_2) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.and e_2 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 e) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) (LLVM.or (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) e_2) ⊑
    LLVM.xor (LLVM.and (LLVM.or e e_2) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute6_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 (LLVM.sdiv (const? 32 42) e_2)) e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_commute7_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_wrong_a_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))) e_1) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or_not_not_wrong_b_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))) e_1) (LLVM.xor (LLVM.and e e_3) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e_1 (LLVM.xor (LLVM.and e_3 e_2) (const? 32 (-1))))
      (LLVM.xor (LLVM.and e e_3) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.or (LLVM.xor e_2 e_1) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e_1) (LLVM.or (LLVM.xor e_2 e_1) e)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.or (LLVM.xor e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e_1) (LLVM.or (LLVM.xor e_1 e_2) e)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.or (LLVM.xor e_1 e) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 e) (LLVM.or (LLVM.xor e_1 e) (LLVM.sdiv (const? 32 42) e_2)))
      (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.or (LLVM.xor e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e_1) (LLVM.or (LLVM.xor e_1 e_2) e)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 e)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_1 e) (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 e)))
      (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or (LLVM.xor e_2 e_1) e) (const? 32 (-1)))
      (LLVM.and (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.or e_2 e_1) (LLVM.or (LLVM.xor e_2 e_1) e)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.and (LLVM.xor e_2 e_1) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_2 e_1) e) (LLVM.or e (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.and (LLVM.xor e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e_2) e) (LLVM.or e (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.and (LLVM.xor e_1 e) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e) (LLVM.sdiv (const? 32 42) e_2))
      (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e)
      (LLVM.xor (LLVM.and (LLVM.xor e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e_2) e) (LLVM.or e (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 e)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 e))
      (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute5_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and (LLVM.xor e_2 e_1) e) (const? 32 (-1)))
      (LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_2 e_1) e) (LLVM.or e (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.or (LLVM.or e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.or (LLVM.or e e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.or (LLVM.or e_1 e) e_2) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.or (LLVM.or e e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and e_2 e_1) (LLVM.xor e (const? 32 (-1))))
      (LLVM.xor (LLVM.or (LLVM.or e_2 e) e_1) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e_2 e_1) e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.or (LLVM.or e_2 e_1) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.sdiv (const? 32 42) e))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e) (LLVM.or e_1 e_2)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor (LLVM.sdiv (const? 32 42) e) e_1) e_2) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) e)
      (LLVM.xor (LLVM.or (LLVM.or (LLVM.sdiv (const? 32 42) e_2) e_1) e) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_not_or_or_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e))
      (LLVM.xor (LLVM.or (LLVM.or e e_1) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) e) e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.and (LLVM.and e_1 e_2) e) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.and (LLVM.and e e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.and (LLVM.and e_1 e) e_2) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.and (LLVM.and e e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or e_2 e_1) (LLVM.xor e (const? 32 (-1))))
      (LLVM.xor (LLVM.and (LLVM.and e_2 e) e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e_2 e_1) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e)
      (LLVM.xor (LLVM.and (LLVM.and e_2 e_1) e) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.sdiv (const? 32 42) e))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e) (LLVM.and e_1 e_2)) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor (LLVM.sdiv (const? 32 42) e) e_1) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) e)
      (LLVM.xor (LLVM.and (LLVM.and (LLVM.sdiv (const? 32 42) e_2) e_1) e) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor e (LLVM.sdiv (const? 32 42) e_2)) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_not_and_and_commute4_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e))
      (LLVM.xor (LLVM.and (LLVM.and e e_1) (LLVM.sdiv (const? 32 42) e_2)) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) e) (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.or e_1 e_2) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_commute1_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and e_2 e_1) (LLVM.xor e (const? 32 (-1)))) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e_2 (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_commute2_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.or e e_2) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e_1 (LLVM.xor e (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.or e_2 e_1) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) e)
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 32 42) e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or e (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) (const? 32 (-1))))
      (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_and_and_or_no_or_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e))
      (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑
    LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e (const? 32 (-1))))
      (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.and e_1 e_2) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_commute1_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or e_2 e_1) (LLVM.xor e (const? 32 (-1)))) (LLVM.xor (LLVM.and e_1 e) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e_2 (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_commute2_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.and e e_2) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_commute1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) e) (LLVM.xor (LLVM.and e_2 e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_commute2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e_1 (const? 32 (-1)))) e)
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 32 42) e_2) e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and e (LLVM.xor (LLVM.sdiv (const? 32 42) e_2) (const? 32 (-1))))
      (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_or_and_no_and_commute3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 32 42) e_2) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e))
      (LLVM.xor (LLVM.and e e_1) (const? 32 (-1))) ⊑
    LLVM.or (LLVM.and (LLVM.sdiv (const? 32 42) e_2) (LLVM.xor e (const? 32 (-1))))
      (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_orn_xor_thm (e e_1 : IntW 4) :
  LLVM.and (LLVM.or (LLVM.xor e_1 (const? 4 (-1))) e) (LLVM.xor e_1 e) ⊑
    LLVM.and e (LLVM.xor e_1 (const? 4 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_orn_xor_commute8_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (mul e_1 e_1) (mul e e)) (LLVM.or (mul e_1 e_1) (LLVM.xor (mul e e) (const? 32 (-1)))) ⊑
    LLVM.and (mul e_1 e_1) (LLVM.xor (mul e e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_zext_zext_thm (e : IntW 4) (e_1 : IntW 8) :
  LLVM.and (zext 16 e_1) (zext 16 e) ⊑ zext 16 (LLVM.and e_1 (zext 8 e)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_zext_zext_thm (e : IntW 8) (e_1 : IntW 4) :
  LLVM.or (zext 16 e_1) (zext 16 e) ⊑ zext 16 (LLVM.or e (zext 8 e_1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_sext_sext_thm (e : IntW 8) (e_1 : IntW 4) :
  LLVM.and (sext 16 e_1) (sext 16 e) ⊑ sext 16 (LLVM.and e (sext 8 e_1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_sext_sext_thm (e : IntW 4) (e_1 : IntW 8) :
  LLVM.or (sext 16 e_1) (sext 16 e) ⊑ sext 16 (LLVM.or e_1 (sext 8 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_sext_sext_thm (e : IntW 4) (e_1 : IntW 8) :
  LLVM.xor (sext 16 e_1) (sext 16 e) ⊑ sext 16 (LLVM.xor e_1 (sext 8 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR56294_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (zext 32 (icmp IntPredicate.eq e (const? 8 2))) (zext 32 (LLVM.and e (const? 8 1))))
      (const? 32 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_or0_thm (e : IntW 32) :
  LLVM.or (add e (const? 32 112)) (const? 32 15) ⊑ add (LLVM.or e (const? 32 15)) (const? 32 112) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_or0_nsw_thm (e : IntW 32) :
  LLVM.or (add e (const? 32 112) { «nsw» := true, «nuw» := false }) (const? 32 15) ⊑
    add (LLVM.or e (const? 32 15)) (const? 32 112) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_or0_nswnuw_thm (e : IntW 32) :
  LLVM.or (add e (const? 32 112) { «nsw» := true, «nuw» := true }) (const? 32 15) ⊑
    add (LLVM.or e (const? 32 15)) (const? 32 112) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_and0_thm (e : IntW 8) :
  LLVM.and (add e (const? 8 48)) (const? 8 (-10)) ⊑ add (LLVM.and e (const? 8 (-10))) (const? 8 48) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_and0_nsw_thm (e : IntW 8) :
  LLVM.and (add e (const? 8 48) { «nsw» := true, «nuw» := false }) (const? 8 (-10)) ⊑
    add (LLVM.and e (const? 8 (-10))) (const? 8 48) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_and0_nswnuw_thm (e : IntW 8) :
  LLVM.and (add e (const? 8 48) { «nsw» := true, «nuw» := true }) (const? 8 (-10)) ⊑
    add (LLVM.and e (const? 8 (-10))) (const? 8 48) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_xor_0_thm (e : IntW 8) :
  LLVM.xor (add e (const? 8 96)) (const? 8 31) ⊑ add (LLVM.xor e (const? 8 31)) (const? 8 96) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_xor_0_nsw_thm (e : IntW 8) :
  LLVM.xor (add e (const? 8 96) { «nsw» := true, «nuw» := false }) (const? 8 31) ⊑
    add (LLVM.xor e (const? 8 31)) (const? 8 96) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem canonicalize_logic_first_xor_0_nswnuw_thm (e : IntW 8) :
  LLVM.xor (add e (const? 8 96) { «nsw» := true, «nuw» := true }) (const? 8 31) ⊑
    add (LLVM.xor e (const? 8 31)) (const? 8 96) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_and_xor_freely_invertable_thm (e : IntW 1) (e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (icmp IntPredicate.sgt e_2 e_1) e) e ⊑ LLVM.and (icmp IntPredicate.sle e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
