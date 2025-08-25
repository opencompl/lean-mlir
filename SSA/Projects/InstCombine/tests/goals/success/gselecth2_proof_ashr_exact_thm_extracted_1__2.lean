
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬(True ∧ 16#8 >>> 3#8 <<< 3#8 ≠ 16#8 ∨ 3#8 ≥ ↑8) → (16#8).sshiftRight' 3#8 = 2#8 :=
sorry