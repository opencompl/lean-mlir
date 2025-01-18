import Mathlib.Data.Nat.Size -- TODO: remove and get rid of shiftLeft_eq_mul_pow use
import SSA.Projects.InstCombine.LLVM.Semantics
import Mathlib.Tactic.Ring
import Mathlib.Data.BitVec

#check BitVec.toInt_eq_toNat_of_msb

theorem toInt_lt {w : Nat} (x : BitVec w) : x.toInt < 2 ^ (w - 1) := by
  simp only [BitVec.toInt, Nat.cast_pow]
  by_cases hw : w = 0
  · subst hw
    simp [BitVec.eq_nil x]
  · rw [←Nat.two_pow_pred_add_two_pow_pred (by omega), ←Nat.two_mul]
    split
    case neg.isTrue h =>
      norm_cast
      omega
    case neg.isFalse h =>
      rw [sub_lt_iff_lt_add]
      norm_cast
      omega

theorem le_toInt {w : Nat} (x : BitVec w) : -2 ^ (w - 1) ≤ x.toInt := by
  simp only [BitVec.toInt, Nat.cast_pow]
  by_cases hw : w = 0
  · subst hw
    simp [BitVec.eq_nil x]
  · rw [←Nat.two_pow_pred_add_two_pow_pred (by omega), ←Nat.two_mul]
    simp only [zero_lt_two, mul_lt_mul_left, Nat.cast_ofNat]
    split
    case neg.isTrue h =>
      norm_cast
      omega
    case neg.isFalse h =>
      simp only [neg_le_sub_iff_le_add]
      norm_cast
      rw [←Nat.two_pow_pred_add_two_pow_pred (by omega), ←Nat.two_mul]
      omega

theorem toInd_add_toInt_lt_two_pow (x y : BitVec w) :
    (x.toInt + y.toInt) < 2 ^ w := by
  by_cases hw : w = 0
  · subst hw
    simp [BitVec.eq_nil x, BitVec.eq_nil y]
  · norm_cast
    rw [←Nat.two_pow_pred_add_two_pow_pred (by omega)]
    have hx := toInt_lt x
    have hy := toInt_lt y
    push_cast
    omega

theorem neg_two_pow_le_toInd_add_toInt (x y : BitVec w) :
    - 2 ^ w ≤ x.toInt + y.toInt := by
  by_cases hw : w = 0
  · subst hw
    simp [BitVec.eq_nil x, BitVec.eq_nil y]
  · norm_cast
    rw [←Nat.two_pow_pred_add_two_pow_pred (by omega)]
    have hx := le_toInt x
    have hy := le_toInt y
    push_cast
    omega

theorem bmod_pos_iff_of_pos_lt {x : Int} {y : Nat} (h1 : 0 ≤ x) (h2 : x < y) :
    0 ≤ (x.bmod y) ↔ x < (y + 1) / 2 := by
  simp [Int.bmod_def]
  rw [Int.emod_eq_of_lt (by omega) (by omega)]
  split
  · omega
  · omega

theorem bmod_neg_iff_of_pos_lt {x : Int} {y : Nat} (h1 : 0 ≤ x) (h2 : x < y) :
    (x.bmod y) < 0 ↔ (y + 1) / 2 ≤ x := by
  simp [Int.bmod_def]
  rw [Int.emod_eq_of_lt (by omega) (by omega)]
  split
  · omega
  · omega

theorem bmod_pos_iff_of_neg_gt {x : Int} {y : Nat} (h1 : x < 0) (h2 : -y ≤ x) :
    0 ≤ (x.bmod y) ↔ x ≤ -(y + 1) / 2 := by
  simp [Int.bmod_def]
  rw [Int.emod_eq_add_self_emod]
  rw [Int.emod_eq_of_lt (by  omega) (by omega)]
  split
  · omega
  · omega

theorem two_pow_add_one_div_two {w : Nat} : (2 ^ w + 1) / 2 = 2 ^ (w - 1) := by
  cases hw : w
  · decide
  · rw [← Nat.two_pow_pred_add_two_pow_pred (by omega)]
    omega

/--
        -4 -3 -2 -1  0  1  2  3
