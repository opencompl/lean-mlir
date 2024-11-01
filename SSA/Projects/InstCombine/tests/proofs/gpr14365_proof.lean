
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpr14365_proof
theorem test0_thm (e : IntW 32) :
  add e
      (add (LLVM.xor (LLVM.and e (const? 32 1431655765)) (const? 32 (-1))) (const? 32 1)
        { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    LLVM.and e (const? 32 (-1431655766)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_thm (e : IntW 32) :
  add e
      (add (LLVM.xor (LLVM.and (ashr e (const? 32 1)) (const? 32 1431655765)) (const? 32 (-1))) (const? 32 1)
        { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    sub e (LLVM.and (lshr e (const? 32 1)) (const? 32 1431655765)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


