
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_add_mismatched_exts_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    7#32 ≥ ↑32 ∨
        9#32 ≥ ↑32 ∨
          True ∧ (x >>> 9#32).msb = true ∨
            True ∧ (signExtend 64 (x.sshiftRight' 7#32)).saddOverflow (zeroExtend 64 (x >>> 9#32)) = true →
      False :=
sorry