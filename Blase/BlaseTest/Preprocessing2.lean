/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- goals/success/gsubhofhnegatible_proof_t7_thm_extracted_1__2.lean
-/
import Blase
open BitVec

-- Check that we correctly reflect this goal state.
-- The goal state is tricky due to binders with different widths,
-- which needs us to correctly build environments with the right de bruijn levels.
/-- warning: declaration uses 'sorry' -/
#guard_msgs in theorem minimized :
    ∀ (v w : Nat) (x_1 : BitVec v) (x_2 : BitVec w), x_1 = 42#v ∨ x_2 = 43#w := by
  intros
  fail_if_success bv_multi_width +verbose?
  sorry

theorem t7_thm.extracted_1._2 :
    ∀ (x_1 : BitVec 1) (x_2 : BitVec 8), x_1 = 1#1 → x_2 - 0#8 = 0#8 + x_2 := by
  intros;
  bv_multi_width

