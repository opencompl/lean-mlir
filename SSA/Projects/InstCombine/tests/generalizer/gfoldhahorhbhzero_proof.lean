
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gfoldhahorhbhzero_proof
theorem a_or_b_proof.a_or_b_thm_1 (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPred.eq e (const? 32 0)) (icmp IntPred.ne e_1 (const? 32 0)))
      (LLVM.and (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.eq e_1 (const? 32 0))) ⊑
    LLVM.xor (icmp IntPred.eq e (const? 32 0)) (icmp IntPred.eq e_1 (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_or_b_const_proof.a_or_b_const_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPred.eq e e_2) (icmp IntPred.ne e_1 e_2))
      (LLVM.and (icmp IntPred.ne e e_2) (icmp IntPred.eq e_1 e_2)) ⊑
    LLVM.xor (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_or_b_const2_proof.a_or_b_const2_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPred.eq e e_2) (icmp IntPred.ne e_1 e_3))
      (LLVM.and (icmp IntPred.ne e e_2) (icmp IntPred.eq e_1 e_3)) ⊑
    LLVM.xor (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
