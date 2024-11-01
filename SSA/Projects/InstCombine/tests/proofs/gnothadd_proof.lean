
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnothadd_proof
theorem basic_thm (e e_1 : IntW 8) : LLVM.xor (add (LLVM.xor e_1 (const? (-1))) e) (const? (-1)) ⊑ sub e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_com_add_thm (e e_1 : IntW 8) : LLVM.xor (add e_1 (LLVM.xor e (const? (-1)))) (const? (-1)) ⊑ sub e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nsw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? (-1))) e { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    sub e_1 e { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nuw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? (-1))) e { «nsw» := false, «nuw» := true }) (const? (-1)) ⊑
    sub e_1 e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nuw_nsw_thm (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e_1 (const? (-1))) e { «nsw» := true, «nuw» := true }) (const? (-1)) ⊑
    sub e_1 e { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


