
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section guminhicmp_proof
theorem eq_umin1_proof.eq_umin1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ult e e_1) e e_1) e ⊑ icmp IntPred.ule e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_umin2_proof.eq_umin2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ule e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_umin3_proof.eq_umin3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (add e (const? 32 3))
      (select (icmp IntPred.ult (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.ule (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_umin4_proof.eq_umin4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (add e (const? 32 3))
      (select (icmp IntPred.ult e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.ule (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uge_umin1_proof.uge_umin1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.uge (select (icmp IntPred.ult e e_1) e e_1) e ⊑ icmp IntPred.uge e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uge_umin2_proof.uge_umin2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.uge (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.uge e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uge_umin3_proof.uge_umin3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ule (add e (const? 32 3))
      (select (icmp IntPred.ult (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.uge e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uge_umin4_proof.uge_umin4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ule (add e (const? 32 3))
      (select (icmp IntPred.ult e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.uge e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_umin1_proof.ne_umin1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ult e e_1) e e_1) e ⊑ icmp IntPred.ugt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_umin2_proof.ne_umin2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ugt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_umin3_proof.ne_umin3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (add e (const? 32 3))
      (select (icmp IntPred.ult (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.ugt (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_umin4_proof.ne_umin4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (add e (const? 32 3))
      (select (icmp IntPred.ult e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.ugt (add e (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_umin1_proof.ult_umin1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ult (select (icmp IntPred.ult e e_1) e e_1) e ⊑ icmp IntPred.ult e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_umin2_proof.ult_umin2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ult (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ult e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_umin3_proof.ult_umin3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ugt (add e (const? 32 3))
      (select (icmp IntPred.ult (add e (const? 32 3)) e_1) (add e (const? 32 3)) e_1) ⊑
    icmp IntPred.ult e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_umin4_proof.ult_umin4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ugt (add e (const? 32 3))
      (select (icmp IntPred.ult e_1 (add e (const? 32 3))) e_1 (add e (const? 32 3))) ⊑
    icmp IntPred.ult e_1 (add e (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
