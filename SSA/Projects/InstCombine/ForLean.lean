import Mathlib.Data.Nat.Size -- TODO: remove and get rid of shiftLeft_eq_mul_pow use
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.LLVM.Semantics

@[simp] theorem sub_toNat_mod_cancel {x : BitVec w} (h : ¬ x = 0#w) :
    (2 ^ w - x.toNat) % 2 ^ w = 2 ^ w - x.toNat := by
  simp [bv_toNat] at h
  rw [Nat.mod_eq_of_lt (by omega)]

@[simp] theorem sub_sub_toNat_cancel {x : BitVec w} :
    2 ^ w - (2 ^ w - x.toNat) = x.toNat := by
  simp [Nat.sub_sub_eq_min, Nat.min_eq_right]
  omega

lemma two_pow_pred_mul_two (h : 0 < w) :
    2 ^ (w - 1) * 2 = 2 ^ w := by
  simp only [← pow_succ, gt_iff_lt, ne_eq, not_false_eq_true]
  rw [Nat.sub_add_cancel]
  omega

lemma two_pow_pred_add_two_pow_pred (h : 0 < w) :
    2 ^ (w - 1) + 2 ^ (w - 1) = 2 ^ w:= by
  rw [← two_pow_pred_mul_two (w := w) h]
  omega

lemma two_pow_pred_lt_two_pow (h : 0 < w) :
    2 ^ (w - 1) < 2 ^ w := by
  simp [← two_pow_pred_add_two_pow_pred h]

lemma two_pow_sub_two_pow_pred (h : 0 < w) :
    2 ^ w - 2 ^ (w - 1) = 2 ^ (w - 1) := by
  simp [← two_pow_pred_add_two_pow_pred h]

lemma two_pow_pred_mod_two_pow (h : 0 < w):
    2 ^ (w - 1) % 2 ^ w = 2 ^ (w - 1) := by
  rw [Nat.mod_eq_of_lt]
  apply two_pow_pred_lt_two_pow h

lemma Nat.eq_one_mod_two_of_ne_zero (n : Nat) (h : n % 2 != 0) : n % 2 = 1 := by
  simp only [bne_iff_ne, ne_eq, mod_two_ne_zero] at h
  assumption

lemma Nat.sub_mod_of_lt (n x : Nat) (hxgt0 : x > 0) (hxltn : x < n) : (n - x) % n = n - x := by
  rcases n with rfl | n <;> simp
  omega


namespace BitVec

lemma ushr_xor_distrib (a b c : BitVec w) :
    (a ^^^ b) >>> c = (a >>> c) ^^^ (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

lemma ushr_and_distrib (a b c : BitVec w) :
    (a &&& b) >>> c = (a >>> c) &&& (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

lemma ushr_or_distrib (a b c : BitVec w) :
    (a ||| b) >>> c = (a >>> c) ||| (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

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

def ofInt_zero_eq (w : Nat) : BitVec.ofInt w 0 = 0#w := rfl
def ofNat_zero_eq (w : Nat) : BitVec.ofNat w 0 = 0#w := rfl
def toInt_zero_eq (w : Nat) : BitVec.toInt 0#w = 0 := by
 simp [BitVec.toInt]
def toNat_zero_eq (w : Nat) : BitVec.toNat 0#w = 0 := rfl

@[simp]
def msb_one (h : 1 < w) : BitVec.msb 1#w = false := by
  simp only [BitVec.msb_eq_decide, decide_eq_false_iff_not, not_le, toNat_ofInt,
    toNat_ofNat]
  rw [Nat.mod_eq_of_lt] <;> simp <;> omega

@[simp]
lemma msb_one_of_width_one : BitVec.msb 1#1 = true := rfl

def msb_allOnes {w : Nat} (h : 0 < w) : BitVec.msb (allOnes w) = true := by
  simp only [BitVec.msb, getMsb, allOnes]
  simp only [getLsb_ofNatLt, Nat.testBit_two_pow_sub_one, Bool.and_eq_true,
    decide_eq_true_eq]
  rw [Nat.sub_lt_iff_lt_add] <;> omega

@[simp]
theorem Nat.one_mod_two_pow_eq {n : Nat} (hn : n ≠ 0) : 1 % 2 ^ n = 1 := by
  rw [Nat.mod_eq_of_lt (Nat.one_lt_pow hn (by decide))]

@[simp]
lemma ofInt_ofNat (w n : Nat) :
    BitVec.ofInt w (no_index (OfNat.ofNat n)) = BitVec.ofNat w n :=
  rfl

-- @[simp]
def neg_allOnes {w : Nat} : -(allOnes w) = (1#w) := by
  simp only [toNat_eq, toNat_neg, toNat_allOnes, toNat_ofNat]
  cases w
  case zero => rfl
  case succ w =>
    rw [Nat.sub_sub_self]
    apply Nat.one_le_pow (h := by decide)

theorem udiv_eq {x y : BitVec n} : x.udiv y = BitVec.ofNat n (x.toNat / y.toNat) := by
  have h : x.toNat / y.toNat < 2 ^ n := by
    exact Nat.lt_of_le_of_lt (Nat.div_le_self ..) (by omega)
  simp only [udiv, bv_toNat, toNat_ofNatLt, h, Nat.mod_eq_of_lt]

@[simp, bv_toNat]
theorem toNat_udiv {x y : BitVec n} : (x.udiv y).toNat = x.toNat / y.toNat := by
  simp only [udiv_eq]
  by_cases h : y = 0
  · simp [h]
  · rw [toNat_ofNat, Nat.mod_eq_of_lt]
    exact Nat.lt_of_le_of_lt (Nat.div_le_self ..) (by omega)

theorem udiv_one_eq_self (w : Nat) (x : BitVec w) : x.udiv 1#w = x := by
  by_cases h : w = 0
  · subst h
    simp [eq_nil x]
  · simp_all [bv_toNat]

theorem udiv_eq_zero_iff {x y : BitVec w} (h : 0#w < y) : udiv x y = 0#w ↔ x < y := by
  simp_all [bv_toNat, Nat.div_eq_zero_iff, h]

@[simp]
theorem udiv_eq_zero {x y : BitVec w} (h : x < y) : udiv x y = 0#w := by
  rw [udiv_eq_zero_iff]
  · simp_all only [lt_def]
  · simp_all only [lt_def, toNat_ofNat, Nat.zero_mod]
    omega

def sdiv_one_allOnes {w : Nat} (h : 1 < w) :
    BitVec.sdiv (1#w) (BitVec.allOnes w) = BitVec.allOnes w := by
  simp only [BitVec.sdiv]
  simp only [msb_one h, neg_eq, @msb_allOnes w (by omega)]
  simp only [neg_allOnes]
  simp only [udiv_one_eq_self]
  simp only [negOne_eq_allOnes]

theorem width_one_cases (a : BitVec 1) : a = 0#1 ∨ a = 1#1 := by
  obtain ⟨a, ha⟩ := a
  simp only [pow_one] at ha
  have acases : a = 0 ∨ a = 1 := by omega
  rcases acases with ⟨rfl | rfl⟩
  · simp
  case inr h =>
    subst h
    simp

@[simp]
lemma add_eq_xor (a b : BitVec 1) : a + b = a ^^^ b := by
  have ha : a = 0 ∨ a = 1 := width_one_cases _
  have hb : b = 0 ∨ b = 1 := width_one_cases _
  rcases ha with h | h <;> (rcases hb with h' | h' <;> (simp [h, h']))

@[simp]
lemma mul_eq_and (a b : BitVec 1) : a * b = a &&& b := by
  have ha : a = 0 ∨ a = 1 := width_one_cases _
  have hb : b = 0 ∨ b = 1 := width_one_cases _
  rcases ha with h | h <;> (rcases hb with h' | h' <;> (simp [h, h']))

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

@[simp]
theorem neg_neg {x : BitVec w} : - - x = x := by
  by_cases h : x = 0#w
  · simp [h]
  · simp [bv_toNat, h]

theorem neg_ne_iff_ne_neg {x y : BitVec w} : -x ≠ y ↔ x ≠ -y := by
  constructor
    <;> intro h h'
    <;> subst h'
    <;> simp [BitVec.neg_neg] at h

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
      have ha' : a = 0#1 ∨ a = 1#1 := BitVec.width_one_cases a
      rcases ha' with ⟨rfl | rfl⟩ <;> (simp only [Nat.reduceAdd, ofNat_eq_ofNat, ne_eq,
        not_true_eq_false] at ha0)
      case inr h => subst h; contradiction
    case succ w' =>
      simp only [BitVec.sdiv, lt_add_iff_pos_left, add_pos_iff, zero_lt_one,
        or_true, msb_one, neg_eq]
      by_cases h : a.msb <;> simp [h]
      · simp only [neg_eq_iff_eq_neg, BitVec.neg_zero]
        rw [BitVec.udiv_eq_zero]
        apply BitVec.gt_one_of_neq_0_neq_1
        · rw [neg_ne_iff_ne_neg]
          simp only [_root_.neg_zero]
          assumption
        · rw [neg_ne_iff_ne_neg]
          rw [← negOne_eq_allOnes] at hao
          assumption
      · rw [BitVec.udiv_eq_zero]
        apply BitVec.gt_one_of_neq_0_neq_1 <;> assumption

def sdiv_one_one : BitVec.sdiv 1#w 1#w = 1#w := by
  by_cases w_0 : w = 0; subst w_0; rfl
  by_cases w_1 : w = 1; subst w_1; rfl
  unfold BitVec.sdiv
  unfold BitVec.udiv
  simp only [toNat_ofNat, neg_eq, toNat_neg]
  rw [msb_one (by omega)]
  simp only []
  have hone : 1 % 2 ^ w = 1 := by
    apply Nat.mod_eq_of_lt
    simp
    omega
  apply BitVec.eq_of_toNat_eq
  simp [hone]

lemma udiv_zero {w : ℕ} {x : BitVec w} : BitVec.udiv x 0#w = 0 := by
  simp only [udiv, toNat_ofNat, Nat.zero_mod, Nat.div_zero, ofNat_eq_ofNat]
  rfl

lemma sdiv_zero {w : ℕ} (x : BitVec w) : BitVec.sdiv x 0#w = 0#w := by
  simp only [sdiv, msb_zero, udiv_zero, ofNat_eq_ofNat, neg_eq, neg_zero]
  split <;> rfl

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

theorem neq_iff_toNat_neq {w : ℕ} {x y : BitVec w} :
  x ≠ y ↔ x.toNat ≠ y.toNat := by
  simp [BitVec.toNat_eq]

theorem toNat_one (hw : w ≠ 0 := by omega): BitVec.toNat (1 : BitVec w) = 1 := by
  simp only [ofNat_eq_ofNat, toNat_ofNat]
  apply Nat.mod_eq_of_lt
  apply Nat.one_lt_pow <;> omega

theorem toNat_intMin' (w : ℕ) : BitVec.toNat (LLVM.intMin w) =
    if w = 0 then 0 else 2^(w-1) := by
  cases w
  case zero =>
    simp [LLVM.intMin]
  case succ w' =>
    simp only [LLVM.intMin, add_tsub_cancel_right, toNat_neg, toNat_ofNat, add_eq_zero, one_ne_zero,
      and_false, ↓reduceIte]
    have hpow : 2^w' > 0 := by
      apply Nat.pow_pos (by decide)
    repeat rw [Nat.pow_succ]
    conv =>
      lhs
      pattern (2^w' % _)
      rw [Nat.mod_eq_of_lt (by omega)]
    have hfact (x : Nat) (hx : x > 0) : x * 2 - x = x := by omega
    rw [hfact _ hpow]
    rw [Nat.mod_eq_of_lt (by omega)]

theorem intMin_eq_one {w : Nat} (hw : w ≤ 1): LLVM.intMin w = 1 := by
  cases w
  · rfl
  · case succ w' =>
    cases w'
    · rfl
    · case succ w' =>
      contradiction

theorem intMin_neq_one {w : Nat} (hw : w > 1): LLVM.intMin w ≠ 1 := by
  cases w
  · simp at hw
  · case succ w' =>
    apply BitVec.neq_iff_toNat_neq.mpr
    rw [BitVec.toNat_one]
    rw [BitVec.toNat_intMin']
    simp only [Nat.succ_ne_zero, ↓reduceIte, Nat.succ_sub_succ_eq_sub, tsub_zero, ne_eq]
    have hpos : 2^w' > 1 := by
      apply Nat.one_lt_two_pow (by omega)
    omega

theorem ofInt_eq_ofNat_mod' {w : ℕ} (n : ℕ) :
    BitVec.ofInt w (OfNat.ofNat n : ℤ) = BitVec.ofNat w n := by
  apply BitVec.eq_of_toNat_eq
  simp only [toNat_ofInt, Nat.cast_ofNat, toNat_ofNat]
  norm_cast

theorem width_one_cases' (x : BitVec 1) :
    x = 0 ∨ x = 1 := by
  obtain ⟨x, hx⟩ := x
  simp [BitVec.toNat_eq]
  omega

/- Not a simp lemma by default because we may want toFin or toInt in the future. -/
theorem ult_toNat (x y : BitVec n) :
    (BitVec.ult (n := n) x y) = decide (x.toNat < y.toNat) := by
  simp [BitVec.ult]

theorem getLsb_geX(x : BitVec w) (hi : i ≥ w) :
    BitVec.getLsb x i = false := by
  have rk : _ := @BitVec.getLsb_ge w x i hi
  apply rk

def intMin (w : Nat) : BitVec w  := BitVec.ofNat w (2^(w - 1))

private theorem toNat_intMin (w : Nat) :
    (intMin w).toNat = (if w = 0 then 0 else 2^(w - 1)) := by
  simp only [intMin, toNat_ofNat]
  by_cases w_0 : w = 0
  · simp [w_0]
  · rw [two_pow_pred_mod_two_pow (by omega)]
    simp [w_0, ↓reduceIte]

@[simp]
private theorem toInt_zero : BitVec.toInt (BitVec.ofNat w 0) = 0 := by
  simp [toInt_ofNat]

private theorem ofInt_neg {w : Nat} {A : BitVec w} (rs : A ≠ intMin w) :
    BitVec.toInt (-A) = -(BitVec.toInt A) := by
  by_cases A_zero : A = 0
  · subst A_zero
    simp
  by_cases w_0 : w = 0
  · subst w_0
    simp [BitVec.eq_nil A]
  unfold BitVec.toInt
  have A_gt_zero : 0 < BitVec.toNat A := by
    simp only [ofNat_eq_ofNat, toNat_eq, toNat_ofNat, Nat.zero_mod] at A_zero
    omega
  rw [BitVec.toNat_neg, @Nat.mod_eq_of_lt (2 ^ w - BitVec.toNat A) (2 ^ w) (by omega)]
  split_ifs <;>
  rename_i a b
  · omega
  · rw [Nat.cast_sub]
    ring_nf
    simp [Nat.le_of_lt (isLt A)]
  · rw [Nat.cast_sub]
    ring_nf
    simp [Nat.le_of_lt (isLt A)]
  · have is_int_min : BitVec.toNat A * 2 = 2^(w) := by
      ring_nf at a b
      rw [Nat.mul_sub_right_distrib, not_lt, Nat.le_sub_iff_add_le, mul_two,
          mul_two, add_le_add_iff_left, ←mul_two] at a
      simp only [eq_of_ge_of_not_gt a (by simp [b])]
      simp only [gt_iff_lt, Nat.ofNat_pos, mul_le_mul_right, le_of_lt (isLt A)]
    have is_int_min' : BitVec.toNat A = 2^(w-1) := by
      have h : 2 ^w  = (2 ^(w - 1)) * 2 := by
        rw [← two_pow_pred_add_two_pow_pred (by omega)]
        omega
      omega
    simp [ne_eq, toNat_eq, is_int_min', toNat_intMin, w_0, ↓reduceIte,
      not_true_eq_false] at rs

private theorem neg_sgt_eq_slt_neg {A B : BitVec w} (h : A ≠ intMin w) (h2 : B ≠ intMin w) :
    (-A >ₛ B) = (A <ₛ -B) := by
  unfold BitVec.slt
  simp only [decide_eq_decide, ofInt_neg h, ofInt_neg h2]
  omega

theorem toInt_eq (x y : BitVec n) : x = y ↔ x.toInt = y.toInt :=
  Iff.intro (congrArg BitVec.toInt) eq_of_toInt_eq

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
  · simp only [toInt_zero, neg_zero, h, decide_False, Bool.not_false, decide_eq_true_eq]
    simp only [ofNat_eq_ofNat, ne_eq, ← toInt_ne, toInt_zero] at h_ne_zero
    omega
  simp only [ne_eq]
  unfold intMin
  simp only [toNat_eq, toNat_ofNat, Nat.zero_mod]
  rw [two_pow_pred_mod_two_pow (by omega)]
  have _ : 0 < 2 ^(w - 1) := by
    simp [Nat.pow_pos]
  omega

theorem intMin_eq_neg_intMin (w : Nat) :
    -intMin w = intMin w := by
  by_cases w_eq_zero : w = 0
  · subst w_eq_zero
    simp [intMin]
  have w_gt_zero : 0 < w := by omega
  simp only [toNat_eq, toNat_neg, toNat_intMin]
  simp only [w_eq_zero, ↓reduceIte]
  simp only [two_pow_sub_two_pow_pred w_gt_zero]
  simp only [two_pow_pred_mod_two_pow w_gt_zero]

theorem sgt_same (A : BitVec w) : ¬ (A >ₛ A) := by
  simp [BitVec.slt]

private theorem intMin_lt_zero (h : 0 < w): intMin w <ₛ 0 := by
  unfold intMin
  unfold BitVec.slt
  simp only [ofNat_eq_ofNat, toInt_zero, decide_eq_true_eq]
  simp [BitVec.toInt_ofNat]
  unfold Int.bmod
  simp only [Nat.cast_pow, Nat.cast_ofNat]
  norm_cast
  simp only [two_pow_pred_mod_two_pow h]
  split_ifs
  · rename_i hh
    norm_cast at hh
    have h_if_nat : ¬ (2 ^ (w - 1) < (2 ^ w + 1) / 2) := by
      have hhh : ¬ (2 ^ (w - 1) * 2 + 1 < (2 ^ w + 1) / 2 * 2 + 1) := by
        rw [Nat.div_two_mul_two_add_one_of_odd]
        · simp only [add_lt_add_iff_right, not_lt]
          rw [← two_pow_pred_add_two_pow_pred h]
          omega
        · apply Even.add_odd
          · apply Even.pow_of_ne_zero
            simp only [even_two]
            omega
          · simp
      omega
    contradiction

  · rename_i hh
    rw [Int.subNatNat_eq_coe]
    norm_cast at hh
    apply Int.sub_lt_of_sub_lt
    simp only [Nat.cast_pow, Nat.cast_ofNat, sub_zero]
    norm_cast
    apply two_pow_pred_lt_two_pow
    simp [h]

private theorem not_gt_eq_le (A B : BitVec w) : (¬ (A >ₛ B)) = (A ≤ₛ B) := by
  simp [BitVec.slt, BitVec.sle]

private theorem sge_eq_sle (A B : BitVec w) : (A ≥ₛ B) = (B ≤ₛ A) := by
  simp [BitVec.sle]

private theorem sge_of_sgt (A B : BitVec w) : (A >ₛ B) → (A ≥ₛ B) := by
  simp only [BitVec.slt, decide_eq_true_eq, BitVec.sle]
  omega

theorem intMin_not_gt_zero : ¬ (intMin w >ₛ (0#w)):= by
  by_cases h : w = 0
  · rw [h]
    simp only [h, of_length_zero, reduceSLT, not_false_eq_true]
  · simp only [not_gt_eq_le, sge_eq_sle]
    rw [sge_of_sgt]
    apply intMin_lt_zero
    omega

theorem zero_sub_eq_neg {w : Nat} { A : BitVec w}: BitVec.ofInt w 0 - A = -A:= by
  simp [BitVec.ofInt_zero_eq]

-- Any bitvec of width 0 is equal to the zero bitvector
theorem width_zero_eq_zero (x : BitVec 0) : x = BitVec.ofNat 0 0 :=
  Subsingleton.allEq ..

@[simp]
theorem toInt_width_zero (x : BitVec 0) : BitVec.toInt x = 0 := by
  rw [BitVec.width_zero_eq_zero x]
  simp

@[simp]
theorem toInt_ofInt_width_one_one : BitVec.toInt (BitVec.ofInt 1 1) = -1 := rfl

@[simp]
theorem toInt_ofInt_zero : BitVec.toInt (BitVec.ofInt w 0) = 0 := by
  simp [BitVec.msb, BitVec.getMsb, BitVec.getLsb, BitVec.ofInt, BitVec.toInt]

@[simp]
theorem toInt_ofInt_1_width_zero :
    BitVec.toInt (BitVec.ofInt (n := 0) 1) = 0 := rfl

@[simp]
theorem toInt_ofInt_1_width_one :
    BitVec.toInt (BitVec.ofInt (n := 1) 1) = -1 := rfl

-- if w = 0. then value is 0
-- if w = 1, then value is -1.

@[simp]
theorem toNat_ofInt_one_width_zero : BitVec.toNat (BitVec.ofInt (n := 0) 1) = 0 := rfl

@[simp]
theorem toNat_ofInt_one_width_one : BitVec.toNat (BitVec.ofInt (n := 1) 1) = 1 := rfl

@[simp]
theorem ofNat_toNat_zero :
BitVec.toNat (BitVec.ofInt w 0) = 0 := by
  simp only [BitVec.toNat, BitVec.ofInt, BitVec.toFin, BitVec.ofNat, OfNat.ofNat]
  norm_cast

@[simp]
theorem ofBool_neq_1 (b : Bool) :
    BitVec.ofBool b ≠ (BitVec.ofNat 1 1) ↔ (BitVec.ofBool b) = (BitVec.ofNat 1 0) := by
  constructor <;> (intros h; cases b <;> simp at h; simp [BitVec.ofBool])

@[simp]
theorem ofBool_neq_0 (b : Bool) :
    BitVec.ofBool b ≠ (BitVec.ofNat 1 0) ↔ (BitVec.ofBool b) = (BitVec.ofNat 1 1) := by
  constructor <;> (intros h; cases b <;> simp at h ; simp_all [BitVec.ofBool, h])

@[simp]
theorem ofBool_eq_1 (b : Bool) :
    BitVec.ofBool b = (BitVec.ofNat 1 1) ↔ b = True := by
  constructor <;> (intros h; cases b <;> simp at h ; simp_all [BitVec.ofBool, h])

@[simp]
theorem ofBool_eq_0 (b : Bool) :
    BitVec.ofBool b = (BitVec.ofNat 1 0) ↔ b = False := by
  constructor <;> (intros h; cases b <;> simp at h ; simp [BitVec.ofBool])

@[simp]
theorem neg_of_ofNat_0_minus_self (x : BitVec w) : (BitVec.ofNat w 0) - x = -x := by
  simp

theorem toInt_eq' (w : Nat) (x : BitVec w) :
    BitVec.toInt x = if x.toNat < (2 : Nat)^(w - 1) then x else x - 2^w := by
  cases w <;> simp
  · case zero =>
    simp [BitVec.eq_nil x]
  · case succ w' =>
      unfold BitVec.toInt
      simp only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ite, Int.cast_natCast, natCast_eq_ofNat,
        ofNat_toNat, zeroExtend_eq, Int.cast_sub, Int.cast_pow, Int.cast_ofNat, ofNat_eq_ofNat]
      have hcases : (BitVec.toNat x < 2 ^ w') ∨ (BitVec.toNat x ≥ 2 ^ w') := by
        apply lt_or_ge
      cases hcases
      case inl hle =>
        simp only [hle, ↓reduceIte, ite_eq_left_iff, not_lt, sub_eq_self, ofNat_eq_ofNat]
        omega
      case inr hgt =>
        have hgt' : ¬ (BitVec.toNat x < 2 ^ w') := by omega
        simp only [ge_iff_le] at hgt
        simp [hgt, hgt', bne, Nat.cast, NatCast.natCast, BEq.beq, Nat.beq]
        omega

theorem toInt_eq'' (w : Nat) (x : BitVec w) :
    BitVec.toInt x =
    if x.toNat < (2 : Nat)^(w - 1) then (x.toNat : ℤ) else (x.toNat : ℤ) - 2^w := by
  cases w <;> simp only [toInt_width_zero, toNat_zero_length, zero_le, tsub_eq_zero_of_le, pow_zero,
    zero_lt_one, ↓reduceIte, Nat.cast_zero, add_tsub_cancel_right]
  split_ifs
  unfold BitVec.toInt
  simp only [Nat.cast_pow, Nat.cast_ofNat, ite_eq_left_iff, not_lt, sub_eq_self, ne_eq, add_eq_zero,
    one_ne_zero, and_false, not_false_eq_true, pow_eq_zero_iff, OfNat.ofNat_ne_zero, imp_false,
    not_le]
  rename_i hh n
  omega
  rename_i hh n
  unfold BitVec.toInt
  simp only [not_lt] at n
  simp only [Nat.cast_pow, Nat.cast_ofNat, ite_eq_right_iff]
  intros a
  omega

/-- If a bitvec's toInt is negative, then the toNat will be larger than half of the bitwidth. -/
lemma large_of_toInt_lt_zero (w : Nat) (x : BitVec w) (hxToInt : BitVec.toInt x < 0) :
    x.toNat ≥ (2 : Nat) ^ (w - 1) := by
  rcases w with rfl | w'
  case zero => simp at hxToInt
  case succ =>
    rw [toInt_eq''] at hxToInt
    split_ifs at hxToInt
    case pos h => omega
    case neg h =>
      omega

lemma toInt_lt_zero_of_large (w : Nat) (x : BitVec w)
    (hxLarge : x.toNat ≥ (2 : Nat) ^ (w - 1)) : BitVec.toInt x < 0 := by
  rcases w with rfl | w'
  case zero =>
    simp at hxLarge
  case succ =>
    rw [toInt_eq'']
    split_ifs
    case pos h => omega
    case neg h =>
      norm_cast
      rw [Int.subNatNat_eq_coe]
      omega

lemma toInt_lt_zero_iff_large (w : Nat) (x : BitVec w) :
    BitVec.toInt x < 0 ↔ x.toNat ≥ (2 : Nat) ^ (w - 1) := by
  constructor
  apply BitVec.large_of_toInt_lt_zero
  apply BitVec.toInt_lt_zero_of_large

/-- If a bitvec's toInt is negative, then the toNat will be larger than half of the bitwidth. -/
lemma small_of_toInt_pos (w : Nat) (x : BitVec w) (hxToInt : BitVec.toInt x ≥ 0) :
    x.toNat < (2 : Nat) ^ (w - 1) := by
  rcases w with rfl | w'
  case zero => simp [BitVec.width_zero_eq_zero]
  case succ =>
    rw [BitVec.toInt_eq''] at hxToInt
    split_ifs at hxToInt
    case pos h => omega
    case neg h =>
      exfalso
      simp_all only [add_tsub_cancel_right, not_lt, ge_iff_le, sub_nonneg]
      norm_cast at hxToInt
      omega

lemma toInt_pos_of_small (w : Nat) (x : BitVec w)
    (hxsmall : x.toNat < (2 : Nat) ^ (w - 1)) : BitVec.toInt x ≥ 0 := by
  rcases w with rfl | w'
  case zero => simp
  case succ =>
    rw [BitVec.toInt_eq'']
    split_ifs
    norm_cast
    simp

lemma toInt_pos_iff_small (w : Nat) (x : BitVec w) :
    x.toNat < (2 : Nat) ^ (w - 1) ↔ BitVec.toInt x ≥ 0 := by
  constructor
  apply BitVec.toInt_pos_of_small
  apply BitVec.small_of_toInt_pos

lemma toInt_pos_iff_small' (w : Nat) (x : BitVec (w + 1)) :
    x.toNat < (2 : Nat) ^ w ↔ BitVec.toInt x ≥ 0 := by
  apply BitVec.toInt_pos_iff_small

lemma toInt_zero_iff (w : Nat) (x : BitVec w) : BitVec.toInt x = 0 ↔ x = 0 := by
  simp [toInt_eq]

lemma toInt_nonzero_iff (w : Nat) (x : BitVec w) : BitVec.toInt x ≠ 0 ↔ x ≠ 0 := by
  simp [← toInt_ne]

@[simp]
lemma carry_and_xor_false : carry i (a &&& b) (a ^^^ b) false = false := by
  induction i
  case zero =>
    simp [carry, Nat.mod_one]
  case succ v v_h =>
    simp only [carry_succ, v_h, Bool.atLeastTwo_false_right, getLsb_and,
      getLsb_xor, Bool.and_eq_false_imp, Bool.and_eq_true, bne_eq_false_iff_eq,
      and_imp]
    intros; simp [*]

@[simp]
theorem and_add_xor_eq_or {a b : BitVec w} : (a &&& b) + (a ^^^ b) = a ||| b := by
  ext i
  rw [getLsb_add (by omega), getLsb_and, getLsb_xor, getLsb_or]
  simp only [Bool.bne_assoc]
  cases a.getLsb ↑i <;> simp [carry_and_xor_false]

@[bv_ofBool]
theorem ofBool_or {a b : Bool} : BitVec.ofBool a ||| BitVec.ofBool b = ofBool (a || b) := by
  simp only [toNat_eq, toNat_or, toNat_ofBool]; rcases a <;> rcases b <;> rfl

@[bv_ofBool]
theorem ofBool_and {a b : Bool} : BitVec.ofBool a &&& BitVec.ofBool b = ofBool (a && b) := by
  simp only [toNat_eq, toNat_and, toNat_ofBool]; rcases a <;> rcases b <;> rfl

@[bv_ofBool]
theorem ofBool_xor {a b : Bool} : BitVec.ofBool a ^^^ BitVec.ofBool b = ofBool (a.xor b) := by
  simp only [toNat_eq, toNat_xor, toNat_ofBool]; rcases a <;> rcases b <;> rfl

@[simp]
theorem ofBool_eq' : ofBool a = ofBool b ↔ a = b:= by
  rcases a <;> rcases b <;> simp [bv_toNat]

theorem negOne_eq_allOnes' : -1#w = BitVec.allOnes w := by
  rw [BitVec.negOne_eq_allOnes]

theorem allOnes_xor_eq_not (x : BitVec w) : allOnes w ^^^ x = ~~~x := by
  apply eq_of_getLsb_eq
  simp

theorem xor_comm (e e_1: BitVec w) : e ^^^ e_1 = e_1 ^^^ e := by
  apply eq_of_getLsb_eq
  intros i
  simp [getLsb_xor, Bool.xor_comm]

theorem allOnes_sub_eq_xor (x :BitVec w) : (allOnes w) - x = x ^^^ (allOnes w) := by
  rw [allOnes_sub_eq_not, ← allOnes_xor_eq_not, BitVec.xor_comm]

@[simp]
theorem and_add_or {A B : BitVec w} : (B &&& A) + (B ||| A) = B + A := by
  rw [add_eq_adc, add_eq_adc, adc_spec B A]
  unfold adc
  rw [iunfoldr_replace (fun i => carry i B A false)]
  · simp [carry]; omega
  · intro i
    simp only [adcb, getLsb_and, getLsb_or, ofBool_false, ofNat_eq_ofNat, zeroExtend_zero,
      BitVec.add_zero, Prod.mk.injEq]
    constructor
    · rw [carry_succ]
      cases A.getLsb i
      <;> cases B.getLsb i
      <;> cases carry i B A false
      <;> rfl
    · rw [getLsb_add (by omega)]
      cases A.getLsb i
      <;> cases B.getLsb i
      <;> cases carry i B A false
      <;> rfl
end BitVec

-- Given (a, b) that are less than a modulus m, to show (a + b) % m < k, it
-- suffices to consider two cases.
-- This theorem allows one to case split a '(a + b) % m < k' into two cases
-- Case 1: if (a + b) < m, then the inequality staightforwardly holds, as (a + b) < k
-- Case 2: if (a + b) ≥ m, then (a + b) % m = (a + b - m), and the inequality
-- holds as (a + b - m) < k
lemma Nat.cases_of_lt_mod_add {a b m k : ℕ} (hsum : (a + b) % m < k)  (ha : a < m) (hb : b < m) :
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
