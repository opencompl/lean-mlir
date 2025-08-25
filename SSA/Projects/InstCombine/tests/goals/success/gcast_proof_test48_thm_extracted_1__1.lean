
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test48_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x <<< 8#32).sshiftRight' 8#32 ≠ zeroExtend 32 x ∨
        True ∧ zeroExtend 32 x <<< 8#32 >>> 8#32 ≠ zeroExtend 32 x ∨
          8#32 ≥ ↑32 ∨
            True ∧ (zeroExtend 32 x <<< 8#32 &&& zeroExtend 32 x != 0) = true ∨
              True ∧ (zeroExtend 32 x <<< 8#32 ||| zeroExtend 32 x).msb = true →
      False :=
sorry