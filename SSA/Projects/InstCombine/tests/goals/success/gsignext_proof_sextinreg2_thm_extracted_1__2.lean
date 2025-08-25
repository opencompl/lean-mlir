
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sextinreg2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ True ∧ x <<< 24#32 >>> 24#32 <<< 24#32 ≠ x <<< 24#32 ∨ 24#32 ≥ ↑32) →
    (x &&& 255#32 ^^^ 128#32) + BitVec.ofInt 32 (-128) = (x <<< 24#32).sshiftRight' 24#32 :=
sorry