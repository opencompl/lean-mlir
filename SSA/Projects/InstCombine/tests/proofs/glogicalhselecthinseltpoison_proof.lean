
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section glogicalhselecthinseltpoison_proof
theorem foo_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and e_3 (sext 32 (icmp IntPredicate.slt e_2 e_1)))
      (LLVM.and e (LLVM.xor (sext 32 (icmp IntPredicate.slt e_2 e_1)) (const? 32 (-1)))) ⊑
    select (icmp IntPredicate.slt e_2 e_1) e_3 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bar_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and e_3 (LLVM.xor (sext 32 (icmp IntPredicate.slt e_2 e_1)) (const? 32 (-1))))
      (LLVM.and e (sext 32 (icmp IntPredicate.slt e_2 e_1))) ⊑
    select (icmp IntPredicate.slt e_2 e_1) e e_3 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem goo_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPredicate.slt e_3 e_2) (const? 32 (-1)) (const? 32 0)) e_1)
      (LLVM.and (LLVM.xor (select (icmp IntPredicate.slt e_3 e_2) (const? 32 (-1)) (const? 32 0)) (const? 32 (-1))) e) ⊑
    select (icmp IntPredicate.slt e_3 e_2) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem poo_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPredicate.slt e_3 e_2) (const? 32 (-1)) (const? 32 0)) e_1)
      (LLVM.and (select (icmp IntPredicate.slt e_3 e_2) (const? 32 0) (const? 32 (-1))) e) ⊑
    select (icmp IntPredicate.slt e_3 e_2) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_inverted_icmp_preds_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (select (icmp IntPredicate.slt e_3 e_2) e_1 (const? 32 0))
      (select (icmp IntPredicate.sge e_3 e_2) e (const? 32 0)) ⊑
    LLVM.or (select (icmp IntPredicate.slt e_3 e_2) e_1 (const? 32 0))
      (select (icmp IntPredicate.slt e_3 e_2) (const? 32 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_inverted_icmp_preds_reverse_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (select (icmp IntPredicate.slt e_3 e_2) (const? 32 0) e_1)
      (select (icmp IntPredicate.sge e_3 e_2) (const? 32 0) e) ⊑
    LLVM.or (select (icmp IntPredicate.slt e_3 e_2) (const? 32 0) e_1)
      (select (icmp IntPredicate.slt e_3 e_2) e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem par_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPredicate.slt e_3 e_2) (const? 32 (-1)) (const? 32 0)) e_1)
      (LLVM.and (LLVM.xor (select (icmp IntPredicate.slt e_3 e_2) (const? 32 (-1)) (const? 32 0)) (const? 32 (-1))) e) ⊑
    select (icmp IntPredicate.slt e_3 e_2) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_thm (e e_1 e_2 : IntW 1) :
  LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) (LLVM.and e_2 e) ⊑ select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_logical_thm (e e_1 e_2 : IntW 1) :
  select (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_multi_uses1_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) (LLVM.and e_2 e))
      (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) ⊑
    LLVM.xor (select e_2 e e_1) (LLVM.and e_1 (LLVM.xor e_2 (const? 1 1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_multi_uses1_logical_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)))
      (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) ⊑
    LLVM.xor (select e_2 e e_1) (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_multi_uses2_thm (e e_1 e_2 : IntW 1) :
  LLVM.and (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) (LLVM.and e_2 e))
      (add (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) (LLVM.and e_2 e)) ⊑
    select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bools_multi_uses2_logical_thm (e e_1 e_2 : IntW 1) :
  select (select (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)))
      (add (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) (select e_2 e (const? 1 0))) (const? 1 0) ⊑
    select (select e_2 e e_1)
      (LLVM.xor (select (LLVM.xor e_2 (const? 1 1)) e_1 (const? 1 0)) (select e_2 e (const? 1 0))) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem allSignBits_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and e_2 (ashr e_1 (const? 32 31))) (LLVM.and (LLVM.xor (ashr e_1 (const? 32 31)) (const? 32 (-1))) e) ⊑
    LLVM.or (select (icmp IntPredicate.slt e_1 (const? 32 0)) e_2 (const? 32 0))
      (select (icmp IntPredicate.slt e_1 (const? 32 0)) (const? 32 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
