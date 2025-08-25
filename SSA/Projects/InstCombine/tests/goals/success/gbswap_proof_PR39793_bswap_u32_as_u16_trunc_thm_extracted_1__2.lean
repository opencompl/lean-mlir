
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR39793_bswap_u32_as_u16_trunc_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬8#32 ≥ ↑32 → truncate 8 (x >>> 8#32 &&& 255#32 ||| x <<< 8#32 &&& 65280#32) = truncate 8 (x >>> 8#32) :=
sorry