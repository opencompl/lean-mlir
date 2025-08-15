import Lean
import Lean.Elab.Term

import SSA.Core.Util
import SSA.Experimental.Bits.Generalize.Generalize
import SSA.Experimental.Bits.Generalize.BitVec.Basic
import SSA.Experimental.Bits.Generalize.BitVec.Reflect

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide
open Tactic

namespace Generalize
set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

instance : HydrableInstances GenBVLogicalExpr where

instance : HydrableGetInputWidth where
  getWidth := getWidth

instance : HydrableGetLogicalExprSize GenBVLogicalExpr where
  getLogicalExprSize e := e.size

instance : HydrableGenLogicalExprToExpr ParsedBVExpr GenBVLogicalExpr GenBVExpr where
  genLogicalExprToExpr := toExpr

instance : HydrableSolve ParsedBVExpr GenBVLogicalExpr GenBVExpr where

instance : HydrableChangeLogicalExprWidth GenBVLogicalExpr where
  changeLogicalExprWidth := changeBVLogicalExprWidth

instance : HydrableParseExprs ParsedBVExpr GenBVLogicalExpr where
  parseExprs := parseExprs

instance : HydrableSubstitute GenBVLogicalExpr GenBVExpr where
  substitute := substitute

instance : HydrablePackedBitvecToSubstitutionValue GenBVLogicalExpr GenBVExpr where
  packedBitVecToSubstitutionValue := packedBitVecToSubstitutionValue

instance : HydrableBooleanAlgebra GenBVLogicalExpr GenBVExpr where
  not e := BoolExpr.not e
  and e1 e2 := BoolExpr.gate Gate.and e1 e2
  True := BoolExpr.const True
  False := BoolExpr.const False
  eq e1 e2 := BoolExpr.literal (GenBVPred.bin e1 BVBinPred.eq e2)
  beq e1 e2 := BoolExpr.gate Gate.beq e1 e2

instance : HydrableGetIdentityAndAbsorptionConstraints GenBVLogicalExpr GenBVExpr where
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints

instance : HydrableAddConstraints GenBVLogicalExpr GenBVExpr where
  addConstraints := addConstraints

instance : HydrableGenExpr GenBVExpr where
  genExprVar id := GenBVExpr.var id
  genExprConst bv := GenBVExpr.const bv

instance : HydrableExistsForall ParsedBVExpr GenBVLogicalExpr GenBVExpr where

instance : HydrableInitialParserState where
  initialParserState := defaultParsedExprState

instance :  HydrableCheckTimeout GenBVLogicalExpr where

def shrinkParsedBVExpr (expr : ParsedBVExpr) (targetWidth : Nat) : MetaM ParsedBVExpr := do
  let bvExpr ← shrinkBVExpr expr.bvExpr targetWidth
  return {expr with bvExpr := bvExpr, width := targetWidth}

  where
    shrinkBVExpr {w} (bvExpr : GenBVExpr w) (result: Nat) : MetaM (GenBVExpr result) := do
      match bvExpr with
      | .var idx => return GenBVExpr.var idx
      | .const val => return GenBVExpr.const (val.setWidth result)
      | .bin lhs op rhs => return GenBVExpr.bin (← shrinkBVExpr lhs result) op (← shrinkBVExpr rhs result)
      | .un op operand => return GenBVExpr.un op (← shrinkBVExpr operand result)
      | .shiftLeft (n := n) lhs rhs => return GenBVExpr.shiftLeft (← shrinkBVExpr lhs result) (← shrinkBVExpr rhs (reduce n))
      | .shiftRight (n := n) lhs rhs => return GenBVExpr.shiftRight (← shrinkBVExpr lhs result) (← shrinkBVExpr rhs (reduce n))
      | .arithShiftRight (n := n) lhs rhs => return GenBVExpr.arithShiftRight (← shrinkBVExpr lhs result) (← shrinkBVExpr rhs (reduce n))
      | .signExtend (w := w) _ expr => return GenBVExpr.signExtend result (← shrinkBVExpr expr (reduce w))
      | .zeroExtend (w := w) _ expr => return GenBVExpr.zeroExtend result (← shrinkBVExpr expr (reduce w))
      | .truncate (w := w) _ expr => return GenBVExpr.truncate result (← shrinkBVExpr expr (reduce w))
      | _ => throwError m! "Unsupported input type: {bvExpr}"

    reduce (instWidth : Nat) : Nat :=
      if instWidth == 1 then instWidth
      else (instWidth  * targetWidth) / expr.width

