
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem match_andAsRem_lshrAsDiv_shlAsMul_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(6#64 ≥ ↑64 ∨ 9#64 = 0 ∨ 6#64 ≥ ↑64) → ¬576#64 = 0 → (x &&& 63#64) + (x >>> 6#64 % 9#64) <<< 6#64 = x % 576#64 :=
sorry