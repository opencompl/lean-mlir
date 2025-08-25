
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addhshlhsdivhnegative1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((-1#32 == 0 || 32 != 1 && x == intMin 32 && -1#32 == -1) = true ∨ 1#32 ≥ ↑32) →
    x.sdiv (-1#32) <<< 1#32 + x = 0#32 - x :=
sorry