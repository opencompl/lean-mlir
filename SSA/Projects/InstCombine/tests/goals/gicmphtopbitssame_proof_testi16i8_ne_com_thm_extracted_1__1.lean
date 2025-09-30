
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem testi16i8_ne_com_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(8#16 ≥ ↑16 ∨ 7#8 ≥ ↑8) →
    ofBool (truncate 8 (x >>> 8#16) != (truncate 8 x).sshiftRight' 7#8) =
      ofBool (x + BitVec.ofInt 16 (-128) <ᵤ BitVec.ofInt 16 (-256)) :=
sorry