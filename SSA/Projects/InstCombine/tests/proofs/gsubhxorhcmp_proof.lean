
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsubhxorhcmp_proof
theorem sext_xor_sub_thm (e : IntW 1) (e_1 : IntW 64) :
  sub (LLVM.xor e_1 (sext 64 e)) (sext 64 e) ⊑ select e (sub (const? 64 0) e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_xor_sub_1_thm (e : IntW 64) (e_1 : IntW 1) :
  sub (LLVM.xor (sext 64 e_1) e) (sext 64 e_1) ⊑ select e_1 (sub (const? 64 0) e) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_xor_sub_2_thm (e : IntW 64) (e_1 : IntW 1) :
  sub (sext 64 e_1) (LLVM.xor e (sext 64 e_1)) ⊑ select e_1 e (sub (const? 64 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_xor_sub_3_thm (e : IntW 64) (e_1 : IntW 1) :
  sub (sext 64 e_1) (LLVM.xor (sext 64 e_1) e) ⊑ select e_1 e (sub (const? 64 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_non_bool_xor_sub_1_thm (e : IntW 64) (e_1 : IntW 8) :
  sub (LLVM.xor (sext 64 e_1) e) (sext 64 e_1) ⊑ sub (LLVM.xor e (sext 64 e_1)) (sext 64 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_diff_i1_xor_sub_thm (e e_1 : IntW 1) :
  sub (sext 64 e_1) (sext 64 e) ⊑ add (zext 64 e) (sext 64 e_1) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_diff_i1_xor_sub_1_thm (e e_1 : IntW 1) :
  sub (sext 64 e_1) (sext 64 e) ⊑ add (zext 64 e) (sext 64 e_1) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_multi_uses_thm (e : IntW 64) (e_1 : IntW 1) (e_2 : IntW 64) :
  add (mul e_2 (sext 64 e_1)) (sub (LLVM.xor e (sext 64 e_1)) (sext 64 e_1)) ⊑
    select e_1 (sub (const? 64 0) (add e_2 e)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem absdiff_thm (e e_1 : IntW 64) :
  sub (LLVM.xor (sext 64 (icmp IntPred.ult e_1 e)) (sub e_1 e)) (sext 64 (icmp IntPred.ult e_1 e)) ⊑
    select (icmp IntPred.ult e_1 e) (sub (const? 64 0) (sub e_1 e)) (sub e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem absdiff1_thm (e e_1 : IntW 64) :
  sub (LLVM.xor (sub e_1 e) (sext 64 (icmp IntPred.ult e_1 e))) (sext 64 (icmp IntPred.ult e_1 e)) ⊑
    select (icmp IntPred.ult e_1 e) (sub (const? 64 0) (sub e_1 e)) (sub e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem absdiff2_thm (e e_1 : IntW 64) :
  sub (LLVM.xor (sub e_1 e) (sext 64 (icmp IntPred.ugt e e_1))) (sext 64 (icmp IntPred.ugt e e_1)) ⊑
    select (icmp IntPred.ugt e e_1) (sub (const? 64 0) (sub e_1 e)) (sub e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
