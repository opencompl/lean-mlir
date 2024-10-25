
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gadd_or_sub_proof
theorem add_or_sub_comb_i32_commuted1_nuw_thm (x : BitVec 32) :
  (if (-x ||| x) + x < -x ||| x ∨ (-x ||| x) + x < x then none else some ((-x ||| x) + x)) ⊑ some x := by bv_compare'

theorem add_or_sub_comb_i8_commuted2_nsw_thm (x : BitVec 8) :
  (if ((-(x * x)).msb = true → (x * x).msb = true) ∧ ¬(x * x + (-(x * x) ||| x * x)).msb = (x * x).msb then none
    else some (x * x + (-(x * x) ||| x * x))) ⊑
    (if (x * x).msb = (255#8).msb ∧ ¬(x * x + 255#8).msb = (x * x).msb then none else some (x * x + 255#8)).bind
      fun a => some (a &&& x * x) := by bv_compare'

theorem add_or_sub_comb_i128_commuted3_nuw_nsw_thm (x : BitVec 128) :
  (if
        ((-(x * x)).msb = true → (x * x).msb = true) ∧
          ¬((x * x ||| -(x * x)) + x * x).msb = ((x * x).msb || (-(x * x)).msb) then
      none
    else
      if (x * x ||| -(x * x)) + x * x < x * x ||| -(x * x) ∨ (x * x ||| -(x * x)) + x * x < x * x then none
      else some ((x * x ||| -(x * x)) + x * x)) ⊑
    some (x * x) := by bv_compare'

theorem add_or_sub_comb_i64_commuted4_thm (x : BitVec 64) : x * x + (x * x ||| -(x * x)) = x * x + 18446744073709551615#64 &&& x * x := by bv_compare'

theorem add_or_sub_comb_i8_negative_y_sub_thm (x x_1 : BitVec 8) : -x_1 ||| x = x ||| -x_1 := by bv_compare'

theorem add_or_sub_comb_i8_negative_y_or_thm (x x_1 : BitVec 8) : -x_1 ||| x = x ||| -x_1 := by bv_compare'

theorem add_or_sub_comb_i8_negative_y_add_thm (x : BitVec 8) : -x ||| x = x ||| -x := by bv_compare'

theorem add_or_sub_comb_i8_negative_xor_instead_or_thm (x : BitVec 8) : -x ^^^ x = x ^^^ -x := by bv_compare'

