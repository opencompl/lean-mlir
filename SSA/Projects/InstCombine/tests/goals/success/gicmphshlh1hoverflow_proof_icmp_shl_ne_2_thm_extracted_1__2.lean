
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_ne_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬((x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨
        (x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨ 1#8 ≥ ↑8) →
    ¬(x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true →
      ofBool ((42#8).sdiv x != (42#8).sdiv x <<< 1#8) = ofBool ((42#8).sdiv x != 0#8) :=
sorry