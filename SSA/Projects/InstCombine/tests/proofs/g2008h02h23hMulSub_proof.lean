
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h02h23hMulSub_proof
theorem test_thm (e : IntW 26) : sub (mul e (const? 26 2885)) (mul e (const? 26 2884)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


