
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_eq_amt_multi_use_thm.extracted_1._2 : ∀ (x : BitVec 44),
  ¬(33#44 ≥ ↑44 ∨ 33#44 ≥ ↑44 ∨ 33#44 ≥ ↑44) →
    ¬(33#44 ≥ ↑44 ∨ True ∧ (x <<< 33#44 &&& (x &&& 2047#44) != 0) = true) →
      x <<< 33#44 + x <<< 33#44 >>> 33#44 = x <<< 33#44 ||| x &&& 2047#44 :=
sorry