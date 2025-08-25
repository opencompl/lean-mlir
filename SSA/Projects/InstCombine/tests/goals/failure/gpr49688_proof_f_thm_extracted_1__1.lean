
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 0#32) = 1#1 → ¬x ≥ ↑32 → ofBool ((7#32).sshiftRight' x <ₛ x) = ofBool (7#32 >>> x <ₛ x) :=
sorry