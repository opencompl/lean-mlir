
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhcompare_proof
theorem test1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and e_1 (const? 65280)) (LLVM.and e (const? 65280)) ⊑
    icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 e) (const? 65280)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_eq_0_and_15_add_1_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 1)) (const? 15)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ne_0_and_15_add_1_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 1)) (const? 15)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 15)) (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_eq_0_and_15_add_3_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 3)) (const? 15)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 13) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ne_0_and_15_add_3_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 3)) (const? 15)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 15)) (const? 13) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_eq_11_and_15_add_10_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 10)) (const? 15)) (const? 11) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ne_11_and_15_add_10_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 10)) (const? 15)) (const? 11) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 15)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


