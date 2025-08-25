
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_invert_signbit_splat_mask2_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬6#8 ≥ ↑8 →
    signExtend 16 (x_1.sshiftRight' 6#8 ^^^ -1#8) &&& x = x &&& signExtend 16 (x_1.sshiftRight' 6#8 ^^^ -1#8) :=
sorry