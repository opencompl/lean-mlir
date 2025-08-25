
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exact_ashr_eq_noexactdiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ BitVec.ofInt 8 (-80) >>> x <<< x ≠ BitVec.ofInt 8 (-80) ∨ x ≥ ↑8) →
    ofBool ((BitVec.ofInt 8 (-80)).sshiftRight' x == BitVec.ofInt 8 (-31)) = 0#1 :=
sorry