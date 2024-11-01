
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsignedhaddhlackhofhoverflowhcheckhviahxor_proof
theorem t3_no_extrause_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (LLVM.xor e_1 (const? (-1))) e ⊑ icmp IntPredicate.ule e (LLVM.xor e_1 (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


