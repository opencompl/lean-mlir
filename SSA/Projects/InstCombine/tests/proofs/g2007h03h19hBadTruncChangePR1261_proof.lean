
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h03h19hBadTruncChangePR1261_proof
theorem test_thm (e : IntW 31) :
  trunc 16 (lshr (add (sext 32 e) (const? 32 16384)) (const? 32 15)) ⊑
    trunc 16 (lshr (add (zext 32 e) (const? 32 16384) { «nsw» := false, «nuw» := true }) (const? 32 15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


