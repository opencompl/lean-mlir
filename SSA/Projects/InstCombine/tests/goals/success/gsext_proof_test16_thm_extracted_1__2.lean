
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(12#16 ≥ ↑16 ∨ 15#16 ≥ ↑16) →
    signExtend 32 (ofBool (x &&& 8#16 == 8#16)) = signExtend 32 ((x <<< 12#16).sshiftRight' 15#16) :=
sorry