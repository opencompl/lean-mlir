import Lean
import Lean.Elab.Term

import Medusa.Generalize
import Medusa.Fp.Basic
import Medusa.Fp.Reflect

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BvDecide
open Tactic


namespace Generalize
set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

instance : HydrableInstances GenFpLogicalExpr where

instance : HydrableGetInputWidth where
  getWidth := Fp.getWidth

instance : HydrableGetLogicalExprSize GenFpLogicalExpr where
  getLogicalExprSize e := e.size

instance : HydrableGenLogicalExprToExpr ParsedFpExpr GenFpLogicalExpr GenFpExpr where
  genLogicalExprToExpr := toExpr

instance : 
      HydrableSolve ParsedFpExpr GenFpLogicalExpr GenFpExpr where

instance : HydrableChangeLogicalExprWidth GenFpLogicalExpr where
  changeLogicalExprWidth := changeFpLogicalExprWidth

instance : HydrableParseExprs ParsedFpExpr GenFpLogicalExpr where
  parseExprs := parseExprs

instance : HydrableSubstitute GenFpLogicalExpr GenFpExpr where
  substitute := substitute

instance : HydrablePackedBitvecToSubstitutionValue GenFpLogicalExpr GenFpExpr where
  packedBitVecToSubstitutionValue := packedBitVecToSubstitutionValue

-- TODO: Can this just be reused for everyone? Seems like we use the BoolExpr?
instance : HydrableBooleanAlgebra GenFpLogicalExpr GenFpExpr where
  not e := BoolExpr.not e
  and e1 e2 := BoolExpr.gate Gate.and e1 e2
  True := BoolExpr.const True
  False := BoolExpr.const False
  eq e1 e2 := BoolExpr.literal (GenFpPred.bin e1 FpBinPred.eq e2)
  beq e1 e2 := BoolExpr.gate Gate.beq e1 e2

instance : HydrableGetIdentityAndAbsorptionConstraints GenFpLogicalExpr GenFpExpr where
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints

instance : HydrableAddConstraints GenFpLogicalExpr GenFpExpr where
  addConstraints := addConstraints

instance : HydrableGenExpr GenFpExpr where
  genExprVar id := GenFpExpr.var id
  genExprConst bv := GenFpExpr.const bv

instance : HydrableExistsForall ParsedFpExpr GenFpLogicalExpr GenFpExpr where

instance : HydrableInitialParserState where
  initialParserState := defaultParsedExprState

instance :  HydrableCheckTimeout GenFpLogicalExpr where

def shrinkParsedFpExpr (expr : ParsedFpExpr) (targetWidth : Nat) : MetaM ParsedFpExpr := do
  let bvExpr ← shrinkFpExpr expr.bvExpr targetWidth
  return {expr with bvExpr := bvExpr, width := targetWidth}

  where
    shrinkFpExpr {w} (bvExpr : GenFpExpr w) (result: Nat) : MetaM (GenFpExpr result) := do
      match bvExpr with
      | .var idx => return GenFpExpr.var idx
      | .const val => return GenFpExpr.const (val.setWidth result)
      | .bin lhs op rhs => return GenFpExpr.bin (← shrinkFpExpr lhs result) op (← shrinkFpExpr rhs result)
      | .un op operand => return GenFpExpr.un op (← shrinkFpExpr operand result)
      | .shiftLeft (n := n) lhs rhs => return GenFpExpr.shiftLeft (← shrinkFpExpr lhs result) (← shrinkFpExpr rhs (reduce n))
      | .shiftRight (n := n) lhs rhs => return GenFpExpr.shiftRight (← shrinkFpExpr lhs result) (← shrinkFpExpr rhs (reduce n))
      | .arithShiftRight (n := n) lhs rhs => return GenFpExpr.arithShiftRight (← shrinkFpExpr lhs result) (← shrinkFpExpr rhs (reduce n))
      | .signExtend (w := w) _ expr => return GenFpExpr.signExtend result (← shrinkFpExpr expr (reduce w))
      | .zeroExtend (w := w) _ expr => return GenFpExpr.zeroExtend result (← shrinkFpExpr expr (reduce w))
      | .truncate (w := w) _ expr => return GenFpExpr.truncate result (← shrinkFpExpr expr (reduce w))
      | _ => throwError m! "Unsupported input type: {bvExpr}"

    reduce (instWidth : Nat) : Nat :=
      if instWidth == 1 then instWidth
      else (instWidth  * targetWidth) / expr.width

