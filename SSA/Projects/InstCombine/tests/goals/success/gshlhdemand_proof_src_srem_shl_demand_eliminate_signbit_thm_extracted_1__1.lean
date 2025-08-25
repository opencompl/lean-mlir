
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_srem_shl_demand_eliminate_signbit_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((1073741824#32 == 0 || 32 != 1 && x == intMin 32 && 1073741824#32 == -1) = true ∨ 1#32 ≥ ↑32) →
    (1073741824#32 == 0 || 32 != 1 && x == intMin 32 && 1073741824#32 == -1) = true ∨
        True ∧ (x.srem 1073741824#32 <<< 1#32).sshiftRight' 1#32 ≠ x.srem 1073741824#32 ∨ 1#32 ≥ ↑32 →
      False :=
sorry