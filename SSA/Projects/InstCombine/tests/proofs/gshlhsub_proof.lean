
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhsub_proof
theorem shl_sub_i32_thm : ∀ (e : IntW 32), shl (const? 1) (sub (const? 31) e) ⊑ lshr (const? (-2147483648)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_sub_i8_thm : ∀ (e : IntW 8), shl (const? 1) (sub (const? 7) e) ⊑ lshr (const? (-128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_sub_i64_thm :
  ∀ (e : IntW 64), shl (const? 1) (sub (const? 63) e) ⊑ lshr (const? (-9223372036854775808)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_bad_sub2_i32_thm :
  ∀ (e : IntW 32), shl (const? 1) (sub e (const? 31)) ⊑ shl (const? 1) (add e (const? (-31))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bad_shl2_sub_i32_thm :
  ∀ (e : IntW 32), shl (const? 1) (sub e (const? 31)) ⊑ shl (const? 1) (add e (const? (-31))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_const_op1_sub_const_op0_thm : ∀ (e : IntW 32), shl (sub (const? 42) e) (const? 3) ⊑ sub (const? 336) (shl e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


