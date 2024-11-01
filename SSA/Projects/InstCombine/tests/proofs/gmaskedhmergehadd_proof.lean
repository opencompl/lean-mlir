
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmaskedhmergehadd_proof
theorem p_thm (e e_1 e_2 : IntW 32) :
  add (LLVM.and e_2 e_1) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.or (LLVM.and e_2 e_1) (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_constmask_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 (const? 32 65280)) (LLVM.and e (const? 32 (-65281))) ⊑
    LLVM.or (LLVM.and e_1 (const? 32 65280)) (LLVM.and e (const? 32 (-65281))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_constmask2_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 (const? 32 61440)) (LLVM.and e (const? 32 (-65281))) ⊑
    LLVM.or (LLVM.and e_1 (const? 32 61440)) (LLVM.and e (const? 32 (-65281))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative0_thm (e e_1 e_2 : IntW 32) :
  add (LLVM.and e_2 e_1) (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e) ⊑
    LLVM.or (LLVM.and e_2 e_1) (LLVM.and e (LLVM.xor e_2 (const? 32 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative2_thm (e e_1 e_2 : IntW 32) :
  add (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.and e e_2) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) (LLVM.and e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative4_thm (e e_1 e_2 : IntW 32) :
  add (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.and e_2 e) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) (LLVM.and e_2 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_constmask_commutative_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 (const? 32 (-65281))) (LLVM.and e (const? 32 65280)) ⊑
    LLVM.or (LLVM.and e_1 (const? 32 (-65281))) (LLVM.and e (const? 32 65280)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_badmask_thm (e e_1 e_2 e_3 : IntW 32) :
  add (LLVM.and e_3 e_2) (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    add (LLVM.and e_3 e_2) (LLVM.and e (LLVM.xor e_1 (const? 32 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n3_constmask_samemask_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 (const? 32 65280)) (LLVM.and e (const? 32 65280)) ⊑
    add (LLVM.and e_1 (const? 32 65280)) (LLVM.and e (const? 32 65280)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


