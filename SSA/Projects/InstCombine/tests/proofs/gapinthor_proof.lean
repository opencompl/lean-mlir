
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthor_proof
theorem test1_thm (e✝ : IntW 23) : LLVM.or e✝ (LLVM.xor (const? (-1)) e✝) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ : IntW 39) :
  LLVM.or (LLVM.and (add e✝¹ (LLVM.and e✝ (const? (-274877906944)))) (LLVM.xor (const? 274877906943) (const? (-1))))
      (LLVM.and e✝¹ (const? 274877906943)) ⊑
    add e✝¹ (LLVM.and e✝ (const? (-274877906944))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 1023) : LLVM.or e✝ (LLVM.xor (const? (-1)) e✝) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ e✝¹ : IntW 399) :
  LLVM.or
      (LLVM.and (add e✝¹ (LLVM.and e✝ (const? 18446742974197923840))) (LLVM.xor (const? 274877906943) (const? (-1))))
      (LLVM.and e✝¹ (const? 274877906943)) ⊑
    add e✝¹ (LLVM.and e✝ (const? 18446742974197923840)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


