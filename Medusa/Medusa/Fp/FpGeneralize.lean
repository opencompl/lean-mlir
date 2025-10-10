import Lean
import Lean.Elab.Term

import Medusa.Generalize
import Medusa.Fp.Basic
import Medusa.Fp.Reflect

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide


namespace Generalize
set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000
set_option linter.unusedVariables false


namespace Fp

instance : HydrableInstances FpPredicate where

instance : HydrableGetInputWidth where
  getWidth := Fp.getWidth

instance : HydrableGetGenPredSize FpPredicate where
  getGenPredSize e := e.size

instance : HydrableGenPredToExpr ParsedFpExpr FpPredicate where
  genPredToExpr := toExpr

instance :
      HydrableSolve ParsedFpExpr FpPredicate FpExpr where

instance : HydrableChangePredWidth FpPredicate where
  changePredWidth := changeFpPredWidth

instance : HydrableParseExprs ParsedFpExpr FpPredicate where
  parseExprs := parseExprs

instance : HydrableSubstitute FpPredicate FpExpr where
  substitute := substitute

instance : HydrablePackedBitvecToSubstitutionValue FpPredicate FpExpr where
  packedBitVecToSubstitutionValue := packedBitVecToFpSubstitutionValue

-- TODO: Can this just be reused for everyone? Seems like we use the BoolExpr?
instance : HydrableBooleanAlgebra FpPredicate FpExpr where
  eq e1 e2 := BoolExpr.literal (FpPredicate.bin e1 .eq e2)

instance : HydrableGetIdentityAndAbsorptionConstraints FpPredicate where
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints

instance : HydrableGenExpr FpExpr where
  genExprVar id := FpExpr.var id
  -- TODO: this is kinda scuffed, because my width does not align with 'w'.
  genExprConst bv := FpExpr.const <| bv.setWidth _

instance : HydrableExistsForall ParsedFpExpr FpPredicate FpExpr where

instance : HydrableInitialParserState where
  initialParserState := defaultParsedExprState

instance :  HydrableCheckTimeout FpPredicate where

def shrinkParsedFpExpr (expr : ParsedFpExpr) (targetWidth : Nat) : MetaM ParsedFpExpr := do
  let bvExpr ← shrinkFpExpr expr.bvExpr targetWidth
  return {expr with bvExpr := bvExpr, width := targetWidth}
  where
    shrinkFpExpr {w} (bvExpr : FpExpr w) (result: Nat) : MetaM (FpExpr result) := do
      match bvExpr with
      | .var idx => return FpExpr.var idx
      | .const val => return FpExpr.const (val.setWidth _)
      -- | TODO: do I need to call shrink?
      | .bin lhs op rhs => return FpExpr.bin (← shrinkFpExpr lhs result) op (← shrinkFpExpr rhs result)

-- TODO: can this be general in Hydrable?
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

    let bvLogicalExpr := BoolExpr.literal (FpPredicate.bin lhs.bvExpr .eq rhsExpr)

    let shrinkedState := {origExpr.state with displayNameToVariable := displayNameToShrinkedVar, symVarIdToVariable := symVarIdToShrinkedVar, inputVarIdToVariable := inputVarIdToShrinkedVar}
    return {origExpr with lhs := lhs, rhs := rhs, logicalExpr := bvLogicalExpr, state := shrinkedState}
  throwError m! "Expected lhsWidth:{lhs.width} and rhsWidth:{rhs.width} to equal targetWidth:{targetWidth}"

instance : HydrableReduceWidth ParsedFpExpr FpPredicate FpExpr where
  shrink := shrink


