
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddhshlhsdivhtohsrem_proof
theorem addhshlhsdivhscalar0_thm (e : IntW 8) : add (shl (LLVM.sdiv e (const? (-4))) (const? 2)) e ⊑ LLVM.srem e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem addhshlhsdivhscalar1_thm (e : IntW 8) :
  add (shl (LLVM.sdiv e (const? (-64))) (const? 6)) e ⊑ LLVM.srem e (const? 64) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem addhshlhsdivhscalar2_thm (e : IntW 32) :
  add (shl (LLVM.sdiv e (const? (-1073741824))) (const? 30)) e ⊑ LLVM.srem e (const? 1073741824) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem addhshlhsdivhnegative0_thm (e : IntW 8) :
  add (shl (LLVM.sdiv e (const? 4)) (const? 2)) e ⊑
    add (shl (LLVM.sdiv e (const? 4)) (const? 2) { «nsw» := true, «nuw» := false }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem addhshlhsdivhnegative1_thm (e : IntW 32) : add (shl (LLVM.sdiv e (const? (-1))) (const? 1)) e ⊑ sub (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


