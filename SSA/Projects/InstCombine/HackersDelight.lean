import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.ForStd
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

theorem xor_ule_or :
    x ^^^ y ≤ᵤ x ||| y := by
  sorry

theorem and_ule_not_xor :
    x &&& y ≤ᵤ ~~~(x ^^^ y) := by
  sorry

def AdditionNoOverflows? (x y : BitVec w) : Prop := (x.adc y false).1

theorem or_ule_add  (h : AdditionNoOverflows? x y) :
    x ||| y ≤ᵤ x + y := by
  sorry

theorem add_ult_or (h : ¬AdditionNoOverflows? x y) :
    (x + y <ᵤ x ||| y) := by
  sorry

theorem sub_abs_ule_xor :
    (x - y).abs ≤ᵤ x ^^^ y := by
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

theorem neq_iff_neg_sub_abs :
    x ≠ y ↔ (-(x - y).abs).getMsb 0 := by
  sorry

theorem lt_iff_sub_xor_xor_and_sub_xor :
    (x <ₛ y) ↔ ((x - y) ^^^ ((x ^^^ y) &&& ((x - y) ^^^ x))).getMsb 0 := by
  sorry

theorem slt_iff_and_not_or_not_xor_and_sub :
    (x <ₛ y) ↔ ((x &&& ~~~ y) ||| (~~~ (x ^^^ y) &&& (x - y))).getMsb 0 := by
  sorry

theorem sle_iff_or_not_and_xor_or_not_sub :
    (x ≤ₛ y) ↔ ((x ||| ~~~ y) &&& ((x ^^^ y) ||| ~~~ (y - x))).getMsb 0 := by
  sorry

theorem ult_iff_not_and_or_not_xor_and_sub :
    (x <ᵤ y) ↔ ((~~~ x &&& y) ||| (~~~ (x ^^^ y) &&& (x - y))).getMsb 0 := by
  sorry

theorem ule_iff_not_or_and_xor_or_not_sub :
    (x ≤ᵤ y) ↔ ((~~~ x ||| y) &&& ((x ^^^ y) ||| ~~~ (y - x))).getMsb 0 := by
  sorry

theorem eq_zero_iff_abs_sub :
    x = 0 ↔ (x.abs - 1).getMsb 0 := by
  sorry

theorem eq_zero_iff_not_or_sub :
    x = 0 ↔ (~~~ (x ||| -x)).getMsb 0 := by
  sorry

theorem eq_zero_iff_not_and_sub :
    x = 0 ↔ (~~~ x &&& x - 1).getMsb 0 := by
  sorry

theorem neq_zero_iff_or_neg :
    x ≠ 0 ↔ (x ||| -x).getMsb 0 := by
  sorry

theorem neq_zero_iff_neg_abs :
    x ≠ 0 ↔ (-(x.abs)).getMsb 0 := by
  sorry

theorem slt_zero_iff :
    (x <ₛ 0) ↔ x.getMsb 0 := by
  sorry

theorem sle_zero_iff_or_sub_one :
    (x ≤ₛ 0) ↔ (x ||| (x - 1)).getMsb 0 := by
  sorry

theorem sle_zero_iff_or_not_sub :
    (x ≤ₛ 0) ↔ (x ||| ~~~ (-x)).getMsb 0 := by
  sorry

theorem zero_slt_iff_neg_and_not :
    (0 <ₛ x) ↔ (-x &&& ~~~ x).getMsb 0 := by
  sorry

theorem zero_sle_iff_neg_and_not :
    (0 ≤ₛ x) ↔ (~~~ x).getMsb 0 := by
  sorry

theorem slt_iff_add_two_pow_ult_add_two_pow :
    (x <ₛ y) ↔ (x + 2 ^ (w - 1) <ₛ y + 2 ^ (w - 1)) := by
  sorry

theorem ult_iff_sub_two_pow_ult_sub_two_pow :
    (x <ᵤ y) ↔ (x - 2 ^ (w - 1) <ₛ y - 2 ^ (w - 1)) := by
  sorry

theorem slt_iff_not_add_two_pow_ule_add_two_pow :
    (x <ₛ y) ↔ ¬ ((y + 2 ^ (w - 1)) ≤ᵤ (x + 2 ^ (w - 1))) := by
  sorry

theorem sle_iff_add_two_pow_ule_add_two_pow :
    (x ≤ₛ y) ↔ (x + 2 ^ (w - 1)) ≤ᵤ (y + 2 ^ (w - 1)) := by
  sorry

theorem ult_iff_not_ule :
    (x <ᵤ y) ↔ ¬ (y ≤ᵤ x) := by
  sorry

theorem eq_iff_adc_not_add :
    x = y ↔ (BitVec.carry w (x) (~~~ y + 1)) false := by
  sorry

theorem neq_iff_adc_not :
    x ≠ y ↔ (BitVec.carry w (x) (~~~ y)) false := by
  sorry

theorem slt_iff_not_adc_add_sub_neg_add_sub :
    (x <ₛ y) ↔  ¬ (BitVec.carry w (x + 2 ^ (w - 1)) (~~~ (y + 2 ^ (w - 1)) + 1)) false := by
  sorry

local instance : HXor Bool Bool Bool where
  hXor := Bool.xor

theorem sle_iff_not_adc_not_add_sub_xor_sub :
    (x <ₛ y) ↔ !(BitVec.carry w x (~~~ y + 1) false ^^^ x.getMsb (w - 1) ^^^ y.getMsb (w - 1)) := by
  sorry

theorem sle_iff_adc_add_sub_neg_add_sub :
    (x ≤ₛ y) ↔ (BitVec.carry w (y + 2 ^ (w - 1)) (~~~ (x + 2 ^ (w - 1)) + 1)) false := by
  sorry

theorem sle_iff_adc_not_add_sub_sub :
    (x ≤ₛ y) ↔ ((BitVec.carry w (y) (~~~ x + 1)) false) ^^^ x.getMsb (w - 1) ^^^ y.getMsb (w - 1) := by
  sorry

theorem ult_iff_not_adc_not_add :
    (x <ᵤ y) ↔ ¬ (BitVec.carry w x (~~~ y + 1) false) := by
  sorry

theorem ult_iff_adc_not_add :
    (x ≤ᵤ y) ↔ (BitVec.carry w y (~~~ x + 1) false) := by
  sorry

theorem eq_zero_iff_adc_not_add :
    x = 0 ↔ (BitVec.carry w (~~~ x) 1) false := by
  sorry

theorem neq_zero_iff_adc_neg :
    x ≠ 0 ↔ (BitVec.carry w x (-1)) false := by
  sorry

theorem slt_iff_adc :
    (x <ₛ 0) ↔ (BitVec.carry w x x) false := by
  sorry

theorem sle_iff_adc_two_pow_sub_neg_add_two_pow_sub :
    (x ≤ₛ 0) ↔ (BitVec.carry w (2 ^ (w - 1)) (-(x + 2 ^ (w - 1)))) false := by
  sorry

end Ch2Basics

end HackersDelight
