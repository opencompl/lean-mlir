
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gandhorhicmphconsthicmp_proof
theorem eq_basic_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ugt e_1 e) ⊑
    icmp IntPred.uge (add e_1 (const? 8 (-1))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_basic_equal_5_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 5)) (icmp IntPred.ule (add e_1 (const? 8 (-5))) e) ⊑
    icmp IntPred.ult (add e_1 (const? 8 (-6))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_basic_equal_minus_1_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ugt (add e_1 (const? 8 1)) e) ⊑
    icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_basic_equal_minus_7_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-7))) (icmp IntPred.ule (add e_1 (const? 8 7)) e) ⊑
    icmp IntPred.ult (add e_1 (const? 8 6)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_commuted_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ult (LLVM.sdiv (const? 8 43) e) e_1) ⊑
    icmp IntPred.uge (add e_1 (const? 8 (-1))) (LLVM.sdiv (const? 8 43) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_commuted_equal_minus_1_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-1)))
      (icmp IntPred.uge (LLVM.sdiv (const? 8 42) e) (add e_1 (const? 8 1))) ⊑
    icmp IntPred.ult e_1 (LLVM.sdiv (const? 8 42) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
