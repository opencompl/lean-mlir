
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (zeroExtend 32 (x &&& 255#16) <ᵤ 255#32) = 1#1 →
    truncate 16 (zeroExtend 32 (x &&& 255#16)) &&& 255#16 = x &&& 255#16 :=
sorry