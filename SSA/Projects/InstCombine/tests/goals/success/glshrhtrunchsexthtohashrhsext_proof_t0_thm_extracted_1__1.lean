
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 → signExtend 16 (truncate 4 (x >>> 4#8)) = signExtend 16 (x.sshiftRight' 4#8) :=
sorry