import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2004h11h22hMissedhandhfold_proof
theorem test21_thm (x : BitVec 8) : x.sshiftRight 7 &&& 1#8 = x >>> 7 := sorry