def shrink (origExpr : ParsedBVLogicalExpr) (targetWidth : Nat) : MetaM ParsedBVLogicalExpr := do
  let lhs ← shrinkParsedBVExpr origExpr.lhs targetWidth
  let rhs ← shrinkParsedBVExpr origExpr.rhs targetWidth

  if h :  targetWidth = lhs.width ∧ lhs.width = rhs.width then
    let rhsExpr := h.right ▸ rhs.bvExpr

    let mut displayNameToShrinkedVar : Std.HashMap Name HydraVariable := Std.HashMap.emptyWithCapacity
    let mut inputVarIdToShrinkedVar : Std.HashMap Nat HydraVariable := Std.HashMap.emptyWithCapacity
    let mut symVarIdToShrinkedVar : Std.HashMap Nat HydraVariable := Std.HashMap.emptyWithCapacity

    for (name, var) in origExpr.state.displayNameToVariable do
      let mut resultWidth := 1

      if var.width != 1 then
        resultWidth := (var.width * targetWidth) / origExpr.lhs.width

      let var := {name := name, width := resultWidth, id := var.id}
      displayNameToShrinkedVar := displayNameToShrinkedVar.insert name var

      if origExpr.state.inputVarIdToVariable.contains var.id then
        inputVarIdToShrinkedVar := inputVarIdToShrinkedVar.insert var.id var

      if origExpr.state.symVarIdToVariable.contains var.id then
        symVarIdToShrinkedVar := symVarIdToShrinkedVar.insert var.id var

    let bvLogicalExpr := BoolExpr.literal (GenBVPred.bin lhs.bvExpr BVBinPred.eq rhsExpr)

    let shrinkedState := {origExpr.state with displayNameToVariable := displayNameToShrinkedVar, symVarIdToVariable := symVarIdToShrinkedVar, inputVarIdToVariable := inputVarIdToShrinkedVar}
    return {origExpr with lhs := lhs, rhs := rhs, logicalExpr := bvLogicalExpr, state := shrinkedState}

  throwError m! "Expected lhsWidth:{lhs.width} and rhsWidth:{rhs.width} to equal targetWidth:{targetWidth}"

instance : HydrableReduceWidth ParsedBVExpr GenBVLogicalExpr GenBVExpr where
  shrink := shrink

elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq w lhsExpr rhsExpr =>
           let some width ← getWidth w  | throwError m! "Could not determine the rewrite width from {w}"
           let initialState  := { defaultParsedExprState with originalWidth := width}
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr width).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.logicalExpr
           let state := parsedBvExpr.state
           trace[Generalize] m! "bvExpr: {bvExpr}, state: {state}"

           let initialGeneralizerState : GeneralizerState ParsedBVExpr GenBVLogicalExpr :=
                { startTime                := 0
                , widthId                  := 0
                , timeout                  := 0
                , processingWidth          := targetWidth
                , targetWidth              := targetWidth
                , parsedLogicalExpr       := parsedBvExpr
                , needsPreconditionsExprs   := []
                , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                }

           let results ← (reduceWidth width targetWidth 3).run' initialGeneralizerState

           logInfo m! "Results: {results}"
      | _ =>
            logInfo m! "Could not match"
      pure ()

-- variable {x y z : BitVec 1}
-- #reducewidth BitVec.zeroExtend 64 (BitVec.zeroExtend 32 x ^^^ 1#32) = BitVec.zeroExtend 64 (x ^^^ 1#1) : 8

-- variable {x y z : BitVec 64}
-- #reducewidth (x + 0 = x) : 4
-- #reducewidth ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00ffff00#64 : 4
-- #reducewidth (x <<< 3  = y + (BitVec.ofNat 64 3)) : 4
-- #reducewidth (x <<< 3) <<< 4 = x <<< 7 : 4
-- #reducewidth x + 5 = x : 8
-- #reducewidth x = 10 : 8
-- #reducewidth (x + (-21)) >>> 1 = x >>> 1 : 4

-- variable {x y z : BitVec 32}
-- #reducewidth (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32  : 8
-- #reducewidth 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x : 8
-- #reducewidth 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 : 8

-- #reducewidth BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) : 8
-- #reducewidth x <<< 6#32 <<< 28#32 = 0#32 : 4

def pruneEquivalentBVExprs (expressions: List (GenBVExpr w)) : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr  (List (GenBVExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (GenBVExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (GenBVPred.bin f BVBinPred.eq expr)))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints Gate.and

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    trace[Generalize] m! "Removed {expressions.length - pruned.length} expressions after pruning {expressions.length} expressions"

    pure pruned

def pruneEquivalentBVLogicalExprs(expressions : List GenBVLogicalExpr): GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (List GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List GenBVLogicalExpr:= []
    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.gate Gate.beq f expr))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints Gate.and

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"
    pure pruned

def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}

def wrap (bvExpr : GenBVExpr w) : BVExprWrapper := { bvExpr := bvExpr, width := w}

def filterCandidatePredicates  (bvLogicalExpr: GenBVLogicalExpr) (preconditionCandidates visited: Std.HashSet GenBVLogicalExpr)
                                                    : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (List GenBVLogicalExpr) :=
  withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let mut res : List GenBVLogicalExpr := []
    -- let mut currentCandidates := preconditionCandidates
    -- if numConjunctions >= 1 then
    --   let combinations := generateCombinations numConjunctions currentCandidates.toList
    --   currentCandidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))
    let widthConstraint : GenBVLogicalExpr := BoolExpr.literal (GenBVPred.bin (GenBVExpr.var widthId) BVBinPred.eq (GenBVExpr.const (BitVec.ofNat bitwidth bitwidth)))

    let mut numInvocations := 0
    let mut currentCandidates := preconditionCandidates.filter (λ cand => !visited.contains cand)
    logInfo m! "Originally processing {currentCandidates.size} candidates"

    -- Progressive filtering implementation
    while !currentCandidates.isEmpty do
      let expressionsConstraints : GenBVLogicalExpr := addConstraints (BoolExpr.const False) currentCandidates.toList Gate.or
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint] Gate.and) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, wrap (GenBVExpr.const (BitVec.ofNat bitwidth bitwidth)))]))
              if !(evalBVLogicalExpr assignment widthSubstitutedCandidate) then
                res := res.insert candidate
            pure res

      currentCandidates := newCandidates

    logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidates.size} potential candidates."
    res := currentCandidates.toList
    pure res

