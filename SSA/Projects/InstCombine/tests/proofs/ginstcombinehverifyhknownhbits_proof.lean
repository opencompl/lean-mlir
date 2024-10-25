
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ginstcombinehverifyhknownhbits_proof
theorem pr110631_thm (x : BitVec 32) (x_1 : BitVec 64) :
  setWidth 16 (signExtend 32 (setWidth 16 x_1 &&& (setWidth 16 x ^^^ 48991#16))) ^^^ 1#16 =
    (setWidth 16 x ^^^ 48991#16) &&& setWidth 16 x_1 ^^^ 1#16 := sorry

