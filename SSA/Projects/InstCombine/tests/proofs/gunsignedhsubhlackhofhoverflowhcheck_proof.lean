
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gunsignedhsubhlackhofhoverflowhcheck_proof
theorem t0_basic_thm (e e_1 : IntW 8) : icmp IntPredicate.ule (sub e_1 e) e_1 ⊑ icmp IntPredicate.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_commutative_thm (e e_1 : IntW 8) : icmp IntPredicate.uge e_1 (sub e_1 e) ⊑ icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n7_wrong_pred2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (sub e_1 e) e_1 ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n8_wrong_pred3_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (sub e_1 e) e_1 ⊑ icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
