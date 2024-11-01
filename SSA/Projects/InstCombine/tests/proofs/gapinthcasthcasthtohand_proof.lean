
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthcasthcasthtohand_proof
theorem test1_thm (e : IntW 61) : zext 61 (trunc 41 e) ⊑ LLVM.and e (const? 2199023255551) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


