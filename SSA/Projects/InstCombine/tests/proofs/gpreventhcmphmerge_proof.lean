
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpreventhcmphmerge_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.xor e_1 (const? 5)) (const? 10))
      (icmp IntPredicate.eq (LLVM.xor e_1 (const? 5)) e) ⊑
    LLVM.or (icmp IntPredicate.eq e_1 (const? 15)) (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.xor e_1 (const? 5)) (const? 10)) (const? 1)
      (icmp IntPredicate.eq (LLVM.xor e_1 (const? 5)) e) ⊑
    select (icmp IntPredicate.eq e_1 (const? 15)) (const? 1) (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  LLVM.xor (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 0)) (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 32)) ⊑
    LLVM.xor (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 0))
      (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 31)) ⊑
    LLVM.or (icmp IntPredicate.eq e_1 e)
      (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 0)) (const? 1)
      (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 31)) ⊑
    select (icmp IntPredicate.eq e_1 e) (const? 1)
      (icmp IntPredicate.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


