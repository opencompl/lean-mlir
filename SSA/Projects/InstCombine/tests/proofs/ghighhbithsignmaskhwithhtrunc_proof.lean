
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section ghighhbithsignmaskhwithhtrunc_proof
theorem t0_thm (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 63))) ⊑ trunc 32 (ashr e (const? 64 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_exact_thm (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 63) { «exact» := true })) ⊑
    trunc 32 (ashr e (const? 64 63) { «exact» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (ashr e (const? 64 63))) ⊑ trunc 32 (lshr e (const? 64 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_exact_thm (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (ashr e (const? 64 63) { «exact» := true })) ⊑
    trunc 32 (lshr e (const? 64 63) { «exact» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n9_thm (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 62))) ⊑
    sub (const? 32 0) (trunc 32 (lshr e (const? 64 62))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_thm (e : IntW 64) :
  sub (const? 32 1) (trunc 32 (lshr e (const? 64 63))) ⊑
    add (trunc 32 (ashr e (const? 64 63))) (const? 32 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


