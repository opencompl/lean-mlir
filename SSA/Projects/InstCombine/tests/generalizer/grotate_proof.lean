
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section grotate_proof
theorem rotateleft_9_neg_mask_wide_amount_commute_proof.rotateleft_9_neg_mask_wide_amount_commute_thm_1 (e : IntW 9) (e_1 : IntW 33) :
  trunc 9
      (LLVM.or (shl (zext 33 e) (LLVM.and e_1 (const? 33 8)))
        (lshr (zext 33 e) (LLVM.and (sub (const? 33 0) e_1) (const? 33 8)))) ⊑
    trunc 9
      (LLVM.or (shl (zext 33 e) (LLVM.and e_1 (const? 33 8)) { «nsw» := true, «nuw» := true })
        (lshr (zext 33 e) (LLVM.and (sub (const? 33 0) e_1) (const? 33 8)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
