
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_eq_amt_multi_use_thm.extracted_1._2 : ∀ (x : BitVec 43),
  ¬(23#43 ≥ ↑43 ∨ 23#43 ≥ ↑43 ∨ 23#43 ≥ ↑43) →
    ¬23#43 ≥ ↑43 → x >>> 23#43 * x >>> 23#43 <<< 23#43 = x >>> 23#43 * (x &&& BitVec.ofInt 43 (-8388608)) :=
sorry