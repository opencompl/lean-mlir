
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_nuw_poison_constant_fold_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 →
    ¬(True ∧ (16#8 <<< 3#8).sshiftRight' 3#8 ≠ 16#8 ∨ True ∧ 16#8 <<< 3#8 >>> 3#8 ≠ 16#8 ∨ 3#8 ≥ ↑8) →
      16#8 <<< 3#8 = BitVec.ofInt 8 (-128) :=
sorry