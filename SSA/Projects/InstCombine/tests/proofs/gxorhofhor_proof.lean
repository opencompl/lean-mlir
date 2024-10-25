
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gxorhofhor_proof
theorem t1_thm (x : BitVec 4) : (x ||| 12#4) ^^^ 10#4 = x &&& 3#4 ^^^ 6#4 := by bv_compare'

