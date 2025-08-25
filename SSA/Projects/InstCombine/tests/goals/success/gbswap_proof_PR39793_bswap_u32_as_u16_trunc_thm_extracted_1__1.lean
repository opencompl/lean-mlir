
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR39793_bswap_u32_as_u16_trunc_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) → 8#32 ≥ ↑32 → False :=
sorry