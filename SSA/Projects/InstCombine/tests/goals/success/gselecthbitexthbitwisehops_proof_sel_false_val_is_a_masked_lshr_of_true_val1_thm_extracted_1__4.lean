
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 60#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 60#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
sorry