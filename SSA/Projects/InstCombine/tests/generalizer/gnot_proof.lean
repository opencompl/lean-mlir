
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gnot_proof
theorem test1_proof.test1_thm_1 (e : IntW 32) : LLVM.xor (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem invert_icmp_proof.invert_icmp_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (icmp IntPred.sle e e_1) (const? 1 1) ⊑ icmp IntPred.sgt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_not_cmp_proof.not_not_cmp_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1))) ⊑ icmp IntPred.sgt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_cmp_constant_proof.not_cmp_constant_thm_1 (e : IntW 32) :
  icmp IntPred.ugt (LLVM.xor e (const? 32 (-1))) (const? 32 42) ⊑ icmp IntPred.ult e (const? 32 (-43)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_ashr_not_proof.not_ashr_not_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (ashr (LLVM.xor e (const? 32 (-1))) e_1) (const? 32 (-1)) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_ashr_const_proof.not_ashr_const_thm_1 (e : IntW 8) :
  LLVM.xor (ashr (const? 8 (-42)) e) (const? 8 (-1)) ⊑ lshr (const? 8 41) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_lshr_const_proof.not_lshr_const_thm_1 (e : IntW 8) :
  LLVM.xor (lshr (const? 8 42) e) (const? 8 (-1)) ⊑ ashr (const? 8 (-43)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_sub_proof.not_sub_thm_1 (e : IntW 32) :
  LLVM.xor (sub (const? 32 123) e) (const? 32 (-1)) ⊑ add e (const? 32 (-124)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_add_proof.not_add_thm_1 (e : IntW 32) :
  LLVM.xor (add e (const? 32 123)) (const? 32 (-1)) ⊑ sub (const? 32 (-124)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_or_neg_proof.not_or_neg_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (LLVM.or (sub (const? 8 0) e_1) e) (const? 8 (-1)) ⊑
    LLVM.and (add e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_select_bool_const1_proof.not_select_bool_const1_thm_1 (e e_1 : IntW 1) :
  LLVM.xor (select e e_1 (const? 1 1)) (const? 1 1) ⊑ select e (LLVM.xor e_1 (const? 1 1)) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_select_bool_const4_proof.not_select_bool_const4_thm_1 (e e_1 : IntW 1) :
  LLVM.xor (select e (const? 1 0) e_1) (const? 1 1) ⊑ select e (const? 1 1) (LLVM.xor e_1 (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_logicalAnd_not_op1_proof.not_logicalAnd_not_op1_thm_1 (e e_1 : IntW 1) :
  LLVM.xor (select e (LLVM.xor e_1 (const? 1 1)) (const? 1 0)) (const? 1 1) ⊑
    select (LLVM.xor e (const? 1 1)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_logicalOr_not_op1_proof.not_logicalOr_not_op1_thm_1 (e e_1 : IntW 1) :
  LLVM.xor (select e (const? 1 1) (LLVM.xor e_1 (const? 1 1))) (const? 1 1) ⊑
    select (LLVM.xor e (const? 1 1)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem invert_both_cmp_operands_add_proof.invert_both_cmp_operands_add_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sgt (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 0) ⊑
    icmp IntPred.slt (sub e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem invert_both_cmp_operands_sub_proof.invert_both_cmp_operands_sub_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ult (sub (LLVM.xor e (const? 32 (-1))) e_1) (const? 32 42) ⊑
    icmp IntPred.ugt (add e e_1) (const? 32 (-43)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem invert_both_cmp_operands_complex_proof.invert_both_cmp_operands_complex_thm_1 (e : IntW 1) (e_1 e_2 e_3 : IntW 32) :
  icmp IntPred.sle (select e (add e_3 (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e_2 (const? 32 (-1))))
      (LLVM.xor e_3 (const? 32 (-1))) ⊑
    icmp IntPred.sge (select e (sub e_1 e_3) e_2) e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sext_proof.test_sext_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (add e_1 (sext 32 (icmp IntPred.eq e (const? 32 0)))) (const? 32 (-1)) ⊑
    sub (sext 32 (icmp IntPred.ne e (const? 32 0))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_zext_nneg_proof.test_zext_nneg_thm_1 (e : IntW 32) (e_1 e_2 : IntW 64) :
  sub (add e_1 (const? 64 (-5))) (add (zext 64 (LLVM.xor e (const? 32 (-1))) { «nneg» := true }) e_2) ⊑
    add (add e_1 (const? 64 (-4))) (sub (sext 64 e) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_trunc_proof.test_trunc_thm_1 (e : IntW 8) :
  LLVM.xor (trunc 8 (ashr (add (zext 32 e) (const? 32 (-1)) { «nsw» := true }) (const? 32 31))) (const? 8 (-1)) ⊑
    sext 8 (icmp IntPred.ne e (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_or2_proof.test_invert_demorgan_or2_thm_1 (e e_1 e_2 : IntW 64) :
  LLVM.xor
      (LLVM.or (LLVM.or (icmp IntPred.ugt e (const? 64 23)) (icmp IntPred.ugt e_1 (const? 64 59)))
        (icmp IntPred.ugt e_2 (const? 64 59)))
      (const? 1 1) ⊑
    LLVM.and (LLVM.and (icmp IntPred.ult e (const? 64 24)) (icmp IntPred.ult e_1 (const? 64 60)))
      (icmp IntPred.ult e_2 (const? 64 60)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_or3_proof.test_invert_demorgan_or3_thm_1 (e e_1 : IntW 32) :
  LLVM.xor
      (LLVM.or
        (LLVM.or
          (LLVM.or (icmp IntPred.eq e (const? 32 178206))
            (icmp IntPred.ult (add e_1 (const? 32 (-195102))) (const? 32 1506)))
          (icmp IntPred.ult (add e_1 (const? 32 (-201547))) (const? 32 716213)))
        (icmp IntPred.ult (add e_1 (const? 32 (-918000))) (const? 32 196112)))
      (const? 1 1) ⊑
    LLVM.and
      (LLVM.and
        (LLVM.and (icmp IntPred.ne e (const? 32 178206))
          (icmp IntPred.ult (add e_1 (const? 32 (-196608))) (const? 32 (-1506))))
        (icmp IntPred.ult (add e_1 (const? 32 (-917760))) (const? 32 (-716213))))
      (icmp IntPred.ult (add e_1 (const? 32 (-1114112))) (const? 32 (-196112))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_logical_or_proof.test_invert_demorgan_logical_or_thm_1 (e e_1 : IntW 64) :
  LLVM.xor
      (LLVM.or (icmp IntPred.eq e (const? 64 0))
        (select (icmp IntPred.eq e (const? 64 27)) (const? 1 1) (icmp IntPred.eq e_1 (const? 64 0))))
      (const? 1 1) ⊑
    LLVM.and (icmp IntPred.ne e (const? 64 0))
      (select (icmp IntPred.ne e (const? 64 27)) (icmp IntPred.ne e_1 (const? 64 0)) (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_and2_proof.test_invert_demorgan_and2_thm_1 (e : IntW 64) :
  LLVM.xor (LLVM.and (add e (const? 64 9223372036854775807)) (const? 64 9223372036854775807)) (const? 64 (-1)) ⊑
    LLVM.or (sub (const? 64 0) e) (const? 64 (-9223372036854775808)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_and3_proof.test_invert_demorgan_and3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 4095)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (sub e e_1) (const? 32 4095)) (const? 32 4095) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invert_demorgan_logical_and_proof.test_invert_demorgan_logical_and_thm_1 (e e_1 : IntW 64) :
  LLVM.xor
      (LLVM.or (icmp IntPred.eq e (const? 64 0))
        (select (icmp IntPred.eq e (const? 64 27)) (icmp IntPred.eq e_1 (const? 64 0)) (const? 1 0)))
      (const? 1 1) ⊑
    LLVM.and (icmp IntPred.ne e (const? 64 0))
      (select (icmp IntPred.ne e (const? 64 27)) (const? 1 1) (icmp IntPred.ne e_1 (const? 64 0))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
