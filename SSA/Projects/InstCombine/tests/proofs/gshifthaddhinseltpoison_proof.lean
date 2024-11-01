
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthaddhinseltpoison_proof
theorem shl_C1_add_A_C2_i32_thm (e : IntW 16) :
  shl (const? 32 6) (add (zext 32 e) (const? 32 5)) ⊑ shl (const? 32 192) (zext 32 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_C1_add_A_C2_i32_thm (e : IntW 32) :
  ashr (const? 32 6) (add (LLVM.and e (const? 32 65535)) (const? 32 5)) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_C1_add_A_C2_i32_thm (e : IntW 32) :
  shl (const? 32 6) (add (LLVM.and e (const? 32 65535)) (const? 32 5)) ⊑
    shl (const? 32 192) (LLVM.and e (const? 32 65535)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


