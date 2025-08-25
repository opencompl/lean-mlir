
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ zeroExtend 32 x ≥ ↑32) →
    True ∧ ((-1#32) <<< zeroExtend 32 x).sshiftRight' (zeroExtend 32 x) ≠ -1#32 ∨
        zeroExtend 32 x ≥ ↑32 ∨
          True ∧
              ((((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x) <<< zeroExtend 32 x).sshiftRight'
                  (zeroExtend 32 x) ≠
                ((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x ∨
            True ∧
                (((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x) <<< zeroExtend 32 x >>> zeroExtend 32 x ≠
                  ((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x ∨
              zeroExtend 32 x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((((-1#32) <<< zeroExtend 32 x ^^^ -1#32) &&& zeroExtend 32 x) <<< zeroExtend 32 x))
        PoisonOr.poison :=
sorry