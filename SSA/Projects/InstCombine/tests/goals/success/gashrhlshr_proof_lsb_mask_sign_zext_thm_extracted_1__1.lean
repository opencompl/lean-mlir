
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lsb_mask_sign_zext_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ -1#32)) >>> 31#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
sorry