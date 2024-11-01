
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glshrhtrunchsexthtohashrhsext_proof
theorem t0_thm (e : IntW 8) : sext 16 (trunc 4 (lshr e (const? 4))) ⊑ sext 16 (ashr e (const? 4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e : IntW 8) : sext 16 (trunc 3 (lshr e (const? 5))) ⊑ sext 16 (ashr e (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e : IntW 7) : sext 16 (trunc 4 (lshr e (const? 3))) ⊑ sext 16 (ashr e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem same_source_shifted_signbit_thm (e : IntW 32) : sext 32 (trunc 8 (lshr e (const? 24))) ⊑ ashr e (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


