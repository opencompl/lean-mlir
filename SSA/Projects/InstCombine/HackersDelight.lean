import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.TacticAuto
import Std.Tactic.BVDecide


set_option linter.unusedTactic false
set_option linter.unreachableTactic false

namespace HackersDelight

namespace Ch2Basics

variable {x y z : BitVec 32}

/- 2–3 Inequalities among Logical and Arithmetic Expressions -/

theorem xor_ule_or :
    x ^^^ y ≤ᵤ x ||| y := by
  try alive_auto
  all_goals sorry

theorem and_ule_not_xor :
    x &&& y ≤ᵤ ~~~(x ^^^ y) := by
  try alive_auto
  all_goals sorry

def AdditionNoOverflows? (x y : BitVec w) : Prop := (x.adc y false).1

theorem or_ule_add  (h : AdditionNoOverflows? x y) :
    x ||| y ≤ᵤ x + y := by
  try alive_auto
  all_goals sorry

theorem add_ult_or (h : ¬AdditionNoOverflows? x y) :
    (x + y <ᵤ x ||| y) := by
  try alive_auto
  all_goals sorry

theorem sub_abs_ule_xor :
    (x - y).abs ≤ᵤ x ^^^ y := by
  try alive_auto
  all_goals sorry

theorem eq_iff_abs_sub_sub :
    x = y ↔ ((x - y).abs - 1).msb := by
  try alive_auto
  all_goals sorry

theorem eq_iff_not_sub_or_sub :
    x = y ↔ (~~~ (x - y ||| y - x)).msb := by
  try alive_auto
  all_goals sorry

theorem neq_iff_sub_or_sub :
    x ≠ y ↔ (x - y ||| y - x).msb := by
  try alive_auto
  all_goals sorry

theorem neq_iff_neg_sub_abs :
    x ≠ y ↔ (-(x - y).abs).msb := by
  try alive_auto
  all_goals sorry

theorem lt_iff_sub_xor_xor_and_sub_xor :
    (x <ₛ y) ↔ ((x - y) ^^^ ((x ^^^ y) &&& ((x - y) ^^^ x))).msb := by
  try alive_auto
  all_goals sorry

theorem slt_iff_and_not_or_not_xor_and_sub :
    (x <ₛ y) ↔ ((x &&& ~~~ y) ||| (~~~ (x ^^^ y) &&& (x - y))).msb := by
  try alive_auto
  all_goals sorry

theorem sle_iff_or_not_and_xor_or_not_sub :
    (x ≤ₛ y) ↔ ((x ||| ~~~ y) &&& ((x ^^^ y) ||| ~~~ (y - x))).msb := by
  try alive_auto
  all_goals sorry

theorem ult_iff_not_and_or_not_xor_and_sub :
    (x <ᵤ y) ↔ ((~~~ x &&& y) ||| (~~~ (x ^^^ y) &&& (x - y))).msb := by
  try alive_auto
  all_goals sorry

theorem ule_iff_not_or_and_xor_or_not_sub :
    (x ≤ᵤ y) ↔ ((~~~ x ||| y) &&& ((x ^^^ y) ||| ~~~ (y - x))).msb := by
  try alive_auto
  all_goals sorry

theorem eq_zero_iff_abs_sub :
    x = 0 ↔ (x.abs - 1).msb := by
  try alive_auto
  all_goals sorry

theorem eq_zero_iff_not_or_sub :
    x = 0 ↔ (~~~ (x ||| -x)).msb := by
  try alive_auto
  all_goals sorry

theorem eq_zero_iff_not_and_sub :
    x = 0 ↔ (~~~ x &&& x - 1).msb := by
  try alive_auto
  all_goals sorry

theorem neq_zero_iff_or_neg :
    x ≠ 0 ↔ (x ||| -x).msb := by
  try alive_auto
  all_goals sorry

theorem neq_zero_iff_neg_abs :
    x ≠ 0 ↔ (-(x.abs)).msb := by
  try alive_auto
  all_goals sorry

