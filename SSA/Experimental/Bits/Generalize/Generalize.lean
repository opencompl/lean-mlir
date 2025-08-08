/-
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Timi Adeniran, Siddharth Bhat
-/
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

namespace Generalize

initialize Lean.registerTraceClass `Generalize

inductive SubstitutionValue (genExpr : Nat → Type) where
| genExpr {w} (genExpr : genExpr w)
| packedBV  (bv: BVExpr.PackedBitVec)

instance : Inhabited (SubstitutionValue genExpr) where
  default := .packedBV (BVExpr.PackedBitVec.mk (w := 0) 0#0)

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
  addConstraints : (expr: genLogicalExpr) → (constraints: List genLogicalExpr) → (gate: Gate) → genLogicalExpr

class HydrableGetIdentityAndAbsorptionConstraints (genLogicalExpr : Type) (genExpr : Nat → Type) where
  getIdentityAndAbsorptionConstraints : (expr: genLogicalExpr) →  (symVars: Std.HashSet Nat) → List genLogicalExpr

class HydrableGenExpr (genLogicalExpr : Type) (genExpr : Nat → Type) where
  genExprVar : Nat → genExpr n
  genExprConst : BitVec n → genExpr n

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

class HydrableSolve (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances genLogicalExpr genExpr,
  HydrableGetAllNamesFromParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableGetLogicalExprSize genLogicalExpr,
  HydrableGenLogicalExprToExpr parsedExprWrapper parsedExpr genLogicalExpr genExpr where

def solve
[H : HydrableSolve parsedExprWrapper parsedExpr genLogicalExpr genExpr]
  (bvExpr : genLogicalExpr) : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let state ← get
    let allNames := H.getAllNamesFromParsedLogicalExpr state.parsedLogicalExpr
    let bitVecWidth := (mkNatLit state.processingWidth)
    let bitVecType :=  mkApp (mkConst ``BitVec) bitVecWidth

    let nameTypeCombo : List (Name × Expr) := allNames.values.map (λ n => (n, bitVecType))

    let res ←
      withLocalDeclsDND nameTypeCombo.toArray fun _ => do
        let mVar ← withTraceNode `Generalize (fun _ => return m!"Converted bvExpr to expr (size : {H.getLogicalExprSize bvExpr})") do
          let mut expr ← H.genLogicalExprToExpr state.parsedLogicalExpr bvExpr bitVecWidth
          Lean.Meta.check expr

          expr ← mkEq expr (mkConst ``Bool.false) -- We do this because bv_decide negates the original expression, and we counter that here
          Lean.Meta.check expr

          mkFreshExprMVar expr

        let cfg: BVDecideConfig := {timeout := 60, embeddedConstraintSubst := false}

        IO.FS.withTempFile fun _ lratFile => do
          let ctx ← (BVDecide.Frontend.TacticContext.new lratFile cfg)
          let res ← BVDecide.Frontend.bvDecide' mVar.mvarId! ctx

          match res with
          | .ok _ => pure none
          | .error counterExample =>
            let nameToId : Std.HashMap Name Nat := Std.HashMap.ofList (allNames.toList.map (λ (id, name) => (name, id)))
            let mut assignment : Std.HashMap Nat BVExpr.PackedBitVec := Std.HashMap.emptyWithCapacity
            for (var, val) in counterExample.equations do
              let name := ((← getLCtx).get! var.fvarId!).userName
              assignment := assignment.insert nameToId[name]! val
            pure (some assignment)
    return res

class HydrableExistsForall (parsedExprWrapper : Type) (parsedExpr : Type)  (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances genLogicalExpr genExpr,
  HydrableSolve parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableSubstitute genLogicalExpr genExpr,
  HydrablePackedBitvecToSubstitutionValue genLogicalExpr genExpr,
  HydrableBooleanAlgebra genLogicalExpr genExpr,
  HydrableGetIdentityAndAbsorptionConstraints genLogicalExpr genExpr,
  HydrableAddConstraints genLogicalExpr genExpr,
  HydrableGenExpr genLogicalExpr genExpr
  where

partial def existsForAll
    [H : HydrableExistsForall parsedExprWrapper parsedExpr genLogicalExpr genExpr]
    (origExpr: genLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)  (numExamples: Nat := 1) :
    GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do

    let rec constantsSynthesis (bvExpr: genLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)
            : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
      let existsRes ← solve bvExpr

      match existsRes with
        | none => trace[Generalize] m! "Could not satisfy exists formula for {bvExpr}"
                  return none
        | some assignment =>
          let existsVals := assignment.filter fun c _ => existsVars.contains c
          let substExpr := H.substitute bvExpr (H.packedBitVecToSubstitutionValue existsVals)
          let forAllRes ← solve (H.not substExpr)

          match forAllRes with
            | none =>
              return some existsVals
            | some counterEx =>
                let newExpr := H.substitute bvExpr (H.packedBitVecToSubstitutionValue counterEx)
                constantsSynthesis (H.and bvExpr newExpr) existsVars forAllVars

    let mut res : List (Std.HashMap Nat BVExpr.PackedBitVec) := []
    let identityAndAbsorptionConstraints := H.getIdentityAndAbsorptionConstraints origExpr (Std.HashSet.ofList existsVars)
    let targetExpr := (H.and origExpr (H.addConstraints H.True (identityAndAbsorptionConstraints) Gate.and))

    match numExamples with
    | 0 => return res
    | n + 1 =>  let consts ← constantsSynthesis targetExpr existsVars forAllVars
                match consts with
                | none => return res
                | some assignment =>
                      res := assignment :: res
                      let newConstraints := assignment.toList.map (fun c => H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv))
                      let constrainedBVExpr := H.not (H.addConstraints H.True newConstraints Gate.and)
                      return res ++ (← existsForAll (H.and origExpr constrainedBVExpr) existsVars forAllVars n)


