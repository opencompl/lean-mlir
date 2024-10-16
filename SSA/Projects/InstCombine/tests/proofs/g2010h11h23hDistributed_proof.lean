
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2010h11h23hDistributed_proof
theorem foo_thm (x x_1 : BitVec 32) :
  ((if x_1.msb = x.msb ∧ ¬(x_1 + x).msb = x_1.msb then none else some (x_1 + x)).bind fun a =>
      (if
              signExtend 64 a * signExtend 64 x_1 < signExtend 64 (twoPow 32 31) ∨
                twoPow 64 31 ≤ signExtend 64 a * signExtend 64 x_1 then
            none
          else some (a * x_1)).bind
        fun a =>
        (if
                signExtend 64 x_1 * signExtend 64 x_1 < signExtend 64 (twoPow 32 31) ∨
                  twoPow 64 31 ≤ signExtend 64 x_1 * signExtend 64 x_1 then
              none
            else some (x_1 * x_1)).bind
          fun y' => some (a - y')) ⊑
    some (x * x_1) := sorry

