
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_thm (e e_1 : IntW 32) :
  LLVM.srem (sub (const? 32 0) e_1 { «nsw» := true, «nuw» := false }) e ⊑
    sub (const? 32 0) (LLVM.srem e_1 e) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