theorem slt_zero_iff :
    (x <ₛ 0) ↔ x.msb := by
  try alive_auto
  all_goals sorry

theorem sle_zero_iff_or_sub_one :
    (x ≤ₛ 0) ↔ (x ||| (x - 1)).msb := by
  try alive_auto
  all_goals sorry

theorem sle_zero_iff_or_not_sub :
    (x ≤ₛ 0) ↔ (x ||| ~~~ (-x)).msb := by
  try alive_auto
  all_goals sorry

theorem zero_slt_iff_neg_and_not :
    (0 <ₛ x) ↔ (-x &&& ~~~ x).msb := by
  try alive_auto
  all_goals sorry

theorem zero_sle_iff_neg_and_not :
    (0 ≤ₛ x) ↔ (~~~ x).msb := by
  try alive_auto
  all_goals sorry

theorem slt_iff_add_two_pow_ult_add_two_pow :
    (x <ₛ y) ↔ (x + 2 ^ (w - 1) <ₛ y + 2 ^ (w - 1)) := by
  try alive_auto
  all_goals sorry

theorem ult_iff_sub_two_pow_ult_sub_two_pow :
    (x <ᵤ y) ↔ (x - 2 ^ (w - 1) <ₛ y - 2 ^ (w - 1)) := by
  try alive_auto
  all_goals sorry

theorem slt_iff_not_add_two_pow_ule_add_two_pow :
    (x <ₛ y) ↔ ¬ ((y + 2 ^ (w - 1)) ≤ᵤ (x + 2 ^ (w - 1))) := by
  try alive_auto
  all_goals sorry

theorem sle_iff_add_two_pow_ule_add_two_pow :
    (x ≤ₛ y) ↔ (x + 2 ^ (w - 1)) ≤ᵤ (y + 2 ^ (w - 1)) := by
  try alive_auto
  all_goals sorry

theorem ult_iff_not_ule :
    (x <ᵤ y) ↔ ¬ (y ≤ᵤ x) := by
  bv_auto

theorem eq_iff_adc_not_add :
    x = y ↔ (BitVec.carry w (x) (~~~ y + 1)) false := by
  try alive_auto
  all_goals sorry

theorem neq_iff_adc_not :
    x ≠ y ↔ (BitVec.carry w (x) (~~~ y)) false := by
  try alive_auto
  all_goals sorry

theorem slt_iff_not_adc_add_sub_neg_add_sub :
    (x <ₛ y) ↔  ¬ (BitVec.carry w (x + 2 ^ (w - 1)) (~~~ (y + 2 ^ (w - 1)) + 1)) false := by
  try alive_auto
  all_goals sorry

local instance : HXor Bool Bool Bool where
  hXor := Bool.xor

theorem sle_iff_not_adc_not_add_sub_xor_sub :
    (x <ₛ y) ↔ !(BitVec.carry w x (~~~ y + 1) false ^^^ x.getMsbD (w - 1) ^^^ y.getMsbD (w - 1)) := by
  try alive_auto
  all_goals sorry

theorem sle_iff_adc_add_sub_neg_add_sub :
    (x ≤ₛ y) ↔ (BitVec.carry w (y + 2 ^ (w - 1)) (~~~ (x + 2 ^ (w - 1)) + 1)) false := by
  try alive_auto
  all_goals sorry

theorem sle_iff_adc_not_add_sub_sub :
    (x ≤ₛ y) ↔ ((BitVec.carry w y (~~~ x + 1)) false) ^^^ x.getMsbD (w - 1) ^^^ y.getMsbD (w - 1) := by
  try alive_auto
  all_goals sorry

theorem ult_iff_not_adc_not_add :
    (x <ᵤ y) ↔ ¬ (BitVec.carry w x (~~~ y + 1) false) := by
  try alive_auto
  all_goals sorry

