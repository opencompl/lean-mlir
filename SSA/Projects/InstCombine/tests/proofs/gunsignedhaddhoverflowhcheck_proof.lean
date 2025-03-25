
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gunsignedhaddhoverflowhcheck_proof
theorem t0_basic_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (add e_1 e) e ⊑ icmp IntPredicate.ugt e_1 (LLVM.xor e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_symmetry_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (add e_1 e) e_1 ⊑ icmp IntPredicate.ugt e (LLVM.xor e_1 (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t4_commutative_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt e_1 (add e e_1) ⊑ icmp IntPredicate.ugt e (LLVM.xor e_1 (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_wrong_pred2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (add e_1 e) e ⊑ icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n11_wrong_pred3_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (add e_1 e) e ⊑ icmp IntPredicate.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
