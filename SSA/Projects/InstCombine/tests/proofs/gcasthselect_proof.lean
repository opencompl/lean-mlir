
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcasthselect_proof
theorem trunc_thm (e e_1 e_2 : IntW 32) :
  trunc 16 (select (icmp IntPredicate.ult e_2 e_1) (const? 32 42) e) ⊑
    select (icmp IntPredicate.ult e_2 e_1) (const? 16 42) (trunc 16 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


