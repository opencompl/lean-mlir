
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_0_and_4096_xor_32_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 4096#32) = 1#1 → ¬7#32 ≥ ↑32 → x = x_1 >>> 7#32 &&& 32#32 ^^^ x ^^^ 32#32 :=
sorry