
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmul_fold_proof
theorem mul8_low_A0_B0_thm (x x_1 : BitVec 8) :
  (x_1 >>> 4 * x + x >>> 4 * x_1) <<< 4 + (x_1 &&& 15#8) * (x &&& 15#8) = x * x_1 := sorry

theorem mul8_low_thm (x x_1 : BitVec 8) :
  (x_1 >>> 4 * (x &&& 15#8) + (x_1 &&& 15#8) * x >>> 4) <<< 4 + (x_1 &&& 15#8) * (x &&& 15#8) = x * x_1 := sorry

theorem mul16_low_thm (x x_1 : BitVec 16) :
  (x_1 >>> 8 * (x &&& 255#16) + (x_1 &&& 255#16) * x >>> 8) <<< 8 + (x_1 &&& 255#16) * (x &&& 255#16) = x * x_1 := sorry

