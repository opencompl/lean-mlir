
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehlackhofhsignedhtruncationhcheck_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (shl e (const? 5)) (const? 5)) e ⊑
    icmp IntPredicate.ult (add e (const? 4)) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pb_thm (e : IntW 65) :
  icmp IntPredicate.eq e (ashr (shl e (const? 1)) (const? 1)) ⊑
    icmp IntPredicate.sgt (add e (const? 9223372036854775808)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n1_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (shl e (const? 5)) (const? 5)) e ⊑ icmp IntPredicate.ult e (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


