
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpr49688_proof
theorem f_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 0)) (const? 1) (icmp IntPredicate.sgt e (ashr (const? 7) e)) ⊑
    select (icmp IntPredicate.slt e (const? 0)) (const? 1) (icmp IntPredicate.sgt e (lshr (const? 7) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f2_thm (e e_1 : IntW 32) :
  zext 32 (select (icmp IntPredicate.slt e_1 (const? 0)) (const? 1) (icmp IntPredicate.sgt e_1 (ashr (const? 7) e))) ⊑
    zext 32
      (select (icmp IntPredicate.slt e_1 (const? 0)) (const? 1)
        (icmp IntPredicate.sgt e_1 (lshr (const? 7) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


