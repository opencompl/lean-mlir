
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsignedhaddhlackhofhoverflowhcheck_proof
theorem t0_basic_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (add e_1 e) e ⊑ icmp IntPredicate.ule e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_symmetry_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (add e_1 e) e_1 ⊑ icmp IntPredicate.ule e (LLVM.xor e_1 (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t4_commutative_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule e_1 (add e e_1) ⊑ icmp IntPredicate.ule e (LLVM.xor e_1 (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n10_wrong_pred2_thm (e e_1 : IntW 8) : icmp IntPredicate.eq (add e_1 e) e ⊑ icmp IntPredicate.eq e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n11_wrong_pred3_thm (e e_1 : IntW 8) : icmp IntPredicate.ne (add e_1 e) e ⊑ icmp IntPredicate.ne e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem low_bitmask_ult_thm (e : IntW 8) :
  icmp IntPredicate.ult (LLVM.and (add e (const? 31)) (const? 31)) e ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem low_bitmask_ugt_thm (e : IntW 8) :
  icmp IntPredicate.ugt (mul e e) (LLVM.and (add (mul e e) (const? 127)) (const? 127)) ⊑
    icmp IntPredicate.ne (mul e e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


