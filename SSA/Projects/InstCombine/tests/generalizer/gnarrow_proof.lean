
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gnarrow_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 32) :
  trunc 1 (LLVM.and (zext 32 (icmp IntPred.slt e e_1)) (zext 32 (icmp IntPred.sgt e e_1))) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shrink_xor_proof.shrink_xor_thm_1 (e : IntW 64) :
  trunc 32 (LLVM.xor e (const? 64 1)) ⊑ LLVM.xor (trunc 32 e) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shrink_or_proof.shrink_or_thm_1 (e : IntW 6) :
  trunc 3 (LLVM.or e (const? 6 (-31))) ⊑ LLVM.or (trunc 3 e) (const? 3 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shrink_and_proof.shrink_and_thm_1 (e : IntW 64) :
  trunc 31 (LLVM.and e (const? 64 42)) ⊑ trunc 31 (LLVM.and e (const? 64 42)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
