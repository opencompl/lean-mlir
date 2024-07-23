import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import SSA.Projects.InstCombine.ForMathlib
import Init.Data.Nat.Bitwise.Basic
import Init.Data.Nat.Bitwise.Lemmas

namespace HackersDelight

namespace Ch2Basics

theorem neg_add_eq_neg_sub {x: BitVec w } :
    -(x + y) = -x - y := by
  ring

theorem neg_eq_not_add_one {x : BitVec w} :
    -x = ~~~x + 1 := by
  exact BitVec.neg_eq_not_add x

theorem not_eq_neg_sub_one {x : BitVec w} :
    ~~~ x = -x - 1 := by
  apply BitVec.eq_sub_iff_add_eq.mpr
  rw [BitVec.neg_eq_not_add]

theorem neg_eq_neg_not_one {x : BitVec w} :
    -x = ~~~(x - 1) := by
  rw [not_eq_neg_sub_one]
  ring

theorem not_not {x : BitVec w} :
    ~~~ ~~~ x = x := by
  rw [not_eq_neg_sub_one,not_eq_neg_sub_one]
  ring

theorem neg_not_eq_add_one {x : BitVec w} :
    - ~~~ x = x + 1 := by
  rw [BitVec.neg_eq_not_add, not_not]

theorem not_neg_eq_sub_one {x : BitVec w} :
    ~~~ (-x) = x - 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem add_eq_sub_not_sub_one {x y : BitVec w} :
    x + y = x - ~~~ y - 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem add_eq_xor_add_mul_and {x y : BitVec w} :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  sorry

theorem add_eq_or_add_and {x y : BitVec w} :
    x + y = (x ||| y) + (x &&& y) := by
  sorry

theorem add_eq_mul_or_neg_xor {x y : BitVec w} :
    x + y = 2 * (x ||| y) - (x ^^^ y) := by
  sorry

theorem sub_eq_add_not_add_one {x y : BitVec w} :
    x - y = x + ~~~ y + 1 := by
  rw[not_eq_neg_sub_one]
  ring

theorem sub_eq_xor_sub_mul_not_and {x y : BitVec w} :
    x - y = (x ^^^ y) - 2 * (~~~ x &&& y) := by
  sorry

theorem sub_eq_and_not_sub_not_and {x y : BitVec w} :
    x - y = (x &&& ~~~ y) - (~~~ x &&& y) := by
  sorry

theorem sub_eq_mul_and_not_sub_xor {x y : BitVec w} :
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  sorry

theorem xor_eq_or_sub_and {x y : BitVec w} :
    x ^^^ y = (x ||| y) - (x &&& y) := by
  sorry

theorem and_not_eq_or_sub {x y : BitVec w} :
    x &&& ~~~ y = (x ||| y) - y := by
  sorry

theorem and_not_eq_not_add {x y : BitVec w} :
    x &&& ~~~ y = ~~~ x + y := by
  sorry

theorem not_sub_eq_sub_sub_one {x y : BitVec w} :
    ~~~ (x - y) = y - x - 1 := by
  rw[not_eq_neg_sub_one]
  ring

theorem not_sub_eq_not_add {x y : BitVec w} :
    ~~~ (x - y) = ~~~ x + y := by
  rw[not_eq_neg_sub_one, not_eq_neg_sub_one]
  ring

theorem or_eq_and_not_add {x y : BitVec w} :
    x ||| y = (x &&& ~~~ y) + y := by
  sorry

theorem and_eq_not_or_sub_not {x y : BitVec w} :
    x &&& y = (~~~ x ||| y) - ~~~ x := by
  sorry

end Ch2Basics

end HackersDelight
