
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsexthofhtrunchnsw_proof
theorem narrow_source_matching_signbits_proof.narrow_source_matching_signbits_thm_1 (e : IntW 32) :
  sext 64 (trunc 8 (shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true })) ⊑
    sext 64 (shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem wide_source_matching_signbits_proof.wide_source_matching_signbits_thm_1 (e : IntW 32) :
  sext 24 (trunc 8 (shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true })) ⊑
    trunc 24 (shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem same_source_matching_signbits_proof.same_source_matching_signbits_thm_1 (e : IntW 32) :
  sext 32 (trunc 8 (shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true })) ⊑
    shl (const? 32 (-1)) (LLVM.and e (const? 32 7)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem same_source_not_matching_signbits_proof.same_source_not_matching_signbits_thm_1 (e : IntW 32) :
  sext 32 (trunc 8 (shl (const? 32 (-1)) (LLVM.and e (const? 32 8)) { «nsw» := true })) ⊑
    ashr (shl (const? 32 (-16777216)) (LLVM.and e (const? 32 8))) (const? 32 24) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
