
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphofhandhx_proof
theorem icmp_ult_x_y_proof.icmp_ult_x_y_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.and e e_1) e ⊑ icmp IntPred.ne (LLVM.and e e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_ult_x_y_2_proof.icmp_ult_x_y_2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ugt (mul e e) (LLVM.and (mul e e) e_1) ⊑ icmp IntPred.ne (LLVM.and (mul e e) e_1) (mul e e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_uge_x_y_2_proof.icmp_uge_x_y_2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ule (mul e e) (LLVM.and (mul e e) e_1) ⊑ icmp IntPred.eq (LLVM.and (mul e e) e_1) (mul e e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_sle_x_negy_proof.icmp_sle_x_negy_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sle (LLVM.and (LLVM.or e_1 (const? 8 (-128))) e) e ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_eq_x_invertable_y_todo_proof.icmp_eq_x_invertable_y_todo_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.eq e (LLVM.and e (select e_1 (const? 8 7) (const? 8 24))) ⊑
    icmp IntPred.eq (LLVM.and e (select e_1 (const? 8 (-8)) (const? 8 (-25)))) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_eq_x_invertable_y_proof.icmp_eq_x_invertable_y_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq e (LLVM.and e (LLVM.xor e_1 (const? 8 (-1)))) ⊑ icmp IntPred.eq (LLVM.and e e_1) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_eq_x_invertable_y2_todo_proof.icmp_eq_x_invertable_y2_todo_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.eq (select e_1 (const? 8 7) (const? 8 24)) (LLVM.and e (select e_1 (const? 8 7) (const? 8 24))) ⊑
    icmp IntPred.eq (LLVM.or e (select e_1 (const? 8 (-8)) (const? 8 (-25)))) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_eq_x_invertable_y2_proof.icmp_eq_x_invertable_y2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e_1 (const? 8 (-1))) (LLVM.and e (LLVM.xor e_1 (const? 8 (-1)))) ⊑
    icmp IntPred.eq (LLVM.or e e_1) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