bmod 4   0  1 -2 -1  0  1 -2 -1
-/
theorem bmod_pos_iff {w : Nat} {x : Int} (h1 : x < 2^w) (h2 : -(2^w) ≤ x) :
    0 ≤ (x.bmod (2^w)) ↔ 2 * x < -(2^w) ∨ (0 ≤ x ∧ 2 * x < 2^w) := by
  simp only [Int.bmod_def, Nat.cast_pow, Nat.cast_ofNat]
  by_cases xpos : 0 ≤ x
  · rw [Int.emod_eq_of_lt (by omega) (by omega)]
    omega
  · rw [Int.emod_eq_add_self_emod, Int.emod_eq_of_lt (by omega) (by omega)]
    omega

theorem bmod_two_pow_neg_iff {w : Nat} {x : Int} (h1 : x < 2 ^ w) (h2 : -(2 ^ w) ≤ x) :
    (x.bmod (2 ^ w)) < 0 ↔ (-(2 ^ w) ≤ 2 * x ∧ x < 0) ∨ (2 ^ w ≤ 2 * x) := by
  simp only [Int.bmod_def, Nat.cast_pow, Nat.cast_ofNat]
  by_cases xpos : 0 ≤ x
  · rw [Int.emod_eq_of_lt (by omega) (by omega)]
    omega
  · rw [Int.emod_eq_add_self_emod, Int.emod_eq_of_lt (by omega) (by omega)]
    omega

theorem bmod_neg_iff_of_neg_gt {x : Int} {y : Nat} (h1 : x < 0) (h2 : -y ≤ x) :
    (x.bmod y) < 0 ↔ - y - 1 < x * 2 := by
  simp [Int.bmod_def]
  rw [Int.emod_eq_add_self_emod]
  rw [Int.emod_eq_of_lt (by  omega) (by omega)]
  split
  · omega
  · omega

theorem uadd_overflow_eq {w : Nat} (x y : BitVec w) :
    uadd_overflow x y = BitVec.carry w x y false := by
  simp only [uadd_overflow, BitVec.carry]
  by_cases h : 2 ^ w ≤ x.toNat + y.toNat <;> simp [h]

theorem sadd_overflow_eq {w : Nat} (x y : BitVec w) :
    sadd_overflow x y = true ↔ x.msb = y.msb ∧ ¬(x + y).msb = x.msb := by
  simp only [sadd_overflow]
  by_cases h: w = 0
  · subst w; revert x y; decide
  · have := le_toInt x
    have := le_toInt y
    have := toInt_lt y
    have := toInt_lt x
    have := toInd_add_toInt_lt_two_pow x y
    have := neg_two_pow_le_toInd_add_toInt x y
    simp only [ge_iff_le, Bool.or_eq_true, decide_eq_true_eq, BitVec.msb_eq_toInt,
      decide_eq_decide, BitVec.toInt_add]
    rw [bmod_two_pow_neg_iff (by omega) (by omega)]
    rw_mod_cast [← @Nat.two_pow_pred_add_two_pow_pred w (by omega)] at *
    omega

theorem smul_overflow_eq {w : Nat} (x y : BitVec w) :
    smul_overflow x y = true ↔ ((y.zeroExtend (w * 2) * x.zeroExtend (w * 2)) <ₛ (BitVec.twoPow w (w - 1)).signExtend (w * 2)) ∨ (y.zeroExtend (w * 2) * x.zeroExtend (w * 2)) ≥ₛ (BitVec.twoPow (w * 2) (w - 1)) := by
  simp [smul_overflow]

  sorry

theorem umul_overflow_eq {w : Nat} (x y : BitVec w) :
    umul_overflow x y ↔ ((0 < w) ∧ BitVec.twoPow (2 * w) w ≤ x.zeroExtend (2 * w) * y.zeroExtend (2 * w)) := by
  simp only [umul_overflow, ge_iff_le, decide_eq_true_eq, BitVec.truncate_eq_setWidth, LE.le]
  simp only [Nat.le_eq, BitVec.toNat_twoPow, BitVec.toNat_mul, BitVec.toNat_setWidth,
    Nat.mul_mod_mod, Nat.mod_mul_mod]
  by_cases w0 : w = 0
  · subst w0
    decide +revert
  have h : x.toNat * y.toNat < 2 ^ (2 * w) := by
    have ltx := BitVec.isLt x
    have lty := BitVec.isLt y
    have lt_mul := @Nat.mul_lt_mul_of_le_of_lt x.toNat (2^w) y.toNat (2^w) (by omega) (by omega) (by omega)
    rw [← Nat.pow_add] at lt_mul
    rw [← Nat.mul_two] at lt_mul
    rw [← Nat.mul_comm 2 w] at lt_mul
    apply lt_mul
  rw [Nat.mod_eq_of_lt h]
  rw [Nat.mod_eq_of_lt ((@Nat.pow_lt_pow_iff_right 2 w (2*w) (by omega)).mpr (by omega))]
  omega

