
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n10_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → 1#64 - x >>> 63#64 = zeroExtend 64 (ofBool (-1#64 <ₛ x)) :=
sorry