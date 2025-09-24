
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- gandhorhicmps_proof_logical_or_logical_or_icmps_comm1_thm_extracted_1__7.lean
-/
import Blase
open BitVec

-- This needs shift left support, and is also probably only provable given
-- the fixed width. In particular, the constraint ¬ 'x_1 ≥ 8' seems a bit suspicious.
-- We should refute this as a arbitrary width theorem, probably, with no abstracted variables.
theorem logical_or_logical_or_icmps_comm1_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ¬(ofBool (x_2 &&& 1#8 <<< x_1 == 0#8) = 1#1 ∨ ofBool (x == 42#8) = 1#1) →
      ¬(True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8) →
        ¬ofBool (x_2 &&& 1#8 <<< x_1 == 0#8) = 1#1 → ofBool (x == 42#8) = 1#1 → ofBool (x_2 &&& 1#8 == 0#8) = 1#1 := by
  bv_multi_width (config := { niter := 20 })
