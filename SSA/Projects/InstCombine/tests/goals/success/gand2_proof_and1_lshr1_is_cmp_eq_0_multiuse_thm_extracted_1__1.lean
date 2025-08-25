
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and1_lshr1_is_cmp_eq_0_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    x ≥ ↑8 ∨
        True ∧ (1#8 >>> x <<< 1#8).sshiftRight' 1#8 ≠ 1#8 >>> x ∨
          True ∧ 1#8 >>> x <<< 1#8 >>> 1#8 ≠ 1#8 >>> x ∨ 1#8 ≥ ↑8 →
      False :=
sorry