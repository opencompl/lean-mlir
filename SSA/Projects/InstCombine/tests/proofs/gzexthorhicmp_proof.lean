
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gzexthorhicmp_proof
theorem zext_or_eq_ult_add_thm (e : IntW 32) :
  zext 32 (LLVM.or (icmp IntPredicate.ult (add e (const? (-3))) (const? 3)) (icmp IntPredicate.eq e (const? 5))) ⊑
    zext 32 (icmp IntPredicate.ult (add e (const? (-3))) (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_zext_or_eq_ult_add_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? (-3))) (const? 2)) (const? 1)
      (zext 32 (icmp IntPredicate.eq e (const? 5))) ⊑
    zext 32 (icmp IntPredicate.ult (add e (const? (-3))) (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


