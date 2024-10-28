
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhorhandhxor_proof
theorem sub_to_xor_thm : ∀ (e e_1 : IntW 32), sub (LLVM.or e_1 e) (LLVM.and e_1 e) ⊑ LLVM.xor e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_to_xor_or_commuted_thm : ∀ (e e_1 : IntW 32), sub (LLVM.or e_1 e) (LLVM.and e e_1) ⊑ LLVM.xor e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_to_xor_and_commuted_thm : ∀ (e e_1 : IntW 32), sub (LLVM.or e_1 e) (LLVM.and e e_1) ⊑ LLVM.xor e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


