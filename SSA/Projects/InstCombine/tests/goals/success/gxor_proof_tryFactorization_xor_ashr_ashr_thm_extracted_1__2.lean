
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_xor_ashr_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) →
    ¬x ≥ ↑32 → (BitVec.ofInt 32 (-3)).sshiftRight' x ^^^ (BitVec.ofInt 32 (-5)).sshiftRight' x = 6#32 >>> x :=
sorry