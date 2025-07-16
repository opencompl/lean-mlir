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

theorem testi32i8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#8 ≥ ↑8 ∨ 8#32 ≥ ↑32) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#32)) = 1#1 →
      ¬15#32 ≥ ↑32 → truncate 8 (x.sshiftRight' 15#32) ^^^ 127#8 = truncate 8 (x >>> 15#32) ^^^ 127#8 :=
sorry