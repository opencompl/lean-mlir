
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h01h21hMulTrunc_proof
theorem test1_thm (e : IntW 16) :
  trunc 16 (LLVM.or (lshr (zext 32 e) (const? 32 8)) (mul (zext 32 e) (const? 32 5))) ⊑
    LLVM.or (lshr e (const? 16 8)) (mul e (const? 16 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


