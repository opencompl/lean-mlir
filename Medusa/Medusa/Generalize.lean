/-
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Timi Adeniran, Siddharth Bhat
-/
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import SexprPBV
import Lean

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

/-!
This file contains the interface for implementing generalization on a new IR type.
The type classes and structures operate on objects of the following types:
- `genExpr w` : This type defines the supported operations on an IR of a given width `w`. An example is the GenBVExpr type.
- `genLogicalExpr` : This defines operations involving predicates on `genExpr` objects. See `GenBVLogicalExpr`.
- `parsedExpr` : This contains the state of a `genExpr`, including its symbolic and input variables.
-/

namespace Generalize

initialize Lean.registerTraceClass `Generalize

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

def evalBoolExpr (b : BoolExpr α) (f : α → Bool) : Bool :=
  match b with
  | .literal a => f a
  | .const b => b
  | .not x => !(evalBoolExpr x f)
  | .gate g x y =>
      match g with
      | .and => (evalBoolExpr x f) && (evalBoolExpr y f)
      | .or => (evalBoolExpr x f) || (evalBoolExpr y f)
      | .xor => (evalBoolExpr x f) != (evalBoolExpr y f)
      | .beq => (evalBoolExpr x f) == (evalBoolExpr y f)
  | .ite d l r =>
      if evalBoolExpr d f then evalBoolExpr l f else evalBoolExpr r f

-- TODO: Does it need to know explicitly that it's a PackedBitVec?
-- Surely, this can be part of the API of a SubstitutionValue?
-- I.e. a type is a substitution value if it
-- can be constructed from BVs.
/--
A value that can be substituted into a `BitVec` formula.
-/
inductive SubstitutionValue (genExpr : Nat → Type) where
| genExpr {w} (genExpr : genExpr w)
| packedBV  (bv: BVExpr.PackedBitVec)

instance : Inhabited (SubstitutionValue genExpr) where
  default := .packedBV (BVExpr.PackedBitVec.mk (w := 0) 0#0)

/--
Convert a (VariableId -→ PackedBitVec) map to a (VariableId → SubstitutionValue) one
-/
class HydrablePackedBitvecToSubstitutionValue (genPred : Type) (genExpr : Nat → Type) where
  packedBitVecToSubstitutionValue : (Std.HashMap Nat BVExpr.PackedBitVec) → Std.HashMap Nat (SubstitutionValue genExpr)

/--
`Hashable`, `BEq`, and `ToMessageData` instances for generalization types.
-/
class HydrableInstances (genPred : Type) where
  beqLogical : BEq genPred := by infer_instance
  messageDataLogical : ToMessageData genPred := by infer_instance
  hashableLogical : Hashable genPred := by infer_instance

attribute [instance] HydrableInstances.beqLogical
attribute [instance] HydrableInstances.messageDataLogical
attribute [instance] HydrableInstances.hashableLogical

deriving instance Hashable for Gate
deriving instance BEq for Gate
deriving instance DecidableEq for Gate
instance : ToMessageData Gate where
  toMessageData g := m!"{g.toString}"

deriving instance Hashable for BoolExpr
deriving instance BEq for BoolExpr
deriving instance DecidableEq for BoolExpr


instance [ToMessageData α] : ToMessageData (BoolExpr α) where
  toMessageData := go
  where
    go : BoolExpr α → MessageData
    | .literal a => toMessageData a
    | .const b => toMessageData b
    | .not x => "!" ++ go x
    | .gate g x y => "(" ++ go x ++ " " ++ g.toString ++ " " ++ go y ++ ")"
    | .ite d l r => "(if " ++ go d ++ " " ++ go l ++ " " ++ go r ++ ")"


deriving instance Hashable for BVBinPred
deriving instance BEq for BVBinPred
deriving instance DecidableEq for BVBinPred

/--
The state of an input or symbolic variable
-/
structure HydraVariable where
  id : Nat
  name : Name
  width : Nat

instance : Inhabited HydraVariable where
  default := {id := 0, width := 0, name := default}

instance : ToString HydraVariable where
  toString s := s! "Variable[id: {s.id}, name : {s.name}, width : {s.width}]"

structure ParsedInputState where
  maxFreeVarId : Nat
  numSymVars :  Nat
  displayNameToVariable : Std.HashMap Name HydraVariable
  inputVarIdToVariable : Std.HashMap Nat HydraVariable
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec
  symVarIdToVariable : Std.HashMap Nat HydraVariable
  valToSymVar : Std.HashMap BVExpr.PackedBitVec Nat

class HydrableInitialParserState
where
  initialParserState : ParsedInputState

/--
Structure for maintaining the state of a parsed input `Expr`.
-/
structure ParsedLogicalExpr (parsedExpr : Type) (genPred : Type)
where
  logicalExpr : BoolExpr genPred
  state : ParsedInputState
  lhs : parsedExpr
  rhs : parsedExpr

abbrev ParseExprM := StateRefT ParsedInputState MetaM

/--
Parse the LHS and RHS of an input `Expr`, returning a `ParsedLogicalExpr` in the given target width.
-/
class HydrableParseExprs (parsedExpr : Type) (genPred : Type) where
  parseExprs : (lhsExpr rhsExpr : Expr) → (width : Nat) → ParseExprM (Option (ParsedLogicalExpr parsedExpr genPred ))

/--
Replace the variables in a BitVec formula with `SubstitutionValue` objects.
-/
class HydrableSubstitute (genPred : Type) (genExpr : Nat → Type) where
  substitute : genPred → (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) → genPred

def subsituteGenLogicalExpr
    [H : HydrableSubstitute genPred genExpr]
    (expr : BoolExpr genPred)
    (assignment: Std.HashMap Nat (SubstitutionValue genExpr)) :
    BoolExpr genPred :=
  match expr with
  | .literal l => BoolExpr.literal (H.substitute l assignment)
  | .not boolExpr =>
      BoolExpr.not (subsituteGenLogicalExpr boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (subsituteGenLogicalExpr lhs assignment) (subsituteGenLogicalExpr rhs assignment)
  | .ite conditional pos neg =>
      BoolExpr.ite
        (subsituteGenLogicalExpr conditional assignment)
        (subsituteGenLogicalExpr pos assignment)
        (subsituteGenLogicalExpr neg assignment)
  | _ => expr
structure GeneralizerState (parsedExpr : Type) (genPred : Type)
  [HydrableInstances genPred]
  where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedLogicalExpr : ParsedLogicalExpr parsedExpr genPred
  needsPreconditionsExprs : List (BoolExpr genPred)
  visitedSubstitutions : Std.HashSet (BoolExpr genPred)

abbrev GeneralizerStateM (parsedExpr : Type) (genPred : Type)
  [HydrableInstances genPred] :=
  StateRefT (GeneralizerState parsedExpr genPred) TermElabM

def GeneralizerStateM.liftTermElabM
  {parsedExpr : Type}  {genPred : Type}
  [HydrableInstances genPred]
  (m : TermElabM α) : GeneralizerStateM parsedExpr genPred α := do
  let v ← m
  return v

/--
Initialize a `GeneralizerState` object with a `parsedLogicalExpr` and the timeout and width configurations
-/
class HydrableInitializeGeneralizerState (parsedExpr : Type) (genPred : Type) (genExpr : Nat → Type) extends HydrableInstances genPred where
  initializeGeneralizerState : (startTime timeout widthId targetWidth: Nat) → (parsedLogicalExpr : ParsedLogicalExpr parsedExpr genPred)
                          → GeneralizerState parsedExpr genPred

/--
Perform simple Boolean operations on `genLogicalExpr` objects
-/
class HydrableBooleanAlgebra (genPred : Type) (genExpr : Nat → Type) where
  -- not : genLogicalExpr → genLogicalExpr
  -- and : genLogicalExpr → genLogicalExpr → genLogicalExpr
  eq : genExpr n → genExpr n → BoolExpr genPred
  -- beq : genLogicalExpr → genLogicalExpr → genLogicalExpr
  -- True : genLogicalExpr
  -- False : genLogicalExpr

def foldConstraints (expr: BoolExpr α) (constraints: List (BoolExpr α)) (op: Gate) : BoolExpr α :=
    match constraints with
    | [] => expr
    | x :: xs =>
      foldConstraints (BoolExpr.gate op expr x) xs op

/-- collect constraints with a "big and" symbol between them: ⋀_i constraint_i -/
def bigAnd (constraints : List (BoolExpr α)) : BoolExpr α :=
  foldConstraints (BoolExpr.const true) constraints Gate.and

def bigOr (constraints : List (BoolExpr α)) : BoolExpr α :=
  foldConstraints (BoolExpr.const false) constraints Gate.or

/--
Return constraints to prevent synthesizing values that might hamper generalization.
For example, we should not synthesize C = 0 for a symbolic constant C that is an operand of a bitwise AND or OR.
-/
class HydrableGetIdentityAndAbsorptionConstraints (genPred : Type) where
  getIdentityAndAbsorptionConstraints : (expr: genPred) →  (symVars: Std.HashSet Nat) → List (BoolExpr genPred)


def getIdentityAndAbsorptionConstraints [H : HydrableGetIdentityAndAbsorptionConstraints genPred]
  (expr: BoolExpr genPred) (symVars: Std.HashSet Nat) : List (BoolExpr genPred) :=
    match expr with
    | .literal l => H.getIdentityAndAbsorptionConstraints l symVars
    | .not boolExpr => getIdentityAndAbsorptionConstraints boolExpr symVars
    | .gate _ lhs rhs => (getIdentityAndAbsorptionConstraints lhs symVars) ++ (getIdentityAndAbsorptionConstraints rhs symVars)
    | .ite constVar auxVar op3 =>
        (getIdentityAndAbsorptionConstraints constVar symVars) ++ (getIdentityAndAbsorptionConstraints auxVar symVars) ++ (getIdentityAndAbsorptionConstraints op3 symVars)
    | _ => []

/--
Create a literal `genExpr` object given a variable ID or `BitVec` constant.
-/
class HydrableGenExpr (genExpr : Nat → Type) where
  genExprVar : Nat → genExpr n
  genExprConst : BitVec n → genExpr n

/--
Convert a `genLogicalExpr` to a Lean Expr. We invoke `BVDecide` on the Lean Expr in the `solve` function.
-/
class HydrableGenPredToExpr (parsedExpr : Type) (genPred : Type) where
  -- TODO: why does this need the full ParsedLogicalExpr? That's a bit weird.
  -- Doesn't it only need the state?
  genPredToExpr : ParsedLogicalExpr parsedExpr genPred → genPred  → MetaM Expr

/--
Get the number of nodes of a `genPred` for debugging.
-/
class HydrableGetGenPredSize (genPred : Type) where
  getGenPredSize : genPred → Nat

/-- Get the number of nodes in a genLogicalExpr -/
def getGenLogicalExprSize [H : HydrableGetGenPredSize genPred] (logicalExpr : BoolExpr genPred) : Nat :=
  match logicalExpr with
  | .literal _ => 1
  | .const _ => 1
  | .not x => 1 + getGenLogicalExprSize x
  | .gate _ x y => 1 + getGenLogicalExprSize x + getGenLogicalExprSize y
  | .ite d l r => 1 + getGenLogicalExprSize d + getGenLogicalExprSize l + getGenLogicalExprSize r

-- TODO: implement by floating code from BvGeneralize up into the common directory.
def genLogicalExprToExpr
  [HydrableInstances genPred]
  [H : HydrableGenPredToExpr parsedExpr genPred]
  (parsedExpr : ParsedLogicalExpr parsedExpr genPred) (logicalExpr : BoolExpr genPred) : MetaM Expr :=
  match logicalExpr with
  | .literal pred => H.genPredToExpr parsedExpr pred
  | .const b =>
      match b with
      | true => return (mkConst ``Bool.true)
      | _ => return (mkConst ``Bool.false)
  | .not boolExpr =>
    return mkApp (.const ``Bool.not []) (← genLogicalExprToExpr parsedExpr boolExpr)
  | .gate gate lhs rhs => do
      let lhs ← genLogicalExprToExpr parsedExpr lhs
      let rhs ← genLogicalExprToExpr parsedExpr rhs
      match gate with
      | .or => return mkApp2 (.const ``Bool.or []) lhs rhs
      | .xor => return mkApp2 (.const ``Bool.xor []) lhs rhs
      | .and => return mkApp2 (.const ``Bool.and []) lhs rhs
      | .beq =>
          mkAppM ``BEq.beq #[lhs, rhs]
  | _ => throwError m! "Unsupported operation {logicalExpr}"

/--
Invoke BVDecide for a given `genLogicalExpr` representing a BitVec formula.
-/
class HydrableSolve (parsedExpr : Type) (genPred : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableInstances genPred,
  HydrableGetGenPredSize genPred,
  HydrableGenPredToExpr parsedExpr genPred where

def solve
[H : HydrableSolve parsedExpr genPred genExpr]
  (bvExpr : BoolExpr genPred) : GeneralizerStateM parsedExpr genPred (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let state ← get
    let allVars := Std.HashMap.union state.parsedLogicalExpr.state.inputVarIdToVariable state.parsedLogicalExpr.state.symVarIdToVariable

    let bitVecType (w : Nat) :=  mkApp (mkConst ``BitVec) (mkNatLit w)

    let nameTypeCombo : List (Name × Expr) := allVars.values.map (λ n => (n.name, bitVecType n.width))

    let res ←
      withLocalDeclsDND nameTypeCombo.toArray fun _ => do
        let mVar ← withTraceNode `Generalize (fun _ => return m!"Converted bvExpr to expr (size : {getGenLogicalExprSize bvExpr})") do
          let mut expr : Expr ←
            genLogicalExprToExpr (state.parsedLogicalExpr : ParsedLogicalExpr parsedExpr genPred) (bvExpr : BoolExpr genPred)
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
            let nameToId : Std.HashMap Name Nat := Std.HashMap.ofList (allVars.toList.map (λ (id, var) => (var.name, id)))
            let mut assignment : Std.HashMap Nat BVExpr.PackedBitVec := Std.HashMap.emptyWithCapacity
            for (var, val) in counterExample.equations do
              let name := ((← getLCtx).get! var.fvarId!).userName
              assignment := assignment.insert nameToId[name]! val
            pure (some assignment)
    return res

