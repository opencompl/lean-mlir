
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem fast_div_201_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 1#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
        True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
          8#16 ≥ ↑16 ∨
            True ∧
                signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
              True ∧
                  zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                1#8 ≥ ↑8 ∨
                  True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
                    True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
                      8#16 ≥ ↑16 ∨
                        True ∧
                            signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                              (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                          True ∧
                              zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                            True ∧
                                ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8).uaddOverflow
                                    (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) =
                                  true ∨
                              7#8 ≥ ↑8 →
      False :=
sorry