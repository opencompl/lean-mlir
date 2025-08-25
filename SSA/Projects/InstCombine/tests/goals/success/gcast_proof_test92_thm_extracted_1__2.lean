
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test92_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#96 ≥ ↑96 → ¬32#64 ≥ ↑64 → truncate 64 (signExtend 96 x >>> 32#96) = x.sshiftRight' 32#64 :=
sorry