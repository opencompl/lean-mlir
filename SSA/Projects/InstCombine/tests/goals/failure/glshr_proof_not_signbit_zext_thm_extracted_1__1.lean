
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_signbit_zext_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → zeroExtend 32 ((x ^^^ -1#16) >>> 15#16) = zeroExtend 32 (ofBool (-1#16 <ₛ x)) :=
sorry