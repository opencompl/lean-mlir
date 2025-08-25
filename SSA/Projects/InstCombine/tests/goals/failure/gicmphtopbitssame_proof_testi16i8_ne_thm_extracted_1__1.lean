
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi16i8_ne_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ofBool ((truncate 8 x).sshiftRight' 7#8 != truncate 8 (x >>> 8#16)) =
      ofBool (x + BitVec.ofInt 16 (-128) <ᵤ BitVec.ofInt 16 (-256)) :=
sorry