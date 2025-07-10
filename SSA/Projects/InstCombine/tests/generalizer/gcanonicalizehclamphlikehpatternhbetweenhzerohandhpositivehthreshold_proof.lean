
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehclamphlikehpatternhbetweenhzerohandhpositivehthreshold_proof
theorem t0_ult_slt_65536_proof.t0_ult_slt_65536_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) e (select (icmp IntPred.slt e (const? 32 65536)) e_1 e_2) ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_ult_slt_0_proof.t1_ult_slt_0_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) e (select (icmp IntPred.slt e (const? 32 0)) e_1 e_2) ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_ult_sgt_65536_proof.t2_ult_sgt_65536_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) e (select (icmp IntPred.sgt e (const? 32 65535)) e_2 e_1) ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_ult_sgt_neg1_proof.t3_ult_sgt_neg1_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) e (select (icmp IntPred.sgt e (const? 32 (-1))) e_2 e_1) ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_ugt_slt_65536_proof.t4_ugt_slt_65536_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 65535)) (select (icmp IntPred.slt e (const? 32 65536)) e_1 e_2) e ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t5_ugt_slt_0_proof.t5_ugt_slt_0_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 65535)) (select (icmp IntPred.slt e (const? 32 0)) e_1 e_2) e ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t6_ugt_sgt_65536_proof.t6_ugt_sgt_65536_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 65535)) (select (icmp IntPred.sgt e (const? 32 65535)) e_2 e_1) e ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_ugt_sgt_neg1_proof.t7_ugt_sgt_neg1_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 65535)) (select (icmp IntPred.sgt e (const? 32 (-1))) e_2 e_1) e ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) e_2 (select (icmp IntPred.slt e (const? 32 0)) e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
