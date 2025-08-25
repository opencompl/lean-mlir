
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_mask_wrong_shl_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬7#32 ≥ ↑32 →
    True ∧ ((x &&& 255#32) <<< 7#32).sshiftRight' 7#32 ≠ x &&& 255#32 ∨
        True ∧ (x &&& 255#32) <<< 7#32 >>> 7#32 ≠ x &&& 255#32 ∨ 7#32 ≥ ↑32 →
      False :=
sorry