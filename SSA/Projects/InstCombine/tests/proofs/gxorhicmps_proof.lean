
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gxorhicmps_proof
theorem slt_zero_thm (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPredicate.slt e_1 (const? 4 0)) (icmp IntPredicate.slt e (const? 4 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 4 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sgt_minus1_thm (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPredicate.sgt e_1 (const? 4 (-1))) (icmp IntPredicate.sgt e (const? 4 (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 4 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem slt_zero_sgt_minus1_thm (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPredicate.slt e_1 (const? 4 0)) (icmp IntPredicate.sgt e (const? 4 (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 4 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e e_1 : IntW 8) :
  LLVM.xor (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ugt e_1 e) ⊑ icmp IntPredicate.ne e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e e_1 : IntW 8) :
  LLVM.xor (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.ne e e_1) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_true_signed_thm (e : IntW 32) :
  LLVM.xor (icmp IntPredicate.sgt e (const? 32 5)) (icmp IntPredicate.slt e (const? 32 6)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_true_signed_commuted_thm (e : IntW 32) :
  LLVM.xor (icmp IntPredicate.slt e (const? 32 6)) (icmp IntPredicate.sgt e (const? 32 5)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_true_unsigned_thm (e : IntW 32) :
  LLVM.xor (icmp IntPredicate.ugt e (const? 32 5)) (icmp IntPredicate.ult e (const? 32 6)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_to_ne_thm (e : IntW 32) :
  LLVM.xor (icmp IntPredicate.sgt e (const? 32 4)) (icmp IntPredicate.slt e (const? 32 6)) ⊑
    icmp IntPredicate.ne e (const? 32 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_to_icmp_add_thm (e : IntW 32) :
  LLVM.xor (icmp IntPredicate.sgt e (const? 32 3)) (icmp IntPredicate.slt e (const? 32 6)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-6))) (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_icmp_invalid_range_thm (e : IntW 8) :
  LLVM.xor (icmp IntPredicate.eq e (const? 8 0)) (icmp IntPredicate.ne e (const? 8 4)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 (-5))) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


