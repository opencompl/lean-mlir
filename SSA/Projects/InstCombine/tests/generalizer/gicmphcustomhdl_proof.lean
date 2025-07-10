
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphcustomhdl_proof
theorem icmp_and_ashr_multiuse_proof.icmp_and_ashr_multiuse_thm_1 (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (ashr e (const? 32 4)) (const? 32 15)) (const? 32 14))
      (icmp IntPred.ne (LLVM.and (ashr e (const? 32 4)) (const? 32 31)) (const? 32 27)) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 240)) (const? 32 224))
      (icmp IntPred.ne (LLVM.and e (const? 32 496)) (const? 32 432)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_and_ashr_multiuse_logical_proof.icmp_and_ashr_multiuse_logical_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and (ashr e (const? 32 4)) (const? 32 15)) (const? 32 14))
      (icmp IntPred.ne (LLVM.and (ashr e (const? 32 4)) (const? 32 31)) (const? 32 27)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 240)) (const? 32 224))
      (icmp IntPred.ne (LLVM.and e (const? 32 496)) (const? 32 432)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_lshr_and_overshift_proof.icmp_lshr_and_overshift_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (lshr e (const? 8 5)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPred.ugt e (const? 8 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
