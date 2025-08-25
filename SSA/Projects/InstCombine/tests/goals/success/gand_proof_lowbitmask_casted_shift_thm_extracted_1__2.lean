
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowbitmask_casted_shift_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ¬1#32 ≥ ↑32 → signExtend 32 (x.sshiftRight' 1#8) &&& 2147483647#32 = signExtend 32 x >>> 1#32 :=
sorry