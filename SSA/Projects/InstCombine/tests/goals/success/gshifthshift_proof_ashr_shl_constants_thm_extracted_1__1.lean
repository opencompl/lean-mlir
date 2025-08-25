
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_shl_constants_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ 3#32 ≥ ↑32) →
    x ≥ ↑32 ∨
        True ∧
            ((BitVec.ofInt 32 (-33)).sshiftRight' x <<< 3#32).sshiftRight' 3#32 ≠
              (BitVec.ofInt 32 (-33)).sshiftRight' x ∨
          3#32 ≥ ↑32 →
      False :=
sorry