-- | TODO: this can be done in general for any Hydrable?
def pruneEquivalentFpExprs (expressions: List (FpExpr w)) : GeneralizerStateM ParsedFpExpr FpPredicate  (List (FpExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (FpExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (FpPredicate.bin f .eq expr)))
      let subsumeCheckExpr :=  bigAnd newConstraints

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    trace[Generalize] m! "Removed {expressions.length - pruned.length} expressions after pruning {expressions.length} expressions"

    pure pruned

-- TODO: Can this be done in general for any Hydrable?
def pruneEquivalentFpLogicalExprs(expressions : List FpPredicate): GeneralizerStateM ParsedFpExpr FpPredicate (List FpPredicate) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List FpPredicate:= []
    -- TODO: isn't this just 'break'?
    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue
      let newConstraints := pruned.map (fun f =>
          -- | TODO: is this what I want? Don't I want instead to add
          -- that they are LOGICALLY equivalent?
          BoolExpr.not (BoolExpr.gate Gate.beq (BoolExpr.literal f) (BoolExpr.literal expr)))
      let subsumeCheckExpr :=  bigAnd newConstraints

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"
    pure pruned

-- | TODO: can this be done in general?
def updateConstantValues (bvExpr: ParsedFpExpr) (assignments: Std.HashMap Nat FpExprWrapper)
             : ParsedFpExpr := bvExpr
  -- {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}

-- TODO: can this be done in general?
def wrap (bvExpr : FpExpr w) : FpExprWrapper := { bvExpr := bvExpr, width := w}

def filterCandidatePredicates  (bvLogicalExpr: FpPredicate) (preconditionCandidates visited: Std.HashSet FpPredicate)
                                                    : GeneralizerStateM ParsedFpExpr FpPredicate (List FpPredicate) :=
  return []
/-
  withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let mut res : List FpPredicate := []
    -- let mut currentCandidates := preconditionCandidates
    -- if numConjunctions >= 1 then
    --   let combinations := generateCombinations numConjunctions currentCandidates.toList
    --   currentCandidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))
    -- | What is this constraint doing?
    let widthConstraint : FpPredicate := BoolExpr.literal (FpPredicate.bin (FpExpr.var widthId) .eq (FpExpr.const (BitVec.ofNat bitwidth bitwidth)))

    let mut numInvocations := 0
    let mut currentCandidates := preconditionCandidates.filter (λ cand => !visited.contains cand)
    logInfo m! "Originally processing {currentCandidates.size} candidates"

    -- Progressive filtering implementation
    while !currentCandidates.isEmpty do
      let expressionsConstraints : FpPredicate := addConstraints (BoolExpr.const False) currentCandidates.toList Gate.or
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint] Gate.and) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet FpPredicate := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet FpPredicate := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, wrap (FpExpr.const (BitVec.ofNat bitwidth bitwidth)))]))
              if !(evalFpLogicalExpr assignment widthSubstitutedCandidate) then
                res := res.insert candidate
            pure res

      currentCandidates := newCandidates

    logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidates.size} potential candidates."
    res := currentCandidates.toList
    pure res
-/

structure PreconditionSynthesisCacheValue where
  positiveExampleValues : List FpExprWrapper
  negativeExampleValues : List FpExprWrapper

instance : ToString PreconditionSynthesisCacheValue where
  toString val :=
    s! "⟨positiveExampleValues := {val.positiveExampleValues}, negativeExampleValues := {val.negativeExampleValues}⟩"

def getPreconditionSynthesisComponents (positiveExamples negativeExamples: List (Std.HashMap Nat FpExprWrapper)) (specialConstants : Std.HashMap (FpExpr w) FpExprWrapper) :
                  Std.HashMap (FpExpr w)  PreconditionSynthesisCacheValue := Id.run do
    let groupExamplesBySymVar (examples : List (Std.HashMap Nat FpExprWrapper)) : Std.HashMap (FpExpr w) (List FpExprWrapper) := Id.run do
      let mut res : Std.HashMap (FpExpr w) (List FpExprWrapper) := Std.HashMap.emptyWithCapacity
      for ex in examples do
        for (const, val) in ex.toArray do
          let constVar : FpExpr w := FpExpr.var const
          let existingList := res.getD constVar []
          res := res.insert constVar (val::existingList)
      res

    let positiveExamplesByKey := groupExamplesBySymVar positiveExamples
    let negativeExamplesByKey := groupExamplesBySymVar negativeExamples

    let mut allInputs : Std.HashMap (FpExpr w)  PreconditionSynthesisCacheValue := Std.HashMap.emptyWithCapacity
    for key in positiveExamplesByKey.keys do
      allInputs := allInputs.insert key {positiveExampleValues := positiveExamplesByKey[key]!, negativeExampleValues := negativeExamplesByKey[key]!}

    for (sc, val) in specialConstants.toArray do
      allInputs := allInputs.insert sc {positiveExampleValues := List.replicate positiveExamples.length val, negativeExampleValues := List.replicate negativeExamples.length val}

    return allInputs

set_option warn.sorry false in
def precondSynthesisUpdateCache (previousLevelCache synthesisComponents: Std.HashMap (FpExpr w)  PreconditionSynthesisCacheValue)
      (positiveExamples negativeExamples: List (Std.HashMap Nat FpExprWrapper)) (specialConstants : Std.HashMap (FpExpr w) FpExprWrapper)
      (ops : List (FpExpr w → FpExpr w → FpExpr w)) : GeneralizerStateM ParsedFpExpr FpPredicate (Std.HashMap (FpExpr w) PreconditionSynthesisCacheValue) := do
  return {}