namespace Nat

theorem eq_one_mod_two_of_ne_zero (n : Nat) (h : n % 2 != 0) : n % 2 = 1 := by
  simp only [bne_iff_ne, ne_eq, mod_two_ne_zero] at h
  assumption

theorem sub_mod_of_lt (n x : Nat) (hxgt0 : x > 0) (hxltn : x < n) : (n - x) % n = n - x := by
  rcases n with rfl | n <;> simp
  omega

theorem two_pow_pred_sub_two_pow {w : Nat} (h : 0 < w) :
    2 ^ (w - 1) - 2 ^ w = - 2 ^ (w - 1) := by
  norm_cast
  rw [← Nat.two_pow_pred_add_two_pow_pred h, Int.subNatNat_eq_coe]
  simp

@[simp]
theorem one_mod_two_pow_eq {n : Nat} (hn : n ≠ 0) : 1 % 2 ^ n = 1 := by
  rw [Nat.mod_eq_of_lt (Nat.one_lt_pow hn (by decide))]

-- Given (a, b) that are less than a modulus m, to show (a + b) % m < k, it
-- suffices to consider two cases.
-- This theorem allows one to case split a '(a + b) % m < k' into two cases
-- Case 1: if (a + b) < m, then the inequality staightforwardly holds, as (a + b) < k
-- Case 2: if (a + b) ≥ m, then (a + b) % m = (a + b - m), and the inequality
-- holds as (a + b - m) < k
lemma cases_of_lt_mod_add {a b m k : ℕ} (hsum : (a + b) % m < k)  (ha : a < m) (hb : b < m) :
  ((a + b) < m ∧ (a + b) < k) ∨ ((a + b ≥ m) ∧ (a + b) < m + k) := by
  by_cases ha_plus_b_lt_m : (a + b) < m
  · left
    constructor
    · exact ha_plus_b_lt_m
    · rw [Nat.mod_eq_of_lt ha_plus_b_lt_m] at hsum
      exact hsum
  · right
    constructor
    · omega
    · have ha_plus_b_lt_2m : (a + b) < 2 * m := by omega
      have ha_plus_b_minus_m_lt_m : (a + b) - m < m := by omega
      have hmod : ((a + b) - m) % m = (a + b) % m := by
        rw [← Nat.mod_eq_sub_mod (by omega)]
      rw [Nat.mod_eq_of_lt (by omega)] at hmod
      omega

theorem mod_eq_if {a b : Nat} : a % b = if 0 ≤ a ∧ a < b then a else (if b ≤ a ∧ a < 2 * b then a - b else a % b) := by
  rw [Nat.mod_def a b]
  simp only [Nat.zero_le, true_and]
  by_cases h : a < b
  · simp only [h, ↓reduceIte]
    have : a / b = 0 := Nat.div_eq_of_lt h
    simp only [this, Nat.mul_zero, Nat.sub_zero]
  · simp [h]
    simp only [show b ≤ a by omega, true_and]
    by_cases h₂ : a < 2 * b
    · simp [h₂]
      have : a / b = 1 := by
        rw [Nat.div_eq]
        simp only [show 0 < b by omega, true_and]
        simp only [show b ≤ a by omega, ↓reduceIte, Nat.reduceEqDiff]
        apply Nat.div_eq_of_lt (by omega)
      simp [this]
    · simp [h₂]

@[simp]
theorem mod_two_pow_mod_two (x : Nat) (w : Nat) (_ : 0 < w) : x % 2 ^ w % 2 = x % 2 := by
  have y : 2 ^ 1 ∣ 2 ^ w := Nat.pow_dvd_pow 2 (by omega)
  rw [pow_one 2] at y
  exact Nat.mod_mod_of_dvd x y

