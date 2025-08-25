
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shift_and_cmp_changed1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ 5#8 ≥ ↑8) →
    ¬5#8 ≥ ↑8 →
      ofBool (((x_1 &&& 8#8 ||| x &&& 6#8) <<< 5#8).sshiftRight' 5#8 <ₛ 1#8) =
        ofBool (x <<< 5#8 &&& BitVec.ofInt 8 (-64) <ₛ 32#8) :=
sorry