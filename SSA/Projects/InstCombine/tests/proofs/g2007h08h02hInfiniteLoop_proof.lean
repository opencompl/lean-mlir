
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2007h08h02hInfiniteLoop_proof
theorem test_thm (x x_1 : BitVec 16) :
  some (signExtend 64 (signExtend 32 x_1 + signExtend 32 x)) ⊑
    (if x_1.msb = x.msb ∧ ¬(signExtend 32 x_1 + signExtend 32 x).msb = x_1.msb then none
        else some (signExtend 32 x_1 + signExtend 32 x)).bind
      fun x' => some (signExtend 64 x') := sorry

