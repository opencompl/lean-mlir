
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gredundanthlefthshifthinputhmaskinghpr49778_proof
theorem src_thm (e : IntW 1) :
  shl (LLVM.and (LLVM.xor (shl (const? (-1)) (zext 32 e)) (const? (-1))) (zext 32 e)) (zext 32 e) ⊑
    shl
      (LLVM.and (LLVM.xor (shl (const? (-1)) (zext 32 e) { «nsw» := true, «nuw» := false }) (const? (-1))) (zext 32 e))
      (zext 32 e) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


