
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_ashr_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → ¬8#64 ≥ ↑64 → truncate 8 ((truncate 32 x).sshiftRight' 8#32) = truncate 8 (x >>> 8#64) :=
sorry