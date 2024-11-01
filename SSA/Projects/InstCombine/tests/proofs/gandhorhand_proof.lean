
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhorhand_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.and e_1 (const? 7)) (LLVM.and e (const? 8))) (const? 7) ⊑ LLVM.and e_1 (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 8) (e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (zext 32 e)) (const? 65536) ⊑ LLVM.and e_1 (const? 65536) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (shl e (const? 1))) (const? 1) ⊑ LLVM.and e_1 (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (lshr e (const? 31))) (const? 2) ⊑ LLVM.and e_1 (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_test1_thm (e : IntW 32) : LLVM.or (LLVM.and e (const? 1)) (const? 1) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_test2_thm (e : IntW 8) : LLVM.or (shl e (const? 7)) (const? (-128)) ⊑ const? (-128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


