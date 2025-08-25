
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lsb_mask_sign_zext_wrong_cst2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ 2#32)) >>> 31#32 = (x + -1#32 &&& x) >>> 31#32 :=
sorry