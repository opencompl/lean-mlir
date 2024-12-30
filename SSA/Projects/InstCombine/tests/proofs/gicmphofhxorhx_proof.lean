
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gicmphofhxorhx_proof
theorem test_xor_ne_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ne (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPredicate.ne e_2 (LLVM.xor e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_xor_eq_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPredicate.eq e_2 (LLVM.xor e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_slt_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sle_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.sge (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sgt_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sgt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sge_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sge (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.sle (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ult_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ult (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ule_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ule (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.uge (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ugt_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_uge_xor_thm (e e_1 : IntW 32) :
  icmp IntPredicate.uge (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPredicate.ule (LLVM.xor e e_1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_sge_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sge (mul e_1 e_1) (LLVM.xor (LLVM.or e (const? 8 (-128))) (mul e_1 e_1)) ⊑
    icmp IntPredicate.slt (LLVM.xor (LLVM.or e (const? 8 (-128))) (mul e_1 e_1)) (mul e_1 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_ugt_2_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ugt (add e_2 e_1) (LLVM.xor (add e_2 e_1) (LLVM.or (LLVM.and e (const? 8 63)) (const? 8 64))) ⊑
    icmp IntPredicate.ugt (add e_2 e_1)
      (LLVM.xor (add e_2 e_1) (LLVM.or (LLVM.and e (const? 8 63)) (const? 8 64) { «disjoint» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


