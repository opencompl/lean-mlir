
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h07h10hCastSextBool_proof
theorem PR2539_A_thm (e : IntW 1) : icmp IntPredicate.slt (zext 32 e) (const? 32 1) ⊑ LLVM.xor e (const? 1 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR2539_B_thm (e : IntW 1) : icmp IntPredicate.slt e (const? 1 1) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


