
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2003h05h26hCastMiscompile_proof
theorem test_thm (e : IntW 64) : zext 64 (trunc 32 e) ⊑ LLVM.and e (const? 4294967295) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


