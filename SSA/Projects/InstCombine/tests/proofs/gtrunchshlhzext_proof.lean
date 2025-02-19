
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gtrunchshlhzext_proof
theorem trunc_shl_zext_32_thm (e : IntW 32) :
  zext 32 (shl (trunc 16 e) (const? 16 4)) ⊑ LLVM.and (shl e (const? 32 4)) (const? 32 65520) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_shl_zext_64_thm (e : IntW 64) :
  zext 64 (shl (trunc 8 e) (const? 8 7)) ⊑ LLVM.and (shl e (const? 64 7)) (const? 64 128) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