theorem two_le_add_iff_odd_and_odd (n m : Nat) :
    2 ≤ n % 2 + m % 2 ↔ n % 2 = 1 ∧ m % 2 = 1 := by
  omega

theorem add_odd_iff_neq (n m : Nat) :
    (n + m) % 2 = 1 ↔ (n % 2 = 1) ≠ (m % 2 = 1) := by
  cases' Nat.mod_two_eq_zero_or_one n with nparity nparity
  <;> cases' Nat.mod_two_eq_zero_or_one m with mparity mparity
  <;> simp [mparity, nparity, Nat.add_mod]

end Nat

namespace BitVec

@[simp]
theorem replicate_one {w : Nat} : BitVec.replicate w 1#1 = BitVec.cast (by simp) (allOnes w) := by
  ext i
  simp
  omega

@[simp]
theorem replicate_zero {w : Nat} : BitVec.replicate w 0#1 = BitVec.cast (by simp) (0#w) := by
  ext i
  simp

theorem abs_eq_add_xor {x : BitVec w} :
    have y : BitVec w := BitVec.cast (by simp) (BitVec.replicate w (BitVec.ofBool x.msb))
    x.abs = (x + y) ^^^ y := by
  simp only [BitVec.abs, neg_eq]
  by_cases h: x.msb
  · simp [h, ← allOnes_sub_eq_not]
  · simp [h]

@[simp, bv_toNat]
lemma toNat_shiftLeft' (A B : BitVec w) :
    BitVec.toNat (A <<< B) = (BitVec.toNat A) * 2 ^ BitVec.toNat B % 2 ^w := by
  simp only [HShiftLeft.hShiftLeft]
  simp only [shiftLeft_eq, toNat_shiftLeft]
  simp only [toNat_shiftLeft, Nat.shiftLeft_eq_mul_pow]

lemma one_shiftLeft_mul_eq_shiftLeft {A B : BitVec w} :
    (1 <<< B * A) = (A <<< B) := by
  apply BitVec.eq_of_toNat_eq
  simp only [bv_toNat, Nat.mod_mul_mod, one_mul]
  rw [Nat.mul_comm]

def msb_allOnes {w : Nat} (h : 0 < w) : BitVec.msb (allOnes w) = true := by
  simp only [BitVec.msb, getMsbD, allOnes]
  simp only [getLsbD_ofNatLt, Nat.testBit_two_pow_sub_one, Bool.and_eq_true,
    decide_eq_true_eq]
  rw [Nat.sub_lt_iff_lt_add] <;> omega

