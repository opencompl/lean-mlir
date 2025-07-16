
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthxor2_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 447) :
  LLVM.xor (LLVM.and e (const? 447 70368744177664)) (LLVM.and e_1 (const? 447 70368744177663)) ⊑
    LLVM.or (LLVM.and e (const? 447 70368744177664)) (LLVM.and e_1 (const? 447 70368744177663))
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 1005) : LLVM.xor e (const? 1005 0) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 123) : LLVM.xor e e ⊑ const? 123 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 737) : LLVM.xor e (LLVM.xor (const? 737 (-1)) e) ⊑ const? 737 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 700) :
  LLVM.xor (LLVM.or e (const? 700 288230376151711743)) (const? 700 288230376151711743) ⊑
    LLVM.and e (const? 700 (-288230376151711744)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 77) : LLVM.xor (LLVM.xor e (const? 77 23)) (const? 77 23) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 1023) :
  LLVM.xor (LLVM.or e (const? 1023 70368744177663)) (const? 1023 703687463) ⊑
    LLVM.or (LLVM.and e (const? 1023 (-70368744177664))) (const? 1023 70368040490200) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
