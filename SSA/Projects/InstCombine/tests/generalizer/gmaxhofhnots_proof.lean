
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmaxhofhnots_proof
theorem max_of_min_proof.max_of_min_thm_1 (e : IntW 32) :
  select
      (icmp IntPred.sgt (select (icmp IntPred.sgt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)))
        (const? 32 (-1)))
      (select (icmp IntPred.sgt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem max_of_min_swap_proof.max_of_min_swap_thm_1 (e : IntW 32) :
  select
      (icmp IntPred.sgt (select (icmp IntPred.slt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1))))
        (const? 32 (-1)))
      (select (icmp IntPred.slt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1)))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem min_of_max_proof.min_of_max_thm_1 (e : IntW 32) :
  select
      (icmp IntPred.slt (select (icmp IntPred.slt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)))
        (const? 32 (-1)))
      (select (icmp IntPred.slt e (const? 32 0)) (LLVM.xor e (const? 32 (-1))) (const? 32 (-1))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem min_of_max_swap_proof.min_of_max_swap_thm_1 (e : IntW 32) :
  select
      (icmp IntPred.slt (select (icmp IntPred.sgt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1))))
        (const? 32 (-1)))
      (select (icmp IntPred.sgt e (const? 32 0)) (const? 32 (-1)) (LLVM.xor e (const? 32 (-1)))) (const? 32 (-1)) ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
