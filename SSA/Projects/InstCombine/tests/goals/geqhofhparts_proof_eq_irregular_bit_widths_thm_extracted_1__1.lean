
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

theorem eq_irregular_bit_widths_thm.extracted_1._1 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) → 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 → False :=
sorry