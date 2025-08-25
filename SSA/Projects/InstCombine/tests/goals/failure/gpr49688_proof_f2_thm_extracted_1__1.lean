
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ 0#32) = 1#1 →
    ¬x ≥ ↑32 → zeroExtend 32 (ofBool ((7#32).sshiftRight' x <ₛ x_1)) = zeroExtend 32 (ofBool (7#32 >>> x <ₛ x_1)) :=
sorry