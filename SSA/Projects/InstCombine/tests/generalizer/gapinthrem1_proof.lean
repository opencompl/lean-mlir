
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthrem1_proof
theorem test1_proof.test1_thm_1 (e : IntW 33) : urem e (const? 33 4096) ⊑ LLVM.and e (const? 33 4095) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 49) :
  urem e (shl (const? 49 4096) (const? 49 11)) ⊑ LLVM.and e (const? 49 8388607) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 59) (e_1 : IntW 1) :
  urem e (select e_1 (const? 59 70368744177664) (const? 59 4096)) ⊑
    LLVM.and e (select e_1 (const? 59 70368744177663) (const? 59 4095)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
