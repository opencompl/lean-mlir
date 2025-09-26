
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

theorem shl_bad_sub2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x - 31#32 ≥ ↑32 →
    True ∧ 1#32 <<< (x + BitVec.ofInt 32 (-31)) >>> (x + BitVec.ofInt 32 (-31)) ≠ 1#32 ∨
        x + BitVec.ofInt 32 (-31) ≥ ↑32 →
      False :=
sorry