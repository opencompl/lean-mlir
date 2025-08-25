
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test12_thm.extracted_1._1 : ∀ (x : BitVec 47),
  ¬(8#47 ≥ ↑47 ∨ 8#47 ≥ ↑47) → x.sshiftRight' 8#47 <<< 8#47 = x &&& BitVec.ofInt 47 (-256) :=
sorry