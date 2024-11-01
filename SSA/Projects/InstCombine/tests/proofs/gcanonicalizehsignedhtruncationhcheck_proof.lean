
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehsignedhtruncationhcheck_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (shl e (const? 5)) (const? 5)) e ⊑
    icmp IntPredicate.ult (add e (const? (-4))) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pb_thm (e : IntW 65) :
  icmp IntPredicate.ne e (ashr (shl e (const? 1)) (const? 1)) ⊑
    icmp IntPredicate.slt (add e (const? 9223372036854775808)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n1_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (shl e (const? 5)) (const? 5)) e ⊑ icmp IntPredicate.ugt e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


