
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true) →
    zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) = signExtend 7 x :=
sorry