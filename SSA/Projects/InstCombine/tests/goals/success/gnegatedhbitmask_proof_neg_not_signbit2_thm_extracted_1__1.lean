
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_not_signbit2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬6#8 ≥ ↑8 →
    6#8 ≥ ↑8 ∨ True ∧ (x >>> 6#8).msb = true ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 6#8)) = true → False :=
sorry