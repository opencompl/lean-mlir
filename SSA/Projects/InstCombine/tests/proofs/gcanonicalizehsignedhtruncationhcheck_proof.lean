
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gcanonicalizehsignedhtruncationhcheck_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (shl e (const? 8 5)) (const? 8 5) { «exact» := true }) e ⊑
    icmp IntPredicate.ult (add e (const? 8 (-4))) (const? 8 (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pb_thm (e : IntW 65) :
  icmp IntPredicate.ne e (ashr (shl e (const? 65 1)) (const? 65 1) { «exact» := true }) ⊑
    icmp IntPredicate.slt (add e (const? 65 9223372036854775808)) (const? 65 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n1_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (shl e (const? 8 5)) (const? 8 5) { «exact» := true }) e ⊑
    icmp IntPredicate.ugt e (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


