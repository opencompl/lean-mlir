
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

theorem testi64i32_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (-1#64 <ₛ x) = 1#1 → truncate 32 (x.sshiftRight' 63#64) ^^^ 127#32 = 127#32 :=
sorry