
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_02_05_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 2#4 <<< 2#4 ≠ x ∨ 2#4 ≥ ↑4) → ofBool (x.sshiftRight' 2#4 <ₛ 5#4) = 1#1 :=
sorry