
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gxor2_proof
theorem test0_proof.test0_thm_1 (e : IntW 32) :
  icmp IntPred.sgt (LLVM.xor e (const? 32 (-2147483648))) (const? 32 (-1)) ⊑ icmp IntPred.slt e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test1_proof.test1_thm_1 (e : IntW 32) :
  icmp IntPred.slt (LLVM.xor e (const? 32 12345)) (const? 32 0) ⊑ icmp IntPred.slt e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 32) :
  LLVM.xor (add (LLVM.and e (const? 32 32)) (const? 32 145)) (const? 32 153) ⊑
    LLVM.or (LLVM.and e (const? 32 32)) (const? 32 8) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.or e (const? 32 145)) (const? 32 177)) (const? 32 153) ⊑
    LLVM.or (LLVM.and e (const? 32 32)) (const? 32 8) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 32) :
  add (LLVM.xor (lshr (LLVM.xor e (const? 32 1234)) (const? 32 8)) (const? 32 1)) (LLVM.xor e (const? 32 1234)) ⊑
    add (LLVM.xor (lshr e (const? 32 8)) (const? 32 5)) (LLVM.xor e (const? 32 1234)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 32) :
  add (lshr (LLVM.xor e (const? 32 1234)) (const? 32 16)) (LLVM.xor e (const? 32 1234)) ⊑
    add (lshr e (const? 32 16)) (LLVM.xor e (const? 32 1234)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.xor e (const? 32 (-1))) ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.xor e (const? 32 (-1))) (LLVM.or e e_1) ⊑ LLVM.or e (LLVM.xor e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e e_1) (LLVM.xor e e_1) ⊑ LLVM.or e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9b_proof.test9b_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e e_1) (LLVM.xor e_1 e) ⊑ LLVM.or e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.xor e e_1) (LLVM.and e e_1) ⊑ LLVM.or e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10b_proof.test10b_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.xor e e_1) (LLVM.and e_1 e) ⊑ LLVM.or e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.and (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11b_proof.test11b_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e_1 e) ⊑
    LLVM.and (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11c_proof.test11c_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor e e_1) (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) ⊑
    LLVM.and (LLVM.xor e e_1) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11d_proof.test11d_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e e_1) ⊑
    LLVM.and (LLVM.xor e e_1) (LLVM.xor (LLVM.xor e e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11e_proof.test11e_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (mul e_1 e_2) e) (LLVM.xor (mul e_1 e_2) (LLVM.xor e (const? 32 (-1)))) ⊑
    LLVM.and (LLVM.xor (mul e_1 e_2) e) (LLVM.xor (LLVM.xor e (mul e_1 e_2)) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11f_proof.test11f_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (mul e_1 e_2) (LLVM.xor e (const? 32 (-1)))) (LLVM.xor (mul e_1 e_2) e) ⊑
    LLVM.and (LLVM.xor (mul e_1 e_2) e) (LLVM.xor (LLVM.xor e (mul e_1 e_2)) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12commuted_proof.test12commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e (const? 32 (-1))) ⊑
    LLVM.xor (LLVM.and e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.xor e (const? 32 (-1))) (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.and e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13commuted_proof.test13commuted_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.xor e (const? 32 (-1))) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.xor (LLVM.and e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute1_proof.xor_or_xor_common_op_commute1_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.xor e e_2) (LLVM.or e e_1) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute2_proof.xor_or_xor_common_op_commute2_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.xor e_2 e) (LLVM.or e e_1) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute3_proof.xor_or_xor_common_op_commute3_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.xor e e_2) (LLVM.or e_1 e) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute4_proof.xor_or_xor_common_op_commute4_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.xor e_2 e) (LLVM.or e_1 e) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute5_proof.xor_or_xor_common_op_commute5_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.xor e e_2) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute6_proof.xor_or_xor_common_op_commute6_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.or e e_1) (LLVM.xor e_2 e) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute7_proof.xor_or_xor_common_op_commute7_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.xor e e_2) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_or_xor_common_op_commute8_proof.xor_or_xor_common_op_commute8_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.or e_1 e) (LLVM.xor e_2 e) ⊑ LLVM.xor (LLVM.and e_1 (LLVM.xor e (const? 32 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_proof.test15_thm_1 (e e_1 : IntW 8) :
  mul (LLVM.and (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1)) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) ⊑
    mul (LLVM.and (LLVM.xor e_1 e) (LLVM.xor (LLVM.xor e e_1) (const? 8 33)))
      (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test16_proof.test16_thm_1 (e e_1 : IntW 8) :
  mul (LLVM.and (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) (LLVM.xor e_1 e)) (LLVM.xor (LLVM.xor e (const? 8 33)) e_1) ⊑
    mul (LLVM.and (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) (LLVM.xor e_1 e))
      (LLVM.xor (LLVM.xor e e_1) (const? 8 33)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_xor_to_or_not1_proof.not_xor_to_or_not1_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e e_2) (LLVM.or e_1 e_2)) (const? 3 (-1)) ⊑
    LLVM.or (LLVM.and e e_2) (LLVM.xor (LLVM.or e_1 e_2) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_xor_to_or_not2_proof.not_xor_to_or_not2_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e e_2) (LLVM.or e_2 e_1)) (const? 3 (-1)) ⊑
    LLVM.or (LLVM.and e e_2) (LLVM.xor (LLVM.or e_2 e_1) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_xor_to_or_not3_proof.not_xor_to_or_not3_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e_2 e) (LLVM.or e_2 e_1)) (const? 3 (-1)) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.xor (LLVM.or e_2 e_1) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_xor_to_or_not4_proof.not_xor_to_or_not4_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e_2 e) (LLVM.or e_1 e_2)) (const? 3 (-1)) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.xor (LLVM.or e_1 e_2) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_notand_to_or_not1_proof.xor_notand_to_or_not1_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e e_2) (const? 3 (-1))) (LLVM.or e_1 e_2) ⊑
    LLVM.or (LLVM.and e e_2) (LLVM.xor (LLVM.or e_1 e_2) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_notand_to_or_not2_proof.xor_notand_to_or_not2_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e e_2) (const? 3 (-1))) (LLVM.or e_2 e_1) ⊑
    LLVM.or (LLVM.and e e_2) (LLVM.xor (LLVM.or e_2 e_1) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_notand_to_or_not3_proof.xor_notand_to_or_not3_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e_2 e) (const? 3 (-1))) (LLVM.or e_2 e_1) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.xor (LLVM.or e_2 e_1) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_notand_to_or_not4_proof.xor_notand_to_or_not4_thm_1 (e e_1 e_2 : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e_2 e) (const? 3 (-1))) (LLVM.or e_1 e_2) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.xor (LLVM.or e_1 e_2) (const? 3 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
