
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 → ¬4#8 ≥ ↑8 → truncate 12 (signExtend 16 x >>> 4#16) = signExtend 12 (x.sshiftRight' 4#8) :=
sorry