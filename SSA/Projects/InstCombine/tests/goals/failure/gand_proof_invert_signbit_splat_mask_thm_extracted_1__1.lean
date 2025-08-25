
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_signbit_splat_mask_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (-1#8 <ₛ x_1) = 1#1 → signExtend 16 (x_1.sshiftRight' 7#8 ^^^ -1#8) &&& x = x :=
sorry