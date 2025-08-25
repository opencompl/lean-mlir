
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi8i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (-1#8 <ₛ x) = 1#1 → x.sshiftRight' 7#8 ^^^ 127#8 = 127#8 :=
sorry