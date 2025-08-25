
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi16i8_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬15#16 ≥ ↑16 → ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 27#8 = BitVec.ofInt 8 (-28) :=
sorry