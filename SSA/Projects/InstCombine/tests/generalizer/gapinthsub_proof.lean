
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthsub_proof
theorem test1_proof.test1_thm_1 (e : IntW 23) : sub e e ⊑ const? 23 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 47) : sub e (const? 47 0) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 97) : sub (const? 97 0) (sub (const? 97 0) e) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e e_1 : IntW 108) : sub e_1 (sub (const? 108 0) e) ⊑ add e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e e_1 e_2 : IntW 19) : sub e (sub e_1 e_2) ⊑ add (sub e_2 e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e e_1 : IntW 57) :
  sub e (LLVM.and e e_1) ⊑ LLVM.and e (LLVM.xor e_1 (const? 57 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 77) : sub (const? 77 (-1)) e ⊑ LLVM.xor e (const? 77 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e : IntW 27) : sub (mul (const? 27 9) e) e ⊑ shl e (const? 27 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 42) : sub e (mul (const? 42 3) e) ⊑ mul e (const? 42 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 9) :
  icmp IntPred.ne (sub e e_1) (const? 9 0) ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e : IntW 43) :
  sub (const? 43 0) (ashr e (const? 43 42)) ⊑ lshr e (const? 43 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e : IntW 79) :
  sub (const? 79 0) (lshr e (const? 79 78)) ⊑ ashr e (const? 79 78) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test16_proof.test16_thm_1 (e : IntW 51) :
  sub (const? 51 0) (LLVM.sdiv e (const? 51 1123)) ⊑ LLVM.sdiv e (const? 51 (-1123)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e : IntW 128) :
  sub (shl e (const? 128 2)) (shl e (const? 128 2)) ⊑ const? 128 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_proof.test19_thm_1 (e e_1 : IntW 39) : add (sub e e_1) e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test20_proof.test20_thm_1 (e e_1 : IntW 33) :
  icmp IntPred.ne (sub e e_1) e ⊑ icmp IntPred.ne e_1 (const? 33 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test21_proof.test21_thm_1 (e e_1 : IntW 256) :
  icmp IntPred.ne (sub e e_1) e ⊑ icmp IntPred.ne e_1 (const? 256 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
