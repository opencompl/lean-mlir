
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(5#8 ≥ ↑8 ∨ True ∧ ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8).msb = true) →
      zeroExtend 32
          (((truncate 8 x ||| BitVec.ofInt 8 (-17)) ^^^
                ((truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)) <<< 6#8 ^^^
                  (truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)))) >>>
              7#8 *
            64#8) =
        zeroExtend 32 ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8) :=
sorry