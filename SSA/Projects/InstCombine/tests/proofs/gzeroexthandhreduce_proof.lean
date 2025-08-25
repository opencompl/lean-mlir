
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gzeroexthandhreduce_proof
theorem test1_thm (e : IntW 8) :
  LLVM.and (zext 32 e) (const? 32 65544) ⊑ zext 32 (LLVM.and e (const? 8 8)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
