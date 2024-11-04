
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gfoldhextheqhchwithhop_proof
theorem fold_add_zext_eq_0_thm (e : IntW 8) :
  add e (zext 8 (icmp IntPredicate.eq e (const? 8 0))) ⊑ add (zext 8 (icmp IntPredicate.eq e (const? 8 0))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


