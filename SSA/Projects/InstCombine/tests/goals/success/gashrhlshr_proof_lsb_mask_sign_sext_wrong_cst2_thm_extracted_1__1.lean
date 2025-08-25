
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lsb_mask_sign_sext_wrong_cst2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → (x + -1#32 &&& (x ^^^ 2#32)).sshiftRight' 31#32 = (x + -1#32 &&& x).sshiftRight' 31#32 :=
sorry