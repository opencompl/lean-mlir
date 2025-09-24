
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- glogicalhselecthinseltpoison_proof_bools_multi_uses2_logical_thm_extracted_1__37.lean
-/
import Blase
open BitVec


/-
This test shows that we need special support for `ofBool`, and we should allow
our solver to interpret 1-width bitvectors always.
Otherwise, we end up not being able to close many boolean problems.
This also exposes a TODO: where we should add `ofBool` support to the reflection.
-/
theorem bools_multi_uses2_logical_thm.extracted_1._37 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 ^^^ 1#1 = 1#1 → ¬x_2 = 1#1 → ¬0#1 = 1#1 → x_1 = 1#1 → 0#1 = 0#1 ^^^ 0#1 := by
  fail_if_success bv_multi_width +verbose?
  sorry
