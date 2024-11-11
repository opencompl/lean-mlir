
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gshifthamounthreassociationhwithhtruncationhshl_proof
theorem t0_thm (e : IntW 16) (e_1 : IntW 32) :
  shl (trunc 16 (shl e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-24))) ⊑
    shl (trunc 16 e_1) (const? 16 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n11_thm (e : IntW 16) (e_1 : IntW 32) :
  shl (trunc 16 (shl e_1 (zext 32 (sub (const? 16 30) e)))) (add e (const? 16 (-31))) ⊑
    shl (trunc 16 (shl e_1 (zext 32 (sub (const? 16 30) e) { «nneg» := true }))) (add e (const? 16 (-31))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