structure PreconditionSynthesisCacheValue where
  positiveExampleValues : List BVExpr.PackedBitVec
  negativeExampleValues : List BVExpr.PackedBitVec

instance : ToString PreconditionSynthesisCacheValue where
  toString val :=
    s! "⟨positiveExampleValues := {val.positiveExampleValues}, negativeExampleValues := {val.negativeExampleValues}⟩"

def getPreconditionSynthesisComponents (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec) :
                  Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue := Id.run do
    let groupExamplesBySymVar (examples : List (Std.HashMap Nat BVExpr.PackedBitVec)) : Std.HashMap (GenBVExpr w) (List BVExpr.PackedBitVec) := Id.run do
      let mut res : Std.HashMap (GenBVExpr w) (List BVExpr.PackedBitVec) := Std.HashMap.emptyWithCapacity
      for ex in examples do
        for (const, val) in ex.toArray do
          let constVar : GenBVExpr w := GenBVExpr.var const
          let existingList := res.getD constVar []
          res := res.insert constVar (val::existingList)
      res

    let positiveExamplesByKey := groupExamplesBySymVar positiveExamples
    let negativeExamplesByKey := groupExamplesBySymVar negativeExamples

    let mut allInputs : Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue := Std.HashMap.emptyWithCapacity
    for key in positiveExamplesByKey.keys do
      allInputs := allInputs.insert key {positiveExampleValues := positiveExamplesByKey[key]!, negativeExampleValues := negativeExamplesByKey[key]!}

    for (sc, val) in specialConstants.toArray do
      allInputs := allInputs.insert sc {positiveExampleValues := List.replicate positiveExamples.length val, negativeExampleValues := List.replicate negativeExamples.length val}

    return allInputs

set_option warn.sorry false in
def precondSynthesisUpdateCache (previousLevelCache synthesisComponents: Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue)
    (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec)
    (ops : List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (Std.HashMap (GenBVExpr w) PreconditionSynthesisCacheValue) := do
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (BVExpr.PackedBitVec × BVExpr.PackedBitVec)) (examples: List (Std.HashMap Nat BVExpr.PackedBitVec))
            (op : GenBVExpr w → GenBVExpr w → GenBVExpr w) : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr  (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalBVExpr examples[index]! (op  (GenBVExpr.const (h.left ▸ lhs.bv)) (GenBVExpr.const (h.right ▸ rhs.bv)))) :: res
              index := index + 1
            else
              throwError m! "Invalid width for lhs:{lhs} and rhs:{rhs}"
          pure res

    for (bvExpr, intermediateRes) in previousLevelCache.toArray do
      let intermediateNegValues := intermediateRes.negativeExampleValues
      let intermediatePosValues := intermediateRes.positiveExampleValues

      for op in ops do
        for (var, componentValue) in synthesisComponents.toArray do
          if specialConstants.contains bvExpr && specialConstants.contains var then --
            continue

          -- Combine the previous cache values with the synthesis components
          let negExCombinations := List.zip intermediateNegValues componentValue.negativeExampleValues
          let evaluatedNegativeExs ← evaluateCombinations negExCombinations negativeExamples op

          let posExCombinations := List.zip intermediatePosValues componentValue.positiveExampleValues
          let evaluatedPositiveExs  ← evaluateCombinations posExCombinations positiveExamples op

          let filterCheckStr := toString (evaluatedNegativeExs ++ evaluatedPositiveExs)
          if observationalEquivFilter.contains filterCheckStr then
            continue

          let newExpr := op bvExpr var
          currentCache := currentCache.insert newExpr { negativeExampleValues := evaluatedNegativeExs.map (λ ex => {bv := ex, w := w})
                                                      , positiveExampleValues := evaluatedPositiveExs.map (λ ex => {bv := ex, w := w}) : PreconditionSynthesisCacheValue}
          observationalEquivFilter := observationalEquivFilter.insert filterCheckStr

    return currentCache

