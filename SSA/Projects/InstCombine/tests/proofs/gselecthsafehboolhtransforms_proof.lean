
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gselecthsafehboolhtransforms_proof
theorem land_land_left1_thm (e e_1 : IntW 1) :
  select (select e_1 e (const? 1 0)) e_1 (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_land_left2_thm (e e_1 : IntW 1) :
  select (select e_1 e (const? 1 0)) e (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_band_left1_thm (e e_1 : IntW 1) : LLVM.and (select e_1 e (const? 1 0)) e_1 ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_band_left2_thm (e e_1 : IntW 1) : LLVM.and (select e_1 e (const? 1 0)) e ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_lor_left1_thm (e e_1 : IntW 1) : select (select e_1 e (const? 1 0)) (const? 1 1) e_1 ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_lor_left2_thm (e e_1 : IntW 1) : select (select e_1 e (const? 1 0)) (const? 1 1) e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_bor_left1_thm (e e_1 : IntW 1) : LLVM.or (select e_1 e (const? 1 0)) e_1 ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_bor_left2_thm (e e_1 : IntW 1) : LLVM.or (select e_1 e (const? 1 0)) e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_land_left1_thm (e e_1 : IntW 1) : select (LLVM.and e_1 e) e_1 (const? 1 0) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_land_left2_thm (e e_1 : IntW 1) : select (LLVM.and e_1 e) e (const? 1 0) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_lor_left1_thm (e e_1 : IntW 1) : select (LLVM.and e_1 e) (const? 1 1) e_1 ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_lor_left2_thm (e e_1 : IntW 1) : select (LLVM.and e_1 e) (const? 1 1) e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_land_left1_thm (e e_1 : IntW 1) : select (select e_1 (const? 1 1) e) e_1 (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_land_left2_thm (e e_1 : IntW 1) : select (select e_1 (const? 1 1) e) e (const? 1 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_band_left1_thm (e e_1 : IntW 1) : LLVM.and (select e_1 (const? 1 1) e) e_1 ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_band_left2_thm (e e_1 : IntW 1) : LLVM.and (select e_1 (const? 1 1) e) e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_lor_left1_thm (e e_1 : IntW 1) :
  select (select e_1 (const? 1 1) e) (const? 1 1) e_1 ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_lor_left2_thm (e e_1 : IntW 1) :
  select (select e_1 (const? 1 1) e) (const? 1 1) e ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_bor_left1_thm (e e_1 : IntW 1) : LLVM.or (select e_1 (const? 1 1) e) e_1 ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_bor_left2_thm (e e_1 : IntW 1) : LLVM.or (select e_1 (const? 1 1) e) e ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_land_left1_thm (e e_1 : IntW 1) : select (LLVM.or e_1 e) e_1 (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_land_left2_thm (e e_1 : IntW 1) : select (LLVM.or e_1 e) e (const? 1 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_lor_left1_thm (e e_1 : IntW 1) : select (LLVM.or e_1 e) (const? 1 1) e_1 ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_lor_left2_thm (e e_1 : IntW 1) : select (LLVM.or e_1 e) (const? 1 1) e ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_land_right1_thm (e e_1 : IntW 1) :
  select e_1 (select e_1 e (const? 1 0)) (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_land_right2_thm (e e_1 : IntW 1) :
  select e_1 (select e e_1 (const? 1 0)) (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_band_right1_thm (e e_1 : IntW 1) : LLVM.and e_1 (select e_1 e (const? 1 0)) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_band_right2_thm (e e_1 : IntW 1) : LLVM.and e_1 (select e e_1 (const? 1 0)) ⊑ select e e_1 (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_lor_right1_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (select e_1 e (const? 1 0)) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_lor_right2_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (select e e_1 (const? 1 0)) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_bor_right1_thm (e e_1 : IntW 1) : LLVM.or e_1 (select e_1 e (const? 1 0)) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem land_bor_right2_thm (e e_1 : IntW 1) : LLVM.or e_1 (select e e_1 (const? 1 0)) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_land_right1_thm (e e_1 : IntW 1) : select e_1 (LLVM.and e_1 e) (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_land_right2_thm (e e_1 : IntW 1) : select e_1 (LLVM.and e e_1) (const? 1 0) ⊑ select e_1 e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_lor_right1_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (LLVM.and e_1 e) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem band_lor_right2_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (LLVM.and e e_1) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_land_right1_thm (e e_1 : IntW 1) : select e_1 (select e_1 (const? 1 1) e) (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_land_right2_thm (e e_1 : IntW 1) : select e_1 (select e (const? 1 1) e_1) (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_band_right1_thm (e e_1 : IntW 1) : LLVM.and e_1 (select e_1 (const? 1 1) e) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_band_right2_thm (e e_1 : IntW 1) : LLVM.and e_1 (select e (const? 1 1) e_1) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_lor_right1_thm (e e_1 : IntW 1) :
  select e_1 (const? 1 1) (select e_1 (const? 1 1) e) ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_lor_right2_thm (e e_1 : IntW 1) :
  select e_1 (const? 1 1) (select e (const? 1 1) e_1) ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_bor_right1_thm (e e_1 : IntW 1) : LLVM.or e_1 (select e_1 (const? 1 1) e) ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lor_bor_right2_thm (e e_1 : IntW 1) : LLVM.or e_1 (select e (const? 1 1) e_1) ⊑ select e (const? 1 1) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_land_right1_thm (e e_1 : IntW 1) : select e_1 (LLVM.or e_1 e) (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_land_right2_thm (e e_1 : IntW 1) : select e_1 (LLVM.or e e_1) (const? 1 0) ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_lor_right1_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (LLVM.or e_1 e) ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bor_lor_right2_thm (e e_1 : IntW 1) : select e_1 (const? 1 1) (LLVM.or e e_1) ⊑ select e_1 (const? 1 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


