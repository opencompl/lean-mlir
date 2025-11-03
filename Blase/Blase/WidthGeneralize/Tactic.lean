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

axiom generalizeAxiom {P : Prop} : P


structure ConcreteWidths where
  /-- Mapping from a concrete width to its generalized variable index. -/
  widths : Array Nat := #[]
  width2ix : Std.HashMap Nat Nat := {}

instance : EmptyCollection ConcreteWidths where
  emptyCollection := {}

def ConcreteWidths.addWidth (s : ConcreteWidths) (n : Nat) : ConcreteWidths :=
  if s.width2ix.contains n then
    s
  else
    { s with 
      widths := s.widths.push n,
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
  (s : ConcreteWidths)
  (fvars : Array Expr) : MetaM Expr := do
  if let some n ← Meta.getNatValue? e then
    if let some ix := s.width2ix[n]? then
      -- This will replace the occurrence of e.g. 64 in '(BitVec.ofNat 64 k)
      return fvars[ix]!
    else
      -- | We have a natural number that is not at the width type level,
      -- so we don't replace it and leave it as-is.
      return e
  else
    -- We only bother in the first-order setting.
    -- So we recurse into applications only.
    let (f, xs) := e.getAppFnArgs
    let mut xsNew : Array Expr := #[]
    for x in xs do
        let xNew ← substWidthInExpr x s fvars
        xsNew := xsNew.push xNew
    mkAppM f xsNew

-- | Add generalized width variables to the current context
def addGeneralizedWidths {α : Type} (xs : Array Nat) (ix : Nat) (fvars : Array Expr)
    (k : Array Expr → MetaM α) : MetaM α := do
  if h : ix < xs.size then
    let n := xs[ix]
    let fvarName := Name.mkSimple s!"bv_width_{n}"
    let fvarType := mkConst ``Nat
    withLocalDecl fvarName BinderInfo.default fvarType fun fvarId => do
      let fvars := fvars.push fvarId
      addGeneralizedWidths xs (ix + 1) fvars k
  else
    k fvars

def doBvGeneralize (g : MVarId) : GenM MVarId := do
  g.withContext do
    let lctx ← getLCtx
    let mut widths : ConcreteWidths := ∅
    for ldecl in lctx do
      let declTy := ldecl.type
      GenM.debugLog m!"inspecting local decl {ldecl.userName} : {declTy}"
      if let some w ← getBitVecType? declTy then
         GenM.debugLog m!"..has width expr: {w}"
         if let some wVal ← getNatValue? w then
           GenM.debugLog m!"....concrete width: {wVal}"
           widths := widths.addWidth wVal
         else
           GenM.debugLog m!"....non-concrete width"
    GenM.debugLog m!"collected concrete widths from fvars: {widths.widths.toList}"
    -- | Now collect concrete widths from the goal type itself
    widths ← collectWidthsInExpr (← g.getType) widths
    addGeneralizedWidths widths.widths 0 #[] fun fvars => do
      sorry
    -- let's introduce new Fvars, one for each width
    return g


/--
This tactic tries to generalize the bitvector width2ix, and only the bitvector
width2ix. See `genTable` if the tactic fails to generalize the right parameters
of a function over bitvectors.
-/
syntax (name := bvGeneralize) "bv_generalize"  : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize) => do
  let g₀ ← getMainGoal
  g₀.withContext do
    let g ← (doBvGeneralize g₀).run {}
    let generalizeAx ← mkAppM ``generalizeAxiom #[← g₀.getType]
    if ! (← isDefEq (.mvar g₀) generalizeAx) then
        throwError "ERROR: unable to prove goal {g₀} with generalize axiom."
    replaceMainGoal [g]
| _ => throwUnsupportedSyntax

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
axiom specializeAxiom {P : Prop} : P


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

-- TODO: the `bv_generalize` tactic fails when a bit vector is already width generic

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
#guard_msgs in theorem test_bv_generalize_simple (x y : BitVec 32) (zs : List (BitVec 44)) : 
    x = x := by
  intros
  bv_generalize
  trace_state
  sorry

/--
info: inspecting local decl test_bv_specialize : ∀ {w v : ℕ} (x y : BitVec w) (zs : List (BitVec v)), x = x
---
info: inspecting local decl w : ℕ
---
info: inspecting local decl v : ℕ
---
info: inspecting local decl x : BitVec w
---
info: ..has width expr: w
---
info: ..has width fvar: w
---
info: inspecting local decl y : BitVec w
---
info: ..has width expr: w
---
info: ..has width fvar: w
---
info: inspecting local decl zs : List (BitVec v)
---
info: specializing width2ix: '[w]'
---
info: Adding equation wEq_0 to goal w v : ℕ
x y : BitVec w
zs : List (BitVec v)
⊢ x = x
---
info: Added equations all width2ix in goal w v : ℕ
x y : BitVec w
zs : List (BitVec v)
wEq_0 : w = 3 := ⋯
⊢ x = x. Now substituting equations.
---
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
  bv_generalize 
  trace_state
  bv_decide

end Tactic
end WidthGeneralize