theorem ult_iff_adc_not_add :
    (x ≤ᵤ y) ↔ (BitVec.carry w y (~~~ x + 1) false) := by
  try alive_auto
  all_goals sorry

theorem eq_zero_iff_adc_not_add :
    x = 0 ↔ (BitVec.carry w (~~~ x) 1) false := by
  try alive_auto
  all_goals sorry

theorem neq_zero_iff_adc_neg :
    x ≠ 0 ↔ (BitVec.carry w x (-1)) false := by
  try alive_auto
  all_goals sorry

theorem slt_iff_adc :
    (x <ₛ 0) ↔ (BitVec.carry w x x) false := by
  try alive_auto
  all_goals sorry

theorem sle_iff_adc_two_pow_sub_neg_add_two_pow_sub :
    (x ≤ₛ 0) ↔ (BitVec.carry w (2 ^ (w - 1)) (-(x + 2 ^ (w - 1)))) false := by
  try alive_auto
  all_goals sorry

theorem add_iff_not_ult :
    AdditionNoOverflows? x y ↔ ~~~ x <ᵤ y := by
  try alive_auto
  all_goals sorry

theorem add_iff_add_ult :
    AdditionNoOverflows? x y ↔ x + y <ᵤ x := by
  try alive_auto
  all_goals sorry

theorem add_add_iff_not_ule :
    AdditionNoOverflows? x (y + 1) ↔ ~~~ x ≤ᵤ y := by
  try alive_auto
  all_goals sorry

theorem add_add_iff_add_add_ule :
    AdditionNoOverflows? x (y + 1) ↔ x + y + 1 ≤ᵤ x := by
  try alive_auto
  all_goals sorry

theorem add_not_add_iff_ult :
    AdditionNoOverflows? x (~~~ y + 1) ↔ x <ᵤ y := by
  try alive_auto
  all_goals sorry

theorem add_not_add_iff_ult_sub :
    AdditionNoOverflows? x (~~~ y + 1) ↔ x <ᵤ x - y := by
  try alive_auto
  all_goals sorry

theorem add_not_iff_ult :
    AdditionNoOverflows? x (~~~ y) ↔ x ≤ᵤ y := by
  try alive_auto
  all_goals sorry

theorem add_not_iff_ule_sub_sub :
    AdditionNoOverflows? x (~~~ y) ↔ x ≤ᵤ x - y - 1 := by
  try alive_auto
  all_goals sorry

def UnsignedMultiplicationOverflows? (x y : BitVec w) : Prop := x.toNat * y.toNat > 2 ^ w
def SignedMultiplicationOverflows? (x y : BitVec w) : Prop := x.toInt * y.toInt > 2 ^ (w - 1)

def last32Bits (x : BitVec 64) : BitVec 32 := BitVec.ofNat 32 x.toNat
def first32Bits (x : BitVec 64) : BitVec 32 := BitVec.ofNat 32 (x >>> 32).toNat

theorem unsigned_mul_overflow_iff_mul_neq_zero {x y : BitVec 64} :
    UnsignedMultiplicationOverflows? x y ↔ first32Bits (x * y) ≠ BitVec.ofNat 32 0 := by
  try alive_auto
  all_goals sorry

theorem signed_mul_overflow_iff_mul_neq_mul_RightShift {x y : BitVec 64} :
    SignedMultiplicationOverflows? x y ↔ first32Bits (x * y) ≠ last32Bits (x * y) >>> 31 := by
  try alive_auto
  all_goals sorry

theorem mul_div_neq_imp_unsigned_mul_overflow (h : y.toNat ≠ 0) :
    (x * y) / z ≠ x → UnsignedMultiplicationOverflows? x y := by
  try alive_auto
  all_goals sorry

theorem lt_and_eq_neg_pow_two_or_mul_div_neq_imp_unsigned_mul_overflow (h : y.toNat ≠ 0) :
    (y < 0) ∧ (x.toInt = - 2 ^ 31) ∨ ((x * y) / z ≠ x) → SignedMultiplicationOverflows? x y := by
  try alive_auto
  all_goals sorry

