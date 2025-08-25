
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem badimm1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        7#8 ≥ ↑8 ∨
            9#16 ≥ ↑16 ∨
              True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
                True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 →
          False :=
sorry