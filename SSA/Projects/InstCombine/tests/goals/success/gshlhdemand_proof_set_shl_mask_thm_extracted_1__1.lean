
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_shl_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → (x_1 ||| 196609#32) <<< x &&& 65536#32 = (x_1 ||| 65537#32) <<< x &&& 65536#32 :=
sorry