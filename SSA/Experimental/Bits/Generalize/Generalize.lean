import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util
import SSA.Experimental.Bits.Generalize.Basic
import SSA.Experimental.Bits.Generalize.Reflect

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

namespace Generalize

structure GeneralizerState where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedBVLogicalExpr : ParsedBVLogicalExpr
  needsPreconditionsExprs : List GenBVLogicalExpr
  visitedSubstitutions : Std.HashSet GenBVLogicalExpr
  constantExprsEnumerationCache : Std.HashMap (GenBVExpr processingWidth) BVExpr.PackedBitVec

abbrev GeneralizerStateM := StateRefT GeneralizerState TermElabM

def GeneralizerStateM.liftTermElabM (m : TermElabM α) : GeneralizerStateM α := do
  let v ← m
  return v

def bvExprToExpr (bvExpr : GenBVExpr w) : GeneralizerStateM Expr := do
  let parsedBVExprState := (← get).parsedBVLogicalExpr.state
  let allNames := Std.HashMap.union parsedBVExprState.inputVarIdToDisplayName parsedBVExprState.symVarToDisplayName

  let bitVecWidth := (mkNatLit w)
  match bvExpr with
  | .var idx => let localDecl ← getLocalDeclFromUserName allNames[idx]!
                pure (mkFVar localDecl.fvarId)
  | .const val => mkAppM ``BitVec.ofInt #[bitVecWidth,  (mkIntLit val.toInt)]
  | .bin lhs op rhs  => match op with
                        | .and => mkAppM ``BitVec.and #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .or => mkAppM ``BitVec.or #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .xor => mkAppM ``BitVec.xor #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .add => mkAppM ``HAdd.hAdd #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .mul => mkAppM ``BitVec.mul #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .udiv => mkAppM ``BitVec.udiv #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
                        | .umod => mkAppM ``BitVec.umod #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .un op expr => match op with
                   | .not => mkAppM ``BitVec.not #[← bvExprToExpr expr]
                   | .rotateLeft n => mkAppM ``BitVec.rotateLeft #[← bvExprToExpr expr, mkNatLit n]
                   | .rotateRight n => mkAppM ``BitVec.rotateRight #[← bvExprToExpr expr, mkNatLit n]
                   | .arithShiftRightConst n => mkAppM ``BitVec.sshiftRight #[← bvExprToExpr expr, mkNatLit n]
                   | .reverse => mkAppM ``BitVec.reverse #[← bvExprToExpr expr]
                   | .clz => mkAppM ``BitVec.clz #[← bvExprToExpr expr]
  | .append lhs rhs _ => mkAppM ``BitVec.append #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .replicate n expr _ => mkAppM ``BitVec.replicate #[mkNatLit n, ← bvExprToExpr expr]
  | .shiftLeft lhs rhs => mkAppM ``HShiftLeft.hShiftLeft #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .shiftRight lhs rhs => mkAppM ``HShiftRight.hShiftRight #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .arithShiftRight lhs rhs => mkAppM ``BitVec.sshiftRight' #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .zeroExtend v expr => mkAppM ``BitVec.zeroExtend #[bitVecWidth, ← bvExprToExpr expr]
  | .truncate v expr => mkAppM ``BitVec.truncate #[bitVecWidth, ← bvExprToExpr expr]
  | .extract _ _ _ => throwError m! "Extract operation is not supported."

def toExpr (bvLogicalExpr: GenBVLogicalExpr) : GeneralizerStateM Expr := do
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) =>
      match op with
      -- | .eq => mkEq (← bvExprToExpr lhs) (← bvExprToExpr rhs)
      | .eq => mkAppM ``BEq.beq #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
      | .ult => mkAppM ``BitVec.ult #[← bvExprToExpr lhs, ← bvExprToExpr rhs]
  | .const b =>
      match b with
      | true => pure (mkConst ``Bool.true)
      | _ => pure (mkConst ``Bool.false)
  | .not boolExpr => mkAppM ``Bool.not #[← toExpr boolExpr]
  | .gate gate lhs rhs =>
        match gate with
        | .or => mkAppM ``Bool.or #[← toExpr lhs, ← toExpr rhs]
        | .xor => mkAppM ``Bool.xor #[← toExpr lhs, ← toExpr rhs]
        | .and => mkAppM ``Bool.and #[← toExpr lhs, ← toExpr rhs]
        | .beq => mkAppM ``BEq.beq #[← toExpr lhs, ← toExpr rhs]
  | _ => throwError m! "Unsupported operation"

def toBVExpr' (bvExpr : GenBVExpr w) : GeneralizerStateM (BVExpr w) := do
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

set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

