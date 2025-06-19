
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsignhtesthandhor_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt e_1 (const? 32 0)) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.slt (LLVM.or e_1 e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.sgt e_1 (const? 32 (-1))) (icmp IntPred.sgt e (const? 32 (-1))) ⊑
    icmp IntPred.sgt (LLVM.and e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.slt e_1 (const? 32 0)) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.slt (LLVM.and e_1 e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.sgt e_1 (const? 32 (-1))) (icmp IntPred.sgt e (const? 32 (-1))) ⊑
    icmp IntPred.sgt (LLVM.or e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 1073741824)) (const? 32 0))
      (icmp IntPred.sgt e (const? 32 (-1))) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-1073741824))) (const? 32 1073741824) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 1073741824)) (const? 32 0))
      (icmp IntPred.sgt e (const? 32 (-1))) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-1073741824))) (const? 32 1073741824) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (icmp IntPred.ult e (const? 32 4)) ⊑
    icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (icmp IntPred.ult e (const? 32 4))
      (const? 1 0) ⊑
    icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (icmp IntPred.ugt e (const? 32 3)) ⊑
    icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ugt e (const? 32 3)) ⊑
    icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
