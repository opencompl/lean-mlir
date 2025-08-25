
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sextinreg_alt_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ True ∧ x <<< 16#32 >>> 16#32 <<< 16#32 ≠ x <<< 16#32 ∨ 16#32 ≥ ↑32) →
    (x &&& 65535#32 ^^^ 32768#32) + BitVec.ofInt 32 (-32768) = (x <<< 16#32).sshiftRight' 16#32 :=
sorry