
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi128i128_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬127#128 ≥ ↑128 → ofBool (-1#128 <ₛ x) = 1#1 → x.sshiftRight' 127#128 ^^^ 27#128 = 27#128 :=
sorry