
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphofhorhx_proof
theorem or_ugt_thm (e e_1 : IntW 8) :
  icmp IntPred.ugt (LLVM.or e_1 e) e_1 ⊑ icmp IntPred.ne (LLVM.or e_1 e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_notY_eq_0_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.or e_1 (LLVM.xor e (const? 8 (-1)))) (LLVM.xor e (const? 8 (-1))) ⊑
    icmp IntPred.eq (LLVM.and e_1 e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ne_notY_eq_1s_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.or e_1 (LLVM.xor e (const? 8 (-1)))) e_1 ⊑
    icmp IntPred.ne (LLVM.or e_1 e) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ne_notY_eq_1s_fail_bad_not_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.or e_1 (LLVM.xor e (const? 8 (-2)))) e_1 ⊑
    icmp IntPred.ne (LLVM.or e_1 (LLVM.xor e (const? 8 1))) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_ule_thm (e e_1 : IntW 8) :
  icmp IntPred.ule (LLVM.or (LLVM.or e_1 (const? 8 1)) (LLVM.and e (const? 8 (-2)))) (LLVM.and e (const? 8 (-2))) ⊑
    icmp IntPred.ule (LLVM.or (LLVM.or e_1 e) (const? 8 1)) (LLVM.and e (const? 8 (-2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_uge_thm (e e_1 : IntW 8) :
  icmp IntPred.uge (LLVM.and e_1 (const? 8 127))
      (LLVM.or (LLVM.or e (const? 8 (-127))) (LLVM.and e_1 (const? 8 127))) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_ule_fail_thm (e e_1 : IntW 8) :
  icmp IntPred.ule (LLVM.or (LLVM.or e_1 (const? 8 64)) (LLVM.and e (const? 8 127))) (LLVM.and e (const? 8 127)) ⊑
    icmp IntPred.ule (LLVM.or (LLVM.or e_1 (LLVM.and e (const? 8 127))) (const? 8 64))
      (LLVM.and e (const? 8 127)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_ugt_thm (e e_1 : IntW 8) :
  icmp IntPred.ugt (LLVM.or (LLVM.or e_1 (const? 8 1)) (LLVM.and e (const? 8 (-2)))) (LLVM.and e (const? 8 (-2))) ⊑
    icmp IntPred.ugt (LLVM.or (LLVM.or e_1 e) (const? 8 1)) (LLVM.and e (const? 8 (-2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_ult_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.and e_1 (const? 8 (-5)))
      (LLVM.or (LLVM.or e (const? 8 36)) (LLVM.and e_1 (const? 8 (-5)))) ⊑
    icmp IntPred.ult (LLVM.and e_1 (const? 8 (-5))) (LLVM.or (LLVM.or e e_1) (const? 8 36)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_simplify_ugt_fail_thm (e e_1 : IntW 8) :
  icmp IntPred.ugt (LLVM.or (LLVM.and e_1 (const? 8 (-2))) (LLVM.or e (const? 8 1))) (LLVM.or e (const? 8 1)) ⊑
    icmp IntPred.ne (LLVM.or e_1 (LLVM.or e (const? 8 1))) (LLVM.or e (const? 8 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y2_todo_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq (select e_2 (const? 8 7) (LLVM.xor e_1 (const? 8 (-1))))
      (LLVM.or e (select e_2 (const? 8 7) (LLVM.xor e_1 (const? 8 (-1))))) ⊑
    icmp IntPred.eq (LLVM.and e (select e_2 (const? 8 (-8)) e_1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_x_invertable_y2_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e_1 (const? 8 (-1))) (LLVM.or e (LLVM.xor e_1 (const? 8 (-1)))) ⊑
    icmp IntPred.eq (LLVM.and e e_1) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR38139_thm (e : IntW 8) :
  icmp IntPred.ne (LLVM.or e (const? 8 (-64))) e ⊑ icmp IntPred.ult e (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
