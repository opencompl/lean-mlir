
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehlowhbithmaskhandhicmpheqhtohicmphule_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑
    icmp IntPredicate.ule e (lshr (const? 8 (-1)) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


