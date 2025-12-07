
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- gandhorhicmps_proof_logical_or_logical_or_icmps_comm1_thm_extracted_1__7.lean
-/
import Blase
open BitVec


-- This sucks, because it now becomes `1 % 2^w` which cannot be further simplified.

@[bv_multi_width_normalize]
theorem BitVec.shl_ofNat_eq_mul_twoPow {w : Nat} (x : BitVec w) (n : Nat) :
  x <<< (BitVec.ofNat w n) =  x <<< ((n % 2^w) : Nat) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq]

-- This needs shift left support, and is also probably only provable given
-- the fixed width. In particular, the constraint ¬ 'x_1 ≥ 8' seems a bit suspicious.
-- We should refute this as a arbitrary width theorem, probably, with no abstracted variables.
/--
info: goal after preprocessing: ⏎
  w : ℕ
  x : BitVec w
  ⊢ x + x = x <<< (1 % 2 ^ w)
---
info: collecting raw expr 'x + x = x <<< (1 % 2 ^ w)'.
---
info: collected predicate: 'MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0)))
  (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 0))' for raw expr.
---
info: fsm from MultiWidth.mkPredicateFSMNondep 1 2 MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0)))
  (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 0)).
---
info: fsm circuit size: 96
---
warning: abstracted non-variable bitvector: ⏎
  → 'x <<< (1 % 2 ^ w)'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0)))
  (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem logical_or_logical_or_icmps_comm1_thm.extracted_1._7 (x : BitVec w) : 
      x + x = x <<< (1#w)
  := by bv_multi_width +verbose?

