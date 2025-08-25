
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_or_lshr_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (0#32 - x ||| x) >>> 31#32 = zeroExtend 32 (ofBool (x != 0#32)) :=
sorry