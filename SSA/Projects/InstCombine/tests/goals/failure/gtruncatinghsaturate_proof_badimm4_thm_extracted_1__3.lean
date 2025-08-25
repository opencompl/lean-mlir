
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem badimm4_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 → ofBool (127#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 126#8 = 126#8 :=
sorry