def bvDecide' (g : MVarId) (ctx : TacticContext) : MetaM (Except CounterExample Result) := do
  match ← bvUnsat g ctx with
  | .ok lratCert => return .ok ⟨some lratCert⟩
  | .error counterExample => return .error counterExample

def reconstructAssignment' (var2Cnf : Std.HashMap BVBit Nat) (assignment : Array (Bool × Nat))
    (aigSize : Nat)  :
    Std.HashMap Nat BVExpr.PackedBitVec := Id.run do
  let mut sparseMap : Std.HashMap Nat (RBMap Nat Bool Ord.compare) := {}

  for (bitVar, cnfVar) in var2Cnf.toArray do
    /-
    The setup of the variables in CNF is as follows:
    1. One auxiliary variable for each node in the AIG
    2. The actual BitVec bitwise variables
    Hence we access the assignment array offset by the AIG size to obtain the value for a BitVec bit.
    We assume that a variable can be found at its index as CaDiCal prints them in order.

    Note that cadical will report an assignment for all literals up to the maximum literal from the
    CNF. So even if variable or AIG bits below the maximum literal did not occur in the CNF they
    will still occur in the assignment that cadical reports.

    There is one crucial thing to consider in addition: If the highest literal that ended up in the
    CNF does not represent the highest variable bit not all variable bits show up in the assignment.
    For this situation we do the same as cadical for literals that did not show up in the CNF:
    set them to true.
    -/
    let idx := cnfVar + aigSize
    let varSet := if h : idx < assignment.size then assignment[idx].fst else true
    let mut bitMap := sparseMap.getD bitVar.var {}
    bitMap := bitMap.insert bitVar.idx varSet
    sparseMap := sparseMap.insert bitVar.var bitMap

  let mut finalMap := Std.HashMap.emptyWithCapacity
  for (bitVecVar, bitMap) in sparseMap.toArray do
    let mut value : Nat := 0
    let mut currentBit := 0
    for (bitIdx, bitValue) in bitMap.toList do
      assert! bitIdx == currentBit
      if bitValue then
        value := value ||| (1 <<< currentBit)
      currentBit := currentBit + 1
    finalMap := finalMap.insert bitVecVar ⟨BitVec.ofNat currentBit value⟩
  return finalMap

def solve' (genBvExpr: GenBVLogicalExpr) : GeneralizerStateM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let bvExpr ← withTraceNode `Generalize (fun _ => return "Converted GenBVLogicalExpr to BVLogicalExpr") do
                    toBVLogicalExpr genBvExpr
                    
    let cadicalTimeoutSec : Nat := 500
    let cfg: BVDecideConfig := {timeout := 500}

    IO.FS.withTempFile fun _ lratFile => do
      let ctx ← BVDecide.Frontend.TacticContext.new lratFile cfg
      let entry ← IO.lazyPure (fun _ => bvExpr.bitblast)

      let (cnf, map) ← IO.lazyPure (fun _ =>
            let (entry, map) := entry.relabelNat'
            let cnf := AIG.toCNF entry
            (cnf, map))

      let res ← runExternal cnf ctx.solver ctx.lratPath
          (trimProofs := true)
          (timeout := cadicalTimeoutSec)
          (binaryProofs := true)

      match res with
      | .ok proof =>
        withTraceNode `Generalize (fun _ => return "Verified proof") do
            let valid := BVDecide.Reflect.verifyBVExpr bvExpr proof
            if !valid then
                throwError m! "Received invalid proof from SAT"
            pure ()
        return none
      | .error assignment =>
        let equations := reconstructAssignment' map assignment entry.aig.decls.size
        return .some equations


def solve (bvExpr : GenBVLogicalExpr) : GeneralizerStateM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let state ← get
    let parsedBVExprState := state.parsedBVLogicalExpr.state

    let allNames := Std.HashMap.union parsedBVExprState.inputVarIdToDisplayName parsedBVExprState.symVarToDisplayName

    let bitVecWidth := (mkNatLit state.processingWidth)
    let bitVecType :=  mkApp (mkConst ``BitVec) bitVecWidth

    let nameTypeCombo : List (Name × Expr) := allNames.values.map (λ n => (n, bitVecType))

    let res ←
      withLocalDeclsDND nameTypeCombo.toArray fun _ => do
        let mVar ← withTraceNode `Generalize (fun _ => return "Converted bvExpr to expr") do
          let mut expr ← toExpr bvExpr
          Lean.Meta.check expr

          expr ← mkEq expr (mkConst ``Bool.false) -- We do this because bv_decide negates the original expression, and we counter that here
          Lean.Meta.check expr
        -- logInfo m! "Generated Lean Expr: {← ppExpr expr} from {bvExpr}"

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

