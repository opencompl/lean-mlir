
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsinkhnothintohand_proof
theorem t0_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.xor (LLVM.and (icmp IntPredicate.eq e_3 e_2) (icmp IntPredicate.eq e_1 e)) (const? 1 1) ⊑
    LLVM.or (icmp IntPredicate.ne e_3 e_2) (icmp IntPredicate.ne e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


