
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gmodulo_proof
theorem modulo2_thm (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 2)) (const? 32 0)) (const? 32 2) (const? 32 0))
      (LLVM.srem e (const? 32 2)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem modulo4_thm (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 4)) (const? 32 0)) (const? 32 4) (const? 32 0))
      (LLVM.srem e (const? 32 4)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 32 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem modulo32_thm (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 32)) (const? 32 0)) (const? 32 32) (const? 32 0))
      (LLVM.srem e (const? 32 32)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
