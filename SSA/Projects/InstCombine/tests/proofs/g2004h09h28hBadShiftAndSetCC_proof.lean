
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2004h09h28hBadShiftAndSetCC_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e (const? 8)) (const? (-16777216))) (const? 167772160) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 16711680)) (const? 655360) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


