
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsinkhnothintohlogicalhor_proof
theorem t0_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.xor (select (icmp IntPredicate.eq e_3 e_2) (const? 1 1) (icmp IntPredicate.eq e_1 e)) (const? 1 1) ⊑
    select (icmp IntPredicate.ne e_3 e_2) (icmp IntPredicate.ne e_1 e) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem n2_thm (e e_1 : IntW 32) (e_2 : IntW 1) :
  LLVM.xor (select e_2 (const? 1 1) (icmp IntPredicate.eq e_1 e)) (const? 1 1) ⊑
    select (LLVM.xor e_2 (const? 1 1)) (icmp IntPredicate.ne e_1 e) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


