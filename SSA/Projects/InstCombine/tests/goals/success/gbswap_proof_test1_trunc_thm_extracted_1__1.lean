
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_trunc_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    24#32 ≥ ↑32 ∨
        8#32 ≥ ↑32 ∨
          True ∧ (x >>> 24#32 &&& (x >>> 8#32 &&& 65280#32) != 0) = true ∨
            True ∧
              zeroExtend 32 (truncate 16 (x >>> 24#32 ||| x >>> 8#32 &&& 65280#32)) ≠
                x >>> 24#32 ||| x >>> 8#32 &&& 65280#32 →
      False :=
sorry