class HydrableCountModel (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances genLogicalExpr genExpr,
  HydrableSolve parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableBooleanAlgebra genLogicalExpr genExpr,
  HydrableGenExpr genLogicalExpr genExpr,
  HydrableAddConstraints genLogicalExpr genExpr
  where

partial def countModel
  [H : HydrableCountModel parsedExprWrapper parsedExpr genLogicalExpr genExpr] (expr : genLogicalExpr) (constants: Std.HashSet Nat): GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr Nat := do
    go 0 expr
    where
        go (count: Nat) (expr : genLogicalExpr) : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr Nat := do
          let res ← solve expr
          match res with
          | none => return count
          | some assignment =>
                let filteredAssignments := assignment.filter (λ c _ => constants.contains c)
                let newConstraints := filteredAssignments.toList.map (fun c => H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv))

                let constrainedBVExpr := H.not (H.addConstraints (H.True) newConstraints Gate.and)

                if count + 1 > 1000 then
                  return count
                pure (← go (count + 1) (H.and expr constrainedBVExpr))

def generateCombinations (num: Nat) (values: List α) : List (List α) :=
    match num, values with
    | 0, _ => [[]]
    | _, [] => []
    | n + 1, x::xs =>
            let combosWithoutX := (generateCombinations (n + 1) xs)
            let combosWithX := (generateCombinations n xs).map (λ combo => x :: combo)
            combosWithoutX ++ combosWithX

