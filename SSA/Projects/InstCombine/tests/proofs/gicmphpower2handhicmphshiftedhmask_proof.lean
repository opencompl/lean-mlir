
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphpower2handhicmphshiftedhmask_proof
theorem icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? (-2147483648)))
      (icmp IntPredicate.ne (LLVM.and e (const? 1610612736)) (const? 1610612736)) ⊑
    icmp IntPredicate.ult e (const? 1610612736) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 1610612736)) (const? 1610612736))
      (icmp IntPredicate.ult e (const? (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? 1610612736) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? (-2147483648)))
      (icmp IntPredicate.ne (LLVM.and e (const? 2147483647)) (const? 2147483647)) ⊑
    icmp IntPredicate.ult e (const? 2147483647) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 2147483647)) (const? 2147483647))
      (icmp IntPredicate.ult e (const? (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? 2147483647) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_2147483648_805306368_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 1073741824))
      (icmp IntPredicate.ne (LLVM.and e (const? 805306368)) (const? 805306368)) ⊑
    icmp IntPredicate.ult e (const? 805306368) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 805306368)) (const? 805306368))
      (icmp IntPredicate.ult e (const? 1073741824)) ⊑
    icmp IntPredicate.ult e (const? 805306368) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 1073741824))
      (icmp IntPredicate.ne (LLVM.and e (const? 1073741823)) (const? 1073741823)) ⊑
    icmp IntPredicate.ult e (const? 1073741823) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 1073741823)) (const? 1073741823))
      (icmp IntPredicate.ult e (const? 1073741824)) ⊑
    icmp IntPredicate.ult e (const? 1073741823) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_8_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 8)) (icmp IntPredicate.ne (LLVM.and e (const? 7)) (const? 7)) ⊑
    icmp IntPredicate.ult e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_8_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 7)) (const? 7)) (icmp IntPredicate.ult e (const? 8)) ⊑
    icmp IntPredicate.ult e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_8_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 8)) (icmp IntPredicate.ne (LLVM.and e (const? 6)) (const? 6)) ⊑
    icmp IntPredicate.ult e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_8_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e (const? 6)) (const? 6)) (icmp IntPredicate.ult e (const? 8)) ⊑
    icmp IntPredicate.ult e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


