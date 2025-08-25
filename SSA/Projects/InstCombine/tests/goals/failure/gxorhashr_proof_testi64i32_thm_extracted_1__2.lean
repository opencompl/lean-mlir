
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi64i32_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ¬ofBool (-1#64 <ₛ x) = 1#1 → truncate 32 (x.sshiftRight' 63#64) ^^^ 127#32 = BitVec.ofInt 32 (-128) :=
sorry