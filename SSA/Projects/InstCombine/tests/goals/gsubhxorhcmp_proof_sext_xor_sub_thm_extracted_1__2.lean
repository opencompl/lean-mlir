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

theorem sext_xor_sub_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  ¬x = 1#1 → (x_1 ^^^ signExtend 64 x) - signExtend 64 x = x_1 :=
sorry