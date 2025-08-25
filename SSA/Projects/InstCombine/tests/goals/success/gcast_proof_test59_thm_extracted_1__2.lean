
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test59_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    ¬(True ∧ (zeroExtend 32 x <<< 4#32).sshiftRight' 4#32 ≠ zeroExtend 32 x ∨
          True ∧ zeroExtend 32 x <<< 4#32 >>> 4#32 ≠ zeroExtend 32 x ∨
            4#32 ≥ ↑32 ∨
              4#8 ≥ ↑8 ∨
                True ∧ (x_1 >>> 4#8).msb = true ∨
                  True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 &&& zeroExtend 32 (x_1 >>> 4#8) != 0) = true ∨
                    True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)).msb = true) →
      zeroExtend 64 (zeroExtend 32 x_1 >>> 4#32 ||| zeroExtend 32 x <<< 4#32 &&& 48#32) =
        zeroExtend 64 (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)) :=
sorry