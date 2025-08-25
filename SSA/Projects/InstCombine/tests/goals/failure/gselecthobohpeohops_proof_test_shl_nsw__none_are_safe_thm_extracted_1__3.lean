
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shl_nsw__none_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2)) <<< 2#32)))) PoisonOr.poison :=
sorry