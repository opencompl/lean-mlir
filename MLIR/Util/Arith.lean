/-
### Addition and subtraction of Int
-/

import Mathlib.Data.Int.Basic
import Mathlib.Data.Int.Order.Basic
import Mathlib.Data.Int.Bitwise
import Mathlib.Data.Int.ModEq
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LibrarySearch



-- Write 2^n in Int contexts instead of (2:Int)^n
instance: HPow Nat Nat Int where
  hPow x y := (x:Int)^y

namespace Int


theorem sub_add_assoc (n m k: Int): n - m + k = n + (k - m) := by
  simp [Int.sub_eq_add_neg, Int.add_assoc, Int.add_comm (-m) k]

theorem sub_assoc (n m k: Int): n - m - k = n - k - m := by
  simp [Int.sub_eq_add_neg, Int.add_assoc, Int.add_comm (-m) (-k)]

theorem add_sub (n m: Int): n + (m - n) = m := by
  rw [Int.sub_eq_add_neg, Int.add_comm m (-n), ←Int.add_assoc,
      Int.add_right_neg, Int.zero_add]

theorem sub_add_dist (n m p: Int): n - (m + p) = n - m - p := by
  rw [Int.sub_eq_add_neg, Int.neg_add, ←Int.add_assoc,
      ←Int.sub_eq_add_neg, ←Int.sub_eq_add_neg]

/-
### Multiplication and power of Int
-/

theorem mul_two (n: Int): n * 2 = n + n := by
  have h: (2:Int) = 1 + 1 := rfl
  simp;
  rw [h];
  rw [Int.mul_add];
  simp [Int.mul_one];


@[simp]
theorem pow_zero (n: Int): n^0 = 1 := by rfl

theorem pow_succ (n: Int) (m: Nat): n^(m+1) = n^m * n := by rfl

theorem two_pow_ge {n: Nat}: (2^n: Int) ≥ 0 := by
  sorry

theorem two_pow_pos {n: Nat}: (2^n: Int) > 0 := by
  sorry

theorem one_le_two_pow {n: Nat}: 1 ≤ (2^n: Int) := by
  sorry

theorem one_lt_two_pow {n: Nat}: n > 0 → 1 < (2^n: Int) := by
  sorry

theorem mod_bounds {a: Int} (b: Int): a ≥ 0 → a < b → a % b = a := by
  sorry

theorem mod_mod (a b: Int): (a % b) % b = a % b := by
  sorry

theorem mod_ge_neg {a b: Int}: a % b ≥ -b := by
  sorry

theorem mod_ge {a b: Int}: (a ≥ 0) → a % b ≥ 0 := by
  sorry

theorem mod_lt {a b: Int}: (b > 0) → a % b < b := by
  sorry

theorem add_mod_right {x z: Int}: (z > 0) → (x ≥ 0) → (x + z) % z = x % z := by
  sorry

theorem add_mod_left {x z: Int}: (z > 0) → (x ≥ 0) → (z + x) % z = x % z := by
  sorry

/-
### Order of Int
-/


theorem ge_zero_eq_nonneg (n: Int): n ≥ 0 ↔ Int.NonNeg n := by
  simp [GE.ge, LE.le, Int.le]

theorem zero_ge_neg {n: Int}: n ≥ 0 → 0 ≥ -n := by
  simp [GE.ge, LE.le, Int.le, Int.neg_neg]


-- (deterministic) timeout at 'whnf', maximum number of heartbeats (200000) has been reached (use 'set_option maxHeartbeats <num>' to set the limit)
theorem add_ge_zero (n m: Int): n ≥ 0 → m ≥ 0 → n + m ≥ 0 := by sorry
  /-
  simp [GE.ge, LE.le, Int.le, HAdd.hAdd, Add.add, Int.add]
  intros hn hm
  cases hn; cases hm; simp; constructor
  -/

theorem le_succ (n: Int): n ≤ n+1 := by
  suffices NonNeg 1 by simp [LE.le, Int.le, add_sub_assoc, add_sub]; trivial
  constructor

theorem succ_le_succ (n m: Int): n ≤ m → n + 1 ≤ m + 1 := by
  sorry

theorem ge_trans {n k} (m: Int): n ≥ m → m ≥ k → n ≥ k := by
  simp [GE.ge]
  intros h₁ h₂
  apply le_trans h₂ h₁

theorem lt_add_right (n m: Int): m > 0 → n < n + m := by
  sorry

theorem mul_ge_zero {n m: Int}: n ≥ 0 → m ≥ 0 → n * m ≥ 0 := by
  rw [Int.ge_zero_eq_nonneg, Int.ge_zero_eq_nonneg, Int.ge_zero_eq_nonneg]
  intros hn hm;
  cases hn; cases hm; constructor

theorem mul_gt_zero {n m: Int}: n > 0 → m > 0 → n * m > 0 := by
  sorry

theorem pow_ge_zero (n: Int) (m: Nat): n ≥ 0 → n^m ≥ 0 := by
  revert n; induction m <;> intros n h <;> simp
  case succ acc ih =>
    simp [pow_succ]; apply mul_ge_zero (ih _ h) h

theorem pow_gt_zero (n: Int) (m: Nat): n > 0 → n^m > 0 := by
  revert n; induction m <;> intros n h <;> simp
  case succ acc ih =>
    simp [pow_succ]; apply mul_gt_zero (ih _ h) h

theorem lt_add_lt_left (n m k: Int): n < m → k + n < k + m := by
  sorry

theorem ge_add_ge_right {n m: Int} (k: Int): n ≥ m → n + k ≥ m + k := by
  sorry

end Int

/-
### Properties on Nat
-/

theorem Nat.minus_plus_one {a: Nat} (h: a > 0): a - 1 + 1 = a := by
  cases a; simp at h; rfl

theorem Nat.lt_min_left {a b c: Nat}: c < min a b → c < a := sorry

theorem Nat.lt_min_right {a b c: Nat}: c < min a b → c < b := sorry
