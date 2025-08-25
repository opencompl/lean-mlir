
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_thm.extracted_1._2 : ∀ (x x_1 : BitVec 16),
  ¬((42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨ 5#16 ≥ ↑16 ∨ 7#16 ≥ ↑16) →
    ¬(12#16 ≥ ↑16 ∨
          (42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨
            True ∧ (x_1.srem 42#16 <<< 7#16).sshiftRight' 7#16 ≠ x_1.srem 42#16 ∨ 7#16 ≥ ↑16) →
      (x_1.srem 42#16 ||| x <<< 5#16) <<< 7#16 = x <<< 12#16 ||| x_1.srem 42#16 <<< 7#16 :=
sorry