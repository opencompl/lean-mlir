
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhwithhtruncationhashr_proof
theorem t0_thm (e : IntW 16) (e_1 : IntW 32) :
  ashr (trunc 16 (ashr e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-1))) ⊑
    trunc 16 (ashr e_1 (const? 32 31)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_ashr_thm (e : IntW 16) (e_1 : IntW 32) :
  ashr (trunc 16 (ashr e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-2))) ⊑
    ashr (trunc 16 (ashr e_1 (zext 32 (sub (const? 16 32) e) { «nneg» := true }))) (add e (const? 16 (-2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_lshr_ashr_thm (e : IntW 16) (e_1 : IntW 32) :
  ashr (trunc 16 (lshr e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-1))) ⊑
    ashr (trunc 16 (lshr e_1 (zext 32 (sub (const? 16 32) e) { «nneg» := true }))) (add e (const? 16 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


