
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test38_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 64 (zeroExtend 8 (ofBool (x == BitVec.ofInt 32 (-2))) ^^^ 1#8) =
    zeroExtend 64 (ofBool (x != BitVec.ofInt 32 (-2))) :=
sorry