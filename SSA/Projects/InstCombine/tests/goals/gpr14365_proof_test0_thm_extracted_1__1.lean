
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

theorem test0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 1431655765#32 ^^^ -1#32).saddOverflow 1#32 = true ∨
        True ∧ x.saddOverflow ((x &&& 1431655765#32 ^^^ -1#32) + 1#32) = true) →
    x + ((x &&& 1431655765#32 ^^^ -1#32) + 1#32) = x &&& BitVec.ofInt 32 (-1431655766) :=
sorry