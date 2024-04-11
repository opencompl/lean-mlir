import Mathlib.Tactic.Ring
import Mathlib.Data.BitVec.Lemmas

namespace BitVec
open Nat

theorem ofInt_negSucc (w n : Nat ) :
    BitVec.ofInt w (Int.negSucc n) = ~~~.ofNat w n := by
  simp [BitVec.ofInt]
  apply BitVec.toNat_injective
  simp only [Int.toNat, toNat_ofNatLt, toNat_not, toNat_ofNat]
  split
  · simp_all [Int.negSucc_emod]
    symm
    rw [← Int.natCast_inj]
    rw [Nat.cast_sub]
    rw [Nat.cast_sub]
    have _ : 0 < 2 ^ w := by simp
    simp_all only [gt_iff_lt, ofNat_pos, pow_pos, cast_pow, Nat.cast_ofNat, cast_one,
      Int.ofNat_emod]
    have h : 0 < 2 ^ w := by simp
    omega
    omega

  · have nonneg : Int.negSucc n % 2 ^ w ≥ 0 := by
      simp only [ge_iff_le, ne_eq, pow_eq_zero_iff', OfNat.ofNat_ne_zero, false_and,
        not_false_eq_true, Int.emod_nonneg (Int.negSucc n) _]
    simp_all only [ofNat_pos, gt_iff_lt, pow_pos, ne_eq, pow_eq_zero_iff', OfNat.ofNat_ne_zero,
      false_and, not_false_eq_true, ge_iff_le, Int.negSucc_not_nonneg]

theorem ofFin_intCast (z : ℤ) : ofFin (z : Fin (2^w)) = Int.cast z := by
  cases w
  case zero =>
    simp only [eq_nil]
  case succ w =>
    simp only [Int.cast, IntCast.intCast]
    unfold Int.castDef
    cases' z with z z
    · rfl
    · rw [ofInt_negSucc]
      simp only [cast_add, cast_one, neg_add_rev]
      rw [← add_ofFin, ofFin_neg, ofFin_ofNat, ofNat_eq_ofNat, ofFin_neg, ofFin_natCast,
        natCast_eq_ofNat, negOne_eq_allOnes, ← sub_toAdd, allOnes_sub_eq_not]

theorem toFin_intCast (z : ℤ) : toFin (z : BitVec w) = z := by
  apply toFin_inj.mpr <| (ofFin_intCast z).symm

instance : CommRing (BitVec w) :=
  toFin_injective.commRing _
    toFin_zero toFin_one toFin_add toFin_mul toFin_neg toFin_sub
    toFin_nsmul toFin_zsmul toFin_pow toFin_natCast toFin_intCast
