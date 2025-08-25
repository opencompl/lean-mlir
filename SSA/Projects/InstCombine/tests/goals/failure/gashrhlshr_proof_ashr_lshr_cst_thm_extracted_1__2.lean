
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_cst_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 1#32) = 1#1 → ¬8#32 ≥ ↑32 → x >>> 8#32 = x.sshiftRight' 8#32 :=
sorry