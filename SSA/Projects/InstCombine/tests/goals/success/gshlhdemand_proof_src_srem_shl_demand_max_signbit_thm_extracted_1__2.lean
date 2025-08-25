
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_srem_shl_demand_max_signbit_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 30#32 ≥ ↑32) →
    ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
      x.srem 2#32 <<< 30#32 &&& BitVec.ofInt 32 (-2147483648) = x.srem 2#32 &&& BitVec.ofInt 32 (-2147483648) :=
sorry