
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsignedhaddhlackhofhoverflowhcheckhviahadd_proof
theorem t6_no_extrause_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (add e_1 e) e ⊑ icmp IntPredicate.ule e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