/--
Exists-forall Implementation, as described in the Yices paper: https://yices.csl.sri.com/papers/smt2015.pdf.
-/
class HydrableExistsForall (parsedExpr : Type)  (genPred : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableInstances genPred,
  HydrableSolve parsedExpr genPred genExpr,
  HydrableSubstitute genPred genExpr,
  HydrablePackedBitvecToSubstitutionValue genPred genExpr,
  HydrableBooleanAlgebra genPred genExpr,
  HydrableGetIdentityAndAbsorptionConstraints genPred,
  -- HydrableAddConstraints genPred genExpr,
  HydrableGenExpr genExpr
  where

partial def existsForAll
    [H : HydrableExistsForall parsedExpr genPred genExpr]
    (origExpr : BoolExpr genPred) (existsVars: List Nat) (forAllVars: List Nat)  (numExamples: Nat := 1) :
    GeneralizerStateM parsedExpr genPred (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do

    let rec constantsSynthesis (bvExpr: BoolExpr genPred) (existsVars: List Nat) (forAllVars: List Nat)
            : GeneralizerStateM parsedExpr genPred (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
      let existsRes ← solve bvExpr

      match existsRes with
        | none => trace[Generalize] m! "Could not satisfy exists formula for {bvExpr}"
                  return none
        | some assignment =>
          let existsVals := assignment.filter fun c _ => existsVars.contains c
          let substExpr := subsituteGenLogicalExpr bvExpr (H.packedBitVecToSubstitutionValue existsVals)
          let forAllRes ← solve (BoolExpr.not substExpr)

          match forAllRes with
            | none =>
              return some existsVals
            | some counterEx =>
                let newExpr := subsituteGenLogicalExpr bvExpr (H.packedBitVecToSubstitutionValue counterEx)
                constantsSynthesis (BoolExpr.gate .and bvExpr newExpr) existsVars forAllVars

    let mut res : List (Std.HashMap Nat BVExpr.PackedBitVec) := []
    let identityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints origExpr (Std.HashSet.ofList existsVars)
    let targetExpr := (BoolExpr.gate .and origExpr (bigAnd (identityAndAbsorptionConstraints)))

    match numExamples with
    | 0 => return res
    | n + 1 =>  let consts ← constantsSynthesis targetExpr existsVars forAllVars
                match consts with
                | none => return res
                | some assignment =>
                      res := assignment :: res
                      let newConstraints := assignment.toList.map (fun c => H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv))
                      let constrainedBVExpr := BoolExpr.not (bigAnd newConstraints)
                      return res ++ (← existsForAll (BoolExpr.gate .and origExpr constrainedBVExpr) existsVars forAllVars n)

/--
Naive model counter implementation for generating the most compact form of a precondition. Not currently in use by the Generalization procedure.
-/
class HydrableCountModel (parsedExpr : Type) (genPred : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableInstances genPred,
  HydrableSolve parsedExpr genPred genExpr,
  HydrableBooleanAlgebra genPred genExpr,
  HydrableGenExpr genExpr
  -- HydrableAddConstraints genLogicalExpr genExpr
  where

partial def countModel
  [H : HydrableCountModel parsedExpr genPred genExpr] (expr : BoolExpr genPred) (constants: Std.HashSet Nat): GeneralizerStateM parsedExpr genPred Nat := do
    go 0 expr
    where
        go (count: Nat) (expr : BoolExpr genPred) : GeneralizerStateM parsedExpr genPred Nat := do
          let res ← solve expr
          match res with
          | none => return count
          | some assignment =>
                let filteredAssignments := assignment.filter (λ c _ => constants.contains c)
                let newConstraints := filteredAssignments.toList.map (fun c => H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv))

                let constrainedBVExpr := BoolExpr.not (bigAnd newConstraints)

                if count + 1 > 1000 then
                  return count
                pure (← go (count + 1) (BoolExpr.gate .and expr constrainedBVExpr))

def generateCombinations (num: Nat) (values: List α) : List (List α) :=
    match num, values with
    | 0, _ => [[]]
    | _, [] => []
    | n + 1, x::xs =>
            let combosWithoutX := (generateCombinations (n + 1) xs)
            let combosWithX := (generateCombinations n xs).map (λ combo => x :: combo)
            combosWithoutX ++ combosWithX

/--
Get negative examples for precondition synthesis.
-/
class HydrableGetNegativeExamples (parsedExpr : Type) (genLogicalExpr : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableSolve parsedExpr genLogicalExpr genExpr,
  HydrableBooleanAlgebra genLogicalExpr genExpr,
  HydrableGenExpr genExpr
  -- HydrableAddConstraints genLogicalExpr genExpr

def getNegativeExamples [H : HydrableGetNegativeExamples parsedExpr genPred genExpr] (bvExpr: BoolExpr genPred) (consts: List Nat) (numEx: Nat) :
              GeneralizerStateM parsedExpr genPred (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
  let targetExpr := BoolExpr.not bvExpr
  return (← helper targetExpr numEx)
  where
        helper (expr: BoolExpr genPred) (depth : Nat)
          : GeneralizerStateM parsedExpr  genPred (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
        match depth with
          | 0 => return []
          | n + 1 =>
              let solution ← solve expr

              match solution with
              | none => return []
              | some assignment =>
                   let constVals := assignment.filter fun c _ => consts.contains c
                   if constVals.isEmpty then return [{}]
                   let newConstraints := constVals.toList.map (fun c => BoolExpr.not (H.eq (H.genExprVar c.fst) (H.genExprConst c.snd.bv)))
                   let res ← helper (bigAnd <| expr::newConstraints) n
                   return [constVals] ++ res


class HydrableCheckTimeout (genPred : Type) extends
    HydrableInstances genPred

def checkTimeout [H : HydrableCheckTimeout genPred] : GeneralizerStateM parsedExpr genPred Unit := do
  let state ← get
  let currentTime ← Core.liftIOCore IO.monoMsNow
  let elapsedTime := currentTime - state.startTime

  trace[Generalize] m! "Elapsed time: {elapsedTime/1000}s"
  if elapsedTime >= state.timeout then
      throwError m! "Synthesis Timeout Failure: Exceeded timeout of {state.timeout/1000}s"

/--
Attempt to find a generalization for the input expression (stored in the state monad) without a precondition.
Instances of this class may implement enumerative/deductive search methods to express the symbolic constants on the RHS in terms of the LHS.
-/
class HydrableSynthesizeWithNoPrecondition (parsedExpr : Type) (genPred : Type) (genExpr : Nat → Type) extends
    HydrableInstances genPred
    where
  synthesizeWithNoPrecondition : (constantAssignments: List (Std.HashMap Nat BVExpr.PackedBitVec)) → GeneralizerStateM parsedExpr genPred (Option (BoolExpr genPred))

/--
The procedure invokes this method if it cannot find a generalization that does not require a precondition.
Instances of this class will process each genLogicalExpr (stored in the state monad) from the previous step and attempt to find precondition(s) that render a generalization valid.
-/
class HydrableCheckForPreconditions (parsedExpr : Type) (genPred : Type) (genExpr : Nat → Type) extends
    HydrableInstances genPred
    where
  checkForPreconditions : (positiveExamples : List (Std.HashMap Nat BVExpr.PackedBitVec)) → (maxConjunctions : Nat)
                          → GeneralizerStateM parsedExpr genPred (Option (BoolExpr genPred))

/--
Update the width of the underlying `genExpr` objects in a `genLogicalExpr` object.
-/
class HydrableChangePredWidth (genPred : Type)
    where
  changePredWidth : (expr : genPred) → (target : Nat) → genPred


class HydrableReduceWidth (parsedExpr : Type) (genPred : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableExistsForall parsedExpr  genPred genExpr
  where
  shrink : (expr : ParsedLogicalExpr parsedExpr genPred) → (target: Nat) → MetaM (ParsedLogicalExpr parsedExpr genPred)

abbrev ReducedWidthRes (parsedExpr : Type) (genPred : Type) := (ParsedLogicalExpr parsedExpr genPred) × List (Std.HashMap Nat BVExpr.PackedBitVec)

def reduceWidth [H : HydrableReduceWidth parsedExpr genPred genExpr]
    (origWidth targetWidth numResults: Nat) : GeneralizerStateM parsedExpr genPred (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
  let state ← get
  let logicalExpr := state.parsedLogicalExpr

  let shrunk ← H.shrink logicalExpr targetWidth
  trace[Generalize] m! "Shrank {logicalExpr.logicalExpr} to {shrunk.logicalExpr}"
  set {state with processingWidth := targetWidth,
                  parsedLogicalExpr := shrunk}

  let shrunkState := shrunk.state
  if state.parsedLogicalExpr.state.symVarToVal.isEmpty then
    return []

  let constantAssignments ← existsForAll shrunk.logicalExpr shrunkState.symVarToVal.keys shrunkState.inputVarIdToVariable.keys numResults

  if constantAssignments.isEmpty then
    set {state with processingWidth := origWidth,
                    parsedLogicalExpr := logicalExpr}

  return constantAssignments

/--
Main generalization workflow. It works as follows at a high level:
- Invokes the `existsForAll` function to synthesize new constants in a lower bitwidth.
- Attempts to find a generalization with no precondition. The function returns this generalization if it exists.
- Finally, it attempts to find a precondition for any candidate processed in the previous step.
-/
class HydrableGeneralize (parsedExpr : Type) (genPred : outParam Type) (genExpr : outParam (Nat → Type)) extends
  HydrableInitialParserState,
  HydrableExistsForall parsedExpr  genPred genExpr,
  HydrableChangePredWidth genPred,
  HydrableReduceWidth parsedExpr genPred genExpr,
  HydrableSynthesizeWithNoPrecondition parsedExpr genPred genExpr,
  HydrableCheckForPreconditions parsedExpr genPred genExpr
  where

def generalize [H : HydrableGeneralize parsedExpr genPred genExpr]
                  : GeneralizerStateM parsedExpr genPred (Option (BoolExpr genPred)) := do
    let state ← get
    let mut parsedLogicalExpr := state.parsedLogicalExpr
    let parsedLogicalExprState := parsedLogicalExpr.state

    let originalWidth := parsedLogicalExprState.originalWidth
    let targetWidth := state.targetWidth

    let mut constantAssignments := [parsedLogicalExprState.symVarToVal]

    if originalWidth > targetWidth then
      let newAssignments ← reduceWidth originalWidth targetWidth 1

      if !newAssignments.isEmpty then
        constantAssignments := newAssignments

    let exprWithNoPrecondition  ← withTraceNode `Generalize (fun _ => return "Performed expression synthesis") do
        H.synthesizeWithNoPrecondition constantAssignments
    let maxConjunctions : Nat := 1

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


-- | TODO: There's no way this is the god-given API for this.
-- I think we should instead produce an `Expr` from the `genLogicalExpr`,
-- and then print that `Expr` using the normal Lean pretty-printer.
/--
Convert a generalization to a printable string, with variable IDs replaced with proper display names.
-/
class HydrablePrettify (genLogicalExpr : Type) where
  prettify : (generalization : BoolExpr genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String
  prettifyAsSexpr : (generalization : BoolExpr genLogicalExpr) → (displayNames : Std.HashMap Nat HydraVariable) → SexprPBV.Sexpr


/--
Convert a generalization to a theorem, with variable IDs replaced with proper display names. For use in a Tactic context.
-/
class HydrablePrettifyAsTheorem (genLogicalExpr : Type) where
  prettifyAsTheorem : (name : Name) → (generalization : BoolExpr genLogicalExpr) → (displayNames : Std.HashMap Nat Name) → String

class HydrableGetInputWidth where
  getWidth : Expr → MetaM (Option Nat)

class HydrableParseAndGeneralize (parsedExpr : Type) (genPred : Type) (genExpr : Nat → Type) extends
  HydrableGeneralize parsedExpr genPred genExpr,
  HydrableParseExprs parsedExpr genPred,
  HydrableInitializeGeneralizerState parsedExpr genPred genExpr,
  HydrablePrettify genPred,
  HydrablePrettifyAsTheorem genPred,
  HydrableGetInputWidth
  where

inductive MedusaSynthGeneralizeConfig.Output 
  | thmStmt
  | sexpr

structure MedusaSynthGeneralizeConfig where
  output : MedusaSynthGeneralizeConfig.Output := .thmStmt

instance : EmptyCollection MedusaSynthGeneralizeConfig where
  emptyCollection := {}

declare_config_elab elabMedusaSynthGeneralizeConfig MedusaSynthGeneralizeConfig


/--
Process the input `Expr` and print the generalization result.
-/
def parseAndGeneralize 
  [H : HydrableParseAndGeneralize parsedExpr genPred genExpr]
  (cfg : MedusaSynthGeneralizeConfig) 
  (hExpr : Expr) (context: GeneralizeContext): TermElabM MessageData := do
    let targetWidth := 8
    let timeoutMs := 300000

    match_expr hExpr with
    | Eq w lhsExpr rhsExpr =>

          let some width ← H.getWidth w  | throwError m! "Could not determine the rewrite width from {w}"
          let startTime ← Core.liftIOCore IO.monoMsNow

          -- Parse the input expression
          let widthId : Nat := 9481
          let widthName := (Name.mkSimple "w")
          let widthVariable : HydraVariable := {id := widthId, name := widthName, width := width}

          let mut initialState := H.initialParserState
          initialState := { initialState with
                          symVarIdToVariable := initialState.symVarIdToVariable.insert widthId widthVariable
                          , displayNameToVariable := initialState.displayNameToVariable.insert widthName widthVariable
                          , originalWidth := width}

          let some parsedLogicalExpr ← (H.parseExprs lhsExpr rhsExpr width).run' initialState
            | throwError "Unsupported expression provided"

          let bvLogicalExpr := parsedLogicalExpr.logicalExpr
          let parsedBVState := parsedLogicalExpr.state

          let mut initialGeneralizerState := H.initializeGeneralizerState startTime timeoutMs widthId targetWidth parsedLogicalExpr

          let generalizeRes ← generalize.run' initialGeneralizerState
          let allVariables := Std.HashMap.union parsedBVState.inputVarIdToVariable parsedBVState.symVarIdToVariable

          let mut variableDisplayNames : Std.HashMap Nat Name := Std.HashMap.emptyWithCapacity
          for (id, var) in allVariables.toList do
            variableDisplayNames := variableDisplayNames.insert id var.name

          trace[Generalize] m! "All vars: {variableDisplayNames}"
          match generalizeRes with
            | some res => match context with
                          | GeneralizeContext.Command => let pretty := HydrablePrettify.prettify res variableDisplayNames
                                                         pure m! "Raw generalization result: {res} \n Input expression: {hExpr} has generalization: {pretty}"
                          | GeneralizeContext.Tactic _name =>
                            match cfg.output with
                            | .thmStmt =>
                              let name := Name.mkSimple "foo"
                              pure m! "{H.prettifyAsTheorem name res variableDisplayNames}"
                            | .sexpr =>
                              throwError (H.prettifyAsSexpr res allVariables) |> format
            | none => throwError m! "Could not generalize {bvLogicalExpr}"
    | _ => throwError m!"The top level constructor is not an equality predicate in {hExpr}"

open Lean Lean.Elab Command Term in
def generalizeCommand
      (H : HydrableParseAndGeneralize parsedExpr genLogicalExpr genExpr)
      (cfg : MedusaSynthGeneralizeConfig)
      (stx : Syntax) : CommandElabM Unit := do
  withoutModifyingEnv <| runTermElabM fun _ =>
    Term.withDeclName `_reduceWidth do
      let hExpr ← Term.elabTerm stx none
      trace[Generalize] m! "hexpr: {hExpr}"
      let res ← parseAndGeneralize (H := H) cfg hExpr GeneralizeContext.Command
      logInfo m! "{res}"

open Lean Lean.Elab Command Term in
def generalizeTactic
      (H : HydrableParseAndGeneralize parsedExpr genLogicalExpr genExpr)
      (cfg : MedusaSynthGeneralizeConfig)
      (expr : Expr) : TacticM Unit := do
  let name ← mkAuxDeclName `generalized
  let msg ← withoutModifyingEnv <| withoutModifyingState do
    Lean.Elab.Tactic.withMainContext do
      -- | TODO: should we add a unification check, that allows the user
      -- to prove the more general version?
      let res ← parseAndGeneralize (H := H) cfg expr (GeneralizeContext.Tactic name)
      pure m! "{res}"
  logInfo m! "{msg}"
