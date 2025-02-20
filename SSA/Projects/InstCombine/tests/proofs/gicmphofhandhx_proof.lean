
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gicmphofhandhx_proof
theorem icmp_ult_x_y_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.and e_1 e) e_1 ⊑ icmp IntPredicate.ne (LLVM.and e_1 e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ult_x_y_2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt (mul e_1 e_1) (LLVM.and (mul e_1 e_1) e) ⊑
    icmp IntPredicate.ne (LLVM.and (mul e_1 e_1) e) (mul e_1 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_uge_x_y_2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (mul e_1 e_1) (LLVM.and (mul e_1 e_1) e) ⊑
    icmp IntPredicate.eq (LLVM.and (mul e_1 e_1) e) (mul e_1 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle_x_negy_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sle (LLVM.and (LLVM.or e_1 (const? 8 (-128))) e) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y_todo_thm (e : IntW 1) (e_1 : IntW 8) :
  icmp IntPredicate.eq e_1 (LLVM.and e_1 (select e (const? 8 7) (const? 8 24))) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (select e (const? 8 (-8)) (const? 8 (-25)))) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq e_1 (LLVM.and e_1 (LLVM.xor e (const? 8 (-1)))) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y2_todo_thm (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPredicate.eq (select e_1 (const? 8 7) (const? 8 24)) (LLVM.and e (select e_1 (const? 8 7) (const? 8 24))) ⊑
    icmp IntPredicate.eq (LLVM.or e (select e_1 (const? 8 (-8)) (const? 8 (-25)))) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_1 (const? 8 (-1))) (LLVM.and e (LLVM.xor e_1 (const? 8 (-1)))) ⊑
    icmp IntPredicate.eq (LLVM.or e e_1) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
