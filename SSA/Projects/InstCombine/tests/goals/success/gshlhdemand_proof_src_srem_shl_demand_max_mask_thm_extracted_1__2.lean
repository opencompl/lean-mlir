
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_srem_shl_demand_max_mask_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 1#32 ≥ ↑32) →
    ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
      x.srem 2#32 <<< 1#32 &&& BitVec.ofInt 32 (-4) = x.srem 2#32 &&& BitVec.ofInt 32 (-4) :=
sorry