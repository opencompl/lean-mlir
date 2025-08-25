
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem srem2_ashr_mask_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
      (x.srem 2#32).sshiftRight' 31#32 &&& 2#32 = x.srem 2#32 &&& 2#32 :=
sorry