def addConstraints (expr: GenBVLogicalExpr) (constraints: List GenBVLogicalExpr) (op: Gate := Gate.and) : GenBVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          match expr with
          | BoolExpr.const _ => addConstraints x xs op
          | _ => addConstraints (BoolExpr.gate op expr x) xs op

def getIdentityAndAbsorptionConstraints (bvLogicalExpr: GenBVLogicalExpr) (symVars : Std.HashSet Nat) : List GenBVLogicalExpr :=
      match bvLogicalExpr with
      | .literal (GenBVPred.bin lhs _ rhs) => (getBVExprConstraints lhs) ++ (getBVExprConstraints rhs)
      | .not boolExpr => getIdentityAndAbsorptionConstraints boolExpr symVars
      | .gate _ lhs rhs => (getIdentityAndAbsorptionConstraints lhs symVars) ++ (getIdentityAndAbsorptionConstraints rhs symVars)
      | .ite constVar auxVar op3 =>
          (getIdentityAndAbsorptionConstraints constVar symVars) ++ (getIdentityAndAbsorptionConstraints auxVar symVars) ++ (getIdentityAndAbsorptionConstraints op3 symVars)
      | _ => []

      where
        getBVExprConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr := Id.run do
                match bvExpr with
                | .shiftRight lhs rhs | .shiftLeft lhs rhs | .arithShiftRight lhs rhs =>
                      match (lhs, rhs) with
                      | (GenBVExpr.var lhsId, GenBVExpr.var rhsId) =>
                          let mut constraints := []

                          if symVars.contains lhsId then
                            constraints := getLhsShiftConstraints lhs ++ constraints

                          if symVars.contains rhsId then
                            constraints := getRhsShiftConstraints rhs ++ constraints
                          pure constraints
                      | (GenBVExpr.var lhsId, _) =>
                          if !symVars.contains lhsId then
                            getBVExprConstraints rhs
                          else
                            (getLhsShiftConstraints lhs) ++ (getBVExprConstraints rhs)
                      | (_, GenBVExpr.var rhsId) =>
                          if !symVars.contains rhsId then
                            getBVExprConstraints lhs
                          else
                          (getBVExprConstraints lhs)  ++ (getRhsShiftConstraints rhs)
                      | _ => ((getBVExprConstraints lhs) ++ (getBVExprConstraints rhs))
                | .bin lhs op rhs  =>
                      match (lhs, rhs) with
                      | (GenBVExpr.var lhsId, GenBVExpr.var rhsId) =>
                          let mut constraints := []

                          if symVars.contains lhsId then
                            constraints := getBitwiseConstraints lhs op ++ constraints

                          if symVars.contains rhsId then
                            constraints := getBitwiseConstraints rhs op ++ constraints
                          pure constraints
                      | (GenBVExpr.var lhsId, _) =>
                          if !symVars.contains lhsId then
                            getBVExprConstraints rhs
                          else
                            (getBitwiseConstraints lhs op) ++ (getBVExprConstraints rhs)
                      | (_, GenBVExpr.var rhsId) =>
                          if !symVars.contains rhsId then
                            getBVExprConstraints lhs
                          else
                         (getBVExprConstraints lhs)  ++ (getBitwiseConstraints rhs op)
                      | _ => ((getBVExprConstraints lhs) ++ (getBVExprConstraints rhs))
                | .un _ operand =>
                      getBVExprConstraints operand
                | _ =>  []

        getLhsShiftConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr :=
          let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const ((BitVec.ofNat w 0)))))
          [neqZero]

        getRhsShiftConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr :=
          let ltWidth := BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.ult (GenBVExpr.const (BitVec.ofNat w w)))
          let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const ((BitVec.ofNat w 0)))))

          [ltWidth, neqZero]

        getBitwiseConstraints {w} (bvExpr: GenBVExpr w) (op : BVBinOp): List GenBVLogicalExpr :=
            let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const (BitVec.ofNat w 0))))
            let neqAllOnes := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const (BitVec.allOnes w))))

            match op with
            | BVBinOp.xor => [neqZero]
            | BVBinOp.or | BVBinOp.and => [neqZero, neqAllOnes]
            | _ => []


