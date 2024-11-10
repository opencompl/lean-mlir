
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section g2012h02h28hICmp_proof
theorem f1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (trunc 8 e) (const? 8 0))
      (icmp IntPredicate.ne (LLVM.and e (const? 32 16711680)) (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.ne (trunc 8 e) (const? 8 0))
      (icmp IntPredicate.ne (LLVM.and e (const? 32 16711680)) (const? 32 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


