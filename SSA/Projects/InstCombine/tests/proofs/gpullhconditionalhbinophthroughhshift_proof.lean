
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpullhconditionalhbinophthroughhshift_proof
theorem and_signbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.and e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.and e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.or e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.or e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.xor e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (LLVM.xor e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_signbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (add e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (add (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nosignbit_select_shl_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  shl (select e✝¹ (add e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (add (shl e✝ (const? 8)) (const? (-16777216))) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_signbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.and e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (lshr e✝ (const? 8)) (const? 16776960)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.and e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (lshr e✝ (const? 8)) (const? 8388352)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.or e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (lshr e✝ (const? 8)) (const? 16776960)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.or e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (lshr e✝ (const? 8)) (const? 8388352)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.xor e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (lshr e✝ (const? 8)) (const? 16776960)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_select_lshr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  lshr (select e✝¹ (LLVM.xor e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (lshr e✝ (const? 8)) (const? 8388352)) (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_signbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.and e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (ashr e✝ (const? 8)) (const? (-256))) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.and e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.and (ashr e✝ (const? 8)) (const? 8388352)) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.or e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (ashr e✝ (const? 8)) (const? (-256))) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.or e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.or (ashr e✝ (const? 8)) (const? 8388352)) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.xor e✝ (const? (-65536))) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (ashr e✝ (const? 8)) (const? (-256))) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_select_ashr_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  ashr (select e✝¹ (LLVM.xor e✝ (const? 2147418112)) e✝) (const? 8) ⊑
    select e✝¹ (LLVM.xor (ashr e✝ (const? 8)) (const? 8388352)) (ashr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


