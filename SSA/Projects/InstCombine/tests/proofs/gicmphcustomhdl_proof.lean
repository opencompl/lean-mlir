
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphcustomhdl_proof
theorem icmp_and_ashr_multiuse_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (ashr e (const? 4)) (const? 15)) (const? 14))
      (icmp IntPredicate.ne (LLVM.and (ashr e (const? 4)) (const? 31)) (const? 27)) ⊑
    LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 240)) (const? 224))
      (icmp IntPredicate.ne (LLVM.and e (const? 496)) (const? 432)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_and_ashr_multiuse_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and (ashr e (const? 4)) (const? 15)) (const? 14))
      (icmp IntPredicate.ne (LLVM.and (ashr e (const? 4)) (const? 31)) (const? 27)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 240)) (const? 224))
      (icmp IntPredicate.ne (LLVM.and e (const? 496)) (const? 432)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_lshr_and_overshift_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (lshr e (const? 5)) (const? 15)) (const? 0) ⊑
    icmp IntPredicate.ugt e (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


