/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- goals/success/gsubhofhnegatible_proof_t7_thm_extracted_1__2.lean
-/
import Blase
open BitVec

-- Check that we correctly reflect this goal state.
-- The goal state is tricky due to binders with different widths,
-- which needs us to correctly build environments with the right de bruijn levels.
/--
info: goal after preprocessing: ⏎
  v✝ w✝ : ℕ
  x_1✝ : BitVec v✝
  x_2✝ : BitVec w✝
  ⊢ x_1✝ = 42#v✝ ∨ x_2✝ = 43#w✝
---
info: collecting raw expr 'x_1✝ = 42#v✝ ∨ x_2✝ = 43#w✝'.
---
info: collected predicate: 'MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 0) 42))
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 1)
    (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 1) 43))' for raw expr.
---
info: fsm from MultiWidth.mkPredicateFSMNondep 2 2 MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 0) 42))
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 1)
    (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 1) 43)).
---
info: fsm circuit size: 133
---
error: CEX: Found exact counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 0) 42))
  (MultiWidth.Nondep.Predicate.binRel
    (MultiWidth.BinaryRelationKind.eq)
    (MultiWidth.Nondep.WidthExpr.var 1)
    (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 1) 43))
-/
#guard_msgs in theorem minimized :
    ∀ (v w : Nat) (x_1 : BitVec v) (x_2 : BitVec w), x_1 = 42#v ∨ x_2 = 43#w := by
  intros
  bv_multi_width +verbose?
  sorry

theorem t7_thm.extracted_1._2 :
    ∀ (x_1 : BitVec 1) (x_2 : BitVec 8), x_1 = 1#1 → x_2 - 0#8 = 0#8 + x_2 := by
  intros;
  bv_multi_width

