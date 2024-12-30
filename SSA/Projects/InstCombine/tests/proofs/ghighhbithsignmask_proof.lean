
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section ghighhbithsignmask_proof
theorem t0_thm (e : IntW 64) : sub (const? 64 0) (lshr e (const? 64 63)) ⊑ ashr e (const? 64 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t0_exact_thm (e : IntW 64) :
  sub (const? 64 0) (lshr e (const? 64 63) { «exact» := true }) ⊑ ashr e (const? 64 63) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 64) : sub (const? 64 0) (ashr e (const? 64 63)) ⊑ lshr e (const? 64 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_exact_thm (e : IntW 64) :
  sub (const? 64 0) (ashr e (const? 64 63) { «exact» := true }) ⊑ lshr e (const? 64 63) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n9_thm (e : IntW 64) :
  sub (const? 64 0) (lshr e (const? 64 62)) ⊑
    sub (const? 64 0) (lshr e (const? 64 62)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_thm (e : IntW 64) :
  sub (const? 64 1) (lshr e (const? 64 63)) ⊑ zext 64 (icmp IntPredicate.sgt e (const? 64 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


