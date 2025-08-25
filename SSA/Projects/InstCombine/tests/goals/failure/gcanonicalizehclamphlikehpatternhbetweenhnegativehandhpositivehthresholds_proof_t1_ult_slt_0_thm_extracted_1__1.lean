
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_ult_slt_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x + 16#32 <ᵤ 144#32) = 1#1 → ofBool (127#32 <ₛ x) = 1#1 ∨ ofBool (x <ₛ BitVec.ofInt 32 (-16)) = 1#1 → False :=
sorry