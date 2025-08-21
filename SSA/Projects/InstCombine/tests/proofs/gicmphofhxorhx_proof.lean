
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphofhxorhx_proof
theorem test_xor_ne_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPred.ne e_2 (LLVM.xor e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_xor_eq_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPred.eq e_2 (LLVM.xor e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_slt_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.sgt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_sle_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.sle (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.sge (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_sgt_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_sge_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.sge (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.sle (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_ult_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.ugt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_ule_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.ule (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.uge (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_ugt_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.ugt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.ult (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_uge_xor_thm (e e_1 : IntW 32) :
  icmp IntPred.uge (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.ule (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem xor_sge_thm (e e_1 : IntW 8) :
  icmp IntPred.sge (mul e_1 e_1) (LLVM.xor (LLVM.or e (const? 8 (-128))) (mul e_1 e_1)) ⊑
    icmp IntPred.slt (LLVM.xor (LLVM.or e (const? 8 (-128))) (mul e_1 e_1)) (mul e_1 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem xor_ugt_2_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.ugt (add e_2 e_1) (LLVM.xor (add e_2 e_1) (LLVM.or (LLVM.and e (const? 8 63)) (const? 8 64))) ⊑
    icmp IntPred.ugt (add e_2 e_1)
      (LLVM.xor (add e_2 e_1) (LLVM.or (LLVM.and e (const? 8 63)) (const? 8 64) { «disjoint» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
