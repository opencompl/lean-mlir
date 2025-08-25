
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x ≥ ↑32 ∨
        True ∧ (x + BitVec.ofInt 32 (-16)).msb = true ∨
          zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64 ∨
            True ∧
                signExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ∨
              True ∧
                zeroExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) →
      False :=
sorry