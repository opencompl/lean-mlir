
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testi32i8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#8 ≥ ↑8 ∨ 8#32 ≥ ↑32) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#32)) = 1#1 →
      ¬15#32 ≥ ↑32 → truncate 8 (x.sshiftRight' 15#32) ^^^ 127#8 = truncate 8 (x >>> 15#32) ^^^ 127#8 :=
sorry