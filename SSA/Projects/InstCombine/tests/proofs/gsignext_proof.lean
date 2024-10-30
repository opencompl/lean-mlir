
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignext_proof
theorem sextinreg_thm :
  ∀ (e : IntW 32),
    add (LLVM.xor (LLVM.and e (const? 65535)) (const? (-32768))) (const? 32768) ⊑
      ashr (shl e (const? 16)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sextinreg_alt_thm :
  ∀ (e : IntW 32),
    add (LLVM.xor (LLVM.and e (const? 65535)) (const? 32768)) (const? (-32768)) ⊑
      ashr (shl e (const? 16)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sextinreg2_thm :
  ∀ (e : IntW 32),
    add (LLVM.xor (LLVM.and e (const? 255)) (const? 128)) (const? (-128)) ⊑
      ashr (shl e (const? 24)) (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_thm :
  ∀ (e : IntW 32),
    add (LLVM.xor (lshr e (const? 5)) (const? 67108864)) (const? (-67108864)) ⊑ ashr e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


