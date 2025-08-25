
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_C1_add_A_C2_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(x &&& 65535#32) + 5#32 ≥ ↑32 →
    ¬x &&& 65535#32 ≥ ↑32 → 6#32 <<< ((x &&& 65535#32) + 5#32) = 192#32 <<< (x &&& 65535#32) :=
sorry