
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem same_signbit_wrong_type_signed_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 →
    ofBool (x_1.sshiftRight' 7#8 != signExtend 8 (ofBool (-1#32 <ₛ x))) = ofBool (x_1 <ₛ 0#8) ^^^ ofBool (-1#32 <ₛ x) :=
sorry