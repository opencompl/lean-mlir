
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gnot_proof
theorem test1_thm (e : IntW 32) : LLVM.xor (LLVM.xor e (const? 32 (-1))) (const? 32 (-1)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem invert_icmp_thm (e e_1 : IntW 32) :
  LLVM.xor (icmp IntPred.sle e_1 e) (const? 1 1) ⊑ icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_not_cmp_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.xor e_1 (const? 32 (-1))) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_cmp_constant_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.xor e (const? 32 (-1))) (const? 32 42) ⊑
    icmp IntPred.ult e (const? 32 (-43)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_ashr_not_thm (e e_1 : IntW 32) :
  LLVM.xor (ashr (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 (-1)) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_ashr_const_thm (e : IntW 8) : LLVM.xor (ashr (const? 8 (-42)) e) (const? 8 (-1)) ⊑ lshr (const? 8 41) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_lshr_const_thm (e : IntW 8) : LLVM.xor (lshr (const? 8 42) e) (const? 8 (-1)) ⊑ ashr (const? 8 (-43)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_sub_thm (e : IntW 32) :
  LLVM.xor (sub (const? 32 123) e) (const? 32 (-1)) ⊑ add e (const? 32 (-124)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_add_thm (e : IntW 32) :
  LLVM.xor (add e (const? 32 123)) (const? 32 (-1)) ⊑ sub (const? 32 (-124)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_or_neg_thm (e e_1 : IntW 8) :
  LLVM.xor (LLVM.or (sub (const? 8 0) e_1) e) (const? 8 (-1)) ⊑
    LLVM.and (add e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_select_bool_const1_thm (e e_1 : IntW 1) :
  LLVM.xor (select e_1 e (const? 1 1)) (const? 1 1) ⊑ select e_1 (LLVM.xor e (const? 1 1)) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_select_bool_const4_thm (e e_1 : IntW 1) :
  LLVM.xor (select e_1 (const? 1 0) e) (const? 1 1) ⊑ select e_1 (const? 1 1) (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_logicalAnd_not_op1_thm (e e_1 : IntW 1) :
  LLVM.xor (select e_1 (LLVM.xor e (const? 1 1)) (const? 1 0)) (const? 1 1) ⊑
    select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem not_logicalOr_not_op1_thm (e e_1 : IntW 1) :
  LLVM.xor (select e_1 (const? 1 1) (LLVM.xor e (const? 1 1))) (const? 1 1) ⊑
    select (LLVM.xor e_1 (const? 1 1)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem invert_both_cmp_operands_add_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 0) ⊑
    icmp IntPred.slt (sub e e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem invert_both_cmp_operands_sub_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (sub (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 42) ⊑
    icmp IntPred.ugt (add e_1 e) (const? 32 (-43)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem invert_both_cmp_operands_complex_thm (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPred.sle (select e_3 (add e_2 (LLVM.xor e_1 (const? 32 (-1)))) (LLVM.xor e (const? 32 (-1))))
      (LLVM.xor e_2 (const? 32 (-1))) ⊑
    icmp IntPred.sge (select e_3 (sub e_1 e_2) e) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_sext_thm (e e_1 : IntW 32) :
  LLVM.xor (add e_1 (sext 32 (icmp IntPred.eq e (const? 32 0)))) (const? 32 (-1)) ⊑
    sub (sext 32 (icmp IntPred.ne e (const? 32 0))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_zext_nneg_thm (e : IntW 64) (e_1 : IntW 32) (e_2 : IntW 64) :
  sub (add e_2 (const? 64 (-5))) (add (zext 64 (LLVM.xor e_1 (const? 32 (-1))) { «nneg» := true }) e) ⊑
    add (add e_2 (const? 64 (-4))) (sub (sext 64 e_1) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_trunc_thm (e : IntW 8) :
  LLVM.xor (trunc 8 (ashr (add (zext 32 e) (const? 32 (-1)) { «nsw» := true, «nuw» := false }) (const? 32 31)))
      (const? 8 (-1)) ⊑
    sext 8 (icmp IntPred.ne e (const? 8 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_or2_thm (e e_1 e_2 : IntW 64) :
  LLVM.xor
      (LLVM.or (LLVM.or (icmp IntPred.ugt e_2 (const? 64 23)) (icmp IntPred.ugt e_1 (const? 64 59)))
        (icmp IntPred.ugt e (const? 64 59)))
      (const? 1 1) ⊑
    LLVM.and (LLVM.and (icmp IntPred.ult e_2 (const? 64 24)) (icmp IntPred.ult e_1 (const? 64 60)))
      (icmp IntPred.ult e (const? 64 60)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_or3_thm (e e_1 : IntW 32) :
  LLVM.xor
      (LLVM.or
        (LLVM.or
          (LLVM.or (icmp IntPred.eq e_1 (const? 32 178206))
            (icmp IntPred.ult (add e (const? 32 (-195102))) (const? 32 1506)))
          (icmp IntPred.ult (add e (const? 32 (-201547))) (const? 32 716213)))
        (icmp IntPred.ult (add e (const? 32 (-918000))) (const? 32 196112)))
      (const? 1 1) ⊑
    LLVM.and
      (LLVM.and
        (LLVM.and (icmp IntPred.ne e_1 (const? 32 178206))
          (icmp IntPred.ult (add e (const? 32 (-196608))) (const? 32 (-1506))))
        (icmp IntPred.ult (add e (const? 32 (-917760))) (const? 32 (-716213))))
      (icmp IntPred.ult (add e (const? 32 (-1114112))) (const? 32 (-196112))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_logical_or_thm (e e_1 : IntW 64) :
  LLVM.xor
      (LLVM.or (icmp IntPred.eq e_1 (const? 64 0))
        (select (icmp IntPred.eq e_1 (const? 64 27)) (const? 1 1) (icmp IntPred.eq e (const? 64 0))))
      (const? 1 1) ⊑
    LLVM.and (icmp IntPred.ne e_1 (const? 64 0))
      (select (icmp IntPred.ne e_1 (const? 64 27)) (icmp IntPred.ne e (const? 64 0)) (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_and2_thm (e : IntW 64) :
  LLVM.xor (LLVM.and (add e (const? 64 9223372036854775807)) (const? 64 9223372036854775807)) (const? 64 (-1)) ⊑
    LLVM.or (sub (const? 64 0) e) (const? 64 (-9223372036854775808)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_and3_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 4095)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (sub e e_1) (const? 32 4095)) (const? 32 4095) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_invert_demorgan_logical_and_thm (e e_1 : IntW 64) :
  LLVM.xor
      (LLVM.or (icmp IntPred.eq e_1 (const? 64 0))
        (select (icmp IntPred.eq e_1 (const? 64 27)) (icmp IntPred.eq e (const? 64 0)) (const? 1 0)))
      (const? 1 1) ⊑
    LLVM.and (icmp IntPred.ne e_1 (const? 64 0))
      (select (icmp IntPred.ne e_1 (const? 64 27)) (const? 1 1) (icmp IntPred.ne e (const? 64 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
