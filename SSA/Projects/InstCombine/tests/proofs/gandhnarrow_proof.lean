
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhnarrow_proof
theorem zext_add_thm (e : IntW 8) :
  LLVM.and (add (zext 16 e) (const? 16 44)) (zext 16 e) ⊑ zext 16 (LLVM.and (add e (const? 8 44)) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sub_thm (e : IntW 8) :
  LLVM.and (sub (const? 16 (-5)) (zext 16 e)) (zext 16 e) ⊑ zext 16 (LLVM.and (sub (const? 8 (-5)) e) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_mul_thm (e : IntW 8) :
  LLVM.and (mul (zext 16 e) (const? 16 3)) (zext 16 e) ⊑ zext 16 (LLVM.and (mul e (const? 8 3)) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_lshr_thm (e : IntW 8) :
  LLVM.and (lshr (zext 16 e) (const? 16 4)) (zext 16 e) ⊑
    zext 16 (LLVM.and (lshr e (const? 8 4)) e) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_ashr_thm (e : IntW 8) :
  LLVM.and (ashr (zext 16 e) (const? 16 2)) (zext 16 e) ⊑
    zext 16 (LLVM.and (lshr e (const? 8 2)) e) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_shl_thm (e : IntW 8) :
  LLVM.and (shl (zext 16 e) (const? 16 3)) (zext 16 e) ⊑ zext 16 (LLVM.and (shl e (const? 8 3)) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


