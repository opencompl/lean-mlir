
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_select_sext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → 64#64 * signExtend 64 x = BitVec.ofInt 64 (-64) :=
sorry