def generatePreconditions (bvLogicalExpr: GenBVLogicalExpr) (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec))
              (_numConjunctions: Nat) : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (Option GenBVLogicalExpr) := do

    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let specialConstants : Std.HashMap (GenBVExpr bitwidth) BVExpr.PackedBitVec := Std.HashMap.ofList [
        ((one bitwidth), {bv := BitVec.ofNat bitwidth 1}),
        ((minusOne bitwidth), {bv := BitVec.ofInt bitwidth (-1)}),
        (GenBVExpr.var widthId, {bv := BitVec.ofNat bitwidth bitwidth})]

    let validCandidates ← withTraceNode `Generalize (fun _ => return "Attempted to generate valid preconditions") do
      let mut preconditionCandidates : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
      let synthesisComponents : Std.HashMap (GenBVExpr bitwidth)  PreconditionSynthesisCacheValue := getPreconditionSynthesisComponents positiveExamples negativeExamples specialConstants

      -- Check for power of 2: const & (const - 1) == 0
      for const in positiveExamples[0]!.keys do
        let bvExprVar := GenBVExpr.var const
        let powerOf2Expr :=  GenBVExpr.bin bvExprVar BVBinOp.and (GenBVExpr.bin bvExprVar BVBinOp.add (minusOne bitwidth))
        let powerOfTwoResults := positiveExamples.map (λ pos => evalBVExpr pos powerOf2Expr)

        if powerOfTwoResults.any (λ val => val == 0) then
          let powerOf2 := BoolExpr.literal (GenBVPred.bin powerOf2Expr BVBinPred.eq (zero bitwidth))
          preconditionCandidates := preconditionCandidates.insert powerOf2

      let mut previousLevelCache : Std.HashMap (GenBVExpr bitwidth) PreconditionSynthesisCacheValue := synthesisComponents

      let numVariables := positiveExamples[0]!.keys.length + 1 -- Add 1 for the width ID
      let ops : List (GenBVExpr bitwidth -> GenBVExpr bitwidth -> GenBVExpr bitwidth):= [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

      let mut currentLevel := 0
      let mut validCandidates : List GenBVLogicalExpr := []
      let mut visited : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity

      while currentLevel < numVariables do
          logInfo m! "Precondition Synthesis: Processing level {currentLevel}"

          let origCandidatesSize := preconditionCandidates.size
          for (bvExpr, intermediateRes) in previousLevelCache.toArray do
            let evaluatedNegativeExs := intermediateRes.negativeExampleValues.map (λ ex => ex.bv.toInt)
            let evaluatedPositiveExs := intermediateRes.positiveExampleValues.map (λ ex => ex.bv.toInt)

            if (evaluatedPositiveExs.all ( λ val => val == 0)) && evaluatedNegativeExs.all (λ val => val != 0) then
              preconditionCandidates := preconditionCandidates.insert (eqToZero bvExpr)
              continue

            if (evaluatedPositiveExs.any ( λ val => val < 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val > 0) then
              let mut cand := lteZero bvExpr widthId
              if (evaluatedPositiveExs.all ( λ val => val < 0)) then
                cand := strictlyLTZero bvExpr widthId

              preconditionCandidates := preconditionCandidates.insert cand

            if (evaluatedPositiveExs.any ( λ val => val > 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val < 0) then
              let mut cand := gteZero bvExpr widthId
              if (evaluatedPositiveExs.all ( λ val => val > 0)) then
                  cand := strictlyGTZero bvExpr widthId

              preconditionCandidates := preconditionCandidates.insert cand

          -- Check if we have a valid candidate
          if preconditionCandidates.size > origCandidatesSize then
            validCandidates ← filterCandidatePredicates bvLogicalExpr preconditionCandidates visited
            match validCandidates with
            | [] => visited := preconditionCandidates
            | _ => return validCandidates

          checkTimeout

          previousLevelCache ← precondSynthesisUpdateCache previousLevelCache synthesisComponents positiveExamples negativeExamples specialConstants ops
          currentLevel := currentLevel + 1

      pure validCandidates

    if validCandidates.isEmpty then
      return none

    if validCandidates.length == 1 then
      return validCandidates[0]?

    -- Prune expressions
    let prunedResults ← pruneEquivalentBVLogicalExprs validCandidates
    match prunedResults with
    | [] => return none
    | _ =>  return some (addConstraints (BoolExpr.const false) prunedResults Gate.or)

abbrev ExpressionSynthesisResult := Std.HashMap Nat (List BVExprWrapper)
set_option warn.sorry false in
def lhsSketchEnumeration  (lhsSketch: GenBVExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) : ExpressionSynthesisResult := Id.run do
  let zero := wrap (GenBVExpr.const (BitVec.ofNat w 0))
  let one := wrap (GenBVExpr.const (BitVec.ofNat w 1 ))
  let minusOne := wrap (GenBVExpr.const (BitVec.ofInt w (-1)))

  -- Special constants representing each input variable
  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsBVExprs : List (BVExprWrapper):= lhsSymVars.toList.map (λ (id, pbv) => {bvExpr := GenBVExpr.var id, width := pbv.w})
  let lhsSymVarsPermutation := productsList (List.replicate lhsSymVarsAsBVExprs.length lhsSymVarsAsBVExprs)

  let inputsAndSymVars := List.product inputCombinations lhsSymVarsPermutation

  let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
  for (var, value) in rhsSymVars.toArray do
    let h : value.w = w := sorry
    rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

  let mut res : ExpressionSynthesisResult := Std.HashMap.emptyWithCapacity
  for combo in inputsAndSymVars do
    let inputsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip inputVars combo.fst))
    let symVarsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip lhsSymVars.keys combo.snd))

    let substitutedExpr := substituteBVExpr lhsSketch (Std.HashMap.union inputsSubstitutions symVarsSubstitutions)
    let evalRes : BitVec w := evalBVExpr lhsSymVars substitutedExpr

    if rhsVarByValue.contains evalRes then
      let existingVar := rhsVarByValue[evalRes]!
      let existingVarRes := res.getD existingVar []

      res := res.insert existingVar (wrap substitutedExpr :: existingVarRes)

  pure res

set_option warn.sorry false in
def pruneConstantExprsSynthesisResults(exprSynthesisResults : ExpressionSynthesisResult)
                            : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr ExpressionSynthesisResult := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let state ← get
          let mut tempResults : Std.HashMap Nat (List (BVExprWrapper)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let width := state.parsedLogicalExpr.state.symVarIdToVariable[var]!.width
              let mut bvExprs : List (GenBVExpr width) := []

              for expr in expressions do
                let h : width = expr.width := sorry
                bvExprs := h ▸ expr.bvExpr :: bvExprs

              let mut prunedExprs ← pruneEquivalentBVExprs bvExprs.reverse -- lets us process in roughly increasing order
              tempResults := tempResults.insert var (prunedExprs.map (λ expr => wrap expr))

          pure tempResults

instance :  HydrableGetNegativeExamples ParsedBVExpr GenBVLogicalExpr GenBVExpr where

def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (BVExprWrapper)))
                                            : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (Option GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Checked if expressions require preconditions") do
    -- logInfo m! "Expression synthesis results : {exprSynthesisResults}"
    let combinations := productsList exprSynthesisResults.values
    let mut substitutions := []

    let state ← get
    let parsedBVLogicalExpr := state.parsedLogicalExpr
    let mut visited := state.visitedSubstitutions

    for combo in combinations do
      -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
      let zippedCombo := Std.HashMap.ofList (List.zip parsedBVLogicalExpr.rhs.symVars.keys combo)
      let substitution := substitute parsedBVLogicalExpr.logicalExpr (bvExprToSubstitutionValue zippedCombo)
      if !visited.contains substitution && !(sameBothSides substitution) then
        substitutions := substitution :: substitutions
        visited := visited.insert substitution

    let mut needsPreconditionExprs := state.needsPreconditionsExprs
    for subst in substitutions.reverse do -- We reverse in a few places so we can process in roughly increasing cost
      let negativeExample ← getNegativeExamples subst parsedBVLogicalExpr.lhs.symVars.keys 1
      if negativeExample.isEmpty then
        return some subst
      needsPreconditionExprs := subst :: needsPreconditionExprs

    let updatedState := {state with visitedSubstitutions := visited, needsPreconditionsExprs := needsPreconditionExprs}
    set updatedState

    return none

abbrev EnumerativeSearchCache :=  Std.HashMap BVExprWrapper BVExpr.PackedBitVec
set_option warn.sorry false in
def constantExprsEnumerationFromCache (previousLevelCache allLhsVars : EnumerativeSearchCache) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec)
                                          (ops: List (GenBVExpr w → GenBVExpr w → GenBVExpr w))
                                          : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (ExpressionSynthesisResult × EnumerativeSearchCache) := do
    let zero := BitVec.ofNat w 0
    let one := BitVec.ofNat w 1
    let minusOne := BitVec.ofInt w (-1)

    let specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec := Std.HashMap.ofList [
      (GenBVExpr.const one, {bv := one}),
      (GenBVExpr.const minusOne, {bv := minusOne})
    ]

    let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
    for (var, value) in rhsSymVars.toArray do
      let h : value.w = w := sorry
      rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

    let mut currentCache := Std.HashMap.emptyWithCapacity

    let mut res : Std.HashMap Nat (List BVExprWrapper) := Std.HashMap.emptyWithCapacity
    for (wrappedBvExpr, packedBV) in previousLevelCache.toArray do
      let packedBVExpr : GenBVExpr packedBV.w := GenBVExpr.const packedBV.bv

      for (lhsVar, lhsVal) in allLhsVars.toArray do
        for op in ops do
          if packedBV.w == lhsVar.width then
            let h : packedBV.w = w ∧ lhsVar.width = w := sorry

            let evaluatedRes := evalBVExpr lhsSymVars (op (h.left ▸ packedBVExpr) (h.right ▸ lhsVar.bvExpr))

            let h' : w = wrappedBvExpr.width := sorry
            let mut newExpr := wrap (op (h' ▸ wrappedBvExpr.bvExpr) (h.right ▸ lhsVar.bvExpr))
            let rhsVarForValue := rhsVarByValue[evaluatedRes]?

            match rhsVarForValue with
            | some rhsVar =>
                let existingCandidates := res.getD rhsVar []
                res := res.insert rhsVar (newExpr::existingCandidates)
            | none =>
              if evaluatedRes == h.left ▸ packedBV.bv then
                newExpr := wrappedBvExpr
              currentCache := currentCache.insert newExpr {bv := evaluatedRes : BVExpr.PackedBitVec}

    pure (res, currentCache)

partial def deductiveSearch (expr: GenBVExpr w) (constants: Std.HashMap Nat BVExpr.PackedBitVec)
      (target: BVExpr.PackedBitVec) (depth: Nat) (parent: Nat) : TermElabM (List (GenBVExpr target.w)) := do

    let updatePackedBVWidth (orig : BVExpr.PackedBitVec) (newWidth: Nat) : BVExpr.PackedBitVec :=
        if orig.w < newWidth then
            if orig.bv < 0 then
             {bv := orig.bv.signExtend newWidth, w := newWidth}
            else {bv := orig.bv.zeroExtend newWidth, w := newWidth}
        else if orig.w > newWidth then
            {bv := orig.bv.truncate newWidth, w := newWidth}
        else
            orig

    match depth with
      | 0 => return []
      | _ =>
            let mut res : List (GenBVExpr target.w) := []

            for (constId, constVal) in constants.toArray do
              let newVar : GenBVExpr target.w := GenBVExpr.var constId

              if constVal == target then
                res := newVar :: res
                continue

              if constId == parent then -- Avoid runaway expressions
                continue

              if target.bv == 0 then
                res := GenBVExpr.const 0 :: res

              let newConstVal := (updatePackedBVWidth constVal target.w)
              let h : newConstVal.w = target.w := sorry

              let constBv := h ▸ newConstVal.bv
              -- ~C = T
              if BitVec.not constBv == target.bv then
                res := GenBVExpr.un BVUnOp.not newVar :: res

              -- C + X = Target; New target = Target - X.
              let addRes ← deductiveSearch expr constants {bv := target.bv - constBv} (depth-1) constId
              res := res ++ addRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.add resExpr)

              -- C - X = Target
              let subRes ← deductiveSearch expr constants {bv := constBv - target.bv} (depth-1) constId
              res := res ++ subRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.add (negate resExpr))

              -- X - C = Target
              let subRes' ← deductiveSearch expr constants {bv := target.bv + constBv}  (depth-1) constId
              res := res ++ subRes'.map (λ resExpr => GenBVExpr.bin (resExpr) BVBinOp.add (negate newVar))

              -- X * C = Target
              if (BitVec.srem target.bv constBv) == 0 && (BitVec.sdiv target.bv constBv != 0) then
                let mulRes ← deductiveSearch expr constants {bv := BitVec.sdiv target.bv constBv} (depth - 1) constId
                res := res ++ mulRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.mul resExpr)

              -- C / X = Target
              if target.bv != 0 && (BitVec.umod constBv target.bv) == 0 then
                let divRes ← deductiveSearch expr constants {bv := BitVec.udiv constBv target.bv} (depth - 1) constId
                res := res ++ divRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.udiv resExpr)

            return res

set_option warn.sorry false in
def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec))
              : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (Option GenBVLogicalExpr) :=  do
    let state ← get
    let parsedBVLogicalExpr := state.parsedLogicalExpr
    let processingWidth := state.processingWidth

    let mut exprSynthesisResults : Std.HashMap Nat (List (BVExprWrapper)) := Std.HashMap.emptyWithCapacity

    for constantAssignment in constantAssignments do
        logInfo m! "Processing constants assignment: {constantAssignment}"
        let lhs := updateConstantValues parsedBVLogicalExpr.lhs constantAssignment
        let rhs := updateConstantValues parsedBVLogicalExpr.rhs constantAssignment
        let h : lhs.width = processingWidth := sorry

        let lhsAssignments := constantAssignment.filter (fun k _ => lhs.symVars.contains k)
        let rhsAssignments := constantAssignment.filter (fun k _ => rhs.symVars.contains k)

        logInfo m! "Performing deductive search"
        for (targetId, targetVal) in rhsAssignments do
          let deductiveSearchRes ← deductiveSearch lhs.bvExpr lhsAssignments targetVal 3 1234
          match deductiveSearchRes with
          | [] => break
          | x::xs => exprSynthesisResults := exprSynthesisResults.insert targetId (deductiveSearchRes.map (λ res => wrap res))

        if exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          match (← getCombinationWithNoPreconditions exprSynthesisResults) with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from just deductive search"

        logInfo m! "Performing enumerative search using a sketch of the LHS"
        let lhsSketchResults := lhsSketchEnumeration lhs.bvExpr lhs.inputVars.keys lhsAssignments rhsAssignments
        for (var, exprs) in lhsSketchResults.toArray do
          let existingExprs := exprSynthesisResults.getD var []
          exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ exprs)

        if !lhsSketchResults.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
          match preconditionCheckResults with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from a sketch of the LHS"

        logInfo m! "Performing bottom-up enumerative search one level at a time"

        let specialConstants : Std.HashMap BVExprWrapper BVExpr.PackedBitVec := Std.HashMap.ofList [
          ((wrap (one processingWidth)), {bv := BitVec.ofNat processingWidth 1}),
          ((wrap (minusOne processingWidth)), {bv :=  BitVec.ofInt processingWidth (-1)})
        ]

        let mut allLHSVars := specialConstants
        for (var, value) in lhsAssignments.toArray do
          allLHSVars := allLHSVars.insert (wrap (GenBVExpr.var (w := processingWidth) var)) value
          allLHSVars := allLHSVars.insert (wrap (GenBVExpr.un (w := processingWidth) BVUnOp.not ((GenBVExpr.var var)))) {bv := BitVec.not (value.bv)}

        let ops : List (GenBVExpr processingWidth → (GenBVExpr processingWidth) → (GenBVExpr processingWidth)) := [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

        let mut currentLevel := 1
        let mut cache := allLHSVars

        while currentLevel < lhs.symVars.size do
          logInfo m! "Expression Synthesis Processing level {currentLevel}"

          let bottomUpRes ← constantExprsEnumerationFromCache cache allLHSVars lhsAssignments rhsAssignments ops
          cache := bottomUpRes.snd
          for (var, exprs) in bottomUpRes.fst do
            let existingExprs := exprSynthesisResults.getD var []
            exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ exprs)

          if !bottomUpRes.fst.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
            exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
            let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
            match preconditionCheckResults with
            | some expr => return some expr
            | none => logInfo m! "Could not find a generalized form from processing level {currentLevel}"

          checkTimeout
          currentLevel :=  currentLevel + 1

    return none

instance :  HydrableSynthesizeWithNoPrecondition ParsedBVExpr GenBVLogicalExpr GenBVExpr where
 synthesizeWithNoPrecondition := synthesizeWithNoPrecondition

def checkForPreconditions (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) (maxConjunctions: Nat)
                                                : GeneralizerStateM ParsedBVExpr GenBVLogicalExpr (Option GenBVLogicalExpr) := do
  let state ← get
  let parsedBVLogicalExpr := state.parsedLogicalExpr

  let positiveExamples := constantAssignments.map (fun assignment => assignment.filter (fun key _ => parsedBVLogicalExpr.lhs.symVars.contains key))

  for numConjunctions in (List.range (maxConjunctions + 1)) do
    logInfo m! "Running with {numConjunctions} allowed conjunctions"
    for expr in state.needsPreconditionsExprs.reverse do
        let negativeExamples ← getNegativeExamples expr positiveExamples[0]!.keys 3
        logInfo m! "Negative examples for {expr} : {negativeExamples}"

        let precondition ← withTraceNode `Generalize (fun _ => return m! "Attempted to generate weak precondition for {expr}") do
                      generatePreconditions expr positiveExamples negativeExamples numConjunctions

        match precondition with
        | none => logInfo m! "Could not generate precondition for expr: {expr} with negative examples: {negativeExamples}"
        | some weakPC =>
                return BoolExpr.ite weakPC expr (BoolExpr.const False)

        checkTimeout
  return none


