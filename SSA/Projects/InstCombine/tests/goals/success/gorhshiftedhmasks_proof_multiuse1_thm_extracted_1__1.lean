
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 2#32) >>> 1#32 <<< 1#32 ≠ x &&& 2#32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x &&& 4#32) >>> 1#32 <<< 1#32 ≠ x &&& 4#32 ∨
            1#32 ≥ ↑32 ∨
              True ∧ ((x &&& 2#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 2#32 ∨
                True ∧ (x &&& 2#32) <<< 6#32 >>> 6#32 ≠ x &&& 2#32 ∨
                  6#32 ≥ ↑32 ∨
                    True ∧ ((x &&& 4#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 4#32 ∨
                      True ∧ (x &&& 4#32) <<< 6#32 >>> 6#32 ≠ x &&& 4#32 ∨ 6#32 ≥ ↑32) →
    1#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x >>> 1#32 &&& 1#32 &&& (x >>> 1#32 &&& 2#32) != 0) = true ∨
            6#32 ≥ ↑32 ∨
              True ∧ ((x >>> 1#32 &&& 1#32 ||| x >>> 1#32 &&& 2#32) &&& (x <<< 6#32 &&& 384#32) != 0) = true →
      False :=
sorry