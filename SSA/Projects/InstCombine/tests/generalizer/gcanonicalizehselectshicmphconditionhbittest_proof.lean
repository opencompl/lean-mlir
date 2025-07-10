
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehselectshicmphconditionhbittest_proof
theorem p0_proof.p0_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 1)) e_1 e_2 ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p1_proof.p1_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.ne (LLVM.and e (const? 8 1)) (const? 8 0)) e_1 e_2 ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n5_proof.n5_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 2)) e_1 e_2 ⊑ e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n6_proof.n6_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 3)) e_1 e_2 ⊑ e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n7_proof.n7_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.ne (LLVM.and e (const? 8 1)) (const? 8 1)) e_1 e_2 ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 0)) e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
