
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gshlhbo_proof
theorem lshr_add_thm (e e_1 : IntW 8) :
  shl (add (lshr e_1 (const? 8 5)) (LLVM.srem e (const? 8 42))) (const? 8 5) ⊑
    LLVM.and (add e_1 (shl (LLVM.srem e (const? 8 42)) (const? 8 5))) (const? 8 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_sub_thm (e e_1 : IntW 8) :
  shl (sub (LLVM.srem e_1 (const? 8 42)) (lshr e (const? 8 3))) (const? 8 3) ⊑
    shl (sub (LLVM.srem e_1 (const? 8 42)) (lshr e (const? 8 3)) { «nsw» := true, «nuw» := false })
      (const? 8 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_thm (e e_1 : IntW 8) :
  shl (LLVM.and (lshr e_1 (const? 8 6)) (LLVM.srem e (const? 8 42))) (const? 8 6) ⊑
    LLVM.and e_1 (shl (LLVM.srem e (const? 8 42)) (const? 8 6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_or_thm (e e_1 : IntW 8) :
  shl (LLVM.or (LLVM.srem e_1 (const? 8 42)) (lshr e (const? 8 4))) (const? 8 4) ⊑
    LLVM.or (LLVM.and e (const? 8 (-16))) (shl (LLVM.srem e_1 (const? 8 42)) (const? 8 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_xor_thm (e e_1 : IntW 8) :
  shl (LLVM.xor (lshr e_1 (const? 8 3)) (LLVM.srem e (const? 8 42))) (const? 8 3) ⊑
    LLVM.xor (LLVM.and e_1 (const? 8 (-8))) (shl (LLVM.srem e (const? 8 42)) (const? 8 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_add_thm (e e_1 : IntW 8) :
  shl (add (LLVM.srem e_1 (const? 8 42)) (LLVM.and (lshr e (const? 8 3)) (const? 8 12))) (const? 8 3) ⊑
    add (LLVM.and e (const? 8 96)) (shl (LLVM.srem e_1 (const? 8 42)) (const? 8 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_sub_thm (e e_1 : IntW 8) :
  shl (sub (LLVM.srem e_1 (const? 8 42)) (LLVM.and (lshr e (const? 8 2)) (const? 8 13))) (const? 8 2) ⊑
    shl
      (sub (LLVM.srem e_1 (const? 8 42)) (LLVM.and (lshr e (const? 8 2)) (const? 8 13))
        { «nsw» := true, «nuw» := false })
      (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_and_thm (e e_1 : IntW 8) :
  shl (LLVM.and (LLVM.and (lshr e_1 (const? 8 2)) (const? 8 13)) (LLVM.srem e (const? 8 42))) (const? 8 2) ⊑
    LLVM.and (LLVM.and e_1 (const? 8 52)) (shl (LLVM.srem e (const? 8 42)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_or_thm (e e_1 : IntW 8) :
  shl (LLVM.or (LLVM.srem e_1 (const? 8 42)) (LLVM.and (lshr e (const? 8 2)) (const? 8 13))) (const? 8 2) ⊑
    LLVM.or (LLVM.and e (const? 8 52)) (shl (LLVM.srem e_1 (const? 8 42)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_or_disjoint_thm (e e_1 : IntW 8) :
  shl (LLVM.or (LLVM.srem e_1 (const? 8 42)) (LLVM.and (lshr e (const? 8 2)) (const? 8 13)) { «disjoint» := true })
      (const? 8 2) ⊑
    LLVM.or (LLVM.and e (const? 8 52)) (shl (LLVM.srem e_1 (const? 8 42)) (const? 8 2)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_and_or_disjoint_thm (e e_1 : IntW 8) :
  shl (LLVM.or (LLVM.srem e_1 (const? 8 42)) (LLVM.and (ashr e (const? 8 2)) (const? 8 13)) { «disjoint» := true })
      (const? 8 2) ⊑
    LLVM.or (LLVM.and e (const? 8 52)) (shl (LLVM.srem e_1 (const? 8 42)) (const? 8 2)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_xor_thm (e e_1 : IntW 8) :
  shl (LLVM.xor (LLVM.and (lshr e_1 (const? 8 2)) (const? 8 13)) (LLVM.srem e (const? 8 42))) (const? 8 2) ⊑
    LLVM.xor (LLVM.and e_1 (const? 8 52)) (shl (LLVM.srem e (const? 8 42)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_add_and_shl_thm (e e_1 : IntW 32) :
  shl (add e_1 (LLVM.and (lshr e (const? 32 5)) (const? 32 127))) (const? 32 5) ⊑
    add (LLVM.and e (const? 32 4064)) (shl e_1 (const? 32 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_and_lshr_thm (e e_1 : IntW 32) :
  shl (add (LLVM.and (lshr e_1 (const? 32 4)) (const? 32 8)) e) (const? 32 4) ⊑
    add (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
