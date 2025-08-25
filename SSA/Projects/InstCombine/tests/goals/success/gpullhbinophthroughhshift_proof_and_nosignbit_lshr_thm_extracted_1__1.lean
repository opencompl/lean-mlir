
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_nosignbit_lshr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 → (x &&& 2147418112#32) >>> 8#32 = x >>> 8#32 &&& 8388352#32 :=
sorry