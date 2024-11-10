
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gsdivhcanonicalize_proof
theorem test_sdiv_canonicalize_op0_thm (e e_1 : IntW 32) :
  LLVM.sdiv (sub (const? 32 0) e_1 { «nsw» := true, «nuw» := false }) e ⊑
    sub (const? 32 0) (LLVM.sdiv e_1 e) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sdiv_canonicalize_op0_exact_thm (e e_1 : IntW 32) :
  LLVM.sdiv (sub (const? 32 0) e_1 { «nsw» := true, «nuw» := false }) e { «exact» := true } ⊑
    sub (const? 32 0) (LLVM.sdiv e_1 e { «exact» := true }) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


