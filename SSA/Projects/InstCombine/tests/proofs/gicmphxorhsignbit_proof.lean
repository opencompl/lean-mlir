
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gicmphxorhsignbit_proof
theorem slt_to_ult_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (LLVM.xor e_1 (const? 8 (-128))) (LLVM.xor e (const? 8 (-128))) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_to_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor e_1 (const? 8 (-128))) (LLVM.xor e (const? 8 (-128))) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_to_ugt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (LLVM.xor e_1 (const? 8 127)) (LLVM.xor e (const? 8 127)) ⊑ icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_to_sgt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor e_1 (const? 8 127)) (LLVM.xor e (const? 8 127)) ⊑ icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_to_ugt_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.xor e (const? 8 (-128))) (const? 8 15) ⊑
    icmp IntPredicate.ugt e (const? 8 (-114)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_to_sgt_thm (e : IntW 8) :
  icmp IntPredicate.uge (LLVM.xor e (const? 8 (-128))) (const? 8 15) ⊑
    icmp IntPredicate.sgt e (const? 8 (-114)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_to_ult_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.xor e (const? 8 127)) (const? 8 15) ⊑ icmp IntPredicate.ult e (const? 8 113) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_to_slt_thm (e : IntW 8) :
  icmp IntPredicate.uge (LLVM.xor e (const? 8 127)) (const? 8 15) ⊑ icmp IntPredicate.slt e (const? 8 113) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.eq (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.xor (icmp IntPredicate.sgt e (const? 32 (-1))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_fail_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.eq (zext 32 e_1) (ashr e (const? 32 31)) ⊑
    icmp IntPredicate.eq (ashr e (const? 32 31)) (zext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_thm (e : IntW 32) :
  icmp IntPredicate.eq (zext 32 (icmp IntPredicate.ne e (const? 32 0))) (lshr e (const? 32 31)) ⊑
    icmp IntPredicate.slt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ne_ne_0_thm (e : IntW 32) :
  icmp IntPredicate.ne (zext 32 (icmp IntPredicate.ne e (const? 32 0))) (lshr e (const? 32 31)) ⊑
    icmp IntPredicate.sgt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ne_ne_b_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (zext 32 (icmp IntPredicate.ne e_1 e)) (lshr e_1 (const? 32 31)) ⊑
    LLVM.xor (icmp IntPredicate.slt e_1 (const? 32 0)) (icmp IntPredicate.ne e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_fail1_thm (e : IntW 32) :
  icmp IntPredicate.eq (zext 32 (icmp IntPredicate.ne e (const? 32 0))) (ashr e (const? 32 31)) ⊑
    icmp IntPredicate.eq (ashr e (const? 32 31)) (zext 32 (icmp IntPredicate.ne e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_fail2_thm (e : IntW 32) :
  icmp IntPredicate.eq (zext 32 (icmp IntPredicate.ne e (const? 32 0))) (lshr e (const? 32 30)) ⊑
    icmp IntPredicate.eq (lshr e (const? 32 30)) (zext 32 (icmp IntPredicate.ne e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
