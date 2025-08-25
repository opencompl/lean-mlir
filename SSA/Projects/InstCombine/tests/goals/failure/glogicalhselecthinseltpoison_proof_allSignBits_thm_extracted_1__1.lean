
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem allSignBits_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
    ofBool (x_1 <ₛ 0#32) = 1#1 →
      x_2 &&& x_1.sshiftRight' 31#32 ||| (x_1.sshiftRight' 31#32 ^^^ -1#32) &&& x = x_2 ||| 0#32 :=
sorry