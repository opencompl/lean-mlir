
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gshifthamounthreassociation_proof
theorem t0_thm (e e_1 : IntW 32) :
  lshr (lshr e_1 (sub (const? 32 32) e)) (add e (const? 32 (-2))) { «exact» := true } ⊑ lshr e_1 (const? 32 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t6_shl_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32 32) e) { «nsw» := false, «nuw» := true }) (add e (const? 32 (-2)))
      { «nsw» := true, «nuw» := false } ⊑
    shl e_1 (const? 32 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t7_ashr_thm (e e_1 : IntW 32) :
  ashr (ashr e_1 (sub (const? 32 32) e) { «exact» := true }) (add e (const? 32 (-2))) ⊑ ashr e_1 (const? 32 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t8_lshr_exact_flag_preservation_thm (e e_1 : IntW 32) :
  lshr (lshr e_1 (sub (const? 32 32) e) { «exact» := true }) (add e (const? 32 (-2))) { «exact» := true } ⊑
    lshr e_1 (const? 32 30) { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_ashr_exact_flag_preservation_thm (e e_1 : IntW 32) :
  ashr (ashr e_1 (sub (const? 32 32) e) { «exact» := true }) (add e (const? 32 (-2))) { «exact» := true } ⊑
    ashr e_1 (const? 32 30) { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t10_shl_nuw_flag_preservation_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32 32) e) { «nsw» := false, «nuw» := true }) (add e (const? 32 (-2)))
      { «nsw» := true, «nuw» := true } ⊑
    shl e_1 (const? 32 30) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t11_shl_nsw_flag_preservation_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32 32) e) { «nsw» := true, «nuw» := false }) (add e (const? 32 (-2)))
      { «nsw» := true, «nuw» := true } ⊑
    shl e_1 (const? 32 30) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


