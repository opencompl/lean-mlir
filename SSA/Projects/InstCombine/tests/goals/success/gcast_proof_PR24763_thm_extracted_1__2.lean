
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR24763_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#32 ≥ ↑32 → ¬1#8 ≥ ↑8 → truncate 16 (signExtend 32 x >>> 1#32) = signExtend 16 (x.sshiftRight' 1#8) :=
sorry