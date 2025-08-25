
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem badimm4_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬ofBool (127#16 <ₛ x) = 1#1 → ofBool (x <ₛ BitVec.ofInt 16 (-128)) = 1#1 → truncate 8 x = BitVec.ofInt 8 (-127) :=
sorry