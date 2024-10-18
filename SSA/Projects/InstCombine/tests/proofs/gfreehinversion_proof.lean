
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gfreehinversion_proof
theorem lshr_not_nneg2_thm (x : BitVec 8) : (x ^^^ 255#8) >>> 1 ^^^ 255#8 = x >>> 1 ||| 128#8 := sorry

