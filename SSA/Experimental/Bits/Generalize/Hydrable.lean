/-
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Timi Adeniran, Siddharth Bhat
-/
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend


namespace Generalize

inductive SubstitutionValue (genExpr : Nat → Type) where
| bvExpr {w} (bvExpr : genExpr w)
| packedBV  (bv: BVExpr.PackedBitVec)

instance : Inhabited (SubstitutionValue genExpr) where
  default := .packedBV (BVExpr.PackedBitVec.mk (w := 0) 0#0)


class HydrableInstances (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  beqLogical : BEq genLogicalExpr := by infer_instance
  messageDataLogical : ToMessageData genLogicalExpr := by infer_instance
  hashableLogical : Hashable genLogicalExpr := by infer_instance
  hashableGenExpr : ∀ (n : Nat), Hashable (genExpr n) := by infer_instance
  beqGenExpr : ∀ (n : Nat), BEq (genExpr n) := by infer_instance

attribute [instance] HydrableInstances.beqLogical
attribute [instance] HydrableInstances.messageDataLogical
attribute [instance] HydrableInstances.hashableLogical
attribute [instance] HydrableInstances.hashableGenExpr
attribute [instance] HydrableInstances.beqGenExpr


class HydrableGenExprToExpr (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genExprToExpr {n : Nat} : parsedLogicalExpr → genExpr n → MetaM Expr

class HydrableGenLogicalExprToExpr (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genLogicalExprToExpr : parsedLogicalExpr → genLogicalExpr → (widthExpr : Expr) → MetaM Expr

class HydrableGetAllNamesFromParsedLogicalExpr (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getAllNamesFromParsedLogicalExpr : parsedLogicalExpr → HashMap Nat Name

class HydrableGetLogicalExprSize (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getLogicalExprSize : genLogicalExpr → Nat

class HydrableSubstitute (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  substitute : genLogicalExpr → (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) → genLogicalExpr

class HydrablePackedBitvecToSubstitutionValue (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  packedBitVecToSubstitutionValue : (Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (SubstitutionValue genExpr)

structure GeneralizerState
  (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
  [HydrableInstances parsedLogicalExpr genLogicalExpr genExpr]
  where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedBVLogicalExpr : parsedLogicalExpr
  needsPreconditionsExprs : List parsedLogicalExpr
  visitedSubstitutions : Std.HashSet genLogicalExpr
  constantExprsEnumerationCache : Std.HashMap (genExpr processingWidth) BVExpr.PackedBitVec

abbrev GeneralizerStateM (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
  [HydrableInstances parsedLogicalExpr genLogicalExpr genExpr] :=
  StateRefT (GeneralizerState parsedLogicalExpr genLogicalExpr genExpr) TermElabM

def GeneralizerStateM.liftTermElabM
  {parsedLogicalExpr : Type}  {genLogicalExpr : Type} {genExpr : Nat → Type}
  [HydrableInstances parsedLogicalExpr genLogicalExpr genExpr]
  (m : TermElabM α) : GeneralizerStateM parsedLogicalExpr genLogicalExpr genExpr α := do
  let v ← m
  return v

class HydrableBooleanAlgebra (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  not : genLogicalExpr → genLogicalExpr
  and : genLogicalExpr → genLogicalExpr → genLogicalExpr
  eq : genExpr n → genExpr n → genLogicalExpr
  beq : genLogicalExpr → genLogicalExpr → genLogicalExpr
  True : genLogicalExpr
  False : genLogicalExpr

class HydrableAddConstraints (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  addConstraints : genLogicalExpr → List genLogicalExpr → Gate → genLogicalExpr

class HydrableGetIdentityAndAbsorptionConstraints (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getIdentityAndAbsorptionConstraints : genLogicalExpr →  Std.HashSet Nat → List genLogicalExpr

class HydrableGenExpr (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genExprVar : Nat → genExpr n
  genExprConst : BitVec n → genExpr n


class HydrableGeneratePreconditions (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances parsedLogicalExpr genLogicalExpr genExpr
    where
 generatePreconditions :
    (bvLogicalExpr: genLogicalExpr) →
    (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) →
    (_numConjunctions: Nat) →
    GeneralizerStateM parsedLogicalExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrableLHSSketchEnumeration (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  lhsSketchEnumeration : (lhsSketch: genExpr n) → (inputVars: List Nat) → (lhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) → (rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (List (genExpr n))

class Hydrable (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances parsedLogicalExpr genLogicalExpr genExpr,
  HydrableGenExprToExpr parsedLogicalExpr genLogicalExpr genExpr
  where
--   beqLogical : BEq genLogicalExpr := by infer_instance
--   messageDataLogical : ToMessageData genLogicalExpr := by infer_instance
--   hashableLogical : Hashable genLogicalExpr := by infer_instance
--   hashableGenExpr : ∀ (n : Nat), Hashable (genExpr n) := by infer_instance
--   beqGenExpr : ∀ (n : Nat), BEq (genExpr n) := by infer_instance
--   genExprToExpr {n : Nat} : parsedLogicalExpr → genExpr n → MetaM Expr
--   genLogicalExprToExpr : parsedLogicalExpr → genLogicalExpr → (widthExpr : Expr) → MetaM Expr
--   getAllNamesFromParsedLogicalExpr : parsedLogicalExpr → HashMap Nat Name
--   getLogicalExprSize : genLogicalExpr → Nat
--   substitute : genLogicalExpr → (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) → genLogicalExpr
--   packedBitVecToSubstitutionValue : (Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (SubstitutionValue genExpr)
--   genExprToSubstitutionValue : (Std.HashMap Nat (genExpr n)) → Std.HashMap Nat (SubstitutionValue genExpr)
--   getIdentityAndAbsorptionConstraints : genLogicalExpr →  Std.HashSet Nat → List genLogicalExpr
--   addConstraints : genLogicalExpr → List genLogicalExpr → Gate → genLogicalExpr
--   not : genLogicalExpr → genLogicalExpr
--   and : genLogicalExpr → genLogicalExpr → genLogicalExpr
--   eq : genExpr n → genExpr n → genLogicalExpr
--   beq : genLogicalExpr → genLogicalExpr → genLogicalExpr
--   True : genLogicalExpr
--   False : genLogicalExpr
--   genExprVar : Nat → genExpr n
--   genExprConst : BitVec n → genExpr n
--   deductiveSearch : genExpr n → Std.HashMap Nat BVExpr.PackedBitVec → BVExpr.PackedBitVec → Nat → Nat → TermElabM (List (genExpr n))
--   evalGenLogicalExpr : (Std.HashMap Nat BVExpr.PackedBitVec) →  Nat →  genLogicalExpr → Bool
--   evalGenExpr : (Std.HashMap Nat BVExpr.PackedBitVec) → (n: Nat) →  genExpr w → BitVec n

-- attribute [instance] Hydrable.beqLogical
-- attribute [instance] Hydrable.messageDataLogical
-- attribute [instance] Hydrable.hashableLogical
-- attribute [instance] Hydrable.hashableGenExpr
-- attribute [instance] Hydrable.beqGenExpr

end Generalize