partial def existsForAll (origExpr: GenBVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)  (numExamples: Nat := 1):
                  GeneralizerStateM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let rec constantsSynthesis (bvExpr: GenBVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)
            : GeneralizerStateM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
      let existsRes ← solve' bvExpr

      match existsRes with
        | none => trace[Generalize] m! "Could not satisfy exists formula for {bvExpr}"
                  return none
        | some assignment =>
          let existsVals := assignment.filter fun c _ => existsVars.contains c
          let substExpr := substitute bvExpr (packedBitVecToSubstitutionValue existsVals)
          let forAllRes ← solve' (BoolExpr.not substExpr)

          match forAllRes with
            | none =>
              return some existsVals
            | some counterEx =>
                let newExpr := substitute bvExpr (packedBitVecToSubstitutionValue counterEx)
                constantsSynthesis (BoolExpr.gate Gate.and bvExpr newExpr) existsVars forAllVars

    let mut res : List (Std.HashMap Nat BVExpr.PackedBitVec) := []
    let identityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints origExpr (Std.HashSet.ofList existsVars)
    let targetExpr := (BoolExpr.gate Gate.and origExpr (addConstraints (BoolExpr.const True) (identityAndAbsorptionConstraints)))

    match numExamples with
    | 0 => return res
    | n + 1 =>  let consts ← constantsSynthesis targetExpr existsVars forAllVars
                match consts with
                | none => return res
                | some assignment =>
                      res := assignment :: res
                      let newConstraints := assignment.toList.map (fun c => BoolExpr.literal (GenBVPred.bin (GenBVExpr.var c.fst) BVBinPred.eq (GenBVExpr.const c.snd.bv)))
                      let constrainedBVExpr := BoolExpr.not (addConstraints (BoolExpr.const True) newConstraints)
                      return res ++ (← existsForAll (BoolExpr.gate Gate.and origExpr constrainedBVExpr) existsVars forAllVars n)

elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := default
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.bvLogicalExpr
           let state := parsedBvExpr.state
           trace[Generalize] m! "bvExpr: {bvExpr}, state: {state}"

           let initialGeneralizerState : GeneralizerState :=
                { startTime                := 0
                , widthId                  := 0
                , timeout                  := 0
                , processingWidth          := targetWidth
                , targetWidth              := targetWidth
                , parsedBVLogicalExpr       := parsedBvExpr
                , needsPreconditionsExprs   := []
                , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                , constantExprsEnumerationCache  := Std.HashMap.emptyWithCapacity
                }


           let results ← (existsForAll bvExpr state.symVarToVal.keys state.inputVarIdToDisplayName.keys 3).run' initialGeneralizerState

           logInfo m! "Results: {results}"
      | _ =>
            logInfo m! "Could not match"
      pure ()


variable {x y z : BitVec 64}
--set_option trace.Meta.Tactic.bv true
#reducewidth (x + 0 = x) : 4
#reducewidth ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00ffff00#64 : 4
#reducewidth (x <<< 3  = y + (BitVec.ofNat 64 3)) : 4
#reducewidth (x <<< 3) <<< 4 = x <<< 7 : 4
#reducewidth x + 5 = x : 8
#reducewidth x = 10 : 8
#reducewidth (x + (-21)) >>> 1 = x >>> 1 : 4

variable {x y z : BitVec 32}
#reducewidth (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32  : 8
#reducewidth 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x : 8
#reducewidth 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 : 4

#reducewidth BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) : 8
#reducewidth x <<< 6#32 <<< 28#32 = 0#32 : 4


partial def deductiveSearch (expr: GenBVExpr w) (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) (depth: Nat) (parent: Nat) :
                      TermElabM ( List (GenBVExpr w)) := do

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
            let mut res : List (GenBVExpr w) := []

            for (constId, constVal) in constants.toArray do
              let newVar := GenBVExpr.var constId

              if constVal == target then
                res := newVar :: res
                continue

              if constId == parent then -- Avoid runaway expressions
                continue

              if target.bv == 0 then
                res := GenBVExpr.const 0 :: res

              let newTarget := (updatePackedBVWidth target constVal.w)
              if h : constVal.w = newTarget.w then
                let targetBv := h ▸ newTarget.bv

                -- ~C = T
                if BitVec.not constVal.bv == targetBv then
                  res := GenBVExpr.un BVUnOp.not newVar :: res

                -- C + X = Target; New target = Target - X.
                let addRes ← deductiveSearch expr constants {bv := targetBv - constVal.bv} (depth-1) constId
                res := res ++ addRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.add resExpr)

                -- C - X = Target
                let subRes ← deductiveSearch expr constants {bv := constVal.bv - targetBv} (depth-1) constId
                res := res ++ subRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.add (negate resExpr))

                -- X - C = Target
                let subRes' ← deductiveSearch expr constants {bv := targetBv + constVal.bv}  (depth-1) constId
                res := res ++ subRes'.map (λ resExpr => GenBVExpr.bin (resExpr) BVBinOp.add (negate newVar))

                -- X * C = Target
                if (BitVec.srem targetBv constVal.bv) == 0 && (BitVec.sdiv targetBv constVal.bv != 0) then
                  let mulRes ← deductiveSearch expr constants {bv := BitVec.sdiv targetBv constVal.bv} (depth - 1) constId
                  res := res ++ mulRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.mul resExpr)

                -- C / X = Target
                if targetBv != 0 && (BitVec.umod constVal.bv targetBv) == 0 then
                  let divRes ← deductiveSearch expr constants {bv := BitVec.udiv constVal.bv targetBv} (depth - 1) constId
                  res := res ++ divRes.map (λ resExpr => GenBVExpr.bin newVar BVBinOp.udiv resExpr)

              else
                    throwError m! "Width mismatch for expr : {expr} and target: {target}"
            return res



