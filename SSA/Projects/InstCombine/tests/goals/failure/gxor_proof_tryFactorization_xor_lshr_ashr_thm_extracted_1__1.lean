
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_xor_lshr_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) →
    x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (5#32 >>> x ^^^ (BitVec.ofInt 32 (-3)).sshiftRight' x)) PoisonOr.poison :=
sorry