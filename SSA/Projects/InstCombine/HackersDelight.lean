import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import SSA.Projects.InstCombine.ForMathlib
import Init.Data.Nat.Bitwise.Basic
import Init.Data.Nat.Bitwise.Lemmas

namespace HackersDelight

namespace Ch2Basics

theorem not_eq_neg_sub_one {x : BitVec w} :
    ~~~ x = -x - 1 := by
  apply BitVec.eq_sub_iff_add_eq.mpr
  rw [BitVec.neg_eq_not_add]

theorem not_and_eq_not_or_not {x y : BitVec w} :
    ~~~ (x &&& y) = ~~~ x ||| ~~~ y := by
  sorry

theorem not_or_eq_not_and_not {x y : BitVec w} :
    ~~~ (x ||| y) = ~~~ x &&& ~~~ y := by
  sorry

theorem not_add_eq_not_sub_one {x : BitVec w} :
    ~~~ (x + 1) = ~~~ x - 1 := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem not_sub_eq_not_add_one {x : BitVec w} :
    ~~~ (x - 1) = ~~~ x + 1 := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem not_xor_eq_not_xor {x y : BitVec w} :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  sorry

theorem not_add_eq_not_sub {x y : BitVec w} :
    ~~~ (x + y) = ~~~ x - y := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem not_neg_eq_not_add {x y : BitVec w} :
    ~~~ (x - y) = ~~~ x + y := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem neg_eq_not_add_one {x : BitVec w} :
    -x = ~~~ x + 1 := by
  exact BitVec.neg_eq_not_add x

theorem neg_eq_neg_not_one {x : BitVec w} :
    -x = ~~~ (x - 1) := by
  rw [not_eq_neg_sub_one]
  ring

theorem not_not {x : BitVec w} :
    ~~~ ~~~ x = x := by
  repeat rw [not_eq_neg_sub_one]
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
  rw [not_eq_neg_sub_one]
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
  rw [not_eq_neg_sub_one]
  ring

theorem not_sub_eq_not_add {x y : BitVec w} :
    ~~~ (x - y) = ~~~ x + y := by
  rw [not_eq_neg_sub_one, not_eq_neg_sub_one]
  ring

theorem not_xor_eq_and_sub_or_sub_one {x y : BitVec w} :
    ~~~ (x ^^^ y) = (x &&& y) - (x ||| y) - 1 := by
  sorry

theorem or_eq_and_not_add {x y : BitVec w} :
    x ||| y = (x &&& ~~~ y) + y := by
  sorry

theorem and_eq_not_or_sub_not {x y : BitVec w} :
    x &&& y = (~~~ x ||| y) - ~~~ x := by
  sorry

theorem xor_le_or {x y : BitVec w} :
    x ^^^ y ≤ x ||| y := by
  sorry

theorem and_le_not_xor {x y : BitVec w} :
    x &&& y ≤ ~~~(x ^^^ y) := by
  sorry

theorem or_le_add {x y : BitVec w} (h : x.toFin + y.toFin < 2^w) :
    x ||| y ≤ x + y := by
  sorry

theorem add_l_or {x y : BitVec w} (h : x.toFin + y.toFin ≥ 2^w) :
    x + y < x ||| y := by
  sorry

theorem eq_imp_abs_sub_sub {x y : BitVec w} :
    x = y ↔ ((x - y).abs - 1).getMsb 0 := by
  sorry

end Ch2Basics

end HackersDelight
