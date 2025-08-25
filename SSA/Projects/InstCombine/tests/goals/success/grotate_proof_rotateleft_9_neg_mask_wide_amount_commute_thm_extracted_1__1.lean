
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem rotateleft_9_neg_mask_wide_amount_commute_thm.extracted_1._1 : ∀ (x : BitVec 33) (x_1 : BitVec 9),
  ¬(x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33) →
    True ∧ (zeroExtend 33 x_1 <<< (x &&& 8#33)).sshiftRight' (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
        True ∧ zeroExtend 33 x_1 <<< (x &&& 8#33) >>> (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
          x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33 →
      False :=
sorry