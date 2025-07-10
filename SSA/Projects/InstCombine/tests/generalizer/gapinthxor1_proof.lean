
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthxor1_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 47) :
  LLVM.xor (LLVM.and e (const? 47 (-70368744177664))) (LLVM.and e_1 (const? 47 70368744177661)) ⊑
    LLVM.or (LLVM.and e (const? 47 (-70368744177664))) (LLVM.and e_1 (const? 47 70368744177661))
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 15) : LLVM.xor e (const? 15 0) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 23) : LLVM.xor e e ⊑ const? 23 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 37) : LLVM.xor e (LLVM.xor (const? 37 (-1)) e) ⊑ const? 37 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 7) :
  LLVM.xor (LLVM.or e (const? 7 23)) (const? 7 23) ⊑ LLVM.and e (const? 7 (-24)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 7) : LLVM.xor (LLVM.xor e (const? 7 23)) (const? 7 23) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 47) :
  LLVM.xor (LLVM.or e (const? 47 70368744177663)) (const? 47 703687463) ⊑
    LLVM.or (LLVM.and e (const? 47 (-70368744177664))) (const? 47 70368040490200) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
