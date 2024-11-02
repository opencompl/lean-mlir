
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthmul2_proof
theorem test1_thm (e : IntW 177) : mul e (shl (const? 177 1) (const? 177 155)) ⊑ shl e (const? 177 155) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


