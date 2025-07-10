
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gunsignedhaddhlackhofhoverflowhcheck_proof
theorem t0_basic_proof.t0_basic_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.uge (add e e_1) e_1 ⊑ icmp IntPred.ule e (LLVM.xor e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_symmetry_proof.t2_symmetry_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.uge (add e e_1) e ⊑ icmp IntPred.ule e_1 (LLVM.xor e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_commutative_proof.t4_commutative_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ule e_1 (add e e_1) ⊑ icmp IntPred.ule e (LLVM.xor e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_wrong_pred2_proof.n10_wrong_pred2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (add e e_1) e_1 ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n11_wrong_pred3_proof.n11_wrong_pred3_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (add e e_1) e_1 ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem low_bitmask_ult_proof.low_bitmask_ult_thm_1 (e : IntW 8) :
  icmp IntPred.ult (LLVM.and (add e (const? 8 31)) (const? 8 31)) e ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem low_bitmask_ugt_proof.low_bitmask_ugt_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (mul e e) (LLVM.and (add (mul e e) (const? 8 127)) (const? 8 127)) ⊑
    icmp IntPred.ne (mul e e) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
