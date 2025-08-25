
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 →
    ofBool (x <<< 8#32 &&& BitVec.ofInt 32 (-16777216) == 167772160#32) = ofBool (x &&& 16711680#32 == 655360#32) :=
sorry