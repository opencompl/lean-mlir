import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import SSA.Projects.InstCombine.ForMathlib
import Init.Data.Nat.Bitwise.Basic
import Init.Data.Nat.Bitwise.Lemmas

namespace HackersDelight

namespace Ch2Basics

variable {x y : BitVec w}

theorem not_eq_neg_sub_one :
    ~~~ x = -x - 1 := by
  apply BitVec.eq_sub_iff_add_eq.mpr
  rw [BitVec.neg_eq_not_add]

theorem not_and_eq_not_or_not :
    ~~~ (x &&& y) = ~~~ x ||| ~~~ y := by
  sorry

theorem not_or_eq_not_and_not :
    ~~~ (x ||| y) = ~~~ x &&& ~~~ y := by
  sorry

theorem not_add_eq_not_sub_one :
    ~~~ (x + 1) = ~~~ x - 1 := by
  simp only [not_eq_neg_sub_one]
  ring

theorem not_sub_eq_not_add_one :
    ~~~ (x - 1) = ~~~ x + 1 := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem not_xor_eq_not_xor :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  sorry

theorem not_add_eq_not_sub :
    ~~~ (x + y) = ~~~ x - y := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem not_sub_eq_not_add :
    ~~~ (x - y) = ~~~ x + y := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem neg_eq_not_add_one :
    -x = ~~~ x + 1 := by
  exact BitVec.neg_eq_not_add x

theorem neg_eq_neg_not_one :
    -x = ~~~ (x - 1) := by
  rw [not_eq_neg_sub_one]
  ring

theorem not_not :
    ~~~ ~~~ x = x := by
  repeat rw [not_eq_neg_sub_one]
  ring

theorem neg_not_eq_add_one :
    - ~~~ x = x + 1 := by
  rw [BitVec.neg_eq_not_add, not_not]

theorem not_neg_eq_sub_one :
    ~~~ (-x) = x - 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem add_eq_sub_not_sub_one :
    x + y = x - ~~~ y - 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem add_eq_xor_add_mul_and :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  sorry

theorem add_eq_or_add_and :
    x + y = (x ||| y) + (x &&& y) := by
  sorry

theorem add_eq_mul_or_neg_xor :
    x + y = 2 * (x ||| y) - (x ^^^ y) := by
  sorry

theorem sub_eq_add_not_add_one :
    x - y = x + ~~~ y + 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem sub_eq_xor_sub_mul_not_and :
    x - y = (x ^^^ y) - 2 * (~~~ x &&& y) := by
  sorry

theorem sub_eq_and_not_sub_not_and :
    x - y = (x &&& ~~~ y) - (~~~ x &&& y) := by
  sorry

theorem sub_eq_mul_and_not_sub_xor :
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  sorry

theorem xor_eq_or_sub_and :
    x ^^^ y = (x ||| y) - (x &&& y) := by
  sorry

theorem and_not_eq_or_sub :
    x &&& ~~~ y = (x ||| y) - y := by
  sorry

theorem and_not_eq_not_add :
    x &&& ~~~ y = ~~~ x + y := by
  sorry

theorem not_sub_eq_sub_sub_one :
    ~~~ (x - y) = y - x - 1 := by
  rw [not_eq_neg_sub_one]
  ring

theorem not_xor_eq_and_sub_or_sub_one :
    ~~~ (x ^^^ y) = (x &&& y) - (x ||| y) - 1 := by
  sorry

theorem or_eq_and_not_add :
    x ||| y = (x &&& ~~~ y) + y := by
  sorry

theorem and_eq_not_or_sub_not :
    x &&& y = (~~~ x ||| y) - ~~~ x := by
  sorry

theorem xor_le_or :
    x ^^^ y ≤ x ||| y := by
  sorry

theorem and_le_not_xor :
    x &&& y ≤ ~~~(x ^^^ y) := by
  sorry

def AdditionNoOverflows? (x y : BitVec w) : Prop := (x.adc y false).1

theorem or_le_add  (h : AdditionNoOverflows? x y) :
    x ||| y ≤ x + y := by
  sorry

theorem add_lt_or (h : ¬AdditionNoOverflows? x y) :
    x + y < x ||| y := by
  sorry

theorem eq_iff_abs_sub_sub :
    x = y ↔ ((x - y).abs - 1).getMsb 0 := by
  sorry

theorem eq_iff_not_sub_or_sub :
    x = y ↔ (~~~ (x - y ||| y - x)).getMsb 0 := by
  sorry

theorem neq_iff_sub_or_sub :
    x ≠ y ↔ (x - y ||| y - x).getMsb 0 := by
  sorry

theorem lt_iff_sub_xor_xor_and_sub_xor :
    x < y ↔ ((x - y) ^^^ ((x ^^^ y) &&& ((x - y) ^^^ x))).getMsb 0 := by
  sorry

theorem lt_iff_and_not_or_not_xor_and_sub :
    x < y ↔ ((x &&& ~~~ y) ||| (~~~ (x ^^^ y) &&& (x - y))).getMsb 0 := by
  sorry

theorem le_iff_or_not_and_xor_or_not_sub :
    x ≤ y ↔ ((x ||| ~~~ y) &&& ((x ^^^ y) ||| ~~~ (y - x))).getMsb 0 := by
  sorry

end Ch2Basics

end HackersDelight
