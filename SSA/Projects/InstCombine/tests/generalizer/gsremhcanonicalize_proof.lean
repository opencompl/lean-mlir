
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_proof.test_srem_canonicalize_op0_thm_1 (e e_1 : IntW 32) :
  LLVM.srem (sub (const? 32 0) e { «nsw» := true }) e_1 ⊑ sub (const? 32 0) (LLVM.srem e e_1) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
