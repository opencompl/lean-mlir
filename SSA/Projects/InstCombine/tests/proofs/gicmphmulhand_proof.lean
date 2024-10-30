
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphmulhand_proof
theorem pr40493_neg3_thm :
  ∀ (e : IntW 32), LLVM.and (mul e (const? 12)) (const? 4) ⊑ LLVM.and (shl e (const? 2)) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pr51551_demand3bits_thm :
  ∀ (e e_1 : IntW 32),
    LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? (-7))) (const? 1)) e) (const? 7) ⊑ LLVM.and e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


