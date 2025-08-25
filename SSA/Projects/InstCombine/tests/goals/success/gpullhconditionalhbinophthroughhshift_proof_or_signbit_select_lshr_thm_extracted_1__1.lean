
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_signbit_select_lshr_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ¬8#32 ≥ ↑32 → (x ||| BitVec.ofInt 32 (-65536)) >>> 8#32 = x >>> 8#32 ||| 16776960#32 :=
sorry