
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#16 ≥ ↑16 → ¬7#8 ≥ ↑8 → truncate 8 (signExtend 16 x >>> 8#16) = x.sshiftRight' 7#8 :=
sorry