def numberOfLeadingZeros {w : Nat} (x : BitVec w) : Nat :=
  let rec countLeadingZeros (i : Nat) (count : Nat) : Nat :=
    match i with
      | Nat.zero => count
      | Nat.succ i =>  if !x.getLsbD i then countLeadingZeros i (count + 1) else count
  countLeadingZeros w 0

theorem le_nlz_add_nlz_not_unsigned_mul_overflow {x y : BitVec 64} :
    32 ≤ numberOfLeadingZeros x + numberOfLeadingZeros y ↔ ¬ UnsignedMultiplicationOverflows? x y := by
  try alive_auto
  all_goals sorry

theorem nlz_add_nlz_le_unsigned_mul_overflow {x y : BitVec 64} :
    numberOfLeadingZeros x + numberOfLeadingZeros y ≤ 30 ↔ UnsignedMultiplicationOverflows? x y := by
  try alive_auto
  all_goals sorry

def SignedDivisionOverflows?? (x y : BitVec w) : Prop := y = 0 ∨ w ≠ 1 ∧ x = (2 ^ (w - 1)) ∧ y = -1

theorem div_overflow_iff_eq_zero_or_eq_neg_pow_two_and_eq_neg :
    SignedDivisionOverflows?? x y ↔ y = 0 ∨ ((x.toInt = -2 ^ 31) ∧ y = -1) := by
  try alive_auto
  all_goals sorry

theorem div_overflow_iff_neq_and_ult_LeftShift {x : BitVec 64} {y : BitVec 32} :
    SignedDivisionOverflows?? x (y.zeroExtend 64) ↔ y ≠ 0 ∧ x < ((y.zeroExtend 64) <<< 32) := by
  try alive_auto
  all_goals sorry

theorem div_overflow_iff_neq_and_RightShift_lt {x y : BitVec 64} {y : BitVec 32} :
    SignedDivisionOverflows?? x (y.zeroExtend 64) ↔ y ≠ 0 ∧ (x >>> 32) < (y.zeroExtend 64) := by
  try alive_auto
  all_goals sorry

def signedDifferenceOrZero (x y : BitVec w) : BitVec w :=
  if x ≥ₛ y then x - y else 0#w

def unsignedDifferenceOrZero (x y : BitVec w) : BitVec w :=
  if x ≥ᵤ y then x - y else 0#w

def unsignedMaxBitVec (x y : BitVec w) : BitVec w :=
  if x ≥ᵤ y then x else y

def unsignedMinBitVec (x y : BitVec w) : BitVec w :=
  if x ≤ᵤ y then x else y

def signedMaxBitVec (x y : BitVec w) : BitVec w :=
  if x ≥ₛ y then x else y

def signedMinBitVec (x y : BitVec w) : BitVec w :=
  if x ≤ₛ y then x else y

theorem signed_max_eq_add_doz :
    signedMaxBitVec x y = y + signedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

theorem signed_min_eq_sub_doz :
    signedMinBitVec x y = x - signedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

theorem unsigned_max_eq_add_dozu :
    unsignedMaxBitVec x y = y + unsignedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

theorem unsigned_min_eq_sub_dozu :
    unsignedMinBitVec x y = x - unsignedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

def leBitmask (x y : BitVec w) : BitVec w :=
  if y ≤ x then -1#w else 0#w

theorem signed_doz_eq_sub_and_bitmask :
   signedDifferenceOrZero x y = (x - y) &&& leBitmask x y := by
  try alive_auto
  all_goals sorry

theorem signed_max_xor_and_bitmask_xor :
    signedMaxBitVec x y = ((x ^^^ y) &&& leBitmask x y) ^^^ y := by
  try alive_auto
  all_goals sorry

