
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthnot_proof
theorem test1_thm (x : BitVec 33) : x ^^^ 8589934591#33 ^^^ 8589934591#33 = x := sorry

