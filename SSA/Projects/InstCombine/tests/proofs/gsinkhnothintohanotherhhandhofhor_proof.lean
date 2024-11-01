
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsinkhnothintohanotherhhandhofhor_proof
theorem t0_thm (e e_1 e_2 e_3 : IntW 8) (e_4 : IntW 1) :
  select (LLVM.or (LLVM.xor e_4 (const? 1)) (icmp IntPredicate.eq e_3 e_2)) e_1 e ⊑
    select (LLVM.and (icmp IntPredicate.ne e_3 e_2) e_4) e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  LLVM.or (LLVM.xor e_2 (const? 1)) (icmp IntPredicate.eq e_1 e) ⊑
    LLVM.or (icmp IntPredicate.eq e_1 e) (LLVM.xor e_2 (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


