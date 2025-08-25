
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addhshlhsdivhnegative0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((4#8 == 0 || 8 != 1 && x == intMin 8 && 4#8 == -1) = true ∨ 2#8 ≥ ↑8) →
    (4#8 == 0 || 8 != 1 && x == intMin 8 && 4#8 == -1) = true ∨
        True ∧ (x.sdiv 4#8 <<< 2#8).sshiftRight' 2#8 ≠ x.sdiv 4#8 ∨ 2#8 ≥ ↑8 →
      False :=
sorry