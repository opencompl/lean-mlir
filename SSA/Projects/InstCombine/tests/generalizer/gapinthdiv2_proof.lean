
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthdiv2_proof
theorem test1_proof.test1_thm_1 (e : IntW 333) :
  LLVM.udiv e (const? 333 70368744177664) ⊑ lshr e (const? 333 46) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 499) :
  LLVM.udiv e (shl (const? 499 4096) (const? 499 197)) ⊑ lshr e (const? 499 209) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 599) (e_1 : IntW 1) :
  LLVM.udiv e (select e_1 (const? 599 70368744177664) (const? 599 4096)) ⊑
    lshr e (select e_1 (const? 599 46) (const? 599 12)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
