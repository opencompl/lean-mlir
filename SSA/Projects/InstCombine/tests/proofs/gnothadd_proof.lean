
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gnothadd_proof
theorem basic_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? 8 (-1))) e) (const? 8 (-1)) ⊑ sub e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem basic_com_add_thm (e e_1 : IntW 8) :
  LLVM.xor (add e_1 (LLVM.xor e (const? 8 (-1)))) (const? 8 (-1)) ⊑ sub e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem basic_preserve_nsw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? 8 (-1))) e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑
    sub e_1 e { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem basic_preserve_nuw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? 8 (-1))) e { «nsw» := false, «nuw» := true }) (const? 8 (-1)) ⊑
    sub e_1 e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem basic_preserve_nuw_nsw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? 8 (-1))) e { «nsw» := true, «nuw» := true }) (const? 8 (-1)) ⊑
    sub e_1 e { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


