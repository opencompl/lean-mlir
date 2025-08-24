
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

theorem badimm4_thm.extracted_1._5 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬ofBool (127#16 <ₛ x) = 1#1 →
          ¬ofBool (x <ₛ BitVec.ofInt 16 (-128)) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 126#8 = truncate 8 x :=
sorry