theorem signed_min_xor_and_bitmask_xor :
    signedMinBitVec x y = ((x ^^^ y) &&& leBitmask y x) ^^^ y := by
  try alive_auto
  all_goals sorry

def carryBitmask (x y : BitVec w) : BitVec w :=
  if BitVec.carry w x (~~~y) false then -1#w else 0#w

theorem unsigned_doz_sub_and_not_carry :
    unsignedDifferenceOrZero x y = ((x - y) &&& ~~~ carryBitmask x y) := by
  try alive_auto
  all_goals sorry

theorem unsigned_max_eq_sub_sub_and_carry :
    unsignedMaxBitVec x y = x - ((x - y) &&& carryBitmask x y) := by
  try alive_auto
  all_goals sorry

theorem unsigned_min_eq_add_sub_and_carry :
    unsignedMinBitVec x y = y + ((x - y) &&& carryBitmask x y) := by
  try alive_auto
  all_goals sorry

section fixedWidth
variable {x y d : BitVec 32}

theorem signed_doz_and_not_xor_xor_and_and_rightShift (h : d = x - y) :
    signedDifferenceOrZero x y = d &&& (~~~ d ^^^ ((x ^^^ y) &&& (d ^^^ x)) >>> 31) := by
  try alive_auto
  all_goals sorry

theorem unsigned_doz_and_not_xor_xor_and_and_rightShift (h : d = x - y) :
    unsignedDifferenceOrZero x y = d &&& ~~~ (((~~~ x &&& y) ||| ~~~ (x ^^^ y) &&& d) >>> 31) := by
  try alive_auto
  all_goals sorry

theorem signed_doz_eq_sub_and_not_sub_rightShift :
    signedDifferenceOrZero x y = (x - y) &&& ~~~ ((x - y) >>> 31) := by
  try alive_auto
  all_goals sorry

theorem signed_max_eq_sub_sub_and_sub_rightShift :
    signedMaxBitVec x y = x - ((x - y) &&& ((x - y) >>> 31)) := by
  try alive_auto
  all_goals sorry

theorem signed_min_eq_add_sub_and_sub_rightShift :
    signedMinBitVec x y = y + ((x - y) &&& ((x - y) >>> 31)) := by
  try alive_auto
  all_goals sorry

theorem lt_sdoz_or_neg_sdoz :
    (y <ₛ x) ↔ (signedDifferenceOrZero x y ||| -(signedDifferenceOrZero x y)).msb := by
  try alive_auto
  all_goals sorry

theorem lt_udoz_or_neg_udoz :
    (y <ᵤ x) ↔ (unsignedDifferenceOrZero x y ||| -(unsignedDifferenceOrZero x y)).msb := by
  try alive_auto
  all_goals sorry

theorem carry_iff_udoz_not_or_neg_udoz_not :
    BitVec.carry w x y false ↔ (unsignedDifferenceOrZero x (~~~ y) ||| - unsignedDifferenceOrZero x (~~~ y)).msb := by
  try alive_auto
  all_goals sorry

end fixedWidth

theorem abs_sub_sdoz_add_sdoz :
    (x - y).abs = signedDifferenceOrZero x y + signedDifferenceOrZero y x := by
  try alive_auto
  all_goals sorry

theorem abs_sub_udoz_add_udoz :
    (x - y).abs = unsignedDifferenceOrZero x y + unsignedDifferenceOrZero y x := by
  try alive_auto
  all_goals sorry

theorem carry_iff_not_ult :
    BitVec.carry w x y false ↔ (~~~ y) <ᵤ x := by
  try alive_auto
  all_goals sorry

theorem sdoz_not_not_eq_sdoz :
    signedDifferenceOrZero (~~~ x) (~~~ y) = signedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

theorem udoz_not_not_eq_udoz :
    unsignedDifferenceOrZero (~~~ x) (~~~ y) = unsignedDifferenceOrZero x y := by
  try alive_auto
  all_goals sorry

end Ch2Basics

end HackersDelight
