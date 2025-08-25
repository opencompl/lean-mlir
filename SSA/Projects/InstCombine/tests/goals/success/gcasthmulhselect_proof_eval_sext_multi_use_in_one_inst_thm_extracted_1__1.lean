
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eval_sext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true) →
    True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true ∨
          True ∧ ((truncate 16 x &&& 14#16) * (truncate 16 x &&& 14#16) &&& BitVec.ofInt 16 (-32768) != 0) = true →
      False :=
sorry