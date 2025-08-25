
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(1#32 ≥ ↑32 ∨
        True ∧ (x.sshiftRight' 1#32 &&& 1431655765#32 ^^^ -1#32).saddOverflow 1#32 = true ∨
          True ∧ x.saddOverflow ((x.sshiftRight' 1#32 &&& 1431655765#32 ^^^ -1#32) + 1#32) = true) →
    ¬(1#32 ≥ ↑32 ∨ True ∧ x.ssubOverflow (x >>> 1#32 &&& 1431655765#32) = true) →
      x + ((x.sshiftRight' 1#32 &&& 1431655765#32 ^^^ -1#32) + 1#32) = x - (x >>> 1#32 &&& 1431655765#32) :=
sorry