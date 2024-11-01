
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmodulo_proof
theorem modulo2_thm (e : IntW 32) :
  add (select (icmp IntPredicate.slt (LLVM.srem e (const? 2)) (const? 0)) (const? 2) (const? 0))
      (LLVM.srem e (const? 2)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem modulo4_thm (e : IntW 32) :
  add (select (icmp IntPredicate.slt (LLVM.srem e (const? 4)) (const? 0)) (const? 4) (const? 0))
      (LLVM.srem e (const? 4)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem modulo32_thm (e : IntW 32) :
  add (select (icmp IntPredicate.slt (LLVM.srem e (const? 32)) (const? 0)) (const? 32) (const? 0))
      (LLVM.srem e (const? 32)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


