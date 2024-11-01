
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhdemand_proof
theorem src_srem_shl_demand_max_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 2)) (const? 30)) (const? (-2147483648)) ⊑
    LLVM.and (LLVM.srem e (const? 2)) (const? (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_min_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 1073741823)) (const? 1)) (const? (-2147483648)) ⊑
    LLVM.and (LLVM.srem e (const? 1073741823)) (const? (-2147483648)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_max_mask_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 2)) (const? 1)) (const? (-4)) ⊑
    LLVM.and (LLVM.srem e (const? 2)) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 4)) (const? 29)) (const? (-1073741824)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 4)) (const? 29) { «nsw» := true, «nuw» := false })
      (const? (-1073741824)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 536870912)) (const? 1)) (const? (-1073741822)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 536870912)) (const? 1) { «nsw» := true, «nuw» := false })
      (const? (-1073741822)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_eliminate_signbit_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 1073741824)) (const? 1)) (const? 2) ⊑
    LLVM.and (shl (LLVM.srem e (const? 1073741824)) (const? 1) { «nsw» := true, «nuw» := false }) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_srem_shl_demand_max_mask_hit_demand_thm (e : IntW 32) :
  LLVM.and (shl (LLVM.srem e (const? 4)) (const? 1)) (const? (-4)) ⊑
    LLVM.and (shl (LLVM.srem e (const? 4)) (const? 1) { «nsw» := true, «nuw» := false }) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_shl_trunc_same_size_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (shl (sext 32 e_1) e) ⊑ trunc 16 (shl (zext 32 e_1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_shl_trunc_smaller_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 5 (shl (sext 32 e_1) e) ⊑ trunc 5 (shl (zext 32 e_1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_shl_mask_thm (e : IntW 32) (e_1 : IntW 16) :
  LLVM.and (shl (sext 32 e_1) e) (const? 65535) ⊑ LLVM.and (shl (zext 32 e_1) e) (const? 65535) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem set_shl_mask_thm (e e_1 : IntW 32) :
  LLVM.and (shl (LLVM.or e_1 (const? 196609)) e) (const? 65536) ⊑
    LLVM.and (shl (LLVM.or e_1 (const? 65537)) e) (const? 65536) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem must_drop_poison_thm (e e_1 : IntW 32) :
  trunc 8 (shl (LLVM.and e_1 (const? 255)) e { «nsw» := true, «nuw» := true }) ⊑ trunc 8 (shl e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f_t15_t01_t09_thm (e : IntW 40) :
  shl (trunc 32 (ashr e (const? 31))) (const? 16) ⊑ LLVM.and (trunc 32 (ashr e (const? 15))) (const? (-65536)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


