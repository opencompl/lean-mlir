
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 96#32) >>> 1#32 <<< 1#32 ≠ x &&& 96#32 ∨
        1#32 ≥ ↑32 ∨
          1#32 ≥ ↑32 ∨
            True ∧ ((x &&& 96#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 96#32 ∨
              True ∧ (x &&& 96#32) <<< 6#32 >>> 6#32 ≠ x &&& 96#32 ∨ 6#32 ≥ ↑32 ∨ 6#32 ≥ ↑32) →
    1#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x >>> 1#32 &&& 48#32 &&& (x >>> 1#32 &&& 15#32) != 0) = true ∨
            6#32 ≥ ↑32 ∨
              True ∧ ((x >>> 1#32 &&& 48#32 ||| x >>> 1#32 &&& 15#32) &&& (x <<< 6#32 &&& 8064#32) != 0) = true →
      False :=
sorry