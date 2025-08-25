
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_thm (e e_1 : IntW 32) :
  LLVM.srem (sub (const? 32 0) e_1 { «nsw» := true, «nuw» := false }) e ⊑
    sub (const? 32 0) (LLVM.srem e_1 e) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
