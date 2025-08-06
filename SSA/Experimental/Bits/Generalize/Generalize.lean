import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util
-- import SSA.Experimental.Bits.Generalize.Basic
-- import SSA.Experimental.Bits.Generalize.Reflect
import SSA.Experimental.Bits.Generalize.Hydrable

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

set_option warn.sorry false

namespace Generalize

/- ===================== Generalizer ==========-/
/-
ParsedBVLogicalExpr
GenBVLogicalExpr
GenBVExpr processingWidth
-/


/- def toBVExpr' (bvExpr : GenBVExpr w) : GeneralizerStateM (BVExpr w) := do
  match bvExpr with
  | .var idx => return BVExpr.var idx
  | .const val => return BVExpr.const val
  | .bin lhs op rhs  => return BVExpr.bin (← toBVExpr' lhs) op (← toBVExpr' rhs)
  | .un op expr =>  return BVExpr.un op (← toBVExpr' expr)
  | .append lhs rhs h => return BVExpr.append (← toBVExpr' lhs) (← toBVExpr' rhs) h
  | .replicate n expr h => return BVExpr.replicate n (← toBVExpr' expr) h
  | .shiftLeft lhs rhs =>  return BVExpr.shiftLeft (← toBVExpr' lhs) (← toBVExpr' rhs)
  | .shiftRight lhs rhs => return BVExpr.shiftRight (← toBVExpr' lhs) (← toBVExpr' rhs)
  | .arithShiftRight lhs rhs =>return BVExpr.arithShiftRight (← toBVExpr' lhs) (← toBVExpr' rhs)
  | _ => throwError m! "Unsupported operation provided: {bvExpr}"


def toBVLogicalExpr (bvLogicalExpr: GenBVLogicalExpr) : GeneralizerStateM BVLogicalExpr := do
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => return BoolExpr.literal (BVPred.bin (← toBVExpr' lhs) op (← toBVExpr' rhs))
  | .const b => return BoolExpr.const b
  | .not boolExpr => return BoolExpr.not (← toBVLogicalExpr boolExpr)
  | .gate gate lhs rhs => return BoolExpr.gate gate (← toBVLogicalExpr lhs) (← toBVLogicalExpr rhs)
  | _ => throwError m! "Unsupported operation"
 -/
set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

class HydrableSolve (parsedExprWrapper : Type) (parsedExpr : Type) (genLogicalExpr : Type) (genExpr : Nat → Type) extends
  HydrableInstances genLogicalExpr genExpr,
  HydrableGetAllNamesFromParsedLogicalExpr parsedExprWrapper parsedExpr genLogicalExpr genExpr,
  HydrableGetLogicalExprSize genLogicalExpr,
  HydrableGenLogicalExprToExpr parsedExprWrapper parsedExpr genLogicalExpr genExpr where


def solve
[H : HydrableSolve parsedExprWrapper parsedExpr genLogicalExpr genExpr]
  (bvExpr : genLogicalExpr) : GeneralizerStateM parsedExprWrapper parsedExpr genLogicalExpr genExpr (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let state ← get
    -- let parsedBVExprState := state.parsedBVLogicalExpr.state
    -- let allNames := Std.HashMap.union parsedBVExprState.inputVarIdToDisplayName parsedBVExprState.symVarToDisplayName
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
  HydrableParseExprs genLogicalExpr parsedExprWrapper parsedExpr,
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

/-
def parseAndGeneralize [H : HydrableGeneralize parsedExprWrapper parsedExpr genLogicalExpr genExpr] (hExpr : Expr) (context: GeneralizeContext): TermElabM MessageData := do
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

          let mut initialGeneralizerState : GeneralizerState :=
            { startTime := startTime
            , widthId := widthId
            , timeout := timeoutMs
            , processingWidth           := targetWidth
            , targetWidth               := targetWidth
            , parsedBVLogicalExpr       := parsedBVLogicalExpr
            , needsPreconditionsExprs   := []
            , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
            , constantExprsEnumerationCache  := Std.HashMap.emptyWithCapacity
            }

          let generalizeRes ← generalize.run' initialGeneralizerState
          let variableDisplayNames := Std.HashMap.union parsedBVState.inputVarIdToDisplayName parsedBVState.symVarToDisplayName

          trace[Generalize] m! "All vars: {variableDisplayNames}"
          match generalizeRes with
            | some res => match context with
                          | GeneralizeContext.Command => let pretty := prettify res variableDisplayNames
                                                         pure m! "Raw generalization result: {res} \n Input expression: {hExpr} has generalization: {pretty}"
                          | GeneralizeContext.Tactic name => pure m! "{printAsTheorem name res variableDisplayNames}"
            | none => throwError m! "Could not generalize {bvLogicalExpr}"

    | _ => throwError m!"The top level constructor is not an equality predicate in {hExpr}"


elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"
      let res ← parseAndGeneralize hExpr GeneralizeContext.Command

      logInfo m! "{res}"


syntax (name := bvGeneralize) "bv_generalize" : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize) => do
    let name ← mkAuxDeclName `generalized
    let msg ← withoutModifyingEnv <| withoutModifyingState do
      withMainContext do
        let expr ← Lean.Elab.Tactic.getMainTarget
        let res ← parseAndGeneralize expr (GeneralizeContext.Tactic name)
        pure m! "{res}"
    logInfo m! "{msg}"
| _ => throwUnsupportedSyntax


set_option linter.unusedTactic false

variable {x y z: BitVec 32}
-- #generalize BitVec.zeroExtend 32 (BitVec.zeroExtend 8 x) = BitVec.zeroExtend 32 x
-- #generalize BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32

-- theorem zextdemo (x : BitVec 32) : BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32 := by
--   bv_decide
--   sorry


-- theorem zextdemo2 (x : BitVec 32) : 1#32 <<< x &&& 1#32 = BitVec.zeroExtend 32 (BitVec.ofBool (x == 0#32)) := by
--   bv_generalize
--   sorry


/--
info: theorem Generalize.demo.generalized_1_1 {w} (x y C1 : BitVec w) : (((C1 - x) ||| y) + y) = ((y ||| (C1 - x)) + y) := by sorry
-/
#guard_msgs in
theorem demo (x y : BitVec 8) : (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y := by
  bv_generalize
  sorry


/--
info: theorem Generalize.demo2.generalized_1_1 {w} (x C1 C2 C3 C4 C5 : BitVec w) : (((x ^^^ C1) ||| C2) ^^^ C3) = ((x &&& (~ C2)) ^^^ (((0 ^^^ C2) ||| C1) ^^^ C3)) := by sorry
-/
#guard_msgs in
theorem demo2 (x y : BitVec 8) :  (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) := by
  bv_generalize
  sorry
-/
