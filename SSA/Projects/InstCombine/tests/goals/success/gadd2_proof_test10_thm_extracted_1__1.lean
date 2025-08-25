
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬3#32 ≥ ↑32 →
    x_1 + 1#32 + ((x.sshiftRight' 3#32 ||| BitVec.ofInt 32 (-1431655766)) ^^^ 1431655765#32) =
      x_1 - (x.sshiftRight' 3#32 &&& 1431655765#32) :=
sorry