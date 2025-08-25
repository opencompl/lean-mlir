
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬(True ∧ 16#8 >>> 3#8 <<< 3#8 ≠ 16#8 ∨ 3#8 ≥ ↑8) → (16#8).sshiftRight' 3#8 = 2#8 :=
sorry