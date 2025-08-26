
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsdivhicmp_proof
theorem sdiv_exact_eq_0_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e_1 e { «exact» := true }) (const? 8 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem udiv_exact_ne_0_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e_1 e { «exact» := true }) (const? 8 0) ⊑
    icmp IntPred.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sdiv_exact_ne_1_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e_1 e { «exact» := true }) (const? 8 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem udiv_exact_eq_1_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e_1 e { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.ne e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sdiv_exact_eq_9_no_of_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e_1 (LLVM.and e (const? 8 7)) { «exact» := true }) (const? 8 9) ⊑
    icmp IntPred.eq (mul (LLVM.and e (const? 8 7)) (const? 8 9) { «nsw» := true, «nuw» := true }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem udiv_exact_ne_30_no_of_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e_1 (LLVM.and e (const? 8 7)) { «exact» := true }) (const? 8 30) ⊑
    icmp IntPred.ne (mul (LLVM.and e (const? 8 7)) (const? 8 30) { «nsw» := false, «nuw» := true }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
