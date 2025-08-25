
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_nontrivial_mask2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-4096) != 20480#16) =
    ofBool (x &&& BitVec.ofInt 16 (-3841) != 20607#16) :=
sorry