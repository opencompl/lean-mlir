
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gorhxorhxor_proof
theorem or_xor_xor_normal_variant1_proof.or_xor_xor_normal_variant1_thm_1 (e e_1 : IntW 1) :
  LLVM.or (LLVM.xor (LLVM.and e e_1) e) (LLVM.xor (LLVM.and e e_1) e_1) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_xor_normal_variant2_proof.or_xor_xor_normal_variant2_thm_1 (e e_1 : IntW 8) :
  LLVM.or (LLVM.xor (LLVM.and e e_1) e_1) (LLVM.xor e (LLVM.and e e_1)) ⊑ LLVM.xor e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_xor_normal_variant3_proof.or_xor_xor_normal_variant3_thm_1 (e e_1 : IntW 16) :
  LLVM.or (LLVM.xor e_1 (LLVM.and e_1 e)) (LLVM.xor e (LLVM.and e_1 e)) ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_xor_normal_variant4_proof.or_xor_xor_normal_variant4_thm_1 (e e_1 : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.and e_1 e) e_1) (LLVM.xor (LLVM.and e_1 e) e) ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_xor_normal_binops_proof.or_xor_xor_normal_binops_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor e_1 e_2) (LLVM.and (LLVM.xor e_1 e_2) (LLVM.xor e e_2)))
      (LLVM.xor (LLVM.xor e e_2) (LLVM.and (LLVM.xor e_1 e_2) (LLVM.xor e e_2))) ⊑
    LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
