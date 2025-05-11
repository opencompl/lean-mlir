
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gassochcasthassoc_proof
theorem XorZextXor_thm (e : IntW 3) :
  LLVM.xor (zext 5 (LLVM.xor e (const? 3 3))) (const? 5 12) ⊑ LLVM.xor (zext 5 e) (const? 5 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem OrZextOr_thm (e : IntW 3) :
  LLVM.or (zext 5 (LLVM.or e (const? 3 3))) (const? 5 8) ⊑ LLVM.or (zext 5 e) (const? 5 11) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem AndZextAnd_thm (e : IntW 3) :
  LLVM.and (zext 5 (LLVM.and e (const? 3 3))) (const? 5 14) ⊑
    zext 5 (LLVM.and e (const? 3 2)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_thm (e : IntW 16) :
  LLVM.and (zext 24 (LLVM.and e (const? 16 32767)) { «nneg» := true }) (const? 24 8388607) ⊑
    zext 24 (LLVM.and e (const? 16 32767)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
