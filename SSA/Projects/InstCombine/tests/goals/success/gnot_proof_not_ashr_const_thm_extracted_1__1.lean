
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_ashr_const_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → (BitVec.ofInt 8 (-42)).sshiftRight' x ^^^ -1#8 = 41#8 >>> x :=
sorry