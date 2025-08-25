
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_lshr_const_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → 42#8 >>> x ^^^ -1#8 = (BitVec.ofInt 8 (-43)).sshiftRight' x :=
sorry