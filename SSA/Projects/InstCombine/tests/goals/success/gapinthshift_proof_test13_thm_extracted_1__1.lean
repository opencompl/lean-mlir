
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._1 : ∀ (x : BitVec 18),
  ¬(8#18 ≥ ↑18 ∨ 9#18 ≥ ↑18) → (x * 3#18).sshiftRight' 8#18 <<< 9#18 = x * 6#18 &&& BitVec.ofInt 18 (-512) :=
sorry