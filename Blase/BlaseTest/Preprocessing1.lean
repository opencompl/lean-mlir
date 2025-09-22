
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- test from: gnot_proof_test_invert_demorgan_logical_or_thm_extracted_1__6.lean
-/
import Blase
open BitVec


@[bv_multi_width_normalize] theorem ofBool_eq_1_iff (x : Bool) :
  ofBool x = 1#1 ↔ x = True := by sorry

@[bv_multi_width_normalize] theorem not_eq_iff_ne (x y : α) :
  ¬ (x = y) ↔ x ≠ y := by simp

theorem test_invert_demorgan_logical_or_thm.extracted_1._6 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 == 27#64) = 1#1 →
    ¬ofBool (x_1 != 27#64) = 1#1 →
      (ofBool (x_1 == 0#64) ||| ofBool (x == 0#64)) ^^^ 1#1 = ofBool (x_1 != 0#64) &&& 0#1 := by
  intros a b c;
  bv_multi_width_normalize
  simp [ofBool_eq_1_iff] at *
  rw [not_eq_iff_ne] at c
  bv_multi_width +verbose?
