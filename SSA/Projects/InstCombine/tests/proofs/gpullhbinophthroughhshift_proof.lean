
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpullhbinophthroughhshift_proof
theorem and_signbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.and e✝ (const? (-65536))) (const? 8) ⊑ LLVM.and (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.and e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.and (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.or e✝ (const? (-65536))) (const? 8) ⊑ LLVM.or (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.or e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.or (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.xor e✝ (const? (-65536))) (const? 8) ⊑ LLVM.xor (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_shl_thm (e✝ : IntW 32) :
  shl (LLVM.xor e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.xor (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_signbit_shl_thm (e✝ : IntW 32) :
  shl (add e✝ (const? (-65536))) (const? 8) ⊑ add (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nosignbit_shl_thm (e✝ : IntW 32) :
  shl (add e✝ (const? 2147418112)) (const? 8) ⊑ add (shl e✝ (const? 8)) (const? (-16777216)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_signbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.and e✝ (const? (-65536))) (const? 8) ⊑ LLVM.and (lshr e✝ (const? 8)) (const? 16776960) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.and e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.and (lshr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.or e✝ (const? (-65536))) (const? 8) ⊑ LLVM.or (lshr e✝ (const? 8)) (const? 16776960) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.or e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.or (lshr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.xor e✝ (const? (-65536))) (const? 8) ⊑ LLVM.xor (lshr e✝ (const? 8)) (const? 16776960) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_lshr_thm (e✝ : IntW 32) :
  lshr (LLVM.xor e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.xor (lshr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_signbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.and e✝ (const? (-65536))) (const? 8) ⊑ LLVM.and (ashr e✝ (const? 8)) (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_nosignbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.and e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.and (lshr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_signbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.or e✝ (const? (-65536))) (const? 8) ⊑ LLVM.or (lshr e✝ (const? 8)) (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nosignbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.or e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.or (ashr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_signbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.xor e✝ (const? (-65536))) (const? 8) ⊑ LLVM.xor (ashr e✝ (const? 8)) (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_nosignbit_ashr_thm (e✝ : IntW 32) :
  ashr (LLVM.xor e✝ (const? 2147418112)) (const? 8) ⊑ LLVM.xor (ashr e✝ (const? 8)) (const? 8388352) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