def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}


partial def countModel (expr : GenBVLogicalExpr) (constants: Std.HashSet Nat): GeneralizerStateM Nat := do
    go 0 expr
    where
        go (count: Nat) (expr : GenBVLogicalExpr) : GeneralizerStateM Nat := do
          let res ← solve' expr
          match res with
          | none => return count
          | some assignment =>
                let filteredAssignments := assignment.filter (λ c _ => constants.contains c)
                let newConstraints := filteredAssignments.toList.map (fun c => BoolExpr.literal (GenBVPred.bin (GenBVExpr.var c.fst) BVBinPred.eq (GenBVExpr.const c.snd.bv)))
                let constrainedBVExpr := BoolExpr.not (addConstraints (BoolExpr.const True) newConstraints)

                if count + 1 > 1000 then
                  return count
                pure (← go (count + 1) (BoolExpr.gate Gate.and expr constrainedBVExpr))

def generateCombinations (num: Nat) (values: List α) : List (List α) :=
    match num, values with
    | 0, _ => [[]]
    | _, [] => []
    | n + 1, x::xs =>
            let combosWithoutX := (generateCombinations (n + 1) xs)
            let combosWithX := (generateCombinations n xs).map (λ combo => x :: combo)
            combosWithoutX ++ combosWithX

def getNegativeExamples (bvExpr: GenBVLogicalExpr) (consts: List Nat) (numEx: Nat) :
              GeneralizerStateM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
  let targetExpr := (BoolExpr.not bvExpr)
  return (← helper targetExpr numEx)
  where
        helper (expr: GenBVLogicalExpr) (depth : Nat)
          : GeneralizerStateM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
        match depth with
          | 0 => return []
          | n + 1 =>
              let solution ← solve' expr

              match solution with
              | none => return []
              | some assignment =>
                   let constVals := assignment.filter fun c _ => consts.contains c
                   let newConstraints := constVals.toList.map (fun c => BoolExpr.not (BoolExpr.literal (GenBVPred.bin (GenBVExpr.var c.fst) BVBinPred.eq (GenBVExpr.const c.snd.bv))))

                   let res ← helper (addConstraints expr newConstraints) n
                   return [constVals] ++ res

def pruneEquivalentBVExprs (expressions: List (GenBVExpr w)) : GeneralizerStateM (List (GenBVExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (GenBVExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (GenBVPred.bin f BVBinPred.eq expr)))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

      if let some _ ← solve' subsumeCheckExpr then
        pruned := expr :: pruned

    trace[Generalize] m! "Removed {expressions.length - pruned.length} expressions after pruning {expressions.length} expressions"

    pure pruned

def pruneEquivalentBVLogicalExprs(expressions : List GenBVLogicalExpr): GeneralizerStateM (List GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List GenBVLogicalExpr:= []
    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.gate Gate.beq f expr))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

      if let some _ ← solve' subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"
    pure pruned

structure PreconditionSynthesisCacheValue where
  positiveExampleValues : List BVExpr.PackedBitVec
  negativeExampleValues : List BVExpr.PackedBitVec

instance : ToString PreconditionSynthesisCacheValue where
  toString val :=
    s! "⟨positiveExampleValues := {val.positiveExampleValues}, negativeExampleValues := {val.negativeExampleValues}⟩"


def zero (w: Nat) := GenBVExpr.const (BitVec.ofNat w 0)
def one (w: Nat) := GenBVExpr.const (BitVec.ofNat w 1)
def minusOne (w: Nat) := GenBVExpr.const (BitVec.ofInt w (-1))

def eqToZero (expr: GenBVExpr w) : GenBVLogicalExpr :=
  BoolExpr.literal (GenBVPred.bin expr BVBinPred.eq (zero w))

