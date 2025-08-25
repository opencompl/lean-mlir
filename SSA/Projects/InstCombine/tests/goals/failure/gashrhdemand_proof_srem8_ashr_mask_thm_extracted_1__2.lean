
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem srem8_ashr_mask_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬ofBool (BitVec.ofInt 32 (-2147483648) <ᵤ x &&& BitVec.ofInt 32 (-2147483641)) = 1#1 →
      (x.srem 8#32).sshiftRight' 31#32 &&& 2#32 = 0#32 :=
sorry