
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthrem1_proof
theorem test1_thm (x : BitVec 33) : x % 4096#33 = x &&& 4095#33 := sorry

theorem test2_thm (x : BitVec 49) : x % 8388608#49 = x &&& 8388607#49 := sorry

