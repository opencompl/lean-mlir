
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsmaxhicmp_proof
theorem eq_smax1_proof.eq_smax1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.sgt e e_1) e e_1) e ⊑ icmp IntPred.sge e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_smax2_proof.eq_smax2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.sgt e_1 e) e_1 e) e ⊑ icmp IntPred.sge e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_smax3_proof.eq_smax3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (add e (const? 32 3))
      (select (icmp IntPred.sgt (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.sge (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_smax4_proof.eq_smax4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (add e (const? 32 3))
      (select (icmp IntPred.sgt e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.sge (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sle_smax1_proof.sle_smax1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sle (select (icmp IntPred.sgt e e_1) e e_1) e ⊑ icmp IntPred.sle e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sle_smax2_proof.sle_smax2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sle (select (icmp IntPred.sgt e_1 e) e_1 e) e ⊑ icmp IntPred.sle e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sle_smax3_proof.sle_smax3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sge (add e (const? 32 3))
      (select (icmp IntPred.sgt (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.sle e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sle_smax4_proof.sle_smax4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sge (add e (const? 32 3))
      (select (icmp IntPred.sgt e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.sle e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_smax1_proof.ne_smax1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.sgt e e_1) e e_1) e ⊑ icmp IntPred.slt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_smax2_proof.ne_smax2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.sgt e_1 e) e_1 e) e ⊑ icmp IntPred.slt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_smax3_proof.ne_smax3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (add e (const? 32 3))
      (select (icmp IntPred.sgt (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.slt (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_smax4_proof.ne_smax4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (add e (const? 32 3))
      (select (icmp IntPred.sgt e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.slt (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_smax1_proof.sgt_smax1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sgt (select (icmp IntPred.sgt e e_1) e e_1) e ⊑ icmp IntPred.sgt e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_smax2_proof.sgt_smax2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sgt (select (icmp IntPred.sgt e_1 e) e_1 e) e ⊑ icmp IntPred.sgt e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_smax3_proof.sgt_smax3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (add e (const? 32 3))
      (select (icmp IntPred.sgt (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.sgt e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_smax4_proof.sgt_smax4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (add e (const? 32 3))
      (select (icmp IntPred.sgt e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.sgt e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
