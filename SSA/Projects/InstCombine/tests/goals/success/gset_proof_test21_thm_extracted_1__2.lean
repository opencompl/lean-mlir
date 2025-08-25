
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test21_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬2#32 ≥ ↑32 → zeroExtend 32 (ofBool (x &&& 4#32 != 0#32)) = x >>> 2#32 &&& 1#32 :=
sorry