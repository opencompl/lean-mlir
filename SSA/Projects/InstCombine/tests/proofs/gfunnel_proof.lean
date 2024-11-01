
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfunnel_proof
theorem unmasked_shlop_insufficient_mask_shift_amount_thm (e✝ e✝¹ e✝² : IntW 16) :
  trunc 8
      (LLVM.or (shl e✝² (sub (const? 8) (LLVM.and e✝¹ (const? 15))))
        (lshr (LLVM.and e✝ (const? 255)) (LLVM.and e✝¹ (const? 15)))) ⊑
    trunc 8
      (LLVM.or (shl e✝² (sub (const? 8) (LLVM.and e✝¹ (const? 15)) { «nsw» := true, «nuw» := false }))
        (lshr (LLVM.and e✝ (const? 255)) (LLVM.and e✝¹ (const? 15)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


