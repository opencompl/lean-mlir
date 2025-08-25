
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#36 ≥ ↑36 →
    8#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 ((zeroExtend 36 x ||| BitVec.ofInt 36 (-2147483648)).sshiftRight' 8#36)))
        PoisonOr.poison :=
sorry