def positive (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  let shiftDistance : GenBVExpr w :=  subtract (GenBVExpr.var widthId) (one w)
  let signVal := GenBVExpr.shiftLeft (one w) shiftDistance
  BoolExpr.literal (GenBVPred.bin expr BVBinPred.ult signVal) --- It's positive if `expr <u 2 ^ (w - 1)`

def strictlyGTZero  (expr: GenBVExpr w) (widthId : Nat)  : GenBVLogicalExpr :=
  BoolExpr.gate  Gate.and (BoolExpr.literal (GenBVPred.bin (zero w) BVBinPred.ult expr)) (positive expr widthId)

def gteZero (expr: GenBVExpr w) (widthId : Nat)  : GenBVLogicalExpr :=
  positive expr widthId

def negative (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  BoolExpr.not (positive expr widthId)

def strictlyLTZero (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  negative expr widthId

def lteZero (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  BoolExpr.gate Gate.or (eqToZero expr) (negative expr widthId)

def checkTimeout : GeneralizerStateM Unit := do
  let state ← get
  let currentTime ← Core.liftIOCore IO.monoMsNow
  let elapsedTime := currentTime - state.startTime

  trace[Generalize] m! "Elapsed time: {elapsedTime/1000}s"
  if elapsedTime >= state.timeout then
      throwError m! "Synthesis Timeout Failure: Exceeded timeout of {state.timeout/1000}s"

def filterCandidatePredicates  (bvLogicalExpr: GenBVLogicalExpr) (preconditionCandidates visited: Std.HashSet GenBVLogicalExpr)
                                                    : GeneralizerStateM (List GenBVLogicalExpr) :=
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
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint]) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve' expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, GenBVExpr.const (BitVec.ofNat bitwidth bitwidth))]))
              if !(evalBVLogicalExpr assignment bitwidth widthSubstitutedCandidate) then
                res := res.insert candidate
            pure res

      currentCandidates := newCandidates

    logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidates.size} potential candidates."
    res := currentCandidates.toList
    pure res

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

def precondSynthesisUpdateCache (previousLevelCache synthesisComponents: Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue)
    (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec)
    (ops : List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM (Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue) := do
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (BVExpr.PackedBitVec × BVExpr.PackedBitVec)) (examples: List (HashMap Nat BVExpr.PackedBitVec))
            (op : GenBVExpr w → GenBVExpr w → GenBVExpr w) : GeneralizerStateM (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalBVExpr examples[index]! w (op  (GenBVExpr.const (h.left ▸ lhs.bv)) (GenBVExpr.const (h.right ▸ rhs.bv)))) :: res
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
              (numConjunctions: Nat) : GeneralizerStateM (Option GenBVLogicalExpr) := do

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
        let powerOfTwoResults := positiveExamples.map (λ pos => evalBVExpr pos bitwidth powerOf2Expr)

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

def lhsSketchEnumeration  (lhsSketch: GenBVExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat (List (GenBVExpr w)) := Id.run do
  let zero := GenBVExpr.const (BitVec.ofNat w 0)
  let one := GenBVExpr.const (BitVec.ofNat w 1 )
  let minusOne := GenBVExpr.const (BitVec.ofInt w (-1))

  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsBVExprs : List (GenBVExpr w):= lhsSymVars.keys.map (λ k => GenBVExpr.var k)
  let lhsSymVarsPermutation := productsList (List.replicate lhsSymVarsAsBVExprs.length lhsSymVarsAsBVExprs)

  let inputsAndSymVars := List.product inputCombinations lhsSymVarsPermutation

  let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
  for (var, value) in rhsSymVars.toArray do
    let h : value.w = w := sorry
    rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

  let mut res : Std.HashMap Nat (List (GenBVExpr w)):= Std.HashMap.emptyWithCapacity
  for combo in inputsAndSymVars do
    let inputsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip inputVars combo.fst))
    let symVarsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip lhsSymVars.keys combo.snd))

    let substitutedExpr := substituteBVExpr lhsSketch (Std.HashMap.union inputsSubstitutions symVarsSubstitutions)
    let evalRes : BitVec w := evalBVExpr lhsSymVars w substitutedExpr

    if rhsVarByValue.contains evalRes then
      let existingVar := rhsVarByValue[evalRes]!
      let existingVarRes := res.getD existingVar []

      res := res.insert existingVar (substitutedExpr::existingVarRes)

  pure res

