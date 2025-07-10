
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gorhxor_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 32) :
  LLVM.or e (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e e_1 : IntW 32) :
  LLVM.or e (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e e_1) (LLVM.xor e (const? 32 (-1))) ⊑ LLVM.xor (LLVM.and e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_commuted_x_y_proof.test5_commuted_x_y_thm_1 (e e_1 : IntW 64) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor e (const? 64 (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? 64 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_common_op_commute0_proof.xor_common_op_commute0_thm_1 (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor e e_1) e ⊑ LLVM.or e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_common_op_commute2_proof.xor_common_op_commute2_thm_1 (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 5)) (LLVM.xor (LLVM.xor e (const? 8 5)) e_1) ⊑
    LLVM.or (LLVM.xor e (const? 8 5)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_common_op_commute3_proof.xor_common_op_commute3_thm_1 (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 5)) (LLVM.xor (mul e_1 e_1) (LLVM.xor e (const? 8 5))) ⊑
    LLVM.or (LLVM.xor e (const? 8 5)) (mul e_1 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e e_1 : IntW 32) :
  LLVM.or e_1 (LLVM.xor e (LLVM.xor e_1 (const? 32 (-1)))) ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e e_1 : IntW 32) :
  LLVM.or e (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_commuted_proof.test10_commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e_1 e) ⊑
    LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e e_1) (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑ LLVM.and e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.or e e_1) ⊑ LLVM.and e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_commuted_proof.test12_commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.or e_1 e) ⊑ LLVM.and e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.and e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_proof.test14_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.or (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_commuted_proof.test14_commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.or (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_proof.test15_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.and (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_commuted_proof.test15_commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.and (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_xor_not_constant_commute0_proof.or_and_xor_not_constant_commute0_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor e e_1) (const? 32 1)) (LLVM.and e_1 (const? 32 (-2))) ⊑
    LLVM.xor (LLVM.and e (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_xor_not_constant_commute1_proof.or_and_xor_not_constant_commute1_thm_1 (e e_1 : IntW 9) :
  LLVM.or (LLVM.and (LLVM.xor e_1 e) (const? 9 42)) (LLVM.and e_1 (const? 9 (-43))) ⊑
    LLVM.xor (LLVM.and e (const? 9 42)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_or_xor_proof.not_or_xor_thm_1 (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 8 (-1))) (const? 8 7)) (const? 8 12) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 (-13)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_proof.xor_or_thm_1 (e : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 32)) (const? 8 7) ⊑ LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 39) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or2_proof.xor_or2_thm_1 (e : IntW 8) :
  LLVM.or (LLVM.xor e (const? 8 33)) (const? 8 7) ⊑ LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 39) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_proof.xor_or_xor_thm_1 (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 8 33)) (const? 8 7)) (const? 8 12) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-8))) (const? 8 43) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_or_proof.or_xor_or_thm_1 (e : IntW 8) :
  LLVM.or (LLVM.xor (LLVM.or e (const? 8 33)) (const? 8 12)) (const? 8 7) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-40))) (const? 8 47) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test17_proof.test17_thm_1 (e e_1 : IntW 8) :
  mul (LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1)) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) ⊑
    mul (LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 8 33)))
      (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e e_1 : IntW 8) :
  mul (LLVM.or (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) (LLVM.xor e_1 e)) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) ⊑
    mul (LLVM.or (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) (LLVM.xor e_1 e))
      (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_proof.test19_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.or (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test20_proof.test20_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test21_proof.test21_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.or e e_1) ⊑
    LLVM.xor (LLVM.xor e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test22_proof.test22_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.or e_1 e) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test23_proof.test23_thm_1 (e : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor (LLVM.or e (const? 8 (-2))) (const? 8 13)) (const? 8 1)) (const? 8 12) ⊑
    const? 8 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR45977_f1_proof.PR45977_f1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) (LLVM.and (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.xor e (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR45977_f2_proof.PR45977_f2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.or e (LLVM.xor e_1 (const? 32 (-1)))) ⊑ LLVM.xor e (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_common_op_commute0_proof.or_xor_common_op_commute0_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or e e_1) (LLVM.xor e e_2) ⊑ LLVM.or (LLVM.or e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_common_op_commute5_proof.or_xor_common_op_commute5_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e e_2) (LLVM.or e_1 e) ⊑ LLVM.or (LLVM.or e_1 e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_common_op_commute6_proof.or_xor_common_op_commute6_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e) (LLVM.or e e_1) ⊑ LLVM.or (LLVM.or e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_common_op_commute7_proof.or_xor_common_op_commute7_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_2 e) (LLVM.or e_1 e) ⊑ LLVM.or (LLVM.or e_1 e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute0_proof.or_not_xor_common_op_commute0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.or (LLVM.xor e (const? 4 (-1))) e_2) (LLVM.xor e e_1) ⊑
    LLVM.or e_2 (LLVM.xor (LLVM.and e e_1) (const? 4 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute2_proof.or_not_xor_common_op_commute2_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e e_1) (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e (const? 8 (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e e_1) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute3_proof.or_not_xor_common_op_commute3_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e (const? 8 (-1)))) (LLVM.xor e e_1) ⊑
    LLVM.or (LLVM.xor (LLVM.and e e_1) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute5_proof.or_not_xor_common_op_commute5_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.or (LLVM.xor e (const? 8 (-1))) e_2) ⊑
    LLVM.or e_2 (LLVM.xor (LLVM.and e_1 e) (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute6_proof.or_not_xor_common_op_commute6_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e (const? 8 (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e_1 e) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_not_xor_common_op_commute7_proof.or_not_xor_common_op_commute7_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 8 0) e_2) (LLVM.xor e (const? 8 (-1)))) (LLVM.xor e_1 e) ⊑
    LLVM.or (LLVM.xor (LLVM.and e_1 e) (const? 8 (-1))) (sub (const? 8 0) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_nand_xor_common_op_commute0_proof.or_nand_xor_common_op_commute0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and e e_2) (const? 4 (-1))) (LLVM.xor e e_1) ⊑
    LLVM.xor (LLVM.and (LLVM.and e e_2) e_1) (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR75692_1_proof.PR75692_1_thm_1 (e : IntW 32) :
  LLVM.or (LLVM.xor e (const? 32 4)) (LLVM.xor e (const? 32 (-5))) ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_not_proof.or_xor_not_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e (LLVM.xor e_1 (const? 32 (-1)))) e_1 ⊑ LLVM.or e_1 (LLVM.xor e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_and_commuted1_proof.or_xor_and_commuted1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (mul e_1 e_1) (LLVM.xor (LLVM.xor (mul e_1 e_1) (const? 32 (-1))) e) ⊑
    LLVM.or (mul e_1 e_1) (LLVM.xor e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_and_commuted2_proof.or_xor_and_commuted2_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor (mul e e) (LLVM.xor (mul e_1 e_1) (const? 32 (-1)))) (mul e_1 e_1) ⊑
    LLVM.or (mul e_1 e_1) (LLVM.xor (mul e e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0000_proof.or_xor_tree_0000_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0001_proof.or_xor_tree_0001_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0010_proof.or_xor_tree_0010_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0011_proof.or_xor_tree_0011_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42)))
      (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0100_proof.or_xor_tree_0100_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0101_proof.or_xor_tree_0101_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0110_proof.or_xor_tree_0110_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_0111_proof.or_xor_tree_0111_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42)))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1000_proof.or_xor_tree_1000_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1001_proof.or_xor_tree_1001_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1010_proof.or_xor_tree_1010_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1011_proof.or_xor_tree_1011_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))) (mul e (const? 32 42)))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1100_proof.or_xor_tree_1100_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))))
      (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1101_proof.or_xor_tree_1101_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_1 (const? 32 42)) (mul e_2 (const? 32 42))))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1110_proof.or_xor_tree_1110_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))))
      (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e (const? 32 42)) (mul e_1 (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_tree_1111_proof.or_xor_tree_1111_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (mul e (const? 32 42)) (LLVM.xor (mul e_2 (const? 32 42)) (mul e_1 (const? 32 42))))
      (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) ⊑
    LLVM.or (LLVM.xor (mul e_1 (const? 32 42)) (mul e (const? 32 42))) (mul e_2 (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
