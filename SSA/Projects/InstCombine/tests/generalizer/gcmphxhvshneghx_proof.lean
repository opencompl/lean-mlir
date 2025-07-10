
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcmphxhvshneghx_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.slt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 8) :
  icmp IntPred.sge (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.slt e (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.sgt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_proof.t3_thm_1 (e : IntW 8) :
  icmp IntPred.sle (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.sgt e (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_proof.t4_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.sgt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t5_proof.t5_thm_1 (e : IntW 8) :
  icmp IntPred.uge (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.sgt e (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t6_proof.t6_thm_1 (e : IntW 8) :
  icmp IntPred.ult (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.slt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_proof.t7_thm_1 (e : IntW 8) :
  icmp IntPred.ule (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.slt e (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t8_proof.t8_thm_1 (e : IntW 8) :
  icmp IntPred.eq (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_proof.t9_thm_1 (e : IntW 8) :
  icmp IntPred.ne (sub (const? 8 0) e { «nsw» := true }) e ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_proof.n10_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e) e ⊑ icmp IntPred.slt e (sub (const? 8 0) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n12_proof.n12_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true }) e_1 ⊑
    icmp IntPred.slt e_1 (sub (const? 8 0) e { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
