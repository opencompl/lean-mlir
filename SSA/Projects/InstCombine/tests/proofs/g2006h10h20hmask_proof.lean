
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2006h10h20hmask_proof
theorem foo_thm (x x_1 : BitVec 64) :
  setWidth 64 (setWidth 32 x_1) &&& setWidth 64 (setWidth 32 x) = x_1 &&& x &&& 4294967295#64 := by bv_compare'

