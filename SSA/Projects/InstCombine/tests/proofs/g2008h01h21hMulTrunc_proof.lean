
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h01h21hMulTrunc_proof
theorem test1_thm (x : BitVec 16) :
  setWidth 16 (setWidth 32 x >>> 8) ||| setWidth 16 (setWidth 32 x * 5#32) = x >>> 8 ||| x * 5#16 := by bv_compare'

