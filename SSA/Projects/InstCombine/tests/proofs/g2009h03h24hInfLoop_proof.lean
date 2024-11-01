
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2009h03h24hInfLoop_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 3968) e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 3968))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


