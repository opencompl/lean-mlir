
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsdivhcanonicalize_proof
theorem test_sdiv_canonicalize_op0_thm (e✝ e✝¹ : IntW 32) :
  LLVM.sdiv (sub (const? 0) e✝¹ { «nsw» := true, «nuw» := false }) e✝ ⊑
    sub (const? 0) (LLVM.sdiv e✝¹ e✝) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sdiv_canonicalize_op0_exact_thm (e✝ e✝¹ : IntW 32) :
  LLVM.sdiv (sub (const? 0) e✝¹ { «nsw» := true, «nuw» := false }) e✝ ⊑
    sub (const? 0) (LLVM.sdiv e✝¹ e✝) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


