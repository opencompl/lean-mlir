
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

theorem PR39793_bswap_u32_as_u16_trunc_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬8#32 ≥ ↑32 → truncate 8 (x >>> 8#32 &&& 255#32 ||| x <<< 8#32 &&& 65280#32) = truncate 8 (x >>> 8#32) :=
sorry