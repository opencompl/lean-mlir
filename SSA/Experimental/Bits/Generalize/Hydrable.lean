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


class HydrableInstances (genLogicalExpr : Type) (genExpr : Nat → Type) where
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

instance : BEq BVExpr.PackedBitVec where
  beq a b := if h : a.w = b.w then
                let b' := h ▸ b.bv
                a.bv == b'
              else
                false

instance : Hashable BVExpr.PackedBitVec where
  hash pbv := hash pbv.bv

instance : ToString BVExpr.PackedBitVec where
  toString bitvec := toString bitvec.bv

instance [ToString α] [ToString β] [Hashable α] [BEq α] : ToString (Std.HashMap α β) where
  toString map :=
    "{" ++ String.intercalate ", " (map.toList.map (λ (k, v) => toString k ++ " → " ++ toString v)) ++ "}"

instance [ToString α] [Hashable α] [BEq α] : ToString (Std.HashSet α ) where
  toString set := toString set.toList

instance : ToString FVarId where
  toString f := s! "{f.name}"


structure ParsedInputState (parsedExprWrapper : Type) where
  maxFreeVarId : Nat
  numSymVars :  Nat
  inputVarToExprWrapper : Std.HashMap Name parsedExprWrapper
  inputVarIdToDisplayName : Std.HashMap Nat Name
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec
  symVarToDisplayName : Std.HashMap Nat Name
  valToSymVar : Std.HashMap BVExpr.PackedBitVec Nat

class HydrableInitialParserState  (parsedExprWrapper: Type)
where
  initialParserState : ParsedInputState parsedExprWrapper

structure ParsedLogicalExpr (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type)
where
  logicalExpr : genLogicalExpr
  state : ParsedInputState parsedExprWrapper
  lhs : parsedExpr
  rhs : parsedExpr

abbrev ParseExprM (parsedExprWrapper : Type) := StateRefT (ParsedInputState parsedExprWrapper) MetaM

class HydrableParseExprs (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) where
  parseExprs : (lhsExpr rhsExpr : Expr) → (targetWidth : Nat) → ParseExprM parsedExprWrapper (Option (ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr ))

class HydrableGenExprToExpr (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genExprToExpr {n : Nat} : ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr → genExpr n → MetaM Expr

class HydrableGenLogicalExprToExpr (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genLogicalExprToExpr : ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr → genLogicalExpr → (widthExpr : Expr) → MetaM Expr

class HydrableGetAllNamesFromParsedLogicalExpr (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getAllNamesFromParsedLogicalExpr : ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr → HashMap Nat Name

class HydrableGetLogicalExprSize (genLogicalExpr : Type) where
  getLogicalExprSize : genLogicalExpr → Nat

class HydrableSubstitute (genLogicalExpr : Type) (genExpr : Nat → Type) where
  substitute : genLogicalExpr → (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) → genLogicalExpr

class HydrablePackedBitvecToSubstitutionValue (genLogicalExpr : Type) (genExpr : Nat → Type) where
  packedBitVecToSubstitutionValue : (Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (SubstitutionValue genExpr)


structure GeneralizerState
  (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
  [HydrableInstances genLogicalExpr genExpr]
  where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedLogicalExpr : ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr
  needsPreconditionsExprs : List genLogicalExpr
  visitedSubstitutions : Std.HashSet genLogicalExpr
  constantExprsEnumerationCache : Std.HashMap (genExpr processingWidth) BVExpr.PackedBitVec

abbrev GeneralizerStateM (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
  [HydrableInstances genLogicalExpr genExpr] :=
  StateRefT (GeneralizerState parsedExprWrapper parsedExpr genLogicalExpr genExpr) TermElabM

def GeneralizerStateM.liftTermElabM
  {parsedExprWrapper : Type} {parsedExpr : Type}  {genLogicalExpr : Type} {genExpr : Nat → Type}
  [HydrableInstances genLogicalExpr genExpr]
  (m : TermElabM α) : GeneralizerStateM  parsedExprWrapper parsedExpr genLogicalExpr genExpr α := do
  let v ← m
  return v

class HydrableInitialGeneralizerState  (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
extends HydrableInstances genLogicalExpr genExpr
where
  initialGeneralizerState : (startTime timeout widthId targetWidth: Nat) → (parsedLogicalExpr : ParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr)
                          → GeneralizerState parsedExprWrapper parsedExpr genLogicalExpr genExpr

class HydrableBooleanAlgebra (genLogicalExpr : Type) (genExpr : Nat → Type) where
  not : genLogicalExpr → genLogicalExpr
  and : genLogicalExpr → genLogicalExpr → genLogicalExpr
  eq : genExpr n → genExpr n → genLogicalExpr
  beq : genLogicalExpr → genLogicalExpr → genLogicalExpr
  True : genLogicalExpr
  False : genLogicalExpr

class HydrableAddConstraints (genLogicalExpr : Type) (genExpr : Nat → Type) where
  addConstraints : genLogicalExpr → List genLogicalExpr → Gate → genLogicalExpr

class HydrableGetIdentityAndAbsorptionConstraints (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getIdentityAndAbsorptionConstraints : genLogicalExpr →  Std.HashSet Nat → List genLogicalExpr

class HydrableGenExpr (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genExprVar : Nat → genExpr n
  genExprConst : BitVec n → genExpr n


class HydrableGeneratePreconditions (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances genLogicalExpr genExpr
    where
 generatePreconditions :
    (bvLogicalExpr: genLogicalExpr) →
    (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) →
    (_numConjunctions: Nat) →
    GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrableChangeExprWidth (genExpr : Nat → Type)
    where
  changeExprWidth : (expr : genExpr w) → (target : Nat) → genExpr target

class HydrableChangeLogicalExprWidth (genLogicalExpr : Type)
    where
  changeLogicalExprWidth : (expr : genLogicalExpr) → (target : Nat) → genLogicalExpr

class HydrableSynthesizeWithNoPrecondition (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances genLogicalExpr genExpr
    where
  synthesizeWithNoPrecondition : (constantAssignments: List (Std.HashMap Nat BVExpr.PackedBitVec)) → GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrableCheckForPreconditions (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances genLogicalExpr genExpr
    where
  checkForPreconditions : (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) → (maxConjunctions : Nat)
                          → GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrablePrettify (genLogicalExpr : Type) where
  prettify : (generalization : genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String

class HydrablePrettifyAsTheorem (genLogicalExpr : Type) where
  prettifyAsTheorem : (name : Name) → (generalization : genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String

-- class Hydrable (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
--   HydrableInstances parsedLogicalExpr genLogicalExpr genExpr,
--   HydrableGenExprToExpr parsedLogicalExpr genLogicalExpr genExpr
--   where

end Generalize
