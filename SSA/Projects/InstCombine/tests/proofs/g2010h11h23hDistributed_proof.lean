
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2010h11h23hDistributed_proof
theorem foo_thm (e e_1 : IntW 32) :
  sub (mul (add e_1 e { «nsw» := true, «nuw» := false }) e_1 { «nsw» := true, «nuw» := false })
      (mul e_1 e_1 { «nsw» := true, «nuw» := false }) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bar_thm (e e_1 : IntW 64) :
  icmp IntPredicate.eq (LLVM.and e_1 (LLVM.xor (LLVM.and e_1 e) (const? 64 (-1)))) (const? 64 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (LLVM.xor e (const? 64 (-1)))) (const? 64 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


