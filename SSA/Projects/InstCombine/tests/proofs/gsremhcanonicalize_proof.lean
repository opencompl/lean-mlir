
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_thm (e✝ e✝¹ : IntW 32) :
  LLVM.srem (sub (const? 0) e✝¹ { «nsw» := true, «nuw» := false }) e✝ ⊑
    sub (const? 0) (LLVM.srem e✝¹ e✝) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


