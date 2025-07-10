
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section ginverthvariablehmaskhinhmaskedhmergehscalar_proof
theorem scalar_proof.scalar_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e e_1) (LLVM.xor e_2 (const? 4 (-1)))) e_1 ⊑
    LLVM.xor (LLVM.and (LLVM.xor e e_1) e_2) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem in_constant_varx_mone_invmask_proof.in_constant_varx_mone_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? 4 (-1))) (LLVM.xor e_1 (const? 4 (-1)))) (const? 4 (-1)) ⊑
    LLVM.or e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem in_constant_varx_6_invmask_proof.in_constant_varx_6_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) (LLVM.xor e_1 (const? 4 (-1)))) (const? 4 6) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem in_constant_mone_vary_invmask_proof.in_constant_mone_vary_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor (const? 4 (-1)) e) (LLVM.xor e_1 (const? 4 (-1)))) e ⊑
    LLVM.or e (LLVM.xor e_1 (const? 4 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem in_constant_6_vary_invmask_proof.in_constant_6_vary_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) (LLVM.xor e_1 (const? 4 (-1)))) e ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) e_1) (const? 4 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem c_1_0_0_proof.c_1_0_0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 4 (-1)))) e_1 ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e) e_2) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem c_0_1_0_proof.c_0_1_0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e e_1) (LLVM.xor e_2 (const? 4 (-1)))) e ⊑
    LLVM.xor (LLVM.and (LLVM.xor e e_1) e_2) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem c_1_1_0_proof.c_1_1_0_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 4 (-1)))) e ⊑
    LLVM.xor (LLVM.and (LLVM.xor e_1 e) e_2) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem commutativity_constant_varx_6_invmask_proof.commutativity_constant_varx_6_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 4 (-1))) (LLVM.xor e (const? 4 6))) (const? 4 6) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem commutativity_constant_6_vary_invmask_proof.commutativity_constant_6_vary_invmask_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 4 (-1))) (LLVM.xor e (const? 4 6))) e ⊑
    LLVM.xor (LLVM.and (LLVM.xor e (const? 4 6)) e_1) (const? 4 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