-- TODO: can this be general?
def shrink (origExpr : ParsedFpLogicalExpr) (targetWidth : Nat) : MetaM ParsedFpLogicalExpr := do
  let lhs ← shrinkParsedFpExpr origExpr.lhs targetWidth
  let rhs ← shrinkParsedFpExpr origExpr.rhs targetWidth

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

    let bvLogicalExpr := BoolExpr.literal (GenFpPred.bin lhs.bvExpr FpBinPred.eq rhsExpr)

    let shrinkedState := {origExpr.state with displayNameToVariable := displayNameToShrinkedVar, symVarIdToVariable := symVarIdToShrinkedVar, inputVarIdToVariable := inputVarIdToShrinkedVar}
    return {origExpr with lhs := lhs, rhs := rhs, logicalExpr := bvLogicalExpr, state := shrinkedState}

  throwError m! "Expected lhsWidth:{lhs.width} and rhsWidth:{rhs.width} to equal targetWidth:{targetWidth}"

instance : HydrableReduceWidth ParsedFpExpr GenFpLogicalExpr GenFpExpr where
  shrink := shrink

-- TODO: make this general.
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

           let initialGeneralizerState : GeneralizerState ParsedFpExpr GenFpLogicalExpr :=
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


-- | TODO: this can be done in general for any Hydrable?
def pruneEquivalentFpExprs (expressions: List (GenFpExpr w)) : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr  (List (GenFpExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (GenFpExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (GenFpPred.bin f FpBinPred.eq expr)))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints Gate.and

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    trace[Generalize] m! "Removed {expressions.length - pruned.length} expressions after pruning {expressions.length} expressions"

    pure pruned

-- TODO: Can this be done in general for any Hydrable?
def pruneEquivalentFpLogicalExprs(expressions : List GenFpLogicalExpr): GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (List GenFpLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List GenFpLogicalExpr:= []
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

-- TODO: can this be done in general?
def updateConstantValues (bvExpr: ParsedFpExpr) (assignments: Std.HashMap Nat FpExpr.PackedBitVec)
             : ParsedFpExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}

-- TODO: can this be done in general?
def wrap (bvExpr : GenFpExpr w) : FpExprWrapper := { bvExpr := bvExpr, width := w}

def filterCandidatePredicates  (bvLogicalExpr: GenFpLogicalExpr) (preconditionCandidates visited: Std.HashSet GenFpLogicalExpr)
                                                    : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (List GenFpLogicalExpr) :=
  withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let mut res : List GenFpLogicalExpr := []
    -- let mut currentCandidates := preconditionCandidates
    -- if numConjunctions >= 1 then
    --   let combinations := generateCombinations numConjunctions currentCandidates.toList
    --   currentCandidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))
    let widthConstraint : GenFpLogicalExpr := BoolExpr.literal (GenFpPred.bin (GenFpExpr.var widthId) FpBinPred.eq (GenFpExpr.const (BitVec.ofNat bitwidth bitwidth)))

    let mut numInvocations := 0
    let mut currentCandidates := preconditionCandidates.filter (λ cand => !visited.contains cand)
    logInfo m! "Originally processing {currentCandidates.size} candidates"

    -- Progressive filtering implementation
    while !currentCandidates.isEmpty do
      let expressionsConstraints : GenFpLogicalExpr := addConstraints (BoolExpr.const False) currentCandidates.toList Gate.or
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint] Gate.and) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet GenFpLogicalExpr := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet GenFpLogicalExpr := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, wrap (GenFpExpr.const (BitVec.ofNat bitwidth bitwidth)))]))
              if !(evalFpLogicalExpr assignment widthSubstitutedCandidate) then
                res := res.insert candidate
            pure res

      currentCandidates := newCandidates

    logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidates.size} potential candidates."
    res := currentCandidates.toList
    pure res

structure PreconditionSynthesisCacheValue where
  positiveExampleValues : List FpExpr.PackedBitVec
  negativeExampleValues : List FpExpr.PackedBitVec

