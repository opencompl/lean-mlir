
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

theorem testi64i32_ne_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(31#32 ≥ ↑32 ∨ 32#64 ≥ ↑64) →
    ofBool ((truncate 32 x).sshiftRight' 31#32 != truncate 32 (x >>> 32#64)) =
      ofBool (x + BitVec.ofInt 64 (-2147483648) <ᵤ BitVec.ofInt 64 (-4294967296)) :=
sorry