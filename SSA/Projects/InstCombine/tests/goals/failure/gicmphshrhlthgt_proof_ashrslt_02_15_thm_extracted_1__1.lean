
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_02_15_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (x.sshiftRight' 2#4 <ₛ -1#4) = ofBool (x <ₛ BitVec.ofInt 4 (-4)) :=
sorry