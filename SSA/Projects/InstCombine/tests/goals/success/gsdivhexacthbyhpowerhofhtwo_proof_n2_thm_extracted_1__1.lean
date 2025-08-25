
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(BitVec.ofInt 8 (-128) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-128) == -1) = true →
    x.sdiv (BitVec.ofInt 8 (-128)) = zeroExtend 8 (ofBool (x == BitVec.ofInt 8 (-128))) :=
sorry