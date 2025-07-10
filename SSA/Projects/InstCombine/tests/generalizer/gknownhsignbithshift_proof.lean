
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gknownhsignbithshift_proof
theorem test_shift_nonnegative_proof.test_shift_nonnegative_thm_1 (e : IntW 32) :
  icmp IntPred.sge (shl (lshr e (const? 32 2)) (const? 32 3) { «nsw» := true }) (const? 32 0) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_shift_negative_proof.test_shift_negative_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (shl (LLVM.or e (const? 32 (-2147483648))) (LLVM.and e_1 (const? 32 7)) { «nsw» := true })
      (const? 32 0) ⊑
    const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
