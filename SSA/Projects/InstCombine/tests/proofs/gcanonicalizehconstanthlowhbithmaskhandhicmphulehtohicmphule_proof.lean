
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gcanonicalizehconstanthlowhbithmaskhandhicmphulehtohicmphule_proof
theorem c0_thm (e : IntW 8) : icmp IntPredicate.ule (LLVM.and e (const? 8 3)) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem cv2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
