
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section grem_proof
theorem test1_thm (e : IntW 32) : LLVM.srem e (const? 32 1) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 32) : urem e (const? 32 8) ⊑ LLVM.and e (const? 32 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3a_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.srem e (const? 32 (-8))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 7)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 1) (e_1 : IntW 32) :
  urem e_1 (select e (const? 32 1) (const? 32 8)) ⊑ LLVM.and e_1 (select e (const? 32 0) (const? 32 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 8) (e_1 : IntW 32) :
  urem e_1 (shl (const? 32 32) (zext 32 e)) ⊑
    LLVM.and e_1
      (add (shl (const? 32 32) (zext 32 e { «nneg» := true }) { «nsw» := false, «nuw» := true })
        (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 32) : LLVM.srem (mul e (const? 32 8)) (const? 32 4) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 32) : LLVM.srem (shl e (const? 32 4)) (const? 32 8) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 32) : urem (mul e (const? 32 64)) (const? 32 32) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 8) :
  trunc 32 (urem (sext 64 (mul (zext 32 e) (const? 32 4))) (const? 64 4)) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 32) :
  urem (mul (LLVM.and e (const? 32 (-2))) (const? 32 2)) (const? 32 4) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 32) : LLVM.srem (LLVM.and e (const? 32 (-4))) (const? 32 2) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e : IntW 32) : LLVM.srem e e ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e : IntW 32) (e_1 : IntW 64) :
  urem e_1 (zext 64 (shl (const? 32 1) e)) ⊑
    LLVM.and e_1
      (add (zext 64 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 64 (-1))
        { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e e_1 : IntW 32) :
  urem (zext 64 e_1) (zext 64 (shl (const? 32 1) e)) ⊑
    zext 64 (LLVM.and e_1 (LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true, «nuw» := false }) (const? 32 (-1))))
      { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e e_1 : IntW 32) :
  urem e_1 (add (LLVM.and (lshr e (const? 32 11)) (const? 32 4)) (const? 32 4)) ⊑
    LLVM.and e_1
      (LLVM.or (LLVM.and (lshr e (const? 32 11)) (const? 32 4)) (const? 32 3) { «disjoint» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e : IntW 32) : urem (const? 32 1) e ⊑ zext 32 (icmp IntPredicate.ne e (const? 32 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e : IntW 16) (e_1 : IntW 32) :
  urem e_1 (select (icmp IntPredicate.ne (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 32) (const? 32 64)) ⊑
    LLVM.and e_1
      (select (icmp IntPredicate.eq (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 63) (const? 32 31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e e_1 : IntW 32) :
  urem e_1 (add (LLVM.and (shl (const? 32 1) e) (shl (const? 32 1) e_1)) (shl (const? 32 1) e)) ⊑
    LLVM.and e_1
      (add
        (add
          (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true })
            (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }))
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true }))
        (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_commutative0_thm (e e_1 : IntW 32) :
  urem e_1 (add (LLVM.and (shl (const? 32 1) e_1) (shl (const? 32 1) e)) (shl (const? 32 1) e)) ⊑
    LLVM.and e_1
      (add
        (add
          (LLVM.and (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
            (shl (const? 32 1) e { «nsw» := false, «nuw» := true }))
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true }))
        (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_commutative1_thm (e e_1 : IntW 32) :
  urem e_1 (add (shl (const? 32 1) e) (LLVM.and (shl (const? 32 1) e) (shl (const? 32 1) e_1))) ⊑
    LLVM.and e_1
      (add
        (add (shl (const? 32 1) e { «nsw» := false, «nuw» := true })
          (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true })
            (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })))
        (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_commutative2_thm (e e_1 : IntW 32) :
  urem e_1 (add (shl (const? 32 1) e) (LLVM.and (shl (const? 32 1) e_1) (shl (const? 32 1) e))) ⊑
    LLVM.and e_1
      (add
        (add (shl (const? 32 1) e { «nsw» := false, «nuw» := true })
          (LLVM.and (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
            (shl (const? 32 1) e { «nsw» := false, «nuw» := true })))
        (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_thm (e : IntW 32) :
  LLVM.srem (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647) ⊑
    urem (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test24_thm (e : IntW 32) :
  icmp IntPredicate.ne (urem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test25_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.srem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test26_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.srem e_1 (shl (const? 32 1) e)) (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and e_1 (LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true, «nuw» := false }) (const? 32 (-1))))
      (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test28_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.srem e (const? 32 (-2147483648))) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_and_odd_eq_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.srem e (const? 32 2)) (const? 32 1) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 (-2147483647))) (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_and_odd_ne_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.srem e (const? 32 2)) (const? 32 1) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 (-2147483647))) (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem srem_constant_dividend_select_of_constants_divisor_thm (e : IntW 1) :
  LLVM.srem (const? 32 42) (select e (const? 32 12) (const? 32 (-3))) ⊑ select e (const? 32 6) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem srem_constant_dividend_select_of_constants_divisor_0_arm_thm (e : IntW 1) :
  LLVM.srem (const? 32 42) (select e (const? 32 12) (const? 32 0)) ⊑ const? 32 6 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_constant_dividend_select_of_constants_divisor_thm (e : IntW 1) :
  urem (const? 32 42) (select e (const? 32 12) (const? 32 (-3))) ⊑ select e (const? 32 6) (const? 32 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_constant_dividend_select_of_constants_divisor_0_arm_thm (e : IntW 1) : urem (const? 32 42) (select e (const? 32 12) (const? 32 0)) ⊑ const? 32 6 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


