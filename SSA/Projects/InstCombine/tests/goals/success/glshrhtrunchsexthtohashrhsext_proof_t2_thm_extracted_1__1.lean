
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 7),
  ¬3#7 ≥ ↑7 → signExtend 16 (truncate 4 (x >>> 3#7)) = signExtend 16 (x.sshiftRight' 3#7) :=
sorry