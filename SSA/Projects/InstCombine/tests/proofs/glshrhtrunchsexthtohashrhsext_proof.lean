
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section glshrhtrunchsexthtohashrhsext_proof
theorem t0_thm (e : IntW 8) : sext 16 (trunc 4 (lshr e (const? 8 4))) ⊑ sext 16 (ashr e (const? 8 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e : IntW 8) : sext 16 (trunc 3 (lshr e (const? 8 5))) ⊑ sext 16 (ashr e (const? 8 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 7) : sext 16 (trunc 4 (lshr e (const? 7 3))) ⊑ sext 16 (ashr e (const? 7 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem same_source_shifted_signbit_thm (e : IntW 32) : sext 32 (trunc 8 (lshr e (const? 32 24))) ⊑ ashr e (const? 32 24) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
