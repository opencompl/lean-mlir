
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_eq_ne_0_fail2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬30#32 ≥ ↑32 →
    ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x >>> 30#32) =
      ofBool (x >>> 30#32 == zeroExtend 32 (ofBool (x != 0#32))) :=
sorry