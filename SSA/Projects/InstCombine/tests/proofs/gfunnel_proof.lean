
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gfunnel_proof
theorem unmasked_shlop_insufficient_mask_shift_amount_thm (e e_1 e_2 : IntW 16) :
  trunc 8
      (LLVM.or (shl e_2 (sub (const? 16 8) (LLVM.and e_1 (const? 16 15))))
        (lshr (LLVM.and e (const? 16 255)) (LLVM.and e_1 (const? 16 15)))) ⊑
    trunc 8
      (LLVM.or (shl e_2 (sub (const? 16 8) (LLVM.and e_1 (const? 16 15)) { «nsw» := true, «nuw» := false }))
        (lshr (LLVM.and e (const? 16 255)) (LLVM.and e_1 (const? 16 15)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
