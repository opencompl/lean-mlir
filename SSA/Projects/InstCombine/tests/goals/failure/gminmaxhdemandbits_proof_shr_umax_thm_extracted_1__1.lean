
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shr_umax_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 15#32) = 1#1 → ¬4#32 ≥ ↑32 → 15#32 >>> 4#32 = x >>> 4#32 :=
sorry