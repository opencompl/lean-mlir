
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphshlh1hoverflow_proof
theorem icmp_shl_ugt_1_thm (e : IntW 8) :
  icmp IntPredicate.ugt (shl e (const? 1)) e ⊑ icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_uge_2_thm (e : IntW 5) :
  icmp IntPredicate.uge (add (const? 10) e) (shl (add (const? 10) e) (const? 1)) ⊑
    icmp IntPredicate.slt (add e (const? 10)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_ule_2_thm (e : IntW 8) :
  icmp IntPredicate.ule (add (const? 42) e) (shl (add (const? 42) e) (const? 1)) ⊑
    icmp IntPredicate.sgt (add e (const? 42)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_eq_1_thm (e : IntW 8) :
  icmp IntPredicate.eq (shl e (const? 1)) e ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_ne_2_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.sdiv (const? 42) e) (shl (LLVM.sdiv (const? 42) e) (const? 1)) ⊑
    icmp IntPredicate.ne (LLVM.sdiv (const? 42) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


