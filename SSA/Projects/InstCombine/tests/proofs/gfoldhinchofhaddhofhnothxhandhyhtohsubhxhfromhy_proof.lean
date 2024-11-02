
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
theorem t0_thm (e e_1 : IntW 32) : add (add (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 1) ⊑ sub e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem n12_thm (e e_1 : IntW 32) :
  add (add (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 2) ⊑
    add (add e (LLVM.xor e_1 (const? 32 (-1)))) (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


