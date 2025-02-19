
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthshift_proof
theorem shl_shl_thm (e : IntW 32) : shl (shl e (const? 32 6)) (const? 32 28) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_lshr_thm (e : IntW 232) : lshr (lshr e (const? 232 231)) (const? 232 1) ⊑ const? 232 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_bigger_lshr_thm (e : IntW 32) :
  shl (trunc 8 (lshr e (const? 32 5))) (const? 8 3) ⊑ LLVM.and (trunc 8 (lshr e (const? 32 2))) (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_smaller_lshr_thm (e : IntW 32) :
  shl (trunc 8 (lshr e (const? 32 3))) (const? 8 5) ⊑ LLVM.and (shl (trunc 8 e) (const? 8 2)) (const? 8 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_bigger_ashr_thm (e : IntW 32) :
  shl (trunc 24 (ashr e (const? 32 12))) (const? 24 3) ⊑
    LLVM.and (trunc 24 (ashr e (const? 32 9)) { «nsw» := true, «nuw» := false }) (const? 24 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_smaller_ashr_thm (e : IntW 32) :
  shl (trunc 24 (ashr e (const? 32 10))) (const? 24 13) ⊑
    LLVM.and (shl (trunc 24 e) (const? 24 3)) (const? 24 (-8192)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_bigger_shl_thm (e : IntW 32) :
  shl (trunc 8 (shl e (const? 32 4))) (const? 8 2) ⊑ shl (trunc 8 e) (const? 8 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_trunc_smaller_shl_thm (e : IntW 32) :
  shl (trunc 8 (shl e (const? 32 2))) (const? 8 4) ⊑ shl (trunc 8 e) (const? 8 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_shl_constants_div_thm (e e_1 : IntW 32) :
  LLVM.udiv e_1 (shl (shl (const? 32 1) e) (const? 32 2)) ⊑ lshr e_1 (add e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_shl_constants_thm (e : IntW 32) :
  shl (ashr (const? 32 (-33)) e) (const? 32 3) ⊑
    shl (ashr (const? 32 (-33)) e) (const? 32 3) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_demand1_thm (e : IntW 8) :
  LLVM.or (lshr (shl (const? 8 40) e) (const? 8 3)) (const? 8 (-32)) ⊑
    LLVM.or (shl (const? 8 5) e) (const? 8 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_demand3_thm (e : IntW 8) :
  LLVM.or (lshr (shl (const? 8 40) e) (const? 8 3)) (const? 8 (-64)) ⊑
    LLVM.or (lshr (shl (const? 8 40) e) (const? 8 3) { «exact» := true }) (const? 8 (-64))
      { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_demand4_thm (e : IntW 8) :
  LLVM.or (lshr (shl (const? 8 44) e) (const? 8 3)) (const? 8 (-32)) ⊑
    LLVM.or (lshr (shl (const? 8 44) e) (const? 8 3)) (const? 8 (-32)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_demand6_thm (e : IntW 16) :
  LLVM.and (lshr (shl (const? 16 (-32624)) e) (const? 16 4)) (const? 16 4094) ⊑
    LLVM.and (shl (const? 16 2057) e) (const? 16 4094) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_shl_demand1_thm (e : IntW 8) :
  LLVM.or (shl (lshr (const? 8 28) e) (const? 8 3)) (const? 8 7) ⊑
    LLVM.or (lshr (const? 8 (-32)) e) (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_shl_demand3_thm (e : IntW 8) :
  LLVM.or (shl (lshr (const? 8 28) e) (const? 8 3)) (const? 8 3) ⊑
    LLVM.or (shl (lshr (const? 8 28) e) (const? 8 3) { «nsw» := false, «nuw» := true }) (const? 8 3)
      { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_shl_demand4_thm (e : IntW 8) :
  LLVM.or (shl (lshr (const? 8 60) e) (const? 8 3)) (const? 8 7) ⊑
    LLVM.or (shl (lshr (const? 8 60) e) (const? 8 3)) (const? 8 7) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


