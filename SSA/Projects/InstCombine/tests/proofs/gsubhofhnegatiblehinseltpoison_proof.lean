
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsubhofhnegatiblehinseltpoison_proof
theorem t0_thm (e : IntW 8) : sub e (const? 8 (-42)) ⊑ add e (const? 8 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e e_1 : IntW 8) : sub e_1 (shl (const? 8 (-42)) e) ⊑ add (shl (const? 8 42) e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t4_thm (e : IntW 1) (e_1 : IntW 8) :
  sub e_1 (select e (const? 8 (-42)) (const? 8 44)) ⊑ add (select e (const? 8 42) (const? 8 (-44))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t7_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e_2 (select e_1 (const? 8 0) (shl (const? 8 1) e)) ⊑
    add (select e_1 (const? 8 0) (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false })) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_thm (e e_1 : IntW 8) : sub (const? 8 0) (sub e_1 e) ⊑ sub e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_of_sub_from_constant_thm (e : IntW 8) : sub (const? 8 0) (sub (const? 8 42) e) ⊑ add e (const? 8 (-42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_from_constant_of_sub_from_constant_thm (e : IntW 8) : sub (const? 8 11) (sub (const? 8 42) e) ⊑ add e (const? 8 (-31)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_from_variable_of_sub_from_constant_thm (e e_1 : IntW 8) : sub e_1 (sub (const? 8 42) e) ⊑ add (add e (const? 8 (-42))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_of_add_with_constant_thm (e : IntW 8) : sub (const? 8 0) (add e (const? 8 42)) ⊑ sub (const? 8 (-42)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_from_constant_of_add_with_constant_thm (e : IntW 8) : sub (const? 8 11) (add e (const? 8 42)) ⊑ sub (const? 8 (-31)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t20_thm (e : IntW 16) (e_1 : IntW 8) :
  sub e_1 (trunc 8 (shl (const? 16 (-42)) e)) ⊑ add e_1 (trunc 8 (shl (const? 16 42) e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_xor_thm (e : IntW 4) :
  sub (const? 4 0) (LLVM.xor e (const? 4 5)) ⊑ add (LLVM.xor e (const? 4 (-6))) (const? 4 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_shl_xor_thm (e e_1 : IntW 4) :
  sub (const? 4 0) (shl (LLVM.xor e_1 (const? 4 5)) e) ⊑
    shl (add (LLVM.xor e_1 (const? 4 (-6))) (const? 4 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_sdiv_thm (e e_1 : IntW 8) :
  sub e_1 (LLVM.sdiv e (const? 8 42)) ⊑ add (LLVM.sdiv e (const? 8 (-42))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_ashr_thm (e e_1 : IntW 8) : sub e_1 (ashr e (const? 8 7)) ⊑ add (lshr e (const? 8 7)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_lshr_thm (e e_1 : IntW 8) : sub e_1 (lshr e (const? 8 7)) ⊑ add (ashr e (const? 8 7)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_sext_thm (e : IntW 1) (e_1 : IntW 8) : sub e_1 (sext 8 e) ⊑ add e_1 (zext 8 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_zext_thm (e : IntW 1) (e_1 : IntW 8) : sub e_1 (zext 8 e) ⊑ add e_1 (sext 8 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negation_of_increment_via_or_with_no_common_bits_set_thm (e e_1 : IntW 8) :
  sub e_1 (LLVM.or (shl e (const? 8 1)) (const? 8 1)) ⊑ add e_1 (LLVM.xor (shl e (const? 8 1)) (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_add_with_single_negatible_operand_thm (e : IntW 8) : sub (const? 8 0) (add e (const? 8 42)) ⊑ sub (const? 8 (-42)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negate_add_with_single_negatible_operand_depth2_thm (e e_1 : IntW 8) :
  sub (const? 8 0) (mul (add e_1 (const? 8 21)) e) ⊑ mul (sub (const? 8 (-21)) e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
