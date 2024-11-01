
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhorhimpliedhcondhnot_proof
theorem test_imply_not2_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.or (select (icmp IntPredicate.eq e_1 (const? 32 0)) e (const? 1 0))
      (LLVM.xor (icmp IntPredicate.eq e_1 (const? 32 0)) (const? 1 1)) ⊑
    select (icmp IntPredicate.ne e_1 (const? 32 0)) (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


