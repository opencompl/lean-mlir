
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test93_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬64#96 ≥ ↑96 → ¬31#32 ≥ ↑32 → truncate 32 (signExtend 96 x >>> 64#96) = x.sshiftRight' 31#32 :=
sorry