instance :  HydrableCheckForPreconditions ParsedBVExpr GenBVLogicalExpr GenBVExpr where
 checkForPreconditions := checkForPreconditions

def prettifyBVBinOp (op: BVBinOp) : String :=
  match op with
  | .and => "&&&"
  | .or => "|||"
  | .xor => "^^^"
  | _ => op.toString

def prettifyBVBinPred (op : BVBinPred) : String :=
  match op with
  | .eq => "="
  | _ => op.toString

def prettifyBVExpr (bvExpr : GenBVExpr w) (displayNames: Std.HashMap Nat Name) : String :=
    match bvExpr with
    | .var idx => displayNames[idx]!.toString
    | .const bv =>
       toString bv.toInt
    | .bin lhs BVBinOp.add (.bin  (GenBVExpr.const bv) BVBinOp.add (GenBVExpr.un BVUnOp.not rhs)) =>
      if bv.toInt == 1 then -- A subtraction
        s! "({prettifyBVExpr lhs displayNames} - {prettifyBVExpr rhs displayNames})"
      else
        s! "({prettifyBVExpr lhs displayNames} + ({prettifyBVExpr (GenBVExpr.const bv) displayNames} + {prettifyBVExpr (GenBVExpr.un BVUnOp.not rhs) displayNames}))"
    | .bin lhs op rhs =>
       s! "({prettifyBVExpr lhs displayNames} {prettifyBVBinOp op} {prettifyBVExpr rhs displayNames})"
    | .un op operand =>
       s! "({op.toString} {prettifyBVExpr operand displayNames})"
    | .shiftLeft lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} <<< {prettifyBVExpr rhs displayNames})"
    | .shiftRight lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} >>> {prettifyBVExpr rhs displayNames})"
    | .arithShiftRight lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} >>>a {prettifyBVExpr rhs displayNames})"
    | .signExtend v expr => s! "BitVec.signExtend {v} {prettifyBVExpr expr displayNames}"
    | .zeroExtend v expr => s! "BitVec.zeroExtend {v} {prettifyBVExpr expr displayNames}"
    | .truncate v expr =>   s! "BitVec.truncate {v} {prettifyBVExpr expr displayNames}"
    | _ => bvExpr.toString

