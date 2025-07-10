
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhorhicmphconsthicmp_proof
theorem eq_basic_proof.eq_basic_thm_1 (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e (const? 8 0)) (icmp IntPred.ugt e e_1) ⊑
    icmp IntPred.uge (add e (const? 8 (-1))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_basic_equal_5_proof.ne_basic_equal_5_thm_1 (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e (const? 8 5)) (icmp IntPred.ule (add e (const? 8 (-5))) e_1) ⊑
    icmp IntPred.ult (add e (const? 8 (-6))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_basic_equal_minus_1_proof.eq_basic_equal_minus_1_thm_1 (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e (const? 8 (-1))) (icmp IntPred.ugt (add e (const? 8 1)) e_1) ⊑
    icmp IntPred.uge e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_basic_equal_minus_7_proof.ne_basic_equal_minus_7_thm_1 (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e (const? 8 (-7))) (icmp IntPred.ule (add e (const? 8 7)) e_1) ⊑
    icmp IntPred.ult (add e (const? 8 6)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_commuted_proof.eq_commuted_thm_1 (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e (const? 8 0)) (icmp IntPred.ult (LLVM.sdiv (const? 8 43) e_1) e) ⊑
    icmp IntPred.uge (add e (const? 8 (-1))) (LLVM.sdiv (const? 8 43) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_commuted_equal_minus_1_proof.ne_commuted_equal_minus_1_thm_1 (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e (const? 8 (-1))) (icmp IntPred.uge (LLVM.sdiv (const? 8 42) e_1) (add e (const? 8 1))) ⊑
    icmp IntPred.ult e (LLVM.sdiv (const? 8 42) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
