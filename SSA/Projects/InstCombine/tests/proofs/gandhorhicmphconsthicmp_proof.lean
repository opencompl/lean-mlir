
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhorhicmphconsthicmp_proof
theorem eq_basic_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 0)) (icmp IntPredicate.ugt e_1 e) ⊑
    icmp IntPredicate.uge (add e_1 (const? (-1))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ne_basic_equal_5_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 5)) (icmp IntPredicate.ule (add e_1 (const? (-5))) e) ⊑
    icmp IntPredicate.ult (add e_1 (const? (-6))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem eq_basic_equal_minus_1_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? (-1))) (icmp IntPredicate.ugt (add e_1 (const? 1)) e) ⊑
    icmp IntPredicate.uge e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ne_basic_equal_minus_7_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? (-7))) (icmp IntPredicate.ule (add e_1 (const? 7)) e) ⊑
    icmp IntPredicate.ult (add e_1 (const? 6)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem eq_commuted_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 0)) (icmp IntPredicate.ult (LLVM.sdiv (const? 43) e) e_1) ⊑
    icmp IntPredicate.uge (add e_1 (const? (-1))) (LLVM.sdiv (const? 43) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ne_commuted_equal_minus_1_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? (-1)))
      (icmp IntPredicate.uge (LLVM.sdiv (const? 42) e) (add e_1 (const? 1))) ⊑
    icmp IntPredicate.ult e_1 (LLVM.sdiv (const? 42) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


