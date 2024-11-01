
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h02h16hSDivOverflow2_proof
theorem i_thm (e : IntW 8) : LLVM.sdiv (LLVM.sdiv e (const? (-3))) (const? (-3)) ⊑ LLVM.sdiv e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


