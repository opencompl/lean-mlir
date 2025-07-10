
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section greusehconstanthfromhselecthinhicmp_proof
theorem p0_ult_65536_proof.p0_ult_65536_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) e_1 (const? 32 65535) ⊑
    select (icmp IntPred.ugt e (const? 32 65535)) (const? 32 65535) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p1_ugt_proof.p1_ugt_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 65534)) e_1 (const? 32 65535) ⊑
    select (icmp IntPred.ult e (const? 32 65535)) (const? 32 65535) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p2_slt_65536_proof.p2_slt_65536_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (const? 32 65536)) e_1 (const? 32 65535) ⊑
    select (icmp IntPred.sgt e (const? 32 65535)) (const? 32 65535) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p3_sgt_proof.p3_sgt_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 65534)) e_1 (const? 32 65535) ⊑
    select (icmp IntPred.slt e (const? 32 65535)) (const? 32 65535) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p13_commutativity0_proof.p13_commutativity0_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) (const? 32 65535) e_1 ⊑
    select (icmp IntPred.ugt e (const? 32 65535)) e_1 (const? 32 65535) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p14_commutativity1_proof.p14_commutativity1_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) (const? 32 65535) (const? 32 42) ⊑
    select (icmp IntPred.ugt e (const? 32 65535)) (const? 32 42) (const? 32 65535) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p15_commutativity2_proof.p15_commutativity2_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 65536)) (const? 32 42) (const? 32 65535) ⊑
    select (icmp IntPred.ugt e (const? 32 65535)) (const? 32 65535) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t22_sign_check_proof.t22_sign_check_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (const? 32 0)) (const? 32 (-1)) e_1 ⊑
    select (icmp IntPred.sgt e (const? 32 (-1))) e_1 (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t22_sign_check2_proof.t22_sign_check2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (const? 32 0) e_1 ⊑
    select (icmp IntPred.slt e (const? 32 0)) e_1 (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
