
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shift_negative_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧
          ((x_1 ||| BitVec.ofInt 32 (-2147483648)) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠
            x_1 ||| BitVec.ofInt 32 (-2147483648) ∨
        x &&& 7#32 ≥ ↑32) →
    ofBool ((x_1 ||| BitVec.ofInt 32 (-2147483648)) <<< (x &&& 7#32) <ₛ 0#32) = 1#1 :=
sorry