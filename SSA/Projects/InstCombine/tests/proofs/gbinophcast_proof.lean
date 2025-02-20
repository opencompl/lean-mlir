
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gbinophcast_proof
theorem and_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.and (sext 32 e_1) e ⊑ select e_1 e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.or (sext 32 e_1) e ⊑ select e_1 (const? 32 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.xor (sext 32 e_1) e ⊑ LLVM.xor e (sext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_add_bool_to_select_thm (e : IntW 32) (e_1 : IntW 1) :
  LLVM.and (add (const? 32 (-1)) (zext 32 e_1)) e ⊑ select e_1 (const? 32 0) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_add_bool_no_fold_thm (e : IntW 32) :
  LLVM.and (add (const? 32 (-1)) (LLVM.and e (const? 32 1))) e ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_add_bool_to_select_multi_use_thm (e : IntW 32) (e_1 : IntW 1) :
  add (LLVM.and (add (const? 32 (-1)) (zext 32 e_1)) e) (add (const? 32 (-1)) (zext 32 e_1)) ⊑
    select e_1 (const? 32 0) (add e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
