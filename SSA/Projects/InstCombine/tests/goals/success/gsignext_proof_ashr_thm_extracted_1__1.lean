
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬5#32 ≥ ↑32 → (x >>> 5#32 ^^^ 67108864#32) + BitVec.ofInt 32 (-67108864) = x.sshiftRight' 5#32 :=
sorry