def pruneConstantExprsSynthesisResults(exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr w)))
                            : GeneralizerStateM (Std.HashMap Nat (List (GenBVExpr w))) := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let mut tempResults : Std.HashMap Nat (List (GenBVExpr w)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let mut prunedExprs ← pruneEquivalentBVExprs expressions
              tempResults := tempResults.insert var prunedExprs.reverse

          pure tempResults


def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr processingWidth)))
                                            : GeneralizerStateM (Option GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Checked if expressions require preconditions") do
    -- logInfo m! "Expression synthesis results : {exprSynthesisResults}"
    let combinations := productsList exprSynthesisResults.values
    let mut substitutions := []

    let state ← get
    let parsedBVLogicalExpr := state.parsedBVLogicalExpr
    let mut visited := state.visitedSubstitutions

    for combo in combinations do
      -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
      let zippedCombo := Std.HashMap.ofList (List.zip parsedBVLogicalExpr.rhs.symVars.keys combo)
      let substitution := substitute parsedBVLogicalExpr.bvLogicalExpr (bvExprToSubstitutionValue zippedCombo)
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

def constantExprsEnumerationFromCache (allLhsVars : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec ) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec)
                                          (ops: List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM (Std.HashMap Nat (List (GenBVExpr w))) := do
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


    let state ← get
    let h : state.processingWidth = w := sorry
    let mut previousLevelCache := state.constantExprsEnumerationCache

    if previousLevelCache.isEmpty then
      previousLevelCache := h ▸ allLhsVars

    let mut currentCache := Std.HashMap.emptyWithCapacity

    let mut res : Std.HashMap Nat (List (GenBVExpr w)):= Std.HashMap.emptyWithCapacity
    for (bvExpr, packedBV) in previousLevelCache.toArray do
      let h' : packedBV.w = w := sorry

      let packedBVExpr : GenBVExpr w := GenBVExpr.const (h' ▸ packedBV.bv)

      for (lhsVar, lhsVal) in allLhsVars.toArray do
        for op in ops do
          let evaluatedRes := evalBVExpr lhsSymVars w (op packedBVExpr lhsVar)

          let mut newExpr : GenBVExpr w := op (h ▸ bvExpr) lhsVar
          let rhsVarForValue := rhsVarByValue[evaluatedRes]?

          match rhsVarForValue with
          | some rhsVar =>
              let existingCandidates := res.getD rhsVar []
              res := res.insert rhsVar (newExpr::existingCandidates)
          | none =>
            if evaluatedRes == h' ▸ packedBV.bv then
              newExpr := h ▸ bvExpr
            currentCache := currentCache.insert newExpr {bv := evaluatedRes : BVExpr.PackedBitVec}

    let uniqueExprs := Std.HashSet.ofList (← pruneEquivalentBVExprs currentCache.keys)
    let nextCache := currentCache.filter (λ k v => uniqueExprs.contains k )

    set {state with constantExprsEnumerationCache := h ▸ currentCache}
    pure res


def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)): GeneralizerStateM (Option GenBVLogicalExpr) :=  do
    let state ← get
    let parsedBVLogicalExpr := state.parsedBVLogicalExpr
    let processingWidth := state.processingWidth

    let mut exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr processingWidth)) := Std.HashMap.emptyWithCapacity

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
          | x::xs => exprSynthesisResults := exprSynthesisResults.insert targetId (h ▸ deductiveSearchRes)

        if exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          match (← getCombinationWithNoPreconditions exprSynthesisResults) with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from just deductive search"

        logInfo m! "Performing enumerative search using a sketch of the LHS"
        let lhsSketchResults := lhsSketchEnumeration lhs.bvExpr lhs.inputVars.keys lhsAssignments rhsAssignments
        for (var, exprs) in lhsSketchResults.toArray do
          let existingExprs := exprSynthesisResults.getD var []
          exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ (h ▸ exprs))

        if !lhsSketchResults.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
          match preconditionCheckResults with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from a sketch of the LHS"

        logInfo m! "Performing bottom-up enumerative search one level at a time"

        let specialConstants : Std.HashMap (GenBVExpr state.processingWidth) BVExpr.PackedBitVec := Std.HashMap.ofList [
          ((one processingWidth), {bv := BitVec.ofNat processingWidth 1}),
          ((minusOne processingWidth), {bv :=  BitVec.ofInt processingWidth (-1)})
        ]

        let mut allLHSVars := specialConstants
        for (var, value) in lhsAssignments.toArray do
          allLHSVars := allLHSVars.insert (GenBVExpr.var var) value
          allLHSVars := allLHSVars.insert (GenBVExpr.un BVUnOp.not ((GenBVExpr.var var))) {bv := BitVec.not (value.bv)}

        let ops := [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

        let mut currentLevel := 1
        while currentLevel < lhs.symVars.size do
          logInfo m! "Expression Synthesis Processing level {currentLevel}"

          --
          let bottomUpRes ← constantExprsEnumerationFromCache allLHSVars lhsAssignments rhsAssignments ops
          for (var, exprs) in bottomUpRes.toArray do
            let existingExprs := exprSynthesisResults.getD var []
            exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ exprs)

          if !bottomUpRes.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
            exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
            let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
            match preconditionCheckResults with
            | some expr => return some expr
            | none => logInfo m! "Could not find a generalized form from processing level {currentLevel}"

          checkTimeout
          currentLevel :=  currentLevel + 1

    return none

