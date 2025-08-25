
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_mask_weird_type_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ¬8#37 ≥ ↑37 →
    True ∧ ((x &&& 255#37) <<< 8#37).sshiftRight' 8#37 ≠ x &&& 255#37 ∨
        True ∧ (x &&& 255#37) <<< 8#37 >>> 8#37 ≠ x &&& 255#37 ∨
          8#37 ≥ ↑37 ∨ True ∧ (x &&& 255#37 &&& (x &&& 255#37) <<< 8#37 != 0) = true →
      False :=
sorry