
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section grotate_proof
theorem rotateleft_9_neg_mask_wide_amount_commute_thm :
  ∀ (e : IntW 33) (e_1 : IntW 9),
    trunc 9
        (LLVM.or (shl (zext 33 e_1) (LLVM.and e (const? 8)))
          (lshr (zext 33 e_1) (LLVM.and (sub (const? 0) e) (const? 8)))) ⊑
      trunc 9
        (LLVM.or (shl (zext 33 e_1) (LLVM.and e (const? 8)) { «nsw» := true, «nuw» := true })
          (lshr (zext 33 e_1) (LLVM.and (sub (const? 0) e) (const? 8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


