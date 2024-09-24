
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2010h11h01hlshrhmask_proof
theorem foo_thm (x x_1 : BitVec 8) :
  (x_1 <<< 7 ^^^ x &&& 138#8) >>> 7 <<< 5 ^^^
      (x &&& 33#8 ||| 168#8 - (x &&& 84#8) &&& 84#8 ||| x_1 <<< 7 ^^^ x &&& 138#8) =
    (x_1 <<< 7 ^^^ x &&& 138#8) >>> 2 &&& 32#8 ^^^
      (x &&& 33#8 ||| 40#8 - (x &&& 84#8) &&& 84#8 ||| x_1 <<< 7 ^^^ x &&& 138#8) := sorry

