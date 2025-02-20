
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gorhxor_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor e_1 (const? 32 (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_commuted_x_y_thm (e e_1 : IntW 64) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor e (const? 64 (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? 64 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_common_op_commute0_thm (e e_1 : IntW 8) : LLVM.or (LLVM.xor e_1 e) e_1 ⊑ LLVM.or e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_common_op_commute2_thm (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor e_1 (const? 8 5)) (LLVM.xor (LLVM.xor e_1 (const? 8 5)) e) ⊑
    LLVM.or (LLVM.xor e_1 (const? 8 5)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_common_op_commute3_thm (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor e_1 (const? 8 5)) (LLVM.xor (mul e e) (LLVM.xor e_1 (const? 8 5))) ⊑
    LLVM.or (LLVM.xor e_1 (const? 8 5)) (mul e e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor e (LLVM.xor e_1 (const? 32 (-1)))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_commuted_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e e_1) ⊑
    LLVM.or (LLVM.xor e e_1) (LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 e) (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.or e_1 e) ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_commuted_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.or e e_1) ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e e_1 : IntW 32) : LLVM.xor (LLVM.or e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e_1 (LLVM.xor e (const? 32 (-1)))) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.xor e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_commuted_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.or (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.xor e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_commuted_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.and (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_xor_not_constant_commute0_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor e_1 e) (const? 32 1)) (LLVM.and e (const? 32 (-2))) ⊑
    LLVM.xor (LLVM.and e_1 (const? 32 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and_xor_not_constant_commute1_thm (e e_1 : IntW 9) :
  LLVM.or (LLVM.and (LLVM.xor e_1 e) (const? 9 42)) (LLVM.and e_1 (const? 9 (-43))) ⊑
    LLVM.xor (LLVM.and e (const? 9 42)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_or_xor_thm (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 8 (-1))) (const? 8 7)) (const? 8 12) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 (-13)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_or_thm (e : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 32)) (const? 8 7) ⊑ LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 39) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_or2_thm (e : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 33)) (const? 8 7) ⊑ LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 39) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_or_xor_thm (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 8 33)) (const? 8 7)) (const? 8 12) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 43) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_or_thm (e : IntW 8) :
  LLVM.or (LLVM.xor (LLVM.or e (const? 8 33)) (const? 8 12)) (const? 8 7) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-40))) (const? 8 47) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e e_1 : IntW 8) :
  mul (LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1)) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) ⊑
    mul (LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 8 33)))
      (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e e_1 : IntW 8) :
  mul (LLVM.or (LLVM.xor (LLVM.xor e_1 (const? 8 33)) e) (LLVM.xor e e_1)) (LLVM.xor (LLVM.xor e_1 (const? 8 33)) e) ⊑
    mul (LLVM.or (LLVM.xor (LLVM.xor e_1 e) (const? 8 33)) (LLVM.xor e e_1))
      (LLVM.xor (LLVM.xor e_1 e) (const? 8 33)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test20_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.or (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test21_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (LLVM.or e_1 e) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (LLVM.or e e_1) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test23_thm (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor (LLVM.or e (const? 8 (-2))) (const? 8 13)) (const? 8 1)) (const? 8 12) ⊑
    const? 8 (-1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR45977_f1_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.xor e_1 (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR45977_f2_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.or e_1 (LLVM.xor e (const? 32 (-1)))) ⊑ LLVM.xor e_1 (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_common_op_commute0_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or e_2 e_1) (LLVM.xor e_2 e) ⊑ LLVM.or (LLVM.or e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_common_op_commute5_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or e e_2) ⊑ LLVM.or (LLVM.or e e_2) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_common_op_commute6_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or e_1 e) ⊑ LLVM.or (LLVM.or e_1 e) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_common_op_commute7_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or e e_1) ⊑ LLVM.or (LLVM.or e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute0_thm (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.or (LLVM.xor e_2 (const? 4 (-1))) e_1) (LLVM.xor e_2 e) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and e_2 e) (const? 4 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute2_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or (sub (const? 8 0) e) (LLVM.xor e_2 (const? 8 (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 8 (-1))) (sub (const? 8 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute3_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e_1 (const? 8 (-1)))) (LLVM.xor e_1 e) ⊑
    LLVM.or (LLVM.xor (LLVM.and e_1 e) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute5_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    LLVM.or e (LLVM.xor (LLVM.and e_2 e_1) (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute6_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e_1) (LLVM.or (sub (const? 8 0) e) (LLVM.xor e_1 (const? 8 (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 8 (-1))) (sub (const? 8 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_not_xor_common_op_commute7_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e_1 (const? 8 (-1)))) (LLVM.xor e e_1) ⊑
    LLVM.or (LLVM.xor (LLVM.and e e_1) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nand_xor_common_op_commute0_thm (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and e_2 e_1) (const? 4 (-1))) (LLVM.xor e_2 e) ⊑
    LLVM.xor (LLVM.and (LLVM.and e_2 e_1) e) (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR75692_1_thm (e : IntW 32) :
  LLVM.or (LLVM.xor e (const? 32 4)) (LLVM.xor e (const? 32 (-5))) ⊑ const? 32 (-1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_not_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e_1 (LLVM.xor e (const? 32 (-1)))) e ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_and_commuted1_thm (e e_1 : IntW 32) :
  LLVM.or (mul e_1 e_1) (LLVM.xor (LLVM.xor (mul e_1 e_1) (const? 32 (-1))) e) ⊑
    LLVM.or (mul e_1 e_1) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_and_commuted2_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_1 e_1) (LLVM.xor (mul e e) (const? 32 (-1)))) (mul e e) ⊑
    LLVM.or (mul e e) (LLVM.xor (mul e_1 e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0000_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0001_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42))) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0010_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0011_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42))) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0100_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0101_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e_1 (const? 32 42)) (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0110_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_0111_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e_1 (const? 32 42)) (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1000_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42))) (mul e_1 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1001_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42))) (mul e_1 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1010_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1011_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1100_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))))
      (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1101_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) (mul e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1110_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))))
      (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (mul e (const? 32 42))) (mul e_1 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_tree_1111_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_2 (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))))
      (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_2 (const? 32 42))) (mul e_1 (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
