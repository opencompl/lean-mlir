
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnarrow_proof
theorem test1_thm (e e_1 : IntW 32) :
  trunc 1 (LLVM.and (zext 32 (icmp IntPredicate.slt e_1 e)) (zext 32 (icmp IntPredicate.sgt e_1 e))) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shrink_xor_thm (e : IntW 64) : trunc 32 (LLVM.xor e (const? 64 1)) ⊑ LLVM.xor (trunc 32 e) (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shrink_or_thm (e : IntW 6) : trunc 3 (LLVM.or e (const? 6 (-31))) ⊑ LLVM.or (trunc 3 e) (const? 3 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


