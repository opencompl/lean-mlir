
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_or_ashr_i32_commute_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬(x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      ((42#32).sdiv x ||| 0#32 - (42#32).sdiv x).sshiftRight' 31#32 = signExtend 32 (ofBool ((42#32).sdiv x != 0#32)) :=
sorry