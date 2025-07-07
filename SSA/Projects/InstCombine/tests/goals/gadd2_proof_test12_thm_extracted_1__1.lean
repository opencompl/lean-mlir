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

theorem test12_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow 1#32 = true ∨
        True ∧ (x_1 + 1#32).saddOverflow ((x ||| BitVec.ofInt 32 (-1431655766)) ^^^ 1431655765#32) = true) →
    x_1 + 1#32 + ((x ||| BitVec.ofInt 32 (-1431655766)) ^^^ 1431655765#32) = x_1 - (x &&& 1431655765#32) :=
sorry