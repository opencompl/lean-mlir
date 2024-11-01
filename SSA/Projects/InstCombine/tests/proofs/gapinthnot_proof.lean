
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthnot_proof
theorem test1_thm (e✝ : IntW 33) : LLVM.xor (LLVM.xor e✝ (const? (-1))) (const? (-1)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


