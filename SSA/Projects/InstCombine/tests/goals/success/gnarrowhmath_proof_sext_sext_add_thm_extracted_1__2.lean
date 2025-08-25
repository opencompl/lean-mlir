
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_sext_add_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 7#32).saddOverflow (x.sshiftRight' 9#32) = true) →
      signExtend 64 (x.sshiftRight' 7#32) + signExtend 64 (x.sshiftRight' 9#32) =
        signExtend 64 (x.sshiftRight' 7#32 + x.sshiftRight' 9#32) :=
sorry