
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem match_andAsRem_lshrAsDiv_shlAsMul_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(6#64 ≥ ↑64 ∨ 9#64 = 0 ∨ 6#64 ≥ ↑64) →
    576#64 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x &&& 63#64) + (x >>> 6#64 % 9#64) <<< 6#64)) PoisonOr.poison :=
sorry