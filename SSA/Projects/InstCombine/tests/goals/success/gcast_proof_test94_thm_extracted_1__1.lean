
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test94_thm.extracted_1._1 : ∀ (x : BitVec 32),
  signExtend 64 (signExtend 8 (ofBool (x == BitVec.ofInt 32 (-2))) ^^^ -1#8) =
    signExtend 64 (ofBool (x != BitVec.ofInt 32 (-2))) :=
sorry