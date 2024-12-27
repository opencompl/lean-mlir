
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gshlhsub_proof
theorem shl_sub_i32_thm (e : IntW 32) :
  shl (const? 32 1) (sub (const? 32 31) e) ⊑ lshr (const? 32 (-2147483648)) e { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_i8_thm (e : IntW 8) :
  shl (const? 8 1) (sub (const? 8 7) e) ⊑ lshr (const? 8 (-128)) e { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_i64_thm (e : IntW 64) :
  shl (const? 64 1) (sub (const? 64 63) e) ⊑ lshr (const? 64 (-9223372036854775808)) e { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_bad_sub_i32_thm (e : IntW 32) :
  shl (const? 32 1) (sub (const? 32 32) e) ⊑
    shl (const? 32 1) (sub (const? 32 32) e) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_bad_sub2_i32_thm (e : IntW 32) :
  shl (const? 32 1) (sub e (const? 32 31)) ⊑
    shl (const? 32 1) (add e (const? 32 (-31))) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bad_shl2_sub_i32_thm (e : IntW 32) :
  shl (const? 32 1) (sub e (const? 32 31)) ⊑
    shl (const? 32 1) (add e (const? 32 (-31))) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_bad_sub_i8_thm (e : IntW 8) :
  shl (const? 8 1) (sub (const? 8 4) e) ⊑
    shl (const? 8 1) (sub (const? 8 4) e) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_bad_sub_i64_thm (e : IntW 64) :
  shl (const? 64 1) (sub (const? 64 67) e) ⊑
    shl (const? 64 1) (sub (const? 64 67) e) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_const_op1_sub_const_op0_thm (e : IntW 32) :
  shl (sub (const? 32 42) e) (const? 32 3) ⊑ sub (const? 32 336) (shl e (const? 32 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


