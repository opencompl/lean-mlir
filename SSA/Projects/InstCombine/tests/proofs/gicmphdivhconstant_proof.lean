
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gicmphdivhconstant_proof
theorem is_rem2_neg_i8_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.srem e (const? 8 2)) (const? 8 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-127))) (const? 8 (-127)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem is_rem32_pos_i8_thm (e : IntW 8) :
  icmp IntPredicate.sgt (LLVM.srem e (const? 8 32)) (const? 8 0) ⊑
    icmp IntPredicate.sgt (LLVM.and e (const? 8 (-97))) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem is_rem4_neg_i16_thm (e : IntW 16) :
  icmp IntPredicate.slt (LLVM.srem e (const? 16 4)) (const? 16 0) ⊑
    icmp IntPredicate.ugt (LLVM.and e (const? 16 (-32765))) (const? 16 (-32768)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_eq_umax_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.udiv e_1 e) (const? 8 (-1)) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.eq e (const? 8 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_eq_big_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.udiv e_1 e) (const? 8 (-128)) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.eq e (const? 8 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_ne_big_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.udiv e_1 e) (const? 8 (-128)) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.ne e (const? 8 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_eq_smin_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.sdiv e_1 e) (const? 8 (-128)) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.eq e (const? 8 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_ult_smin_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.sdiv e_1 e) (const? 8 (-128)) ⊑
    icmp IntPredicate.sgt (LLVM.sdiv e_1 e) (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_x_by_const_cmp_x_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 32 13)) e ⊑ icmp IntPredicate.eq e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_x_by_const_cmp_x_thm (e : IntW 32) :
  icmp IntPredicate.slt (LLVM.udiv e (const? 32 123)) e ⊑ icmp IntPredicate.sgt e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_x_by_const_cmp_x_thm (e : IntW 32) :
  icmp IntPredicate.eq (lshr e (const? 32 1)) e ⊑ icmp IntPredicate.eq e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_by_const_cmp_sge_value_thm (e : IntW 32) :
  icmp IntPredicate.sge (lshr e (const? 32 3)) e ⊑ icmp IntPredicate.slt e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_x_by_const_cmp_sge_x_thm (e : IntW 32) :
  icmp IntPredicate.sge (ashr e (const? 32 5)) e ⊑ icmp IntPredicate.slt e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


