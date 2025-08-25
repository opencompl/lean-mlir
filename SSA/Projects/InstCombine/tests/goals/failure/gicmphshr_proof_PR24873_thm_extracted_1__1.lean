
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR24873_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬x ≥ ↑64 → ofBool ((BitVec.ofInt 64 (-4611686018427387904)).sshiftRight' x == -1#64) = ofBool (61#64 <ᵤ x) :=
sorry