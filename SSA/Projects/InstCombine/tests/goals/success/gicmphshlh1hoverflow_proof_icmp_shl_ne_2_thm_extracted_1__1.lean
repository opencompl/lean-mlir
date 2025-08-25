
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_ne_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨
        (x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨ 1#8 ≥ ↑8) →
    (x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true → False :=
sorry