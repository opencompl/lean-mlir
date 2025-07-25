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

theorem set_bits_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (x &&& BitVec.ofInt 8 (-6) &&& 0#8 != 0) = true) →
      x &&& BitVec.ofInt 8 (-6) = x &&& BitVec.ofInt 8 (-6) ||| 0#8 :=
sorry