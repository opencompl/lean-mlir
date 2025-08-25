
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_xor_ashr_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) →
    ¬x ≥ ↑32 → (BitVec.ofInt 32 (-3)).sshiftRight' x ^^^ 5#32 >>> x = (BitVec.ofInt 32 (-8)).sshiftRight' x :=
sorry