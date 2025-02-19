
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gpr49688_proof
theorem f_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 0)) (const? 1 1) (icmp IntPredicate.sgt e (ashr (const? 32 7) e)) ⊑
    select (icmp IntPredicate.slt e (const? 32 0)) (const? 1 1)
      (icmp IntPredicate.sgt e (lshr (const? 32 7) e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f2_thm (e e_1 : IntW 32) :
  zext 32
      (select (icmp IntPredicate.slt e_1 (const? 32 0)) (const? 1 1)
        (icmp IntPredicate.sgt e_1 (ashr (const? 32 7) e))) ⊑
    zext 32
      (select (icmp IntPredicate.slt e_1 (const? 32 0)) (const? 1 1)
        (icmp IntPredicate.sgt e_1 (lshr (const? 32 7) e))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


