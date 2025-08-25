
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_lshr_exact__exact_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
sorry