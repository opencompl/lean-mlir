
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gicmphor_proof
theorem set_low_bit_mask_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.or e (const? 8 1)) (const? 8 19) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-2))) (const? 8 18) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_low_bit_mask_ugt_thm (e : IntW 8) :
  icmp IntPredicate.ugt (LLVM.or e (const? 8 3)) (const? 8 19) ⊑ icmp IntPredicate.ugt e (const? 8 19) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_low_bit_mask_uge_thm (e : IntW 8) :
  icmp IntPredicate.uge (LLVM.or e (const? 8 3)) (const? 8 20) ⊑ icmp IntPredicate.ugt e (const? 8 19) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_low_bit_mask_ule_thm (e : IntW 8) :
  icmp IntPredicate.ule (LLVM.or e (const? 8 3)) (const? 8 18) ⊑
    icmp IntPredicate.ult (LLVM.or e (const? 8 3)) (const? 8 19) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_low_bit_mask_sge_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.or e (const? 8 31)) (const? 8 51) ⊑
    icmp IntPredicate.sgt (LLVM.or e (const? 8 31)) (const? 8 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_low_bit_mask_sle_thm (e : IntW 8) :
  icmp IntPredicate.sle (LLVM.or e (const? 8 63)) (const? 8 68) ⊑
    icmp IntPredicate.slt (LLVM.or e (const? 8 63)) (const? 8 69) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_const_mask_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.or e_1 (const? 8 42)) (LLVM.or e (const? 8 42)) ⊑
    icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 e) (const? 8 (-43))) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_const_mask_wrong_opcode_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.or e_1 (const? 8 5)) (LLVM.xor e (const? 8 5)) ⊑
    icmp IntPredicate.eq (LLVM.xor e (LLVM.or e_1 (const? 8 5))) (const? 8 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_or_xor_2_eq_thm (e e_1 e_2 e_3 : IntW 64) :
  icmp IntPredicate.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0) ⊑
    LLVM.and (icmp IntPredicate.eq e_3 e_2) (icmp IntPredicate.eq e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_or_xor_2_ne_thm (e e_1 e_2 e_3 : IntW 64) :
  icmp IntPredicate.ne (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0) ⊑
    LLVM.or (icmp IntPredicate.ne e_3 e_2) (icmp IntPredicate.ne e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_or_xor_2_3_fail_thm (e e_1 e_2 e_3 : IntW 64) :
  LLVM.or (icmp IntPredicate.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0))
      (icmp IntPredicate.eq (LLVM.xor e_3 e_2) (const? 64 0)) ⊑
    LLVM.or (icmp IntPredicate.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0))
      (icmp IntPredicate.eq e_3 e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_or_xor_2_4_fail_thm (e e_1 e_2 e_3 : IntW 64) :
  LLVM.or (icmp IntPredicate.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0))
      (icmp IntPredicate.eq (LLVM.xor e_1 e) (const? 64 0)) ⊑
    LLVM.or (icmp IntPredicate.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 64 0))
      (icmp IntPredicate.eq e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


