
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthofhbittest_proof
theorem and_lshr_and_proof.and_lshr_and_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (LLVM.and (lshr e (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_and_proof.and_and_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem f_var0_proof.f_var0_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e e_1) (const? 32 0)) (LLVM.and (lshr e (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (const? 32 2))) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem f_var0_commutative_and_proof.f_var0_commutative_and_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and (lshr e (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (const? 32 2))) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem f_var1_proof.f_var1_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e e_1) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (const? 32 1))) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem f_var1_commutative_and_proof.f_var1_commutative_and_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (const? 32 1))) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n5_proof.n5_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 2)) (const? 32 1) ⊑
    LLVM.and (lshr e (const? 32 1)) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n6_proof.n6_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0)) (LLVM.and (lshr e (const? 32 2)) (const? 32 1))
      (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 1)
      (LLVM.and (lshr e (const? 32 2)) (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n7_proof.n7_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 1) (LLVM.and e (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n8_proof.n8_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 1)) (LLVM.and (lshr e (const? 32 2)) (const? 32 1))
      (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 1)
      (LLVM.and (lshr e (const? 32 2)) (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
