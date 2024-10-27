
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthcasthcasthtohand_proof
theorem test1_thm (x : BitVec 61) : setWidth 61 (setWidth 41 x) = x &&& 2199023255551#61 := sorry

