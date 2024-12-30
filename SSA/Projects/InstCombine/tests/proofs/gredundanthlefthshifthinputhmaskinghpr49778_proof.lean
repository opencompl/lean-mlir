
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gredundanthlefthshifthinputhmaskinghpr49778_proof
theorem src_thm (e : IntW 1) :
  shl (LLVM.and (LLVM.xor (shl (const? 32 (-1)) (zext 32 e)) (const? 32 (-1))) (zext 32 e)) (zext 32 e) ⊑
    shl
      (LLVM.and (LLVM.xor (shl (const? 32 (-1)) (zext 32 e) { «nsw» := true, «nuw» := false }) (const? 32 (-1)))
        (zext 32 e))
      (zext 32 e) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


