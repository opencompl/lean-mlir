
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_poison_constant_fold_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬(True ∧ 42#8 >>> 3#8 <<< 3#8 ≠ 42#8 ∨ 3#8 ≥ ↑8) → (42#8).sshiftRight' 3#8 = 5#8 :=
sorry