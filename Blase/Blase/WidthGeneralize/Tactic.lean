import Mathlib.Data.Fintype.Defs
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.MultiWidth.Preprocessing
import Blase.KInduction.KInduction
import Blase.AutoStructs.FormulaToAuto
import Blase.ReflectMap
import Lean.Meta.Tactic.Subst
import Lean

initialize Lean.registerTraceClass `Blase.WidthGeneralize

namespace WidthGeneralize
namespace Tactic
open Lean Meta Elab Tactic

def getBitVecType? (t : Expr) : MetaM (Option Expr) := do
  let t ← instantiateMVars t
  let t ← whnf t
  match_expr t with
  | BitVec w => return some w
  | _ => return none

def isNatType? (t : Expr) : MetaM (Option Expr) := do
  let t ← instantiateMVars t
  let t ← whnf t
  match_expr t with
  | Nat => return some t
  | _ => return none

structure BvGeneralizeConfig where
  debug : Bool := false

abbrev GenM := ReaderT BvGeneralizeConfig MetaM

def GenM.debugLog (msg : MessageData) : GenM Unit := do
  let cfg ← read
  if cfg.debug then
    logInfo msg
  else
    pure ()

def GenM.run (x : GenM α)  (cfg : BvGeneralizeConfig) : MetaM α :=
  ReaderT.run x cfg

axiom generalizeAxiom (P : Prop) : P


structure ConcreteWidths where
  /-- Mapping from a concrete width to its generalized variable index. -/
  bvs : Std.HashSet FVarId := ∅
  width2ix : Std.HashMap Nat Nat := {}

instance : EmptyCollection ConcreteWidths where
  emptyCollection := {}


def ConcreteWidths.widths (s : ConcreteWidths) : Array Nat :=
  s.width2ix.keys.toArray.qsort

def ConcreteWidths.addBV (s : ConcreteWidths) (bv : FVarId) : ConcreteWidths :=
    { s with
      bvs := s.bvs.insert bv
    }

def ConcreteWidths.addWidth (s : ConcreteWidths) (n : Nat) : ConcreteWidths :=
  if s.width2ix.contains n then
    s
  else
    { s with
      width2ix := s.width2ix.insert n (s.width2ix.size)
    }

partial def collectWidthsInExpr (e : Expr) (s : ConcreteWidths) : GenM ConcreteWidths := do
  let mut s := s
  if let some wExpr ← getBitVecType? e then
    let wExpr ← instantiateMVars wExpr
    if let some n ← Meta.getNatValue? wExpr then
      -- we have a concrete nat width, so let's add it to our cache
      s := s.addWidth n

  -- We only bother in the first-order setting.
  -- So we recurse into applications only.
  let (_f, xs) := e.getAppFnArgs
  for x in xs do
      s ← collectWidthsInExpr x s
  return s


/-- Substitute concrete bitvector widths with their corresponding fvar. -/
partial def substWidthInExpr
  (e : Expr)
  (widthMap : Std.HashMap Nat Expr)
  (bvsMap : Std.HashMap FVarId Expr) : MetaM Expr := do
  match_expr e with
  | OfNat.ofNat ty val => do
      let some wExpr ← getBitVecType? ty
        | return e
      let some n ← getNatValue? wExpr
        | return e
      if let some newW := widthMap.find? n then
        let newTy ← mkAppM ``BitVec #[(newW)]
        let newExpr ← mkAppM ``OfNat.ofNat #[newTy, mkNatLit val]
        return newExpr
      else
        return e
  | BitVec.ofInt ewidth eval => do
      let some n ← getNatValue? ewidth
        | return e
      if let some newW := widthMap.find? n then
        let newExpr ← mkAppM ``BitVec.ofInt #[newW, eval]
        return newExpr
      else
        return e

-- | Add generalized width variables to the current context
def addGeneralizedWidths {α : Type} (xs : Array Nat) (ix : Nat) (fvars : Std.HashMap Nat Expr)
    (k : Std.HashMap Nat Expr → GenM α) : GenM α := do
  if h : ix < xs.size then
    let n := xs[ix]
    let fvarName := Name.mkSimple s!"bv_width_{n}"
    let fvarType := mkConst ``Nat
    withLocalDecl fvarName BinderInfo.default fvarType fun fvarId => do
      let fvars := fvars.insert n fvarId
      addGeneralizedWidths xs (ix + 1) fvars k
  else
    k fvars

def addGeneralizedBVs (genWs : Std.HashMap Nat Expr)
  (bvs : Array FVarId)
  (ix : Nat)
  (out : Std.HashMap FVarId Expr)
  (k : Std.HashMap FVarId Expr → GenM α) : GenM α := do
  if h : ix < bvs.size then
    let bvFVarId := bvs[ix]
    let bvType ← inferType (.fvar bvFVarId)
    let some wExpr ← getBitVecType? bvType
      | throwError "Expected bitvector type for {Expr.fvar bvFVarId}, got {bvType}"
    let some n ← getNatValue? wExpr
      | throwError "Expected concrete width for {Expr.fvar bvFVarId}, got width expr {wExpr}"
    let ldecl ← bvFVarId.getDecl
    let genBvType ← mkAppM ``BitVec #[(genWs[n]!)]
    withLocalDecl (ldecl.userName.appendAfter "gen")
      BinderInfo.default genBvType fun fvarId => do
        let out := out.insert bvFVarId fvarId
        addGeneralizedBVs genWs bvs (ix + 1) out k
  else
    k out


def doBvGeneralize (g : MVarId) : GenM MVarId := do
  g.withContext do
    let lctx ← getLCtx
    let mut widths : ConcreteWidths := ∅
    for ldecl in lctx do
      let declTy := ldecl.type
      GenM.debugLog m!"inspecting local decl {ldecl.userName} : {declTy}"
      if let some w ← getBitVecType? declTy then
         GenM.debugLog m!"..is BV with width expr: {w}"
         widths := widths.addBV ldecl.fvarId
         if let some wVal ← getNatValue? w then
           GenM.debugLog m!"....concrete width: {wVal}"
           widths := widths.addWidth wVal
         else
           GenM.debugLog m!"....non-concrete width"
    GenM.debugLog m!"collected concrete widths from fvars: {widths.widths.toList}"
    -- | Now collect concrete widths from the goal type itself
    widths ← collectWidthsInExpr (← g.getType) widths
    GenM.debugLog m!"collected concrete widths from goal: {widths.widths.toList}"

    addGeneralizedWidths widths.widths 0 ∅ fun genWs => do
      GenM.debugLog m!"Added generalized widths: {genWs.toArray}"
      addGeneralizedBVs genWs widths.bvs.toArray 0 ∅ fun genBVs => do
        GenM.debugLog m!"Added generalized BVs: {genBVs.toArray.map fun (k, v) => (Expr.fvar k, v)}"
          let gType ← g.getType
          let gTypeNew ← substWidthInExpr gType widths genWs.toArray
          return ()
    -- let's introduce new Fvars, one for each width
    return g


declare_config_elab elabBvGeneralizeConfig BvGeneralizeConfig

/--
This tactic tries to generalize the bitvector width2ix, and only the bitvector
width2ix. See `genTable` if the tactic fails to generalize the right parameters
of a function over bitvectors.
-/
syntax (name := bvGeneralize) "bv_generalize" Lean.Parser.Tactic.optConfig  : tactic

@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize $cfg) => do
  let cfg ← elabBvGeneralizeConfig cfg
  let g₀ ← getMainGoal
  g₀.withContext do
    let g ← (doBvGeneralize g₀).run cfg
    let generalizeAx ← mkAppM ``generalizeAxiom #[← g₀.getType]
    if ! (← isDefEq (.mvar g₀) generalizeAx) then
        throwError "ERROR: unable to prove goal {g₀} with generalize axiom."
    replaceMainGoal [g]
| _ => throwUnsupportedSyntax

-- TODO: the `bv_generalize` tactic fails when a bit vector is already width generic

#guard_msgs in theorem test_bv_generalize_simple (x y : BitVec 32)  :
    x = x + y := by
  intros
  bv_generalize +debug
  trace_state

/--
trace: x✝ y✝ : BitVec 32
zs✝ : List (BitVec 44)
⊢ x✝ = x✝
---
warning: declaration uses 'sorry'
---
warning: 'intros' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
-/
#guard_msgs in theorem test_bv_generalize_ofNat (x y : BitVec 32)  :
    x = x + BitVec.ofNat 32 1 := by
  intros
  bv_generalize +debug
  trace_state
  sorry

#guard_msgs in theorem test_bv_generalize_ofInt (x y : BitVec 32)  :
    x = x + BitVec.ofInt 32 1 := by
  intros
  bv_generalize +debug
  trace_state
  sorry
#guard_msgs in theorem test_bv_generalize_OfNatofnat (x y : BitVec 32)  :
    x = x + 4  := by
  intros
  bv_generalize +debug
  trace_state
  sorry


/--
error: unsolved goals
x✝ y✝ : BitVec 32
zs✝ : List (BitVec 44)
z✝ : BitVec 10
h✝ : 52 + 10 = 42
heq✝ : x✝ = y✝
⊢ BitVec.zeroExtend 10 x✝ = BitVec.zeroExtend 10 y✝ + 0
---
trace: x✝ y✝ : BitVec 32
zs✝ : List (BitVec 44)
z✝ : BitVec 10
h✝ : 52 + 10 = 42
heq✝ : x✝ = y✝
⊢ BitVec.zeroExtend 10 x✝ = BitVec.zeroExtend 10 y✝ + 0
-/
#guard_msgs in theorem test_bv_generalize (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize
  trace_state

/--
error: unsolved goals
x✝ y✝ : BitVec 32
zs✝ : List (BitVec 44)
z✝ : BitVec 10
h✝ : 52 + 10 = 42
heq✝ : x✝ = y✝
⊢ BitVec.zeroExtend 10 x✝ = BitVec.zeroExtend 10 y✝ + 0
-/
#guard_msgs in theorem test_bv_generalize_spec (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  trace_state
  bv_decide


/-! # Specializer -/


structure SpecializeConfig where
  debug : Bool := false


abbrev SpecM := ReaderT SpecializeConfig MetaM

def SpecM.debugLog (msg : MessageData) : SpecM Unit := do
  let cfg ← read
  if cfg.debug then
    logInfo msg
  else
    pure ()

def SpecM.run (x : SpecM α)  (cfg : SpecializeConfig) : MetaM α :=
  ReaderT.run x cfg

/-- Axiom used by width specialization tactic. -/
axiom specializeAxiom (P : Prop) : P


def substWidthsToDecls (ix : Nat) (fvars : Array FVarId) (g : MVarId) : SpecM MVarId := do
    if hix : ix < fvars.size then
      let fvar := fvars[ix]
      let val : Nat := 3 + ix * 2
      let valExpr := mkNatLit val
      let eqExpr ← mkEq (.fvar fvar) valExpr
      let eqValue ← mkAppM ``specializeAxiom #[eqExpr]
      Meta.withLetDecl (Name.mkSimple s!"wEq_{ix}") eqExpr eqValue fun newEq => do
          SpecM.debugLog m!"Adding equation {newEq} to goal {g}"
          if !newEq.isFVar then
              throwError "Expected newEq to be an FVar, got {newEq}"
          substWidthsToDecls (ix + 1) fvars g
    else
        let gType ← g.getType
        let gNew ← mkFreshExprMVar gType
        g.assign (← mkAppM ``specializeAxiom #[gType])
        let gNew := gNew.mvarId!
        gNew.withContext do
          SpecM.debugLog
            m!"Added equations all width2ix in goal {gNew}. Now substituting equations."
          let some gNew ← gNew.substEqs
            | throwError "Failed to substitute equations in goal {gNew}"
          return gNew


/--
Returns a new goal where all bitvector width2ix in the context have been specialized
to concrete values.
-/
def specializeGoal (g : MVarId) : SpecM MVarId := do
    let lctx ← getLCtx
    let mut widthVars : Std.HashSet FVarId := {}
    for ldecl in lctx do
      let declTy := ldecl.type
      SpecM.debugLog m!"inspecting local decl {ldecl.userName} : {declTy}"
      let some w ← getBitVecType? declTy
        | continue
      SpecM.debugLog m!"..has width expr: {w}"
      if w.isFVar then
         SpecM.debugLog m!"..has width fvar: {w}"
         widthVars := widthVars.insert w.fvarId!
    SpecM.debugLog m!"specializing width2ix: '{widthVars.toList.map Expr.fvar}'"
    substWidthsToDecls 0 widthVars.toArray g


declare_config_elab elabBvSpecializeConfig SpecializeConfig
syntax (name := bvSpecialize) "bv_specialize" Lean.Parser.Tactic.optConfig : tactic


def doSpecialize (cfg : SpecializeConfig) : TacticM Unit := do
  let g ← getMainGoal
  g.withContext do
    let newG ← SpecM.run (specializeGoal g) cfg
    replaceMainGoal [newG]

@[tactic bvSpecialize]
def evalBvSpecialize : Tactic := fun
| `(tactic| bv_specialize $cfg) => do
  let cfg ← elabBvSpecializeConfig cfg
  doSpecialize cfg
| _ => throwUnsupportedSyntax

/--
trace: v : ℕ
zs : List (BitVec v)
x y : BitVec 3
⊢ x = x
-/
#guard_msgs in theorem test_bv_specialize (x y : BitVec w) (zs : List (BitVec v)) :
    x = x := by
  bv_specialize
  trace_state
  sorry



end Tactic
end WidthGeneralize
