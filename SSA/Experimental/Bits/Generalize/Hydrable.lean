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

instance : BEq BVExpr.PackedBitVec where
  beq a b := if h : a.w = b.w then
                let b' := h ▸ b.bv
                a.bv == b'
              else
                false

instance : Hashable BVExpr.PackedBitVec where
  hash pbv := hash pbv.bv

structure GeneralizerState
  (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type)
  [HydrableInstances parsedLogicalExpr genLogicalExpr genExpr]
  where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedLogicalExpr : parsedLogicalExpr
  needsPreconditionsExprs : List genLogicalExpr
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

structure ParsedInputState (parsedExprWrapper : Type) where
  maxFreeVarId : Nat
  numSymVars :  Nat
  inputVarToExprWrapper : Std.HashMap Name parsedExprWrapper
  inputVarIdToDisplayName : Std.HashMap Nat Name
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec
  symVarToDisplayName : Std.HashMap Nat Name
  valToSymVar : Std.HashMap BVExpr.PackedBitVec Nat

class HydrableGetParserState  (parsedExprWrapper: Type)
where
  defaultParserState : ParsedInputState parsedExprWrapper

structure ParsedLogicalExpr (genLogicalExpr : Type) (parsedExprWrapper : Type) (parsedExpr : Type)
where
  logicalExpr : genLogicalExpr
  state : ParsedInputState parsedExprWrapper
  lhs : parsedExpr
  rhs : parsedExpr

--class HydrableGetParsedLogicalExpr (genLogicalExpr : Type) (parsedExprWrapper : Type) where

abbrev ParseExprM (parsedExprWrapper : Type) := StateRefT (ParsedInputState parsedExprWrapper) MetaM

class HydrableParseExprs (genLogicalExpr : Type) (parsedExprWrapper : Type) (parsedExpr : Type)  where
  parseExprs : (lhsExpr rhsExpr : Expr) → (targetWidth : Nat) → ParseExprM parsedExprWrapper (Option (ParsedLogicalExpr genLogicalExpr parsedExprWrapper parsedExpr))


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

class HydrableChangeExprWidth (genExpr : Nat → Type)
    where
  changeExprWidth : (expr : genExpr w) → (target : Nat) → genExpr target

class HydrableChangeLogicalExprWidth (genLogicalExpr : Type)
    where
  changeLogicalExprWidth : (expr : genLogicalExpr) → (target : Nat) → genLogicalExpr

class HydrableSynthesizeWithNoPrecondition (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances parsedLogicalExpr genLogicalExpr genExpr
    where
  synthesizeWithNoPrecondition : (constantAssignments: List (Std.HashMap Nat BVExpr.PackedBitVec)) → GeneralizerStateM parsedLogicalExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrableCheckForPreconditions (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
    HydrableInstances parsedLogicalExpr genLogicalExpr genExpr
    where
  checkForPreconditions : (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) → (maxConjunctions : Nat)
                          → GeneralizerStateM parsedLogicalExpr genLogicalExpr genExpr (Option genLogicalExpr)

class HydrablePrettify (genLogicalExpr : Type) where
  prettify : (generalization : genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String

class HydrablePrettifyAsTheorem (genLogicalExpr : Type) where
  prettifyAsTheorem : (name : Name) → (generalization : genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String

class Hydrable (parsedLogicalExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances parsedLogicalExpr genLogicalExpr genExpr,
  HydrableGenExprToExpr parsedLogicalExpr genLogicalExpr genExpr
  where

end Generalize
