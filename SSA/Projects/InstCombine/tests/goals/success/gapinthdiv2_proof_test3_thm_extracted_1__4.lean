
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 599),
  ¬x = 1#1 → ¬4096#599 = 0 → ¬12#599 ≥ ↑599 → x_1 / 4096#599 = x_1 >>> 12#599 :=
sorry