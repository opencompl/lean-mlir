
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section g2007h08h02hInfiniteLoop_proof
theorem test_thm (e e_1 : IntW 16) :
  sext 64 (add (sext 32 e_1) (sext 32 e)) ⊑
    sext 64 (add (sext 32 e_1) (sext 32 e) { «nsw» := true, «nuw» := false }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


