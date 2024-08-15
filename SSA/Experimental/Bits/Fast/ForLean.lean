import Mathlib.Algebra.Group.Defs
import Mathlib.Tactic.NormNum

/-!
These theorems are separate in their own file because they
could potentially be upstreamed into Lean
-/

@[simp]
theorem Nat.mod_two_pow_mod_two (x : Nat) (w : Nat) (_ : 0 < w) : x % 2 ^ w % 2 = x % 2 := by
  have y : 2 ^ 1 ∣ 2 ^ w := Nat.pow_dvd_pow 2 (by omega)
  rw [pow_one 2] at y
  exact Nat.mod_mod_of_dvd x y

theorem Nat.parity_and (n m : Nat) :
    2 ≤ n % 2 + m % 2 ↔ n % 2 = 1 ∧ m % 2 = 1 := by
  omega

theorem Nat.add_odd_iff_neq (n m : Nat) :
    (n + m) % 2 = 1 ↔ (n % 2 = 1) ≠ (m % 2 = 1) := by
  cases' Nat.mod_two_eq_zero_or_one n with nparity nparity
  <;> cases' Nat.mod_two_eq_zero_or_one m with mparity mparity
  <;> simp [mparity, nparity, Nat.add_mod]

theorem Bool.xor_decide (p q : Prop) [dp : Decidable p] [Decidable  q] :
    (decide p).xor (decide q) = decide (p ≠ q) := by
  cases' dp with pt pt
  <;> simp [pt]
