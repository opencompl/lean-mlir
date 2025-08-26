
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

theorem testi128i128_thm.extracted_1._2 : ∀ (x : BitVec 128),
  ¬127#128 ≥ ↑128 → ¬ofBool (-1#128 <ₛ x) = 1#1 → x.sshiftRight' 127#128 ^^^ 27#128 = BitVec.ofInt 128 (-28) :=
sorry