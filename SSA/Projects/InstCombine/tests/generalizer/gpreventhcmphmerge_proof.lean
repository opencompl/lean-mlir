
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gpreventhcmphmerge_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.xor e (const? 32 5)) (const? 32 10)) (icmp IntPred.eq (LLVM.xor e (const? 32 5)) e_1) ⊑
    LLVM.or (icmp IntPred.eq e (const? 32 15)) (icmp IntPred.eq (LLVM.xor e e_1) (const? 32 5)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test1_logical_proof.test1_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.xor e (const? 32 5)) (const? 32 10)) (const? 1 1)
      (icmp IntPred.eq (LLVM.xor e (const? 32 5)) e_1) ⊑
    select (icmp IntPred.eq e (const? 32 15)) (const? 1 1) (icmp IntPred.eq (LLVM.xor e e_1) (const? 32 5)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (icmp IntPred.eq (LLVM.xor e e_1) (const? 32 0)) (icmp IntPred.eq (LLVM.xor e e_1) (const? 32 32)) ⊑
    LLVM.xor (icmp IntPred.eq e e_1) (icmp IntPred.eq (LLVM.xor e e_1) (const? 32 32)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 0))
      (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 31)) ⊑
    LLVM.or (icmp IntPred.eq e e_1) (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 31)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_logical_proof.test3_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 31)) ⊑
    select (icmp IntPred.eq e e_1) (const? 1 1) (icmp IntPred.eq (sub e e_1 { «nsw» := true }) (const? 32 31)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
