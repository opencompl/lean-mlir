
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → signExtend 16 (truncate 3 (x >>> 5#8)) = signExtend 16 (x.sshiftRight' 5#8) :=
sorry