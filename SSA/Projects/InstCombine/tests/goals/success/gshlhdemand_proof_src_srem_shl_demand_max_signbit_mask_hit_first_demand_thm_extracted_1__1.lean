
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((4#32 == 0 || 32 != 1 && x == intMin 32 && 4#32 == -1) = true ∨ 29#32 ≥ ↑32) →
    (4#32 == 0 || 32 != 1 && x == intMin 32 && 4#32 == -1) = true ∨
        True ∧ (x.srem 4#32 <<< 29#32).sshiftRight' 29#32 ≠ x.srem 4#32 ∨ 29#32 ≥ ↑32 →
      False :=
sorry