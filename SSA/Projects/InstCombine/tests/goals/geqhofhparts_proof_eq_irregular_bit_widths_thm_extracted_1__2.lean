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

theorem eq_irregular_bit_widths_thm.extracted_1._2 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
    ¬(7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
      ofBool (truncate 5 (x_1 >>> 13#31) == truncate 5 (x >>> 13#31)) &&&
          ofBool (truncate 6 (x_1 >>> 7#31) == truncate 6 (x >>> 7#31)) =
        ofBool (truncate 11 (x_1 >>> 7#31) == truncate 11 (x >>> 7#31)) :=
sorry