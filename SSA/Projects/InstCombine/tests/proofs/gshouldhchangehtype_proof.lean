
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshouldhchangehtype_proof
theorem test1_thm (x x_1 : BitVec 8) : setWidth 8 (setWidth 64 x_1 + setWidth 64 x) = x_1 + x := sorry

theorem test2_thm (x x_1 : BitVec 16) : setWidth 16 (setWidth 64 x_1 + setWidth 64 x) = x_1 + x := sorry

theorem test3_thm (x x_1 : BitVec 32) : setWidth 32 (setWidth 64 x_1 + setWidth 64 x) = x_1 + x := sorry

theorem test4_thm (x x_1 : BitVec 9) :
  some (setWidth 9 (setWidth 64 x_1 + setWidth 64 x)) ⊑
    (if
            (setWidth 64 x_1).msb = (setWidth 64 x).msb ∧
              ¬(setWidth 64 x_1 + setWidth 64 x).msb = (setWidth 64 x_1).msb then
          none
        else
          if setWidth 64 x_1 + setWidth 64 x < setWidth 64 x_1 ∨ setWidth 64 x_1 + setWidth 64 x < setWidth 64 x then
            none
          else some (setWidth 64 x_1 + setWidth 64 x)).bind
      fun x' => some (setWidth 9 x') := sorry

