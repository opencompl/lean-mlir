
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_mul_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16) →
      truncate 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight' 8#20) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 8#16 :=
sorry