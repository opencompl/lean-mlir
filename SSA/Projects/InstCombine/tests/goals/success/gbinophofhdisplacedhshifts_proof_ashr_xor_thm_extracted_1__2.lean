
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_xor_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) →
    ¬x ≥ ↑8 → (BitVec.ofInt 8 (-128)).sshiftRight' x ^^^ (BitVec.ofInt 8 (-64)).sshiftRight' (x + 1#8) = 96#8 >>> x :=
sorry