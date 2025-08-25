
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem badimm2_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16) →
          ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = 127#8 :=
sorry