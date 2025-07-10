
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2008h05h31hBools_proof
theorem foo1_proof.foo1_thm_1 (e e_1 : IntW 1) : sub e e_1 ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo2_proof.foo2_thm_1 (e e_1 : IntW 1) : mul e e_1 ⊑ LLVM.and e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo3_proof.foo3_thm_1 (e e_1 : IntW 1) : LLVM.udiv e e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo4_proof.foo4_thm_1 (e e_1 : IntW 1) : LLVM.sdiv e e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
