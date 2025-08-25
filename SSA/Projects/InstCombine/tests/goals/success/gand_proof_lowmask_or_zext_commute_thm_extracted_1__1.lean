
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_or_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 24),
  (x_1 ||| zeroExtend 24 x) &&& 65535#24 = zeroExtend 24 (x ||| truncate 16 x_1) :=
sorry