/-
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (FpExprWrapper × FpExprWrapper)) (examples: List (Std.HashMap Nat FpExprWrapper))
            (op : FpExpr w → FpExpr w → FpExpr w) : GeneralizerStateM ParsedFpExpr FpPredicate  (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalFpExpr examples[index]! (op  (FpExpr.const (h.left ▸ lhs.bv)) (FpExpr.const (h.right ▸ rhs.bv)))) :: res
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
-/

def generatePreconditions
    (bvLogicalExpr: FpPredicate) (positiveExamples negativeExamples: List (Std.HashMap Nat FpExprWrapper))
    (_numConjunctions: Nat) : GeneralizerStateM ParsedFpExpr FpPredicate (Option FpPredicate) := do
    return none
/-
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let specialConstants : Std.HashMap (FpExpr bitwidth) FpExprWrapper := Std.HashMap.ofList [
        ((one bitwidth), {bv := BitVec.ofNat bitwidth 1}),
        ((minusOne bitwidth), {bv := BitVec.ofInt bitwidth (-1)}),
        (FpExpr.var widthId, {bv := BitVec.ofNat bitwidth bitwidth})]

    let validCandidates ← withTraceNode `Generalize (fun _ => return "Attempted to generate valid preconditions") do
      let mut preconditionCandidates : Std.HashSet FpPredicate := Std.HashSet.emptyWithCapacity
      let synthesisComponents : Std.HashMap (FpExpr bitwidth)  PreconditionSynthesisCacheValue := getPreconditionSynthesisComponents positiveExamples negativeExamples specialConstants

      -- Check for power of 2: const & (const - 1) == 0
      for const in positiveExamples[0]!.keys do
        let bvExprVar := FpExpr.var const
        let powerOf2Expr :=  FpExpr.bin bvExprVar FpBinOp.and (FpExpr.bin bvExprVar FpBinOp.add (minusOne bitwidth))
        let powerOfTwoResults := positiveExamples.map (λ pos => evalFpExpr pos powerOf2Expr)

        if powerOfTwoResults.any (λ val => val == 0) then
          let powerOf2 := BoolExpr.literal (GenFpPred.bin powerOf2Expr FpBinPred.eq (zero bitwidth))
          preconditionCandidates := preconditionCandidates.insert powerOf2

      let mut previousLevelCache : Std.HashMap (FpExpr bitwidth) PreconditionSynthesisCacheValue := synthesisComponents

      let numVariables := positiveExamples[0]!.keys.length + 1 -- Add 1 for the width ID
      let ops : List (FpExpr bitwidth -> FpExpr bitwidth -> FpExpr bitwidth):= [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

      let mut currentLevel := 0
      let mut validCandidates : List FpPredicate := []
      let mut visited : Std.HashSet FpPredicate := Std.HashSet.emptyWithCapacity

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
-/

-- TODO: move into KitchenSink.
-- TODO: why are we even using lists?
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

-- TODO: move into KitchenSink.
-- TODO: why are we even using lists?
def List.product (l₁ : List α) (l₂ : List β) : List (α × β) := l₁.flatMap fun a => l₂.map (Prod.mk a)

abbrev ExpressionSynthesisResult := Std.HashMap Nat (List FpExprWrapper)
set_option warn.sorry false in
def lhsSketchEnumeration  (lhsSketch: FpExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat FpExprWrapper) : ExpressionSynthesisResult := Id.run do
  return {}
/-
  let zero := wrap (FpExpr.const (BitVec.ofNat w 0))
  let one := wrap (FpExpr.const (BitVec.ofNat w 1 ))
  let minusOne := wrap (FpExpr.const (BitVec.ofInt w (-1)))

  -- Special constants representing each input variable
  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsFpExprs : List (FpExprWrapper):= lhsSymVars.toList.map (λ (id, pbv) => {bvExpr := FpExpr.var id, width := pbv.w})
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
-/


set_option warn.sorry false in
def pruneConstantExprsSynthesisResults(exprSynthesisResults : ExpressionSynthesisResult)
                            : GeneralizerStateM ParsedFpExpr FpPredicate ExpressionSynthesisResult := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let state ← get
          let mut tempResults : Std.HashMap Nat (List (FpExprWrapper)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let width := state.parsedLogicalExpr.state.symVarIdToVariable[var]!.width
              let mut bvExprs : List (FpExpr width) := []

              for expr in expressions do
                let h : width = expr.width := sorry
                bvExprs := h ▸ expr.bvExpr :: bvExprs

              let mut prunedExprs ← pruneEquivalentFpExprs bvExprs.reverse -- lets us process in roughly increasing order
              tempResults := tempResults.insert var (prunedExprs.map (λ expr => wrap expr))

          pure tempResults

instance :  HydrableGetNegativeExamples ParsedFpExpr FpPredicate FpExpr where

def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (FpExprWrapper)))
                                            : GeneralizerStateM ParsedFpExpr FpPredicate (Option FpPredicate) := do
  return none
/-
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
-/

abbrev EnumerativeSearchCache :=  Std.HashMap FpExprWrapper FpExprWrapper
set_option warn.sorry false in
private def constantExprsEnumerationFromCache
    (previousLevelCache allLhsVars : EnumerativeSearchCache)
    (lhsSymVars rhsSymVars : Std.HashMap Nat FpExprWrapper)
    (ops: List (FpExpr w → FpExpr w → FpExpr w))
    : GeneralizerStateM ParsedFpExpr FpPredicate (ExpressionSynthesisResult × EnumerativeSearchCache) := do
  return ({}, {})
/-
    let zero := BitVec.ofNat w 0
    let one := BitVec.ofNat w 1
    let minusOne := BitVec.ofInt w (-1)

    -- TODO: create this cache automatically:?
    let specialConstants : Std.HashMap (FpExpr w) FpExprWrapper := Std.HashMap.ofList [
      (FpExpr.const one, {bv := one}),
      (FpExpr.const minusOne, {bv := minusOne})
    ]

    let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
    for (var, value) in rhsSymVars.toArray do
      let h : value.w = w := sorry
      rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

    let mut currentCache := Std.HashMap.emptyWithCapacity

    let mut res : Std.HashMap Nat (List FpExprWrapper) := Std.HashMap.emptyWithCapacity
    for (wrappedBvExpr, packedFp) in previousLevelCache.toArray do
      let packedFpExpr : FpExpr packedFp.w := FpExpr.const packedFp.bv

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
              currentCache := currentCache.insert newExpr {bv := evaluatedRes : FpExprWrapper}

    pure (res, currentCache)
-/

set_option warn.sorry false in
partial def deductiveSearch (expr: FpExpr w) (constants: Std.HashMap Nat FpExprWrapper)
      (target: FpExprWrapper) (depth: Nat) (parent: Nat) : TermElabM (List (FpExpr target.width)) := do
  return []
/-
    let updatePackedFpWidth (orig : FpExprWrapper) (newWidth: Nat) : FpExprWrapper :=
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
            let mut res : List (FpExpr target.w) := []

            for (constId, constVal) in constants.toArray do
              let newVar : FpExpr target.w := FpExpr.var constId

              if constVal == target then
                res := newVar :: res
                continue

              if constId == parent then -- Avoid runaway expressions
                continue

              if target.bv == 0 then
                res := FpExpr.const 0 :: res

              let newConstVal := (updatePackedFpWidth constVal target.w)
              let h : newConstVal.w = target.w := sorry

              let constBv := h ▸ newConstVal.bv
              -- ~C = T
              if BitVec.not constBv == target.bv then
                res := FpExpr.un FpUnOp.not newVar :: res

              -- C + X = Target; New target = Target - X.
              let addRes ← deductiveSearch expr constants {bv := target.bv - constBv} (depth-1) constId
              res := res ++ addRes.map (λ resExpr => FpExpr.bin newVar FpBinOp.add resExpr)

              -- C - X = Target
              let subRes ← deductiveSearch expr constants {bv := constBv - target.bv} (depth-1) constId
              res := res ++ subRes.map (λ resExpr => FpExpr.bin newVar FpBinOp.add (negate resExpr))

              -- X - C = Target
              let subRes' ← deductiveSearch expr constants {bv := target.bv + constBv}  (depth-1) constId
              res := res ++ subRes'.map (λ resExpr => FpExpr.bin (resExpr) FpBinOp.add (negate newVar))

              -- X * C = Target
              if (BitVec.srem target.bv constBv) == 0 && (BitVec.sdiv target.bv constBv != 0) then
                let mulRes ← deductiveSearch expr constants {bv := BitVec.sdiv target.bv constBv} (depth - 1) constId
                res := res ++ mulRes.map (λ resExpr => FpExpr.bin newVar FpBinOp.mul resExpr)

              -- C / X = Target
              if target.bv != 0 && (BitVec.umod constBv target.bv) == 0 then
                let divRes ← deductiveSearch expr constants {bv := BitVec.udiv constBv target.bv} (depth - 1) constId
                res := res ++ divRes.map (λ resExpr => FpExpr.bin newVar FpBinOp.udiv resExpr)

            return res
-/

set_option warn.sorry false in
def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec))
              : GeneralizerStateM ParsedFpExpr FpPredicate (Option <| BoolExpr FpPredicate) :=  do
  return none
/-
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

        let specialConstants : Std.HashMap FpExprWrapper FpExprWrapper := Std.HashMap.ofList [
          ((wrap (one processingWidth)), {bv := BitVec.ofNat processingWidth 1}),
          ((wrap (minusOne processingWidth)), {bv :=  BitVec.ofInt processingWidth (-1)})
        ]

        let mut allLHSVars := specialConstants
        for (var, value) in lhsAssignments.toArray do
          allLHSVars := allLHSVars.insert (wrap (FpExpr.var (w := processingWidth) var)) value
          allLHSVars := allLHSVars.insert (wrap (FpExpr.un (w := processingWidth) FpUnOp.not ((FpExpr.var var)))) {bv := BitVec.not (value.bv)}

        let ops : List (FpExpr processingWidth → (FpExpr processingWidth) → (FpExpr processingWidth)) := [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

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
-/
-- | TODO: this should not take a BVExpr.PackedBitVec, but rather a FpExprWrapper or something similar.
instance :  HydrableSynthesizeWithNoPrecondition ParsedFpExpr FpPredicate FpExpr where
 synthesizeWithNoPrecondition := synthesizeWithNoPrecondition

-- | TODO: this should not take a BVExpr.PackedBitVec, but rather a FpExprWrapper or something similar.
def checkForPreconditions (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) (maxConjunctions: Nat)
  : GeneralizerStateM ParsedFpExpr FpPredicate (Option <| BoolExpr FpPredicate) := do
  return none
/-
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
-/

instance :  HydrableCheckForPreconditions ParsedFpExpr FpPredicate FpExpr where
 checkForPreconditions := checkForPreconditions



instance : HydrablePrettify FpPredicate where
  prettify expr _ := toString expr

-- | TODO: can this be generated by adding a constant to the environment and then printing the constant, instead of manually string-printing?
-- How does 'extract_goals' do it?
private def prettifyAsTheorem (name: Name) (generalization : BoolExpr FpPredicate) (displayNames: Std.HashMap Nat Name) : String := Id.run do
  let params := displayNames.values.filter (λ n => n.toString != "w")

  let res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " (params.map (λ p => p.toString))} : BitVec w)"
  let res := res ++ s! " : {HydrablePrettify.prettify generalization displayNames}"
  let res := res ++ s! " := by sorry"
  pure res

instance : HydrablePrettifyAsTheorem FpPredicate where
  prettifyAsTheorem := prettifyAsTheorem

abbrev FpGeneralizerState := GeneralizerState ParsedFpExpr FpPredicate
private def initialGeneralizerState (startTime timeout widthId targetWidth: Nat) (parsedLogicalExpr : ParsedFpLogicalExpr)
            : FpGeneralizerState := { startTime := startTime
                                    , widthId := widthId
                                    , timeout := timeout
                                    , processingWidth           := targetWidth
                                    , targetWidth               := targetWidth
                                    , parsedLogicalExpr       := parsedLogicalExpr
                                    , needsPreconditionsExprs   := []
                                    , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                                    }

instance : HydrableInitializeGeneralizerState ParsedFpExpr FpPredicate FpExpr where
  initializeGeneralizerState := initialGeneralizerState

instance : HydrableGeneralize ParsedFpExpr FpPredicate FpExpr where
instance fpHydrableParseAndGeneralize : HydrableParseAndGeneralize ParsedFpExpr FpPredicate FpExpr where

/-- TODO: Rename this to #generalize_bv, or create a global registry via attributes of names to generalizers. -/
elab "#fpgeneralize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  generalizeCommand (H := fpHydrableParseAndGeneralize) expr

syntax (name := fpGeneralize) "fp_generalize" : tactic

open Lean Meta Elab Tactic in
@[tactic fpGeneralize]
def evalFpGeneralize : Tactic
  | `(tactic| fp_generalize) => do
      withMainContext do
        generalizeTactic (H := fpHydrableParseAndGeneralize) (← getMainTarget)
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

#guard_msgs in
theorem demo (x y : BitVec 8) : (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y := by
  -- fp_generalize
  sorry


#guard_msgs in
theorem demo2 (x y : BitVec 8) :  (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) := by
  -- fp_generalize
  sorry

end Examples
