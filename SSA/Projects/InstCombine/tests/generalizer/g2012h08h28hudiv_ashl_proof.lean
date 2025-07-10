
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2012h08h28hudiv_ashl_proof
theorem udiv400_proof.udiv400_thm_1 (e : IntW 32) :
  LLVM.udiv (lshr e (const? 32 2)) (const? 32 100) ⊑ LLVM.udiv e (const? 32 400) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv400_yes_proof.sdiv400_yes_thm_1 (e : IntW 32) :
  LLVM.sdiv (lshr e (const? 32 2)) (const? 32 100) ⊑ LLVM.udiv e (const? 32 400) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i80_proof.udiv_i80_thm_1 (e : IntW 80) :
  LLVM.udiv (lshr e (const? 80 2)) (const? 80 100) ⊑ LLVM.udiv e (const? 80 400) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
