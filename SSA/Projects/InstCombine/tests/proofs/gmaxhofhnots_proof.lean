
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmaxhofhnots_proof
theorem max_of_min_thm (e : IntW 32) :
  select
      (icmp IntPredicate.sgt
        (select (icmp IntPredicate.sgt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)))
        (const? 32 (-1)))
      (select (icmp IntPredicate.sgt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_of_min_swap_thm (e : IntW 32) :
  select
      (icmp IntPredicate.sgt
        (select (icmp IntPredicate.slt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1))))
        (const? 32 (-1)))
      (select (icmp IntPredicate.slt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1)))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem min_of_max_thm (e : IntW 32) :
  select
      (icmp IntPredicate.slt
        (select (icmp IntPredicate.slt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)))
        (const? 32 (-1)))
      (select (icmp IntPredicate.slt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem min_of_max_swap_thm (e : IntW 32) :
  select
      (icmp IntPredicate.slt
        (select (icmp IntPredicate.sgt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1))))
        (const? 32 (-1)))
      (select (icmp IntPredicate.sgt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1)))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


