
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_lshr_infloop_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) → 1#32 ≥ ↑32 → False :=
sorry