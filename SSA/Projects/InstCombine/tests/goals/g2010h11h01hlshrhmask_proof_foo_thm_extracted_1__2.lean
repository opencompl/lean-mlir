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

theorem foo_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(7#8 ≥ ↑8 ∨ 7#8 ≥ ↑8 ∨ 5#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(7#8 ≥ ↑8 ∨
          2#8 ≥ ↑8 ∨
            True ∧ (40#8).ssubOverflow (x &&& 84#8) = true ∨
              True ∧ (x &&& 33#8 &&& (40#8 - (x &&& 84#8) &&& 84#8) != 0) = true ∨
                7#8 ≥ ↑8 ∨
                  True ∧
                    ((x &&& 33#8 ||| 40#8 - (x &&& 84#8) &&& 84#8) &&& (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) !=
                        0) =
                      true) →
      (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) >>> 7#8 <<< 5#8 ^^^
          (x &&& 33#8 ||| BitVec.ofInt 8 (-88) - (x &&& 84#8) &&& 84#8 |||
            x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) =
        (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) >>> 2#8 &&& 32#8 ^^^
          (x &&& 33#8 ||| 40#8 - (x &&& 84#8) &&& 84#8 ||| x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) :=
sorry