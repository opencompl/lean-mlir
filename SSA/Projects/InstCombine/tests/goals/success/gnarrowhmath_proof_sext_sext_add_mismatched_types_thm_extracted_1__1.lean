
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_sext_add_mismatched_types_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(7#16 ≥ ↑16 ∨ 9#32 ≥ ↑32) →
    7#16 ≥ ↑16 ∨
        9#32 ≥ ↑32 ∨
          True ∧ (signExtend 64 (x_1.sshiftRight' 7#16)).saddOverflow (signExtend 64 (x.sshiftRight' 9#32)) = true →
      False :=
sorry