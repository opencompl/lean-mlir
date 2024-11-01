
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gzexthorhicmp_proof
theorem zext_or_eq_ult_add_thm (e : IntW 32) :
  zext 32
      (LLVM.or (icmp IntPredicate.ult (add e (const? 32 (-3))) (const? 32 3)) (icmp IntPredicate.eq e (const? 32 5))) ⊑
    zext 32 (icmp IntPredicate.ult (add e (const? 32 (-3))) (const? 32 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_zext_or_eq_ult_add_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 (-3))) (const? 32 2)) (const? 32 1)
      (zext 32 (icmp IntPredicate.eq e (const? 32 5))) ⊑
    zext 32 (icmp IntPredicate.ult (add e (const? 32 (-3))) (const? 32 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


