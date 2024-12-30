
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section ggethlowbitmaskhuptohandhincludinghbit_proof
theorem t0_thm (e : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e) (const? 8 (-1))) (shl (const? 8 1) e) ⊑
    lshr (const? 8 (-1)) (sub (const? 8 7) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e : IntW 16) :
  LLVM.or (add (shl (const? 16 1) e) (const? 16 (-1))) (shl (const? 16 1) e) ⊑
    lshr (const? 16 (-1)) (sub (const? 16 15) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_nocse_thm (e : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e) (const? 8 (-1))) (shl (const? 8 1) e) ⊑
    LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true })
      (LLVM.xor (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t17_nocse_mismatching_x_thm (e e_1 : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e_1) (const? 8 (-1))) (shl (const? 8 1) e) ⊑
    LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true })
      (LLVM.xor (shl (const? 8 (-1)) e_1 { «nsw» := true, «nuw» := false }) (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


