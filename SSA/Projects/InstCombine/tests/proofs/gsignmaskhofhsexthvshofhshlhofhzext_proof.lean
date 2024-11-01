
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignmaskhofhsexthvshofhshlhofhzext_proof
theorem t0_thm (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 16)) (const? 32 (-2147483648)) ⊑
    LLVM.and (sext 32 e) (const? 32 (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e : IntW 8) :
  LLVM.and (shl (zext 32 e) (const? 32 24)) (const? 32 (-2147483648)) ⊑
    LLVM.and (sext 32 e) (const? 32 (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_thm (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 15)) (const? 32 (-2147483648)) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n4_thm (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 16)) (const? 32 (-1073741824)) ⊑
    LLVM.and (shl (zext 32 e) (const? 32 16) { «nsw» := false, «nuw» := true }) (const? 32 (-1073741824)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


