
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehclamphlikehpatternhbetweenhnegativehandhpositivehthresholds_proof
theorem t0_ult_slt_128_proof.t0_ult_slt_128_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 16)) (const? 32 144)) e
      (select (icmp IntPred.slt e (const? 32 128)) e_1 e_2) ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_ult_slt_0_proof.t1_ult_slt_0_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 16)) (const? 32 144)) e
      (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e_2) ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_ult_sgt_128_proof.t2_ult_sgt_128_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 16)) (const? 32 144)) e
      (select (icmp IntPred.sgt e (const? 32 127)) e_2 e_1) ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_ult_sgt_neg1_proof.t3_ult_sgt_neg1_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 16)) (const? 32 144)) e
      (select (icmp IntPred.sgt e (const? 32 (-17))) e_2 e_1) ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_ugt_slt_128_proof.t4_ugt_slt_128_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt (add e (const? 32 16)) (const? 32 143)) (select (icmp IntPred.slt e (const? 32 128)) e_1 e_2)
      e ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t5_ugt_slt_0_proof.t5_ugt_slt_0_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt (add e (const? 32 16)) (const? 32 143))
      (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e_2) e ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t6_ugt_sgt_128_proof.t6_ugt_sgt_128_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt (add e (const? 32 16)) (const? 32 143)) (select (icmp IntPred.sgt e (const? 32 127)) e_2 e_1)
      e ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_ugt_sgt_neg1_proof.t7_ugt_sgt_neg1_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt (add e (const? 32 16)) (const? 32 143))
      (select (icmp IntPred.sgt e (const? 32 (-17))) e_2 e_1) e ⊑
    select (icmp IntPred.sgt e (const? 32 127)) e_2 (select (icmp IntPred.slt e (const? 32 (-16))) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_ugt_slt_proof.n10_ugt_slt_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 128)) e (select (icmp IntPred.slt e (const? 32 0)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 32 128)) e e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n11_uge_slt_proof.n11_uge_slt_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 129)) (select (icmp IntPred.slt e (const? 32 0)) e_1 e_2) e ⊑
    select (icmp IntPred.ult e (const? 32 129)) e_2 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
