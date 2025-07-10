
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gdivhi1_proof
theorem sdiv_i1_is_op0_proof.sdiv_i1_is_op0_thm_1 (e e_1 : IntW 1) : LLVM.sdiv e e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i1_is_op0_proof.udiv_i1_is_op0_thm_1 (e e_1 : IntW 1) : LLVM.udiv e e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem srem_i1_is_zero_proof.srem_i1_is_zero_thm_1 (e e_1 : IntW 1) : LLVM.srem e e_1 ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i1_is_zero_proof.urem_i1_is_zero_thm_1 (e e_1 : IntW 1) : urem e e_1 ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
