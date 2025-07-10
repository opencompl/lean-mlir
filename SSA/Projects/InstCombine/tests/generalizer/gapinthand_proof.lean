
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthand_proof
theorem test0_proof.test0_thm_1 (e : IntW 39) : LLVM.and e (const? 39 0) ⊑ const? 39 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 15) : LLVM.and e (const? 15 (-1)) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 23) :
  LLVM.and (LLVM.and e (const? 23 127)) (const? 23 128) ⊑ const? 23 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 37) :
  icmp IntPred.ne (LLVM.and e (const? 37 (-2147483648))) (const? 37 0) ⊑
    icmp IntPred.ugt e (const? 37 2147483647) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 47) :
  LLVM.and (ashr e (const? 47 39)) (const? 47 255) ⊑ lshr e (const? 47 39) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e : IntW 999) : LLVM.and e (const? 999 0) ⊑ const? 999 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 1005) : LLVM.and e (const? 1005 (-1)) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 123) :
  LLVM.and (LLVM.and e (const? 123 127)) (const? 123 128) ⊑ const? 123 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e : IntW 737) :
  icmp IntPred.ne (LLVM.and e (const? 737 (-2147483648))) (const? 737 0) ⊑
    icmp IntPred.ugt e (const? 737 2147483647) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e : IntW 1024) :
  LLVM.and (ashr e (const? 1024 1016)) (const? 1024 255) ⊑ lshr e (const? 1024 1016) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
