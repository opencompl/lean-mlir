
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 23),
  ¬(11#23 ≥ ↑23 ∨ 12#23 ≥ ↑23) → (x * 3#23) >>> 11#23 <<< 12#23 = x * 6#23 &&& BitVec.ofInt 23 (-4096) :=
sorry