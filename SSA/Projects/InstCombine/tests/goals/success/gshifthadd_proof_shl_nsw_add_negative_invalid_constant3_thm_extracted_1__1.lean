
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_add_negative_invalid_constant3_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (2#4 <<< (x + BitVec.ofInt 4 (-8))).sshiftRight' (x + BitVec.ofInt 4 (-8)) ≠ 2#4 ∨
        x + BitVec.ofInt 4 (-8) ≥ ↑4) →
    True ∧ (2#4 <<< (x ^^^ BitVec.ofInt 4 (-8))).sshiftRight' (x ^^^ BitVec.ofInt 4 (-8)) ≠ 2#4 ∨
        x ^^^ BitVec.ofInt 4 (-8) ≥ ↑4 →
      False :=
sorry