
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnothadd_proof
theorem basic_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) + x ^^^ 255#8 = x_1 - x := sorry

theorem basic_com_add_thm (x x_1 : BitVec 8) : x_1 + (x ^^^ 255#8) ^^^ 255#8 = x - x_1 := sorry

theorem basic_preserve_nsw_thm (x x_1 : BitVec 8) :
  ((if (x_1.msb ^^ (255#8).msb) = x.msb ∧ ¬((x_1 ^^^ 255#8) + x).msb = (x_1.msb ^^ (255#8).msb) then none
        else some ((x_1 ^^^ 255#8) + x)).bind
      fun x' => some (x' ^^^ 255#8)) ⊑
    if (signExtend 9 x_1 - signExtend 9 x).msb = (signExtend 9 x_1 - signExtend 9 x).getMsbD 1 then some (x_1 - x)
    else none := sorry

theorem basic_preserve_nuw_thm (x x_1 : BitVec 8) :
  ((if (x_1 ^^^ 255#8) + x < x_1 ^^^ 255#8 ∨ (x_1 ^^^ 255#8) + x < x then none else some ((x_1 ^^^ 255#8) + x)).bind
      fun x' => some (x' ^^^ 255#8)) ⊑
    if x_1 < x then none else some (x_1 - x) := sorry

theorem basic_preserve_nuw_nsw_thm (x x_1 : BitVec 8) :
  ((if (x_1.msb ^^ (255#8).msb) = x.msb ∧ ¬((x_1 ^^^ 255#8) + x).msb = (x_1.msb ^^ (255#8).msb) then none
        else
          if (x_1 ^^^ 255#8) + x < x_1 ^^^ 255#8 ∨ (x_1 ^^^ 255#8) + x < x then none
          else some ((x_1 ^^^ 255#8) + x)).bind
      fun x' => some (x' ^^^ 255#8)) ⊑
    if (signExtend 9 x_1 - signExtend 9 x).msb = (signExtend 9 x_1 - signExtend 9 x).getMsbD 1 then
      if x_1 < x then none else some (x_1 - x)
    else none := sorry

