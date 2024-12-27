
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gshlhdemand_proof
theorem src_srem_shl_demand_max_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 2)) (const? 32 30)) (const? 32 (-2147483648)) ⊑
    LLVM.and (LLVM.srem e (const? 32 2)) (const? 32 (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_min_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 1073741823)) (const? 32 1)) (const? 32 (-2147483648)) ⊑
    LLVM.and (LLVM.srem e (const? 32 1073741823)) (const? 32 (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_max_mask_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 2)) (const? 32 1)) (const? 32 (-4)) ⊑
    LLVM.and (LLVM.srem e (const? 32 2)) (const? 32 (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 4)) (const? 32 29)) (const? 32 (-1073741824)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 32 4)) (const? 32 29) { «nsw» := true, «nuw» := false })
      (const? 32 (-1073741824)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 536870912)) (const? 32 1)) (const? 32 (-1073741822)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 32 536870912)) (const? 32 1) { «nsw» := true, «nuw» := false })
      (const? 32 (-1073741822)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_eliminate_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 1073741824)) (const? 32 1)) (const? 32 2) ⊑
    LLVM.and (shl (LLVM.srem e (const? 32 1073741824)) (const? 32 1) { «nsw» := true, «nuw» := false })
      (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_srem_shl_demand_max_mask_hit_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 32 4)) (const? 32 1)) (const? 32 (-4)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 32 4)) (const? 32 1) { «nsw» := true, «nuw» := false }) (const? 32 (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_shl_trunc_same_size_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (shl (sext 32 e_1) e) ⊑ trunc 16 (shl (zext 32 e_1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_shl_trunc_smaller_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 5 (shl (sext 32 e_1) e) ⊑ trunc 5 (shl (zext 32 e_1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_shl_mask_thm (e : IntW 32) (e_1 : IntW 16) :
  LLVM.and (shl (sext 32 e_1) e) (const? 32 65535) ⊑ LLVM.and (shl (zext 32 e_1) e) (const? 32 65535) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_shl_mask_thm (e e_1 : IntW 32) :
  LLVM.and (shl (LLVM.or e_1 (const? 32 196609)) e) (const? 32 65536) ⊑
    LLVM.and (shl (LLVM.or e_1 (const? 32 65537)) e) (const? 32 65536) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem must_drop_poison_thm (e e_1 : IntW 32) :
  trunc 8 (shl (LLVM.and e_1 (const? 32 255)) e { «nsw» := true, «nuw» := true }) ⊑ trunc 8 (shl e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f_t15_t01_t09_thm (e : IntW 40) :
  shl (trunc 32 (ashr e (const? 40 31))) (const? 32 16) ⊑
    LLVM.and (trunc 32 (ashr e (const? 40 15)) { «nsw» := true, «nuw» := false }) (const? 32 (-65536)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


