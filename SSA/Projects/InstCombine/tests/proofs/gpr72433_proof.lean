
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gpr72433_proof
theorem widget_thm (e : IntW 32) :
  mul
      (add (mul (const? 32 20) (sub (const? 32 2) (zext 32 (icmp IntPredicate.eq e (const? 32 0)))))
        (LLVM.xor (zext 32 (icmp IntPredicate.eq e (const? 32 0))) (const? 32 1)))
      (sub (const? 32 2) (zext 32 (icmp IntPredicate.eq e (const? 32 0)))) ⊑
    shl
      (LLVM.or (shl (const? 32 20) (zext 32 (icmp IntPredicate.ne e (const? 32 0))) { «nsw» := true, «nuw» := true })
        (zext 32 (icmp IntPredicate.ne e (const? 32 0))) { «disjoint» := true })
      (zext 32 (icmp IntPredicate.ne e (const? 32 0))) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


