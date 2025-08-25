
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test8_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(127#128 ≥ ↑128 ∨ 120#128 ≥ ↑128 ∨ 127#128 ≥ ↑128) →
    (x ^^^ (1#128 <<< 127#128).sshiftRight' 120#128) + 1#128 <<< 127#128 =
      x ^^^ 170141183460469231731687303715884105600#128 :=
sorry