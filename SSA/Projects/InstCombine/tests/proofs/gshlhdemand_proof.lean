
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhdemand_proof
theorem set_shl_mask_thm :
  ∀ (e e_1 : IntW 32),
    LLVM.and (shl (LLVM.or e_1 (const? 196609)) e) (const? 65536) ⊑
      LLVM.and (shl (LLVM.or e_1 (const? 65537)) e) (const? 65536) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


