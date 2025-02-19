
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section guaddo_proof
theorem uaddo_commute3_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (LLVM.xor e_2 (const? 32 (-1))) e_1) e (add e_1 e_2) ⊑
    select (icmp IntPredicate.ugt e_1 (LLVM.xor e_2 (const? 32 (-1)))) e (add e_1 e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uaddo_commute4_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (LLVM.xor e_2 (const? 32 (-1))) e_1) e (add e_2 e_1) ⊑
    select (icmp IntPredicate.ugt e_1 (LLVM.xor e_2 (const? 32 (-1)))) e (add e_2 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uaddo_commute7_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (LLVM.xor e_2 (const? 32 (-1))) e_1) (add e_1 e_2) e ⊑
    select (icmp IntPredicate.ugt e_1 (LLVM.xor e_2 (const? 32 (-1)))) (add e_1 e_2) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uaddo_commute8_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (LLVM.xor e_2 (const? 32 (-1))) e_1) (add e_2 e_1) e ⊑
    select (icmp IntPredicate.ugt e_1 (LLVM.xor e_2 (const? 32 (-1)))) (add e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uaddo_wrong_pred2_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.uge e_2 (LLVM.xor e_1 (const? 32 (-1)))) e (add e_2 e_1) ⊑
    select (icmp IntPredicate.ult e_2 (LLVM.xor e_1 (const? 32 (-1)))) (add e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


