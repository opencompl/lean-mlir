
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpr34349_proof
theorem fast_div_201_thm (x : BitVec 8) :
  some ((setWidth 8 ((setWidth 16 x * 71#16) >>> 8) + (x - setWidth 8 ((setWidth 16 x * 71#16) >>> 8)) >>> 1) >>> 7) ⊑
    (if
            signExtend 32 (setWidth 16 x) * 71#32 < signExtend 32 (twoPow 16 15) ∨
              twoPow 32 15 ≤ signExtend 32 (setWidth 16 x) * 71#32 then
          none
        else
          if twoPow 32 15 <<< 1 ≤ setWidth 32 (setWidth 16 x) * 71#32 then none else some (setWidth 16 x * 71#16)).bind
      fun a =>
      (if
              signExtend 32 (setWidth 16 x) * 71#32 < signExtend 32 (twoPow 16 15) ∨
                twoPow 32 15 ≤ signExtend 32 (setWidth 16 x) * 71#32 then
            none
          else
            if twoPow 32 15 <<< 1 ≤ setWidth 32 (setWidth 16 x) * 71#32 then none
            else some (setWidth 16 x * 71#16)).bind
        fun x_1 =>
        (if
                (x - setWidth 8 (a >>> 8)) >>> 1 + setWidth 8 (x_1 >>> 8) < (x - setWidth 8 (a >>> 8)) >>> 1 ∨
                  (x - setWidth 8 (a >>> 8)) >>> 1 + setWidth 8 (x_1 >>> 8) < setWidth 8 (x_1 >>> 8) then
              none
            else some ((x - setWidth 8 (a >>> 8)) >>> 1 + setWidth 8 (x_1 >>> 8))).bind
          fun x' => some (x' >>> 7) := sorry

