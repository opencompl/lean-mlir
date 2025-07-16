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

theorem or_min_31_30_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x <ᵤ BitVec.ofInt 8 (-30)) = 1#1 → BitVec.ofInt 8 (-30) ||| 31#8 = x ||| 31#8 :=
sorry