class HydrableGetNegativeExamples (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableSolve parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableBooleanAlgebra genLogicalExpr genExpr,
  HydrableGenExpr genLogicalExpr genExpr,
  HydrableAddConstraints genLogicalExpr genExpr

def getNegativeExamples [H : HydrableGetNegativeExamples parsedExprWrapper parsedExpr genLogicalExpr genExpr] (bvExpr: genLogicalExpr) (consts: List Nat) (numEx: Nat) :
              GeneralizerStateM parsedExprWrapper parsedExpr  genLogicalExpr genExpr (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
  let targetExpr := H.not bvExpr
  return (← helper targetExpr numEx)
  where
        helper (expr: genLogicalExpr) (depth : Nat)
          : GeneralizerStateM parsedExprWrapper parsedExpr  genLogicalExpr genExpr (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
        match depth with
          | 0 => return []
          | n + 1 =>
              let solution ← solve expr

              match solution with
              | none => return []
              | some assignment =>
                   let constVals := assignment.filter fun c _ => consts.contains c
                   let newConstraints := constVals.toList.map (fun c => H.not (H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv)))

                   let res ← helper (H.addConstraints expr newConstraints Gate.and) n
                   return [constVals] ++ res


class HydrableCheckTimeout (parsedExprWrapper: Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances genLogicalExpr genExpr

def checkTimeout {parsedExprWrapper parsedExpr genLogicalExpr genExpr} [H : HydrableCheckTimeout parsedExprWrapper parsedExpr genLogicalExpr genExpr] : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr Unit := do
  let state ← get
  let currentTime ← Core.liftIOCore IO.monoMsNow
  let elapsedTime := currentTime - state.startTime

  trace[Generalize] m! "Elapsed time: {elapsedTime/1000}s"
  if elapsedTime >= state.timeout then
      throwError m! "Synthesis Timeout Failure: Exceeded timeout of {state.timeout/1000}s"


class HydrableGeneralize (parsedExprWrapper: Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableExistsForall parsedExprWrapper parsedExpr  genLogicalExpr genExpr,
  HydrableChangeLogicalExprWidth genLogicalExpr,
  HydrableInitialParserState parsedExprWrapper,
  HydrableSynthesizeWithNoPrecondition parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableCheckForPreconditions parsedExprWrapper parsedExpr genLogicalExpr genExpr
  where

def generalize [H : HydrableGeneralize parsedExprWrapper parsedExpr genLogicalExpr genExpr] : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr  (Option genLogicalExpr) := do
    let state ← get
    let parsedLogicalExpr := state.parsedLogicalExpr
    let mut logicalExpr := parsedLogicalExpr.logicalExpr
    let parsedBVState := parsedLogicalExpr.state

    let originalWidth := parsedBVState.originalWidth
    let targetWidth := state.targetWidth

    let mut constantAssignments := []
    --- Synthesize constants in a lower width if needed
    if originalWidth > targetWidth then
      constantAssignments ← existsForAll logicalExpr parsedBVState.symVarToVal.keys parsedBVState.inputVarIdToDisplayName.keys 1

    let mut processingWidth := targetWidth
    if constantAssignments.isEmpty then
      logInfo m! "Did not synthesize new constant values in width {targetWidth}"
      constantAssignments := parsedBVState.symVarToVal :: constantAssignments
      processingWidth := originalWidth

    if processingWidth != targetWidth then
        -- Revert to the original width if necessary
      logicalExpr := H.changeLogicalExprWidth logicalExpr processingWidth
      trace[Generalize] m! "Using values for {logicalExpr} in width {processingWidth}: {constantAssignments}"

    set {state with
                processingWidth := processingWidth,
                constantExprsEnumerationCache := {},
                parsedLogicalExpr := { parsedLogicalExpr with logicalExpr := logicalExpr }}

    let exprWithNoPrecondition  ← withTraceNode `Generalize (fun _ => return "Performed expression synthesis") do
        H.synthesizeWithNoPrecondition constantAssignments
    let maxConjunctions : ℕ := 1

    match exprWithNoPrecondition with
    | some generalized => return some generalized
    | none =>
              let state ← get
              if state.needsPreconditionsExprs.isEmpty then
                throwError m! "Could not synthesise constant expressions for {state.parsedLogicalExpr.logicalExpr}"

              let preconditionRes ← withTraceNode `Generalize (fun _ => return "Attempted to generate weak precondition for all expression combos") do
                H.checkForPreconditions constantAssignments maxConjunctions

              match preconditionRes with
              | some expr => return some expr
              | none => return none
    -- TODO:  verify width independence

inductive GeneralizeContext where
  | Command : GeneralizeContext
  | Tactic (name : Name) : GeneralizeContext


class HydrableParseAndGeneralize (parsedExprWrapper: Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableGeneralize parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableParseExprs parsedExprWrapper parsedExpr genLogicalExpr,
  HydrableInitialGeneralizerState parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrablePrettify genLogicalExpr,
  HydrablePrettifyAsTheorem genLogicalExpr
  where

def parseAndGeneralize [H : HydrableParseAndGeneralize parsedExprWrapper parsedExpr genLogicalExpr genExpr] (hExpr : Expr) (context: GeneralizeContext): TermElabM MessageData := do
    let targetWidth := 8
    let timeoutMs := 300000

    match_expr hExpr with
    | Eq _ lhsExpr rhsExpr =>
          let startTime ← Core.liftIOCore IO.monoMsNow

          -- Parse the input expression
          let widthId : Nat := 9481
          let mut initialState := H.initialParserState
          initialState := { initialState with symVarToDisplayName := initialState.symVarToDisplayName.insert widthId (Name.mkSimple "w")}

          let some parsedLogicalExpr ← (H.parseExprs lhsExpr rhsExpr targetWidth).run' initialState
            | throwError "Unsupported expression provided"

          let bvLogicalExpr := parsedLogicalExpr.logicalExpr
          let parsedBVState := parsedLogicalExpr.state

          let mut initialGeneralizerState := H.initialGeneralizerState startTime timeoutMs widthId targetWidth parsedLogicalExpr

          let generalizeRes ← generalize.run' initialGeneralizerState
          let variableDisplayNames := Std.HashMap.union parsedBVState.inputVarIdToDisplayName parsedBVState.symVarToDisplayName

          trace[Generalize] m! "All vars: {variableDisplayNames}"
          match generalizeRes with
            | some res => match context with
                          | GeneralizeContext.Command => let pretty := H.prettify res variableDisplayNames
                                                         pure m! "Raw generalization result: {res} \n Input expression: {hExpr} has generalization: {pretty}"
                          | GeneralizeContext.Tactic name => pure m! "{H.prettifyAsTheorem name res variableDisplayNames}"
            | none => throwError m! "Could not generalize {bvLogicalExpr}"

    | _ => throwError m!"The top level constructor is not an equality predicate in {hExpr}"