-- @[simp]
def neg_allOnes {w : Nat} : -(allOnes w) = (1#w) := by
  simp only [toNat_eq, toNat_neg, toNat_allOnes, toNat_ofNat]
  cases w
  case zero => rfl
  case succ w =>
    rw [Nat.sub_sub_self]
    apply Nat.one_le_pow (h := by decide)

theorem udiv_one_eq_self (w : Nat) (x : BitVec w) : x.udiv 1#w = x := by
  by_cases h : w = 0
  · subst h
    simp [eq_nil x]
  · simp_all [bv_toNat]

theorem udiv_eq_zero_iff {x y : BitVec w} (h : 0#w < y) : udiv x y = 0#w ↔ x < y := by
  simp_all [bv_toNat, Nat.div_eq_zero_iff, h]
  omega

@[simp]
theorem udiv_eq_zero {x y : BitVec w} (h : x < y) : udiv x y = 0#w := by
  rw [udiv_eq_zero_iff]
  · simp_all only [lt_def]
  · simp_all only [lt_def, toNat_ofNat, Nat.zero_mod]
    omega

def sdiv_one_allOnes {w : Nat} (h : 1 < w) :
    BitVec.sdiv (1#w) (BitVec.allOnes w) = BitVec.allOnes w := by
  simp only [BitVec.sdiv]
  simp only [msb_one, neg_eq, @msb_allOnes w (by omega)]
  simp only [neg_allOnes]
  simp only [udiv_one_eq_self]
  simp only [negOne_eq_allOnes]
  have : ¬ (w = 1) := by omega
  simp [this]

theorem sub_eq_add_neg {w : Nat} {x y : BitVec w} : x - y = x + (- y) := by
  simp only [HAdd.hAdd, HSub.hSub, Neg.neg, Sub.sub, BitVec.sub, Add.add, BitVec.add]
  simp [BitVec.ofNat, Fin.ofNat', add_comm]

open BitVec

lemma toNat_neq_of_neq_ofNat {a : BitVec w} {n : Nat} (h : a ≠ BitVec.ofNat w n) : a.toNat ≠ n := by
  intros haeq
  have hn : n < 2 ^ w := by
    rw [← haeq]
    apply BitVec.isLt
  have hcontra : a = BitVec.ofNat w n := by
    apply BitVec.eq_of_toNat_eq
    simp only [haeq, toNat_ofNat]
    rw [Nat.mod_eq_of_lt hn]
  contradiction

lemma gt_one_of_neq_0_neq_1 (a : BitVec w) (ha0 : a ≠ 0) (ha1 : a ≠ 1) : a > 1 := by
  simp only [ofNat_eq_ofNat, gt_iff_lt, lt_def, toNat_ofNat]
  simp only [ofNat_eq_ofNat, ne_eq] at ha0 ha1
  cases w
  case zero =>
    simp only [reduceOfNat] at ha0 ha1
    simp [BitVec.eq_nil a] at ha0
  case succ w' =>
    simp only [ne_eq, add_eq_zero, one_ne_zero, and_false, not_false_eq_true,
      Nat.one_mod_two_pow_eq]
    have ha0' : a.toNat ≠ 0 := toNat_neq_of_neq_ofNat ha0
    have ha1' : a.toNat ≠ 1 := toNat_neq_of_neq_ofNat ha1
    omega

def one_sdiv { w : Nat} {a : BitVec w} (ha0 : a ≠ 0) (ha1 : a ≠ 1)
    (hao : a ≠ allOnes w) :
    BitVec.sdiv (1#w) a = 0#w := by
  rcases w with ⟨rfl | ⟨rfl | w⟩⟩
  case zero => simp [BitVec.eq_nil a]
  case succ w' =>
    cases w'
    case zero =>
      rcases eq_zero_or_eq_one a with ⟨rfl | rfl⟩ <;> (simp only [Nat.reduceAdd, ofNat_eq_ofNat, ne_eq,
        not_true_eq_false] at ha0)
      case inr h => subst h; contradiction
    case succ w' =>
      simp only [BitVec.sdiv, lt_add_iff_pos_left, add_pos_iff, zero_lt_one,
        or_true, msb_one, neg_eq]
      by_cases h : a.msb <;> simp [h]
      · rw [← BitVec.udiv_eq, BitVec.udiv_eq_zero]
        apply BitVec.gt_one_of_neq_0_neq_1
        · rw [neg_ne_iff_ne_neg]
          simp only [_root_.neg_zero]
          assumption
        · rw [neg_ne_iff_ne_neg]
          rw [← negOne_eq_allOnes] at hao
          assumption
      · rw [← BitVec.udiv_eq, BitVec.udiv_eq_zero]
        apply BitVec.gt_one_of_neq_0_neq_1 <;> assumption

def sdiv_one_one : BitVec.sdiv 1#w 1#w = 1#w := by
  by_cases w_0 : w = 0; subst w_0; rfl
  by_cases w_1 : w = 1; subst w_1; rfl
  unfold BitVec.sdiv
  unfold BitVec.udiv
  simp only [msb_one, w_1, decide_false, toNat_ofNat, ne_eq, w_0, not_false_eq_true,
    Nat.one_mod_two_pow_eq, zero_lt_one, Nat.div_self]
  apply BitVec.eq_of_toNat_eq
  simp
  have hone : 1 % 2 ^ w = 1 := by
    apply Nat.mod_eq_of_lt
    simp
    omega
  simp [hone]

-- @[simp bv_toNat]
lemma toNat_neq_zero_of_neq_zero {x : BitVec w} (hx : x ≠ 0) : x.toNat ≠ 0 := by
  intro h
  apply hx
  apply BitVec.eq_of_toNat_eq
  simp [h]

lemma eq_zero_of_toNat_mod_eq_zero {x : BitVec w} (hx : x.toNat % 2^w = 0) : x = 0 := by
  obtain ⟨x, xlt⟩ := x
  simp only [toNat_ofFin] at hx
  rw [Nat.mod_eq_of_lt xlt] at hx
  subst hx
  rfl

theorem toNat_one (hw : w ≠ 0 := by omega): BitVec.toNat (1 : BitVec w) = 1 := by
  simp only [ofNat_eq_ofNat, toNat_ofNat]
  apply Nat.mod_eq_of_lt
  apply Nat.one_lt_pow <;> omega

theorem intMin_eq_one {w : Nat} (hw : w ≤ 1): BitVec.intMin w = 1 := by
  cases w
  · rfl
  · case succ w' =>
    cases w'
    · rfl
    · case succ w' =>
      contradiction

theorem intMin_neq_one {w : Nat} (h : w > 1): BitVec.intMin w ≠ 1 := by
  have h' : w > 0 := by omega
  simp [bv_toNat, h']
  rw [← Nat.two_pow_pred_add_two_pow_pred (by omega)]
  omega

/- Not a simp lemma by default because we may want toFin or toInt in the future. -/
theorem ult_toNat (x y : BitVec n) :
    (BitVec.ult (n := n) x y) = decide (x.toNat < y.toNat) := by
  simp [BitVec.ult]

theorem getLsb_geX(x : BitVec w) (hi : i ≥ w) :
    BitVec.getLsbD x i = false := by
  have rk : _ := @BitVec.getLsbD_ge w x i hi
  apply rk

theorem intMin_slt_zero (h : 0 < w) :
    BitVec.slt (intMin w) 0 := by
  simp only [BitVec.slt, toInt_intMin, Int.ofNat_emod, Nat.cast_pow, Nat.cast_ofNat, ofNat_eq_ofNat,
    toInt_zero, Left.neg_neg_iff, decide_eq_true_eq]
  norm_cast
  simp [h]

theorem neg_sgt_eq_slt_neg {A B : BitVec w} (h : A ≠ intMin w) (h2 : B ≠ intMin w) :
    (-A >ₛ B) = (A <ₛ -B) := by
  unfold BitVec.slt
  simp only [decide_eq_decide, toInt_neg_of_ne_intMin h, toInt_neg_of_ne_intMin h2]
  omega

theorem sgt_zero_eq_not_neg_sgt_zero (A : BitVec w) (h_ne_intMin : A ≠ intMin w)
    (h_ne_zero : A ≠ 0) : (A >ₛ 0#w) ↔ ¬ ((-A) >ₛ 0#w) := by
  by_cases w0 : w = 0
  · subst w0
    simp [BitVec.eq_nil A] at h_ne_zero
  simp only [Bool.not_eq_true, Bool.coe_true_iff_false]
  rw [neg_sgt_eq_slt_neg h_ne_intMin _]
  unfold BitVec.slt
  by_cases h : A.toInt < 0
  · simp [h]
    omega
  · simp only [toInt_zero, neg_zero, h, decide_false, Bool.not_false, decide_eq_true_eq]
    simp only [ofNat_eq_ofNat, ne_eq, ← toInt_ne, toInt_zero] at h_ne_zero
    omega
  simp only [ne_eq]
  simp only [bv_toNat]
  have h : 0 < w := by omega
  simp only [Nat.zero_mod, h, Nat.two_pow_pred_mod_two_pow, ne_eq]
  have two_pow_pos := Nat.two_pow_pos (w-1)
  omega

theorem sgt_same (A : BitVec w) : ¬ (A >ₛ A) := by
  simp [BitVec.slt]

private theorem intMin_lt_zero (h : 0 < w): intMin w <ₛ 0 := by
  unfold BitVec.slt
  simp only [toInt_intMin, ofNat_eq_ofNat, toInt_zero, Left.neg_neg_iff, decide_eq_true_eq]
  norm_cast
  rw [Nat.two_pow_pred_mod_two_pow (by omega)]
  exact Nat.two_pow_pos (w-1)

private theorem not_gt_eq_le (A B : BitVec w) : (¬ (A >ₛ B)) = (A ≤ₛ B) := by
  simp [BitVec.slt, BitVec.sle]

private theorem sge_eq_sle (A B : BitVec w) : (A ≥ₛ B) = (B ≤ₛ A) := by
  simp [BitVec.sle]

private theorem sge_of_sgt (A B : BitVec w) : (A >ₛ B) → (A ≥ₛ B) := by
  simp only [BitVec.slt, decide_eq_true_eq, BitVec.sle]
  omega

theorem intMin_not_gt_zero : ¬ (intMin w >ₛ (0#w)):= by
  by_cases h : w = 0
  · subst h
    simp [of_length_zero]
  · simp only [not_gt_eq_le, sge_eq_sle]
    rw [sge_of_sgt]
    apply intMin_lt_zero
    omega

@[simp]
lemma carry_and_xor_false : carry i (a &&& b) (a ^^^ b) false = false := by
  induction i
  case zero =>
    simp [carry, Nat.mod_one]
  case succ v v_h =>
    simp only [carry_succ, v_h, Bool.atLeastTwo_false_right, getLsbD_and,
      getLsbD_xor, Bool.and_eq_false_imp, Bool.and_eq_true, bne_eq_false_iff_eq,
      and_imp]
    intros; simp [*]

@[simp]
theorem and_add_xor_eq_or {a b : BitVec w} : (a &&& b) + (a ^^^ b) = a ||| b := by
  ext i
  rw [getLsbD_add (by omega), getLsbD_and, getLsbD_xor, getLsbD_or]
  simp only [Bool.bne_assoc]
  cases a.getLsbD ↑i <;> simp [carry_and_xor_false]

attribute [bv_ofBool] ofBool_or_ofBool
attribute [bv_ofBool] ofBool_and_ofBool
attribute [bv_ofBool] ofBool_xor_ofBool
attribute [simp, bv_ofBool] ofBool_eq_iff_eq

theorem allOnes_xor_eq_not (x : BitVec w) : allOnes w ^^^ x = ~~~x := by
  apply eq_of_getLsbD_eq
  simp

theorem allOnes_sub_eq_xor (x :BitVec w) : (allOnes w) - x = x ^^^ (allOnes w) := by
  rw [allOnes_sub_eq_not, ← allOnes_xor_eq_not, BitVec.xor_comm]

@[simp]
theorem and_add_or {A B : BitVec w} : (B &&& A) + (B ||| A) = B + A := by
  rw [add_eq_adc, add_eq_adc, adc_spec B A]
  unfold adc
  rw [iunfoldr_replace (fun i => carry i B A false)]
  · simp [carry]; omega
  · intro i
    simp only [adcb, getLsbD_and, getLsbD_or, ofBool_false, ofNat_eq_ofNat, BitVec.setWidth_zero,
      BitVec.add_zero, Prod.mk.injEq]
    constructor
    · rw [carry_succ]
      cases A.getLsbD i
      <;> cases B.getLsbD i
      <;> cases carry i B A false
      <;> rfl
    · rw [getLsbD_add (by omega)]
      cases A.getLsbD i
      <;> cases B.getLsbD i
      <;> cases carry i B A false
      <;> rfl

@[simp] theorem msb_signExtend_of_ge {i} (h : i ≥ w) (x : BitVec w) :
    (x.signExtend i).msb = x.msb := by
  simp [BitVec.msb_eq_getLsbD_last, getLsbD_signExtend]
  split <;> by_cases (0 < i) <;> simp_all
  simp [show i = w by omega]

theorem signExtend_succ (i : Nat) (x : BitVec w) :
    x.signExtend (i+1) = cons (if i < w then x.getLsbD i else x.msb) (x.signExtend i) := by
  ext j
  simp only [getLsbD_signExtend, Fin.is_lt, decide_true, Bool.true_and, getLsbD_cons]
  split <;> split <;> simp_all <;> omega

@[simp]
theorem one_shiftLeft_mul {x y : BitVec w} :
    1#w <<< x.toNat * y = y <<< x.toNat := by
  simp [←BitVec.mul_twoPow_eq_shiftLeft, BitVec.mul_comm]

@[simp]
theorem mul_allOnes {x : BitVec w} :
    x * BitVec.allOnes w = -x := by
  simp [← BitVec.negOne_eq_allOnes]

@[simp]
theorem allOnes_sshiftRight {w n : Nat} :
  (allOnes w).sshiftRight n = allOnes w := by
  ext i
  by_cases h : 0 < w
  · simp [BitVec.msb_allOnes h, getLsbD_sshiftRight, ←decide_not]; omega
  · simp [getLsbD_sshiftRight]; omega

attribute [simp] shiftLeft_ushiftRight

theorem ofInt_neg_one : BitVec.ofInt w (-1) = -1#w := by
  simp only [Int.reduceNeg, toNat_eq, toNat_ofInt, Nat.cast_pow, Nat.cast_ofNat, toNat_neg,
    toNat_ofNat]
  by_cases h : w = 0
  · subst h
    simp
  · simp only [Int.reduceNeg, ne_eq, h, not_false_eq_true, Nat.one_mod_two_pow_eq,
    Nat.self_sub_mod]
    have h' := @Int.add_emod_self (-1) (2^w)
    rw [← h', ← Int.tmod_eq_emod (by omega) (by omega), Int.tmod_eq_of_lt (by omega) (by omega),
      Int.add_comm]
    norm_cast
    rw [Int.ofNat_add_negSucc, Int.subNatNat_eq_coe]
    simp only [Nat.cast_pow, Nat.cast_ofNat, Nat.succ_eq_add_one, zero_add, Nat.cast_one,
      Int.pred_toNat]
    norm_cast

@[simp]
theorem shiftLeft_and_distrib' {x y : BitVec w} {n m : Nat} :
    x <<< n &&& y <<< (m + n) = (x &&& y <<< m) <<< n := by
  simp [BitVec.shiftLeft_and_distrib, BitVec.shiftLeft_add]

@[simp]
theorem sdiv_allOnes {w : ℕ} {x : BitVec w} :
    x.sdiv (BitVec.allOnes w) = -x := by
  simp only [BitVec.sdiv_eq]
  by_cases h : w = 0
  · subst h
    simp [BitVec.eq_nil x]
  · rw [BitVec.msb_allOnes (by omega)]
    by_cases h : x.msb <;> simp [h, BitVec.neg_allOnes]
end BitVec

namespace Bool

theorem xor_decide (p q : Prop) [dp : Decidable p] [Decidable q] :
    (decide p).xor (decide q) = decide (p ≠ q) := by
  cases' dp with pt pt
  <;> simp [pt]

@[simp]
theorem xor_not_xor {a b : Bool} : ((!(a ^^ b)) ^^ b) = !a := by
  cases a
  <;> cases b
  <;> simp

@[simp]
theorem not_xor_and_self {a b : Bool} : (!(a ^^ b) && b) = (a && b) := by
  cases a
  <;> cases b
  <;> simp

theorem xor_inv_left {a b c : Bool} : (a ^^ b) = c ↔ b = (a ^^ c) := by
  cases a
  <;> cases b
  <;> simp

@[simp]
theorem xor_ne_self {a b : Bool} : (a ^^ ((!a) != b)) = !b := by
  cases a
  <;> simp

@[simp]
theorem not_eq_and {a b : Bool} : ((!b) == (a && b)) = (!a && b)  := by
  cases a
  <;> simp

@[simp]
theorem not_bne' {a b : Bool} : (!bne a b) = (a == b) := by
  cases a
  <;> simp

end Bool

theorem Option.some_bind'' (x : α) (f : α → Option β) : some x >>= f = f x := by
  simp

@[simp]
theorem bind_if_then_none_eq_if_bind (h : Prop) [Decidable h] (x : Option α) :
    (if h then none else x) >>= f = if h then none else x >>= f := by
  split <;> simp

@[simp]
theorem bind_if_else_none_eq_if_bind (h : Prop) [Decidable h] (x : Option α) :
    (if h then x else none) >>= f = if h then x >>= f else none := by
  split <;> simp

theorem if_if_eq_if_and (x y : Prop) [Decidable x] [Decidable y] :
   (if x then if y then a else b else b) = if x ∧ y then a else b := by
  split_ifs <;> simp_all

theorem if_if_eq_if_or (x y : Prop) [Decidable x] [Decidable y] :
   (if x then a else if y then a else b) = if x ∨ y then a else b := by
  split_ifs <;> simp_all
