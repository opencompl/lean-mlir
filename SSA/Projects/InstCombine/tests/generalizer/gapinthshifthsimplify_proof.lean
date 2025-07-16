
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthshifthsimplify_proof
theorem test0_proof.test0_thm_1 (e e_1 e_2 : IntW 41) :
  LLVM.and (shl e e_2) (shl e_1 e_2) ⊑ shl (LLVM.and e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test1_proof.test1_thm_1 (e e_1 e_2 : IntW 57) :
  LLVM.or (lshr e e_2) (lshr e_1 e_2) ⊑ lshr (LLVM.or e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 e_2 : IntW 49) :
  LLVM.xor (ashr e e_2) (ashr e_1 e_2) ⊑ ashr (LLVM.xor e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
