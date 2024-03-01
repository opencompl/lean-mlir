import Mathlib.Tactic.Ring
import Std.Data.BitVec
import Mathlib.Data.BitVec.Lemmas
import Mathlib.Data.BitVec.Defs

namespace Std.BitVec
open Nat

theorem ofFin_intCast (z : ℤ) : ofFin (z : Fin (2^w)) = Int.cast z := by
  cases w
  case zero =>
    simp only [eq_nil]
  case succ w =>
    simp only [Int.cast, IntCast.intCast, BitVec.ofInt]
    unfold Int.castDef
    cases' z with z z
    · rfl
    · simp only [cast_add, cast_one, neg_add_rev]
      rw [← add_ofFin, ofFin_neg, ofFin_ofNat, ofNat_eq_ofNat, ofFin_neg, ofFin_natCast,
        natCast_eq_ofNat, negOne_eq_allOnes, ← sub_toAdd, allOnes_sub_eq_not]

theorem toFin_intCast (z : ℤ) : toFin (z : BitVec w) = z := by
  apply toFin_inj.mpr <| (ofFin_intCast z).symm

instance : CommRing (BitVec w) :=
  toFin_injective.commRing _
    toFin_zero toFin_one toFin_add toFin_mul toFin_neg toFin_sub
    (Function.swap toFin_nsmul) (Function.swap toFin_zsmul) toFin_pow toFin_natCast toFin_intCast