def checkForPreconditions (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) (maxConjunctions: Nat)
                                                : GeneralizerStateM (Option GenBVLogicalExpr) := do
  let state ← get
  let parsedBVLogicalExpr := state.parsedBVLogicalExpr

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

def generalize  : GeneralizerStateM (Option GenBVLogicalExpr) := do
    let state ← get
    let parsedBVLogicalExpr := state.parsedBVLogicalExpr
    let mut bvLogicalExpr := parsedBVLogicalExpr.bvLogicalExpr
    let parsedBVState := parsedBVLogicalExpr.state

    let originalWidth := parsedBVState.originalWidth
    let targetWidth := state.targetWidth

    let mut constantAssignments := []
    --- Synthesize constants in a lower width if needed
    if originalWidth > targetWidth then
      constantAssignments ← existsForAll bvLogicalExpr parsedBVState.symVarToVal.keys parsedBVState.inputVarIdToDisplayName.keys 1

    let mut processingWidth := targetWidth
    if constantAssignments.isEmpty then
      logInfo m! "Did not synthesize new constant values in width {targetWidth}"
      constantAssignments := parsedBVState.symVarToVal :: constantAssignments
      processingWidth := originalWidth

    if processingWidth != targetWidth then
        -- Revert to the original width if necessary
      bvLogicalExpr := changeBVLogicalExprWidth bvLogicalExpr processingWidth
      trace[Generalize] m! "Using values for {bvLogicalExpr} in width {processingWidth}: {constantAssignments}"

    set {state with
                processingWidth := processingWidth,
                constantExprsEnumerationCache := {},
                parsedBVLogicalExpr := { parsedBVLogicalExpr with bvLogicalExpr := bvLogicalExpr }}

    let exprWithNoPrecondition  ← withTraceNode `Generalize (fun _ => return "Performed expression synthesis") do
        synthesizeWithNoPrecondition constantAssignments
    let maxConjunctions : ℕ := 1

    match exprWithNoPrecondition with
    | some generalized => return some generalized
    | none =>
              let state ← get
              if state.needsPreconditionsExprs.isEmpty then
                throwError m! "Could not synthesise constant expressions for {state.parsedBVLogicalExpr.bvLogicalExpr}"

              let preconditionRes ← withTraceNode `Generalize (fun _ => return "Attempted to generate weak precondition for all expression combos") do
                checkForPreconditions constantAssignments maxConjunctions

              match preconditionRes with
              | some expr => return some expr
              | none => return none
    -- TODO:  verify width independence

inductive GeneralizeContext where
  | Command : GeneralizeContext
  | Tactic (name : Name) : GeneralizeContext


def printAsTheorem (name: Name) (generalization: GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name) : String := Id.run do
  let params := displayNames.values.filter (λ n => n.toString != "w")

  let mut res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " (params.map (λ p => p.toString))} : BitVec w)"

  match generalization with
  | .ite cond positive _ => res := res ++ s! " (h: {prettify cond displayNames}) : {prettify positive displayNames}"
  | _ => res := res ++ s! " : {prettify generalization displayNames}"

  res := res ++ s! " := by sorry"
  pure res

def parseAndGeneralize (hExpr : Expr) (context: GeneralizeContext): TermElabM MessageData := do
    let targetWidth := 8
    let timeoutMs := 300000

    match_expr hExpr with
    | Eq _ lhsExpr rhsExpr =>
          let startTime ← Core.liftIOCore IO.monoMsNow

          -- Parse the input expression
          let widthId : Nat := 9481
          let mut initialState : ParsedBVExprState := default
          initialState := { initialState with symVarToDisplayName := initialState.symVarToDisplayName.insert widthId (Name.mkSimple "w")}

          let some parsedBVLogicalExpr ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState
            | throwError "Unsupported expression provided"

          trace[Generalize] m! "Parsed GenBVLogicalExpr state: {parsedBVLogicalExpr.state}"

          let bvLogicalExpr := parsedBVLogicalExpr.bvLogicalExpr
          let parsedBVState := parsedBVLogicalExpr.state

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
---
warning: declaration uses 'sorry'
-/
#guard_msgs in
theorem demo (x y : BitVec 8) : (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y := by
  bv_generalize
  sorry


/--
info: theorem Generalize.demo2.generalized_1_1 {w} (x C1 C2 C3 C4 C5 : BitVec w) : (((x ^^^ C1) ||| C2) ^^^ C3) = ((x &&& (~ C2)) ^^^ (((0 ^^^ C2) ||| C1) ^^^ C3)) := by sorry
---
warning: declaration uses 'sorry'
-/
#guard_msgs in
theorem demo2 (x y : BitVec 8) :  (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) := by
  bv_generalize
  sorry
