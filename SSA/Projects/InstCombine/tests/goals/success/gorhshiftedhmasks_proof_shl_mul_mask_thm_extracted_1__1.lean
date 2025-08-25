
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_mul_mask_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 →
    True ∧ (x &&& 255#32).smulOverflow 65537#32 = true ∨
        True ∧ (x &&& 255#32).umulOverflow 65537#32 = true ∨
          True ∧ ((x &&& 255#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 255#32 ∨
            True ∧ (x &&& 255#32) <<< 8#32 >>> 8#32 ≠ x &&& 255#32 ∨ 8#32 ≥ ↑32 →
      False :=
sorry