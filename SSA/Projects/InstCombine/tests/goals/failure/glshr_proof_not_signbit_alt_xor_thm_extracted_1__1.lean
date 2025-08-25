
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_signbit_alt_xor_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → (x ^^^ BitVec.ofInt 8 (-2)) >>> 7#8 = zeroExtend 8 (ofBool (-1#8 <ₛ x)) :=
sorry