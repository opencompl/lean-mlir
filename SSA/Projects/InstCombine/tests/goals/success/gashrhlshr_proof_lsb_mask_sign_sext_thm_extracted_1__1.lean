
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lsb_mask_sign_sext_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ -1#32)).sshiftRight' 31#32 = signExtend 32 (ofBool (x == 0#32)) :=
sorry