def isGteZeroCheck (expr : GenBVLogicalExpr) : Bool :=
  match expr with
  | .literal (GenBVPred.bin _ BVBinPred.ult (GenBVExpr.shiftLeft (GenBVExpr.const bv) (GenBVExpr.bin (GenBVExpr.var _) BVBinOp.add (GenBVExpr.bin (GenBVExpr.const bv') BVBinOp.add (GenBVExpr.un BVUnOp.not (GenBVExpr.const bv'')))))) =>
          bv.toInt == 1 && bv'.toInt == 1 && bv''.toInt == 1
  | _ => false

def prettifyComparison (bvLogicalExpr : GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name)  : Option String := Id.run do
  let mut res : Option String := none
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs BVBinPred.ult _) =>
    if isGteZeroCheck bvLogicalExpr then
      res := some s! "{prettifyBVExpr lhs displayNames} >= 0"
  | .gate Gate.and (BoolExpr.literal (GenBVPred.bin (GenBVExpr.const bv) BVBinPred.ult expr)) rhs =>
    if bv.toInt == 0 && isGteZeroCheck rhs then
      res := some s! "{prettifyBVExpr expr displayNames} > 0"
  | .not expr  =>
     if isGteZeroCheck expr then
      match expr with
      |  .literal (GenBVPred.bin lhs _ _) => res := some s! "{prettifyBVExpr lhs displayNames} < 0"
      | _ => return none
  | _ => return none

  res


def prettify (generalization: GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name) : String :=
  match (prettifyComparison generalization displayNames) with
  | some s => s
  | none =>
      match generalization with
      | .literal (GenBVPred.bin lhs op rhs) =>
          s! "{prettifyBVExpr lhs displayNames} {prettifyBVBinPred op} {prettifyBVExpr rhs displayNames}"
      | .not boolExpr =>
          s! "!({prettify boolExpr displayNames})"
      | .gate op lhs rhs =>
          s! "({prettify lhs displayNames}) {op.toString} ({prettify rhs displayNames})"
      | .ite cond positive _ =>
          s! "if {prettify cond displayNames} then {prettify positive displayNames} "
      | _ => generalization.toString


instance : HydrablePrettify GenBVLogicalExpr where
  prettify := prettify

def prettifyAsTheorem (name: Name) (generalization: GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name) : String := Id.run do
  let params := displayNames.values.filter (λ n => n.toString != "w")

  let mut res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " (params.map (λ p => p.toString))} : BitVec w)"

  match generalization with
  | .ite cond positive _ => res := res ++ s! " (h: {prettify cond displayNames}) : {prettify positive displayNames}"
  | _ => res := res ++ s! " : {prettify generalization displayNames}"

  res := res ++ s! " := by sorry"
  pure res

instance : HydrablePrettifyAsTheorem GenBVLogicalExpr where
  prettifyAsTheorem := prettifyAsTheorem

abbrev BVGeneralizerState := GeneralizerState ParsedBVExpr GenBVLogicalExpr
def initialGeneralizerState (startTime timeout widthId targetWidth: Nat) (parsedLogicalExpr : ParsedBVLogicalExpr)
            : BVGeneralizerState := { startTime := startTime
                                    , widthId := widthId
                                    , timeout := timeout
                                    , processingWidth           := targetWidth
                                    , targetWidth               := targetWidth
                                    , parsedLogicalExpr       := parsedLogicalExpr
                                    , needsPreconditionsExprs   := []
                                    , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                                    }

instance : HydrableInitializeGeneralizerState ParsedBVExpr GenBVLogicalExpr GenBVExpr where
  initializeGeneralizerState := initialGeneralizerState

instance : HydrableGeneralize ParsedBVExpr GenBVLogicalExpr GenBVExpr where
instance bvHydrableParseAndGeneralize : HydrableParseAndGeneralize ParsedBVExpr GenBVLogicalExpr GenBVExpr where

elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"
      let res ← parseAndGeneralize (H := bvHydrableParseAndGeneralize)
        hExpr GeneralizeContext.Command

      logInfo m! "{res}"

syntax (name := bvGeneralize) "bv_generalize" : tactic

open Lean Meta Elab Tactic in
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic
  | `(tactic| bv_generalize) => do
      let name ← mkAuxDeclName `generalized
      let msg ← withoutModifyingEnv <| withoutModifyingState do
        Lean.Elab.Tactic.withMainContext do
          let expr ← Lean.Elab.Tactic.getMainTarget
          let res ← parseAndGeneralize (H := bvHydrableParseAndGeneralize)
            expr (GeneralizeContext.Tactic name)
          pure m! "{res}"
      logInfo m! "{msg}"
  | _ => Lean.Elab.throwUnsupportedSyntax


set_option linter.unusedTactic false


--variable {x y z : BitVec 1}
-- #generalize BitVec.zeroExtend 64 (BitVec.zeroExtend 32 x ^^^ 1#32) = BitVec.zeroExtend 64 (x ^^^ 1#1) --#fold_xor_zext_sandwich_thm

-- variable {x y z : BitVec 8}
-- #generalize x + 0 = 0 --  TODO: This crashes because bv_normalize removes the symbolic variable from the expression when attempting to find counterexamples, and we only get counterexamples for the input variable, which is not ideal since we expect counterexamples for the symbolic constants if they exist.
-- #generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y

--variable {x y z : BitVec 11 }
-- #generalize BitVec.signExtend 47 (BitVec.zeroExtend 39 x) = BitVec.zeroExtend 47 x --gzext_proof#sext_zext_apint2_thm

-- variable {x y z : BitVec 16}
-- #generalize BitVec.signExtend 64 (BitVec.zeroExtend 32 x) = BitVec.zeroExtend 64 x

-- variable {x y z: BitVec 32}
-- #generalize BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32
-- #generalize BitVec.zeroExtend 32 (BitVec.zeroExtend 8 x) = BitVec.zeroExtend 32 x


-- theorem addZero (x C1: BitVec 8) : x + C1 = C1 := by
--   bv_normalize
--   bv_decide

-- theorem zext' (x : BitVec 1) (C1 : BitVec 4) (C2: BitVec 1) : BitVec.zeroExtend 8 ((BitVec.zeroExtend 4 x).xor C1) = BitVec.zeroExtend 8 (x.xor C2) := by
--   bv_decide
--   sorry

-- theorem zext (x : BitVec 1) : BitVec.zeroExtend 64 (BitVec.zeroExtend 32 x ^^^ 1#32) = BitVec.zeroExtend 64 (x ^^^ 1#1) := by
--   bv_decide
--   sorry

-- theorem zext2 (x : BitVec 8) :  (BitVec.signExtend 47 (BitVec.zeroExtend 39 x) = BitVec.zeroExtend 47 x) := by
--   bv_decide
--   sorry


section Examples
set_option warn.sorry false
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

end Examples
