
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h03h25hDoubleShift_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.ne (lshr (shl e (const? 12)) (const? 12)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 1048575)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


