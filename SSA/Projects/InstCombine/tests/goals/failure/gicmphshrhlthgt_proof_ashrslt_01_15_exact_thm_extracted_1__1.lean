
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_01_15_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 1#4 <<< 1#4 ≠ x ∨ 1#4 ≥ ↑4) →
    ofBool (x.sshiftRight' 1#4 <ₛ -1#4) = ofBool (x <ₛ BitVec.ofInt 4 (-2)) :=
sorry