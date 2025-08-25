
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR39793_bswap_u64_as_u16_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(8#64 ≥ ↑64 ∨ 8#64 ≥ ↑64) →
    ¬8#64 ≥ ↑64 → truncate 8 (x >>> 8#64 &&& 255#64 ||| x <<< 8#64 &&& 65280#64) = truncate 8 (x >>> 8#64) :=
sorry