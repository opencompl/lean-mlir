
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gintegerhroundhuphpow2halignment_proof
theorem t0_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    LLVM.and (add e (const? 8 15)) (const? 8 (-16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 32)) (const? 8 (-32))) ⊑
    LLVM.and (add e (const? 8 31)) (const? 8 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 15)) (const? 8 (-16))) ⊑
    LLVM.and (add e (const? 8 15)) (const? 8 (-16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n9_wrong_x0_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e_1 (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e_1 (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n9_wrong_x1_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e_1
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e_1
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n9_wrong_x2_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_wrong_low_bit_mask_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n12_wrong_bias_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 32)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n14_wrong_comparison_constant_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 1)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 1)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n15_wrong_comparison_predicate_and_constant_thm (e : IntW 8) :
  select (icmp IntPredicate.ult (LLVM.and e (const? 8 15)) (const? 8 2)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 8 14)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
