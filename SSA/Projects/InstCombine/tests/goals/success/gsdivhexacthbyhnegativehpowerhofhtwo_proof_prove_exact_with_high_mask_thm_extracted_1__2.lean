
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem prove_exact_with_high_mask_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(BitVec.ofInt 8 (-4) == 0 || 8 != 1 && x &&& BitVec.ofInt 8 (-32) == intMin 8 && BitVec.ofInt 8 (-4) == -1) = true →
    ¬(2#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 2#8 &&& BitVec.ofInt 8 (-8)) = true) →
      (x &&& BitVec.ofInt 8 (-32)).sdiv (BitVec.ofInt 8 (-4)) = 0#8 - (x.sshiftRight' 2#8 &&& BitVec.ofInt 8 (-8)) :=
sorry