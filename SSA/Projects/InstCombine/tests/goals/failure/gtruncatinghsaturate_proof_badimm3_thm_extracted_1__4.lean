
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem badimm3_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬14#16 ≥ ↑16 →
        ¬ofBool (x + 128#16 <ᵤ 256#16) = 1#1 →
          14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 → False :=
sorry