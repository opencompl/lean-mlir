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

theorem sub_undemanded_low_bits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬4#32 ≥ ↑32 → ((x ||| 15#32) - 1616#32) >>> 4#32 = (x + BitVec.ofInt 32 (-1616)) >>> 4#32 :=
sorry