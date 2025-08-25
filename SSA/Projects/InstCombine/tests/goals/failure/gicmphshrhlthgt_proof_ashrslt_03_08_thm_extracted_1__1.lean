
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_03_08_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬3#4 ≥ ↑4 → ofBool (x.sshiftRight' 3#4 <ₛ BitVec.ofInt 4 (-8)) = 0#1 :=
sorry