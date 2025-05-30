
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphxorhsignbit_proof
theorem slt_to_ult_thm (e e_1 : IntW 8) :
  icmp IntPred.slt (LLVM.xor e_1 (const? 8 (-128))) (LLVM.xor e (const? 8 (-128))) ⊑
    icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_to_slt_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.xor e_1 (const? 8 (-128))) (LLVM.xor e (const? 8 (-128))) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_to_ugt_thm (e e_1 : IntW 8) :
  icmp IntPred.slt (LLVM.xor e_1 (const? 8 127)) (LLVM.xor e (const? 8 127)) ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_to_sgt_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.xor e_1 (const? 8 127)) (LLVM.xor e (const? 8 127)) ⊑ icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_to_ugt_thm (e : IntW 8) :
  icmp IntPred.sge (LLVM.xor e (const? 8 (-128))) (const? 8 15) ⊑
    icmp IntPred.ugt e (const? 8 (-114)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_to_sgt_thm (e : IntW 8) :
  icmp IntPred.uge (LLVM.xor e (const? 8 (-128))) (const? 8 15) ⊑
    icmp IntPred.sgt e (const? 8 (-114)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_to_ult_thm (e : IntW 8) :
  icmp IntPred.sge (LLVM.xor e (const? 8 127)) (const? 8 15) ⊑ icmp IntPred.ult e (const? 8 113) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_to_slt_thm (e : IntW 8) :
  icmp IntPred.uge (LLVM.xor e (const? 8 127)) (const? 8 15) ⊑ icmp IntPred.slt e (const? 8 113) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.eq (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.xor (icmp IntPred.sgt e (const? 32 (-1))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_fail_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.eq (zext 32 e_1) (ashr e (const? 32 31)) ⊑
    icmp IntPred.eq (ashr e (const? 32 31)) (zext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 0))) (lshr e (const? 32 31)) ⊑
    icmp IntPred.slt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ne_ne_0_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.ne e (const? 32 0))) (lshr e (const? 32 31)) ⊑
    icmp IntPred.sgt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ne_ne_b_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.ne e_1 e)) (lshr e_1 (const? 32 31)) ⊑
    LLVM.xor (icmp IntPred.slt e_1 (const? 32 0)) (icmp IntPred.ne e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_fail1_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 0))) (ashr e (const? 32 31)) ⊑
    icmp IntPred.eq (ashr e (const? 32 31)) (zext 32 (icmp IntPred.ne e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_ne_0_fail2_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 0))) (lshr e (const? 32 30)) ⊑
    icmp IntPred.eq (lshr e (const? 32 30)) (zext 32 (icmp IntPred.ne e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
