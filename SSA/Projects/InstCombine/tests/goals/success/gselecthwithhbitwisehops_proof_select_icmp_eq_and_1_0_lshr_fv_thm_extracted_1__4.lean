
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_eq_and_1_0_lshr_fv_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 1#8 == 0#8) = 1#1 →
    ¬2#8 ≥ ↑8 → ¬(1#8 ≥ ↑8 ∨ x_1 <<< 1#8 &&& 2#8 ≥ ↑8) → x >>> 2#8 = x >>> (x_1 <<< 1#8 &&& 2#8) :=
sorry