instance : ToString PreconditionSynthesisCacheValue where
  toString val :=
    s! "⟨positiveExampleValues := {val.positiveExampleValues}, negativeExampleValues := {val.negativeExampleValues}⟩"

def getPreconditionSynthesisComponents (positiveExamples negativeExamples: List (Std.HashMap Nat FpExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenFpExpr w) FpExpr.PackedBitVec) :
                  Std.HashMap (GenFpExpr w)  PreconditionSynthesisCacheValue := Id.run do
    let groupExamplesBySymVar (examples : List (Std.HashMap Nat FpExpr.PackedBitVec)) : Std.HashMap (GenFpExpr w) (List FpExpr.PackedBitVec) := Id.run do
      let mut res : Std.HashMap (GenFpExpr w) (List FpExpr.PackedBitVec) := Std.HashMap.emptyWithCapacity
      for ex in examples do
        for (const, val) in ex.toArray do
          let constVar : GenFpExpr w := GenFpExpr.var const
          let existingList := res.getD constVar []
          res := res.insert constVar (val::existingList)
      res

    let positiveExamplesByKey := groupExamplesBySymVar positiveExamples
    let negativeExamplesByKey := groupExamplesBySymVar negativeExamples

    let mut allInputs : Std.HashMap (GenFpExpr w)  PreconditionSynthesisCacheValue := Std.HashMap.emptyWithCapacity
    for key in positiveExamplesByKey.keys do
      allInputs := allInputs.insert key {positiveExampleValues := positiveExamplesByKey[key]!, negativeExampleValues := negativeExamplesByKey[key]!}

    for (sc, val) in specialConstants.toArray do
      allInputs := allInputs.insert sc {positiveExampleValues := List.replicate positiveExamples.length val, negativeExampleValues := List.replicate negativeExamples.length val}

    return allInputs

set_option warn.sorry false in
def precondSynthesisUpdateCache (previousLevelCache synthesisComponents: Std.HashMap (GenFpExpr w)  PreconditionSynthesisCacheValue)
    (positiveExamples negativeExamples: List (Std.HashMap Nat FpExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenFpExpr w) FpExpr.PackedBitVec)
    (ops : List (GenFpExpr w → GenFpExpr w → GenFpExpr w)) : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (Std.HashMap (GenFpExpr w) PreconditionSynthesisCacheValue) := do
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (FpExpr.PackedBitVec × FpExpr.PackedBitVec)) (examples: List (Std.HashMap Nat FpExpr.PackedBitVec))
            (op : GenFpExpr w → GenFpExpr w → GenFpExpr w) : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr  (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalFpExpr examples[index]! (op  (GenFpExpr.const (h.left ▸ lhs.bv)) (GenFpExpr.const (h.right ▸ rhs.bv)))) :: res
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

def generatePreconditions (bvLogicalExpr: GenFpLogicalExpr) (positiveExamples negativeExamples: List (Std.HashMap Nat FpExpr.PackedBitVec))
              (_numConjunctions: Nat) : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (Option GenFpLogicalExpr) := do

    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let specialConstants : Std.HashMap (GenFpExpr bitwidth) FpExpr.PackedBitVec := Std.HashMap.ofList [
        ((one bitwidth), {bv := BitVec.ofNat bitwidth 1}),
        ((minusOne bitwidth), {bv := BitVec.ofInt bitwidth (-1)}),
        (GenFpExpr.var widthId, {bv := BitVec.ofNat bitwidth bitwidth})]

    let validCandidates ← withTraceNode `Generalize (fun _ => return "Attempted to generate valid preconditions") do
      let mut preconditionCandidates : Std.HashSet GenFpLogicalExpr := Std.HashSet.emptyWithCapacity
      let synthesisComponents : Std.HashMap (GenFpExpr bitwidth)  PreconditionSynthesisCacheValue := getPreconditionSynthesisComponents positiveExamples negativeExamples specialConstants

      -- Check for power of 2: const & (const - 1) == 0
      for const in positiveExamples[0]!.keys do
        let bvExprVar := GenFpExpr.var const
        let powerOf2Expr :=  GenFpExpr.bin bvExprVar FpBinOp.and (GenFpExpr.bin bvExprVar FpBinOp.add (minusOne bitwidth))
        let powerOfTwoResults := positiveExamples.map (λ pos => evalFpExpr pos powerOf2Expr)

        if powerOfTwoResults.any (λ val => val == 0) then
          let powerOf2 := BoolExpr.literal (GenFpPred.bin powerOf2Expr FpBinPred.eq (zero bitwidth))
          preconditionCandidates := preconditionCandidates.insert powerOf2

      let mut previousLevelCache : Std.HashMap (GenFpExpr bitwidth) PreconditionSynthesisCacheValue := synthesisComponents

      let numVariables := positiveExamples[0]!.keys.length + 1 -- Add 1 for the width ID
      let ops : List (GenFpExpr bitwidth -> GenFpExpr bitwidth -> GenFpExpr bitwidth):= [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

      let mut currentLevel := 0
      let mut validCandidates : List GenFpLogicalExpr := []
      let mut visited : Std.HashSet GenFpLogicalExpr := Std.HashSet.emptyWithCapacity

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
    let prunedResults ← pruneEquivalentFpLogicalExprs validCandidates
    match prunedResults with
    | [] => return none
    | _ =>  return some (addConstraints (BoolExpr.const false) prunedResults Gate.or)

/-- productsList [xs, ys] = [(x, y) for x in xs for y in ys],
extended to arbitary number of arrays. -/
def productsList : List (List α) -> List (List α)
| [] => [[]] -- empty product returns empty tuple.
| (xs::xss) => Id.run do
  let mut out := []
  let xss' := productsList xss -- make tuples of the other columns.
  for x in xs do  -- for every element in this column, take product with all other tuples.
    out := out.append (xss'.map (fun xs => x :: xs))
  return out

def List.product (l₁ : List α) (l₂ : List β) : List (α × β) := l₁.flatMap fun a => l₂.map (Prod.mk a)

abbrev ExpressionSynthesisResult := Std.HashMap Nat (List FpExprWrapper)
set_option warn.sorry false in
def lhsSketchEnumeration  (lhsSketch: GenFpExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat FpExpr.PackedBitVec) : ExpressionSynthesisResult := Id.run do
  let zero := wrap (GenFpExpr.const (BitVec.ofNat w 0))
  let one := wrap (GenFpExpr.const (BitVec.ofNat w 1 ))
  let minusOne := wrap (GenFpExpr.const (BitVec.ofInt w (-1)))

  -- Special constants representing each input variable
  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsFpExprs : List (FpExprWrapper):= lhsSymVars.toList.map (λ (id, pbv) => {bvExpr := GenFpExpr.var id, width := pbv.w})
  let lhsSymVarsPermutation := productsList (List.replicate lhsSymVarsAsFpExprs.length lhsSymVarsAsFpExprs)

  let inputsAndSymVars := List.product inputCombinations lhsSymVarsPermutation

  let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
  for (var, value) in rhsSymVars.toArray do
    let h : value.w = w := sorry
    rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

  let mut res : ExpressionSynthesisResult := Std.HashMap.emptyWithCapacity
  for combo in inputsAndSymVars do
    let inputsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip inputVars combo.fst))
    let symVarsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip lhsSymVars.keys combo.snd))

    let substitutedExpr := substituteFpExpr lhsSketch (Std.HashMap.union inputsSubstitutions symVarsSubstitutions)
    let evalRes : BitVec w := evalFpExpr lhsSymVars substitutedExpr

    if rhsVarByValue.contains evalRes then
      let existingVar := rhsVarByValue[evalRes]!
      let existingVarRes := res.getD existingVar []

      res := res.insert existingVar (wrap substitutedExpr :: existingVarRes)

  pure res

set_option warn.sorry false in
def pruneConstantExprsSynthesisResults(exprSynthesisResults : ExpressionSynthesisResult)
                            : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr ExpressionSynthesisResult := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let state ← get
          let mut tempResults : Std.HashMap Nat (List (FpExprWrapper)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let width := state.parsedLogicalExpr.state.symVarIdToVariable[var]!.width
              let mut bvExprs : List (GenFpExpr width) := []

              for expr in expressions do
                let h : width = expr.width := sorry
                bvExprs := h ▸ expr.bvExpr :: bvExprs

              let mut prunedExprs ← pruneEquivalentFpExprs bvExprs.reverse -- lets us process in roughly increasing order
              tempResults := tempResults.insert var (prunedExprs.map (λ expr => wrap expr))

          pure tempResults

instance :  HydrableGetNegativeExamples ParsedFpExpr GenFpLogicalExpr GenFpExpr where

def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (FpExprWrapper)))
                                            : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (Option GenFpLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Checked if expressions require preconditions") do
    -- logInfo m! "Expression synthesis results : {exprSynthesisResults}"
    let combinations := productsList exprSynthesisResults.values
    let mut substitutions := []

    let state ← get
    let parsedFpLogicalExpr := state.parsedLogicalExpr
    let mut visited := state.visitedSubstitutions

    for combo in combinations do
      -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
      let zippedCombo := Std.HashMap.ofList (List.zip parsedFpLogicalExpr.rhs.symVars.keys combo)
      let substitution := substitute parsedFpLogicalExpr.logicalExpr (bvExprToSubstitutionValue zippedCombo)
      if !visited.contains substitution && !(sameBothSides substitution) then
        substitutions := substitution :: substitutions
        visited := visited.insert substitution

    let mut needsPreconditionExprs := state.needsPreconditionsExprs
    for subst in substitutions.reverse do -- We reverse in a few places so we can process in roughly increasing cost
      let negativeExample ← getNegativeExamples subst parsedFpLogicalExpr.lhs.symVars.keys 1
      if negativeExample.isEmpty then
        return some subst
      needsPreconditionExprs := subst :: needsPreconditionExprs

    let updatedState := {state with visitedSubstitutions := visited, needsPreconditionsExprs := needsPreconditionExprs}
    set updatedState

    return none

abbrev EnumerativeSearchCache :=  Std.HashMap FpExprWrapper FpExpr.PackedBitVec
set_option warn.sorry false in
def constantExprsEnumerationFromCache (previousLevelCache allLhsVars : EnumerativeSearchCache) (lhsSymVars rhsSymVars : Std.HashMap Nat FpExpr.PackedBitVec)
                                          (ops: List (GenFpExpr w → GenFpExpr w → GenFpExpr w))
                                          : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (ExpressionSynthesisResult × EnumerativeSearchCache) := do
    let zero := BitVec.ofNat w 0
    let one := BitVec.ofNat w 1
    let minusOne := BitVec.ofInt w (-1)

    let specialConstants : Std.HashMap (GenFpExpr w) FpExpr.PackedBitVec := Std.HashMap.ofList [
      (GenFpExpr.const one, {bv := one}),
      (GenFpExpr.const minusOne, {bv := minusOne})
    ]

    let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
    for (var, value) in rhsSymVars.toArray do
      let h : value.w = w := sorry
      rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

    let mut currentCache := Std.HashMap.emptyWithCapacity

    let mut res : Std.HashMap Nat (List FpExprWrapper) := Std.HashMap.emptyWithCapacity
    for (wrappedBvExpr, packedFp) in previousLevelCache.toArray do
      let packedFpExpr : GenFpExpr packedFp.w := GenFpExpr.const packedFp.bv

      for (lhsVar, lhsVal) in allLhsVars.toArray do
        for op in ops do
          if packedFp.w == lhsVar.width then
            let h : packedFp.w = w ∧ lhsVar.width = w := sorry

            let evaluatedRes := evalFpExpr lhsSymVars (op (h.left ▸ packedFpExpr) (h.right ▸ lhsVar.bvExpr))

            let h' : w = wrappedBvExpr.width := sorry
            let mut newExpr := wrap (op (h' ▸ wrappedBvExpr.bvExpr) (h.right ▸ lhsVar.bvExpr))
            let rhsVarForValue := rhsVarByValue[evaluatedRes]?

            match rhsVarForValue with
            | some rhsVar =>
                let existingCandidates := res.getD rhsVar []
                res := res.insert rhsVar (newExpr::existingCandidates)
            | none =>
              if evaluatedRes == h.left ▸ packedFp.bv then
                newExpr := wrappedBvExpr
              currentCache := currentCache.insert newExpr {bv := evaluatedRes : FpExpr.PackedBitVec}

    pure (res, currentCache)

set_option warn.sorry false in
partial def deductiveSearch (expr: GenFpExpr w) (constants: Std.HashMap Nat FpExpr.PackedBitVec)
      (target: FpExpr.PackedBitVec) (depth: Nat) (parent: Nat) : TermElabM (List (GenFpExpr target.w)) := do

    let updatePackedFpWidth (orig : FpExpr.PackedBitVec) (newWidth: Nat) : FpExpr.PackedBitVec :=
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
            let mut res : List (GenFpExpr target.w) := []

            for (constId, constVal) in constants.toArray do
              let newVar : GenFpExpr target.w := GenFpExpr.var constId

              if constVal == target then
                res := newVar :: res
                continue

              if constId == parent then -- Avoid runaway expressions
                continue

              if target.bv == 0 then
                res := GenFpExpr.const 0 :: res

              let newConstVal := (updatePackedFpWidth constVal target.w)
              let h : newConstVal.w = target.w := sorry

              let constBv := h ▸ newConstVal.bv
              -- ~C = T
              if BitVec.not constBv == target.bv then
                res := GenFpExpr.un FpUnOp.not newVar :: res

              -- C + X = Target; New target = Target - X.
              let addRes ← deductiveSearch expr constants {bv := target.bv - constBv} (depth-1) constId
              res := res ++ addRes.map (λ resExpr => GenFpExpr.bin newVar FpBinOp.add resExpr)

              -- C - X = Target
              let subRes ← deductiveSearch expr constants {bv := constBv - target.bv} (depth-1) constId
              res := res ++ subRes.map (λ resExpr => GenFpExpr.bin newVar FpBinOp.add (negate resExpr))

              -- X - C = Target
              let subRes' ← deductiveSearch expr constants {bv := target.bv + constBv}  (depth-1) constId
              res := res ++ subRes'.map (λ resExpr => GenFpExpr.bin (resExpr) FpBinOp.add (negate newVar))

              -- X * C = Target
              if (BitVec.srem target.bv constBv) == 0 && (BitVec.sdiv target.bv constBv != 0) then
                let mulRes ← deductiveSearch expr constants {bv := BitVec.sdiv target.bv constBv} (depth - 1) constId
                res := res ++ mulRes.map (λ resExpr => GenFpExpr.bin newVar FpBinOp.mul resExpr)

              -- C / X = Target
              if target.bv != 0 && (BitVec.umod constBv target.bv) == 0 then
                let divRes ← deductiveSearch expr constants {bv := BitVec.udiv constBv target.bv} (depth - 1) constId
                res := res ++ divRes.map (λ resExpr => GenFpExpr.bin newVar FpBinOp.udiv resExpr)

            return res

set_option warn.sorry false in
def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat FpExpr.PackedBitVec))
              : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (Option GenFpLogicalExpr) :=  do
    let state ← get
    let parsedFpLogicalExpr := state.parsedLogicalExpr
    let processingWidth := state.processingWidth

    let mut exprSynthesisResults : Std.HashMap Nat (List (FpExprWrapper)) := Std.HashMap.emptyWithCapacity

    for constantAssignment in constantAssignments do
        logInfo m! "Processing constants assignment: {constantAssignment}"
        let lhs := updateConstantValues parsedFpLogicalExpr.lhs constantAssignment
        let rhs := updateConstantValues parsedFpLogicalExpr.rhs constantAssignment
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

        let specialConstants : Std.HashMap FpExprWrapper FpExpr.PackedBitVec := Std.HashMap.ofList [
          ((wrap (one processingWidth)), {bv := BitVec.ofNat processingWidth 1}),
          ((wrap (minusOne processingWidth)), {bv :=  BitVec.ofInt processingWidth (-1)})
        ]

        let mut allLHSVars := specialConstants
        for (var, value) in lhsAssignments.toArray do
          allLHSVars := allLHSVars.insert (wrap (GenFpExpr.var (w := processingWidth) var)) value
          allLHSVars := allLHSVars.insert (wrap (GenFpExpr.un (w := processingWidth) FpUnOp.not ((GenFpExpr.var var)))) {bv := BitVec.not (value.bv)}

        let ops : List (GenFpExpr processingWidth → (GenFpExpr processingWidth) → (GenFpExpr processingWidth)) := [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

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

instance :  HydrableSynthesizeWithNoPrecondition ParsedFpExpr GenFpLogicalExpr GenFpExpr where
 synthesizeWithNoPrecondition := synthesizeWithNoPrecondition

def checkForPreconditions (constantAssignments : List (Std.HashMap Nat FpExpr.PackedBitVec)) (maxConjunctions: Nat)
                                                : GeneralizerStateM ParsedFpExpr GenFpLogicalExpr (Option GenFpLogicalExpr) := do
  let state ← get
  let parsedFpLogicalExpr := state.parsedLogicalExpr

  let positiveExamples := constantAssignments.map (fun assignment => assignment.filter (fun key _ => parsedFpLogicalExpr.lhs.symVars.contains key))

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


instance :  HydrableCheckForPreconditions ParsedFpExpr GenFpLogicalExpr GenFpExpr where
 checkForPreconditions := checkForPreconditions

def prettifyFpBinOp (op: FpBinOp) : String :=
  match op with
  | .and => "&&&"
  | .or => "|||"
  | .xor => "^^^"
  | _ => op.toString

def prettifyFpBinPred (op : FpBinPred) : String :=
  match op with
  | .eq => "="
  | _ => op.toString

def prettifyFpExpr (bvExpr : GenFpExpr w) (displayNames: Std.HashMap Nat Name) : String :=
    match bvExpr with
    | .var idx => displayNames[idx]!.toString
    | .const bv =>
       toString bv.toInt
    | .bin lhs FpBinOp.add (.bin  (GenFpExpr.const bv) FpBinOp.add (GenFpExpr.un FpUnOp.not rhs)) =>
      if bv.toInt == 1 then -- A subtraction
        s! "({prettifyFpExpr lhs displayNames} - {prettifyFpExpr rhs displayNames})"
      else
        s! "({prettifyFpExpr lhs displayNames} + ({prettifyFpExpr (GenFpExpr.const bv) displayNames} + {prettifyFpExpr (GenFpExpr.un FpUnOp.not rhs) displayNames}))"
    | .bin lhs op rhs =>
       s! "({prettifyFpExpr lhs displayNames} {prettifyFpBinOp op} {prettifyFpExpr rhs displayNames})"
    | .un op operand =>
       s! "({op.toString} {prettifyFpExpr operand displayNames})"
    | .shiftLeft lhs rhs =>
        s! "({prettifyFpExpr lhs displayNames} <<< {prettifyFpExpr rhs displayNames})"
    | .shiftRight lhs rhs =>
        s! "({prettifyFpExpr lhs displayNames} >>> {prettifyFpExpr rhs displayNames})"
    | .arithShiftRight lhs rhs =>
        s! "({prettifyFpExpr lhs displayNames} >>>a {prettifyFpExpr rhs displayNames})"
    | .signExtend v expr => s! "BitVec.signExtend {v} {prettifyFpExpr expr displayNames}"
    | .zeroExtend v expr => s! "BitVec.zeroExtend {v} {prettifyFpExpr expr displayNames}"
    | .truncate v expr =>   s! "BitVec.truncate {v} {prettifyFpExpr expr displayNames}"
    | _ => bvExpr.toString

def isGteZeroCheck (expr : GenFpLogicalExpr) : Bool :=
  match expr with
  | .literal (GenFpPred.bin _ FpBinPred.ult (GenFpExpr.shiftLeft (GenFpExpr.const bv) (GenFpExpr.bin (GenFpExpr.var _) FpBinOp.add (GenFpExpr.bin (GenFpExpr.const bv') FpBinOp.add (GenFpExpr.un FpUnOp.not (GenFpExpr.const bv'')))))) =>
          bv.toInt == 1 && bv'.toInt == 1 && bv''.toInt == 1
  | _ => false

def prettifyComparison (bvLogicalExpr : GenFpLogicalExpr) (displayNames: Std.HashMap Nat Name)  : Option String := Id.run do
  let mut res : Option String := none
  match bvLogicalExpr with
  | .literal (GenFpPred.bin lhs FpBinPred.ult _) =>
    if isGteZeroCheck bvLogicalExpr then
      res := some s! "{prettifyFpExpr lhs displayNames} >= 0"
  | .gate Gate.and (BoolExpr.literal (GenFpPred.bin (GenFpExpr.const bv) FpBinPred.ult expr)) rhs =>
    if bv.toInt == 0 && isGteZeroCheck rhs then
      res := some s! "{prettifyFpExpr expr displayNames} > 0"
  | .not expr  =>
     if isGteZeroCheck expr then
      match expr with
      |  .literal (GenFpPred.bin lhs _ _) => res := some s! "{prettifyFpExpr lhs displayNames} < 0"
      | _ => return none
  | _ => return none

  res


def prettify (generalization: GenFpLogicalExpr) (displayNames: Std.HashMap Nat Name) : String :=
  match (prettifyComparison generalization displayNames) with
  | some s => s
  | none =>
      match generalization with
      | .literal (GenFpPred.bin lhs op rhs) =>
          s! "{prettifyFpExpr lhs displayNames} {prettifyFpBinPred op} {prettifyFpExpr rhs displayNames}"
      | .not boolExpr =>
          s! "!({prettify boolExpr displayNames})"
      | .gate op lhs rhs =>
          s! "({prettify lhs displayNames}) {op.toString} ({prettify rhs displayNames})"
      | .ite cond positive _ =>
          s! "if {prettify cond displayNames} then {prettify positive displayNames} "
      | _ => generalization.toString


instance : HydrablePrettify GenFpLogicalExpr where
  prettify := prettify

def prettifyAsTheorem (name: Name) (generalization: GenFpLogicalExpr) (displayNames: Std.HashMap Nat Name) : String := Id.run do
  let params := displayNames.values.filter (λ n => n.toString != "w")

  let mut res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " (params.map (λ p => p.toString))} : BitVec w)"

  match generalization with
  | .ite cond positive _ => res := res ++ s! " (h: {prettify cond displayNames}) : {prettify positive displayNames}"
  | _ => res := res ++ s! " : {prettify generalization displayNames}"

  res := res ++ s! " := by sorry"
  pure res

instance : HydrablePrettifyAsTheorem GenFpLogicalExpr where
  prettifyAsTheorem := prettifyAsTheorem

abbrev FpGeneralizerState := GeneralizerState ParsedFpExpr GenFpLogicalExpr
def initialGeneralizerState (startTime timeout widthId targetWidth: Nat) (parsedLogicalExpr : ParsedFpLogicalExpr)
            : FpGeneralizerState := { startTime := startTime
                                    , widthId := widthId
                                    , timeout := timeout
                                    , processingWidth           := targetWidth
                                    , targetWidth               := targetWidth
                                    , parsedLogicalExpr       := parsedLogicalExpr
                                    , needsPreconditionsExprs   := []
                                    , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                                    }

instance : HydrableInitializeGeneralizerState ParsedFpExpr GenFpLogicalExpr GenFpExpr where
  initializeGeneralizerState := initialGeneralizerState

instance : HydrableGeneralize ParsedFpExpr GenFpLogicalExpr GenFpExpr where
instance bvHydrableParseAndGeneralize : HydrableParseAndGeneralize ParsedFpExpr GenFpLogicalExpr GenFpExpr where

/-- TODO: Rename this to #generalize_bv, or create a global registry via attributes of names to generalizers. -/
elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  generalizeCommand (H := bvHydrableParseAndGeneralize) expr

syntax (name := bvGeneralize) "bv_generalize" : tactic

open Lean Meta Elab Tactic in
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic
  | `(tactic| bv_generalize) => do
      generalizeTactic (H := bvHydrableParseAndGeneralize) (← getMainTarget)
  | _ => Lean.Elab.throwUnsupportedSyntax

-- TODO: move these into a separate file.

-- variable {x y z : BitVec 1}
-- #generalize BitVec.zeroExtend 64 (BitVec.zeroExtend 32 x ^^^ 1#32) = BitVec.zeroExtend 64 (x ^^^ 1#1) --#fold_xor_zext_sandwich_thm; Need to think about how to use special constants with the same width as the variables during precondition synthesis

-- -- variable {x y z : BitVec 8}
-- -- #generalize x + 0 = 0 --  TODO: This crashes because bv_normalize removes the symbolic variable from the expression when attempting to find counterexamples, and we only get counterexamples for the input variable, which is not ideal since we expect counterexamples for the symbolic constants if they exist.
-- -- #generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y

-- variable {x y z: BitVec 32}
-- #generalize BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32

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
