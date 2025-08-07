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

theorem badimm1_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 9#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 9#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(7#8 ≥ ↑8 ∨
              9#16 ≥ ↑16 ∨
                True ∧ signExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16 ∨
                  True ∧ zeroExtend 16 (truncate 8 (x >>> 9#16)) ≠ x >>> 9#16) →
          ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = BitVec.ofInt 8 (-128) :=
sorry