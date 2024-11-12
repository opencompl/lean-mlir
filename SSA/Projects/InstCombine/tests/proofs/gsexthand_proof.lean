
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gsexthand_proof
theorem fold_sext_to_and_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 1) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-127))) (const? 8 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and1_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 1) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 (-127))) (const? 8 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and2_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 1073741826)) (const? 32 2) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-126))) (const? 8 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and3_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 1073741826)) (const? 32 2) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 (-126))) (const? 8 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 (-1)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong2_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 128) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong3_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 (-2147483648)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong4_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 1) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong5_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (sext 32 e) (const? 32 (-256))) (const? 32 1) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong6_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 (-1)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong7_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 128) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong8_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 (-2147483648)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong9_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 1) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_sext_to_and_wrong10_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (sext 32 e) (const? 32 (-256))) (const? 32 1) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


