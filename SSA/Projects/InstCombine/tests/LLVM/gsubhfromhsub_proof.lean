
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhfromhsub_proof
theorem t0_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_thm (x x_1 x_2 : BitVec 8) :
  ((if (signExtend 9 x_2 - signExtend 9 x_1).msb = (signExtend 9 x_2 - signExtend 9 x_1).getMsbD 1 then
          if x_2 < x_1 then none else some (x_2 - x_1)
        else none).bind
      fun a =>
      if (signExtend 9 a - signExtend 9 x).msb = (signExtend 9 a - signExtend 9 x).getMsbD 1 then
        if a < x then none else some (a - x)
      else none) ⊑
    (if x_1.msb = x.msb ∧ ¬(x_1 + x).msb = x_1.msb then none
        else if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x)).bind
      fun a =>
      if (signExtend 9 x_2 - signExtend 9 a).msb = (signExtend 9 x_2 - signExtend 9 a).getMsbD 1 then
        if x_2 < a then none else some (x_2 - a)
      else none := sorry

theorem t1_flags_nuw_only_thm (x x_1 x_2 : BitVec 8) :
  ((if x_2 < x_1 then none else some (x_2 - x_1)).bind fun a => if a < x then none else some (a - x)) ⊑
    (if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x)).bind fun a =>
      if x_2 < a then none else some (x_2 - a) := sorry

theorem t1_flags_sub_nsw_sub_thm (x x_1 x_2 : BitVec 8) :
  ((if (signExtend 9 x_2 - signExtend 9 x_1).msb = (signExtend 9 x_2 - signExtend 9 x_1).getMsbD 1 then some (x_2 - x_1)
        else none).bind
      fun a => some (a - x)) ⊑
    some (x_2 - (x_1 + x)) := sorry

theorem t1_flags_nuw_first_thm (x x_1 x_2 : BitVec 8) :
  ((if x_2 < x_1 then none else some (x_2 - x_1)).bind fun a => some (a - x)) ⊑ some (x_2 - (x_1 + x)) := sorry

theorem t1_flags_nuw_second_thm (x x_1 x_2 : BitVec 8) :
  (if x_2 - x_1 < x then none else some (x_2 - x_1 - x)) ⊑ some (x_2 - (x_1 + x)) := sorry

theorem t1_flags_nuw_nsw_first_thm (x x_1 x_2 : BitVec 8) :
  ((if (signExtend 9 x_2 - signExtend 9 x_1).msb = (signExtend 9 x_2 - signExtend 9 x_1).getMsbD 1 then
          if x_2 < x_1 then none else some (x_2 - x_1)
        else none).bind
      fun a => some (a - x)) ⊑
    some (x_2 - (x_1 + x)) := sorry

theorem t1_flags_nuw_nsw_second_thm (x x_1 x_2 : BitVec 8) :
  (if (signExtend 9 (x_2 - x_1) - signExtend 9 x).msb = (signExtend 9 (x_2 - x_1) - signExtend 9 x).getMsbD 1 then
      if x_2 - x_1 < x then none else some (x_2 - x_1 - x)
    else none) ⊑
    some (x_2 - (x_1 + x)) := sorry

theorem t3_c0_thm (x x_1 : BitVec 8) : 42#8 - x_1 - x = 42#8 - (x_1 + x) := sorry

theorem t4_c1_thm (x : BitVec 8) : x - 42#8 = x + 214#8 := sorry

theorem t5_c2_thm (x x_1 : BitVec 8) : x_1 - x - 42#8 = x_1 - x + 214#8 := sorry

theorem t9_c0_c2_thm (x : BitVec 8) : 42#8 - x - 24#8 = 18#8 - x := sorry

theorem t10_c1_c2_thm (x : BitVec 8) : x - 42#8 - 24#8 = x + 190#8 := sorry

