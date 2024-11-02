
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2011h03h08hSRemMinusOneBadOpt_proof
theorem test_thm (e : IntW 64) :
  LLVM.srem (trunc 32 (LLVM.or e (const? 64 4294967294))) (const? 32 (-1)) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


