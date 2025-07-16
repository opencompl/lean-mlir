
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section grem_proof
theorem test1_proof.test1_thm_1 (e : IntW 32) : LLVM.srem e (const? 32 1) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 32) : urem e (const? 32 8) ⊑ LLVM.and e (const? 32 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3a_proof.test3a_thm_1 (e : IntW 32) :
  icmp IntPred.ne (LLVM.srem e (const? 32 (-8))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  urem e (select e_1 (const? 32 1) (const? 32 8)) ⊑ LLVM.and e (select e_1 (const? 32 0) (const? 32 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  urem e (shl (const? 32 32) (zext 32 e_1)) ⊑
    LLVM.and e (add (shl (const? 32 32) (zext 32 e_1 { «nneg» := true }) { «nuw» := true }) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 32) : LLVM.srem (mul e (const? 32 8)) (const? 32 4) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e : IntW 32) : LLVM.srem (shl e (const? 32 4)) (const? 32 8) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 32) : urem (mul e (const? 32 64)) (const? 32 32) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 8) :
  trunc 32 (urem (sext 64 (mul (zext 32 e) (const? 32 4))) (const? 64 4)) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e : IntW 32) :
  urem (mul (LLVM.and e (const? 32 (-2))) (const? 32 2)) (const? 32 4) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e : IntW 32) :
  LLVM.srem (LLVM.and e (const? 32 (-4))) (const? 32 2) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e : IntW 32) : LLVM.srem e e ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_proof.test14_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  urem e (zext 64 (shl (const? 32 1) e_1)) ⊑
    LLVM.and e (add (zext 64 (shl (const? 32 1) e_1 { «nuw» := true })) (const? 64 (-1)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_proof.test15_thm_1 (e e_1 : IntW 32) :
  urem (zext 64 e) (zext 64 (shl (const? 32 1) e_1)) ⊑
    zext 64 (LLVM.and e (LLVM.xor (shl (const? 32 (-1)) e_1 { «nsw» := true }) (const? 32 (-1))))
      { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test16_proof.test16_thm_1 (e e_1 : IntW 32) :
  urem e (add (LLVM.and (lshr e_1 (const? 32 11)) (const? 32 4)) (const? 32 4)) ⊑
    LLVM.and e
      (LLVM.or (LLVM.and (lshr e_1 (const? 32 11)) (const? 32 4)) (const? 32 3) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test17_proof.test17_thm_1 (e : IntW 32) :
  urem (const? 32 1) e ⊑ zext 32 (icmp IntPred.ne e (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  urem e_1 (select (icmp IntPred.ne (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 32) (const? 32 64)) ⊑
    LLVM.and e_1
      (select (icmp IntPred.eq (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 63) (const? 32 31)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_proof.test19_thm_1 (e e_1 : IntW 32) :
  urem e_1 (add (LLVM.and (shl (const? 32 1) e) (shl (const? 32 1) e_1)) (shl (const? 32 1) e)) ⊑
    LLVM.and e_1
      (add
        (add (LLVM.and (shl (const? 32 1) e { «nuw» := true }) (shl (const? 32 1) e_1 { «nuw» := true }))
          (shl (const? 32 1) e { «nuw» := true }))
        (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_commutative0_proof.test19_commutative0_thm_1 (e e_1 : IntW 32) :
  urem e_1 (add (LLVM.and (shl (const? 32 1) e_1) (shl (const? 32 1) e)) (shl (const? 32 1) e)) ⊑
    LLVM.and e_1
      (add
        (add (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e { «nuw» := true }))
          (shl (const? 32 1) e { «nuw» := true }))
        (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_commutative1_proof.test19_commutative1_thm_1 (e e_1 : IntW 32) :
  urem e_1 (add (shl (const? 32 1) e) (LLVM.and (shl (const? 32 1) e) (shl (const? 32 1) e_1))) ⊑
    LLVM.and e_1
      (add
        (add (shl (const? 32 1) e { «nuw» := true })
          (LLVM.and (shl (const? 32 1) e { «nuw» := true }) (shl (const? 32 1) e_1 { «nuw» := true })))
        (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_commutative2_proof.test19_commutative2_thm_1 (e e_1 : IntW 32) :
  urem e_1 (add (shl (const? 32 1) e) (LLVM.and (shl (const? 32 1) e_1) (shl (const? 32 1) e))) ⊑
    LLVM.and e_1
      (add
        (add (shl (const? 32 1) e { «nuw» := true })
          (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e { «nuw» := true })))
        (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test22_proof.test22_thm_1 (e : IntW 32) :
  LLVM.srem (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647) ⊑
    urem (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test24_proof.test24_thm_1 (e : IntW 32) :
  icmp IntPred.ne (urem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test25_proof.test25_thm_1 (e : IntW 32) :
  icmp IntPred.ne (LLVM.srem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test26_proof.test26_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.srem e (shl (const? 32 1) e_1)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (LLVM.xor (shl (const? 32 (-1)) e_1 { «nsw» := true }) (const? 32 (-1))))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test28_proof.test28_thm_1 (e : IntW 32) :
  icmp IntPred.eq (LLVM.srem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_and_odd_eq_proof.positive_and_odd_eq_thm_1 (e : IntW 32) :
  icmp IntPred.eq (LLVM.srem e (const? 32 2)) (const? 32 1) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-2147483647))) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_and_odd_ne_proof.positive_and_odd_ne_thm_1 (e : IntW 32) :
  icmp IntPred.ne (LLVM.srem e (const? 32 2)) (const? 32 1) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 (-2147483647))) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem srem_constant_dividend_select_of_constants_divisor_proof.srem_constant_dividend_select_of_constants_divisor_thm_1 (e : IntW 1) :
  LLVM.srem (const? 32 42) (select e (const? 32 12) (const? 32 (-3))) ⊑ select e (const? 32 6) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem srem_constant_dividend_select_of_constants_divisor_0_arm_proof.srem_constant_dividend_select_of_constants_divisor_0_arm_thm_1 (e : IntW 1) :
  LLVM.srem (const? 32 42) (select e (const? 32 12) (const? 32 0)) ⊑ const? 32 6 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_constant_dividend_select_of_constants_divisor_proof.urem_constant_dividend_select_of_constants_divisor_thm_1 (e : IntW 1) :
  urem (const? 32 42) (select e (const? 32 12) (const? 32 (-3))) ⊑ select e (const? 32 6) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_constant_dividend_select_of_constants_divisor_0_arm_proof.urem_constant_dividend_select_of_constants_divisor_0_arm_thm_1 (e : IntW 1) :
  urem (const? 32 42) (select e (const? 32 12) (const? 32 0)) ⊑ const? 32 6 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
