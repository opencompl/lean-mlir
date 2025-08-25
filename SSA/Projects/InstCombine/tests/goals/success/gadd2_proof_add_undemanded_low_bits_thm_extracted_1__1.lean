
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_undemanded_low_bits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬4#32 ≥ ↑32 → ((x ||| 15#32) + 1616#32) >>> 4#32 = (x + 1616#32) >>> 4#32 :=
sorry