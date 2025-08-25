
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test21_thm.extracted_1._1 : ∀ (x : BitVec 12),
  ¬6#12 ≥ ↑12 → ofBool (x <<< 6#12 == BitVec.ofInt 12 (-128)) = ofBool (x &&& 63#12 == 62#12) :=
sorry