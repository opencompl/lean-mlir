
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcanonicalizehlackhofhsignedhtruncationhcheck_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPred.eq (ashr (shl e (const? 8 5)) (const? 8 5) { «exact» := true }) e ⊑
    icmp IntPred.ult (add e (const? 8 4)) (const? 8 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pb_thm (e : IntW 65) :
  icmp IntPred.eq e (ashr (shl e (const? 65 1)) (const? 65 1) { «exact» := true }) ⊑
    icmp IntPred.sgt (add e (const? 65 9223372036854775808)) (const? 65 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n1_thm (e : IntW 8) :
  icmp IntPred.eq (lshr (shl e (const? 8 5)) (const? 8 5) { «exact» := true }) e ⊑
    icmp IntPred.ult e (const? 8 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
