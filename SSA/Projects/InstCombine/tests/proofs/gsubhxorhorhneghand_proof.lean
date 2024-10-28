
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhxorhorhneghand_proof
theorem sub_to_and_thm :
  ∀ (e e_1 : IntW 32), sub (LLVM.xor e_1 e) (LLVM.or e_1 e) ⊑ sub (const? 0) (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_to_and_or_commuted_thm :
  ∀ (e e_1 : IntW 32), sub (LLVM.xor e_1 e) (LLVM.or e e_1) ⊑ sub (const? 0) (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_to_and_and_commuted_thm :
  ∀ (e e_1 : IntW 32), sub (LLVM.xor e_1 e) (LLVM.or e e_1) ⊑ sub (const? 0) (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


