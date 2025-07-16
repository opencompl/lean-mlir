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

theorem not_signbit_alt_xor_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → (x ^^^ BitVec.ofInt 8 (-2)) >>> 7#8 = zeroExtend 8 (ofBool (-1#8 <ₛ x)) :=
sorry