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
/-
A tactic to generalize the width of BitVectors
-/

structure State where
  /-- Maps fixed width to a new MVar for the generic width. -/
  mapping : DiscrTree Expr
  invMapping : Std.HashMap Expr Expr
  deriving Inhabited

abbrev GenM := StateT State TermElabM 

def State.get? (e : Expr) : GenM (Option Expr) := do
  let s ← get
  match ← s.mapping.getMatch e with
  | #[x] => return x
  | #[] => return none
  | _ => unreachable!

def State.setMapping (e x : Expr) : GenM Unit := do
  let s ← get
  let m ← s.mapping.insert e x
  set {s with mapping := m}

/-- Get the generic width BV MVar corresponding to an existing BV width. -/
def State.add? (e : Expr) : GenM Expr := do
  match ← get? e with
  | some x => pure x
  | none =>
    if e.isFVar || e.isBVar then pure e else
    let x ← mkFreshExprMVar (some (.const ``Nat [])) (userName := `w)
    setMapping e x
    modify fun s => { s with invMapping := s.invMapping.insert x e }
    pure x

/--
This table determines which arguments of important functions are bitwidths and
should be generalized and which ones are normal parameters which should be
recursively visited.
-/
def genTable : Std.HashMap Name (Array Bool) := Id.run do
  let mut table := .emptyWithCapacity 16
  table := table.insert ``BitVec #[true]
  table := table.insert ``BitVec.zeroExtend #[true, true, false]
  table := table.insert ``BitVec.truncate #[true, true, false]
  table := table.insert ``BitVec.signExtend #[true, true, false]
  table := table.insert ``BitVec.instOfNat #[true, false, false]
  table := table.insert ``BitVec.instAdd #[true]
  table := table.insert ``BitVec.instSub #[true]
  table := table.insert ``BitVec.instMul #[true]
  table := table.insert ``BitVec.instDiv #[true]
  table := table.insert ``AndOp #[true]
  table := table.insert ``BitVec.ofNat #[true, false]
  table

/--
Get arguments to generalize for a given function name.
TODO: don't use a hardcoded table, but infer from definitions.
-/
def getArgsToGeneralize (name : Name) : Option (Array Bool) :=
  genTable[name]?


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

#check MVarId.revert
#check MVarId.generalize
#check MVarId.intros
#check MVarId.substEqs

def doBvGeneralize (g : MVarId) : MetaM MVarId := do
  let lctx ← getLCtx
  let mut allFVars := #[]
  for h in lctx do
    if not h.isImplementationDetail then
      allFVars := allFVars.push h.fvarId
  let (_revertedFvars, g) ← g.revert allFVars
  let (_introsdFvars, g) ← g.intros
  return g

axiom generalizeAxiom : ∀ P, P
axiom specializeAxiom : ∀ P, P



def substWidthsToDecls (ix : Nat) (fvars : Array FVarId) (g : MVarId) : MetaM MVarId := do
    if hix : ix < fvars.size then 
      let fvar := fvars[ix]
      let val : Nat := 3 + ix * 2
      let valExpr := mkNatLit val
      let eqExpr ← mkEq (.fvar fvar) valExpr
      let eqValue ← mkAppM ``specializeAxiom #[eqExpr]
      Meta.withLetDecl (Name.mkSimple s!"wEq_{ix}") eqExpr eqValue fun newEq => do
          logInfo m!"Adding equation {newEq} to goal {g}" 
          if !newEq.isFVar then
              throwError "Expected newEq to be an FVar, got {newEq}"
          substWidthsToDecls (ix + 1) fvars g
    else
        let gType ← g.getType
        let gNew ← mkFreshExprMVar gType
        g.assign (← mkAppM ``specializeAxiom #[gType])
        let gNew := gNew.mvarId!
        gNew.withContext do
          logInfo m!"Added equations all widths in goal {gNew}. Now substituting equations."
          let some gNew ← gNew.substEqs
            | throwError "Failed to substitute equations in goal {gNew}"
          return gNew

/--
This tactic tries to generalize the bitvector widths, and only the bitvector
widths. See `genTable` if the tactic fails to generalize the right parameters
of a function over bitvectors.
-/
syntax (name := bvGeneralize) "bv_generalize"  : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize) => do
  let g₀ ← getMainGoal
  g₀.withContext do
    let g ← doBvGeneralize g₀
    let generalizeAx ← mkAppM ``generalizeAxiom #[← g₀.getType]
    if ! (← isDefEq (.mvar g₀) generalizeAx) then
        throwError "ERROR: unable to prove goal {g₀} with generalize axiom."
    replaceMainGoal [g]
| _ => throwUnsupportedSyntax


/-- 
Returns a new goal where all bitvector widths in the context have been specialized
to concrete values.
-/
def specializeGoal (g : MVarId) : MetaM MVarId := do
    let lctx ← getLCtx
    let mut widthVars : Std.HashSet FVarId := {}
    for ldecl in lctx do
      let declTy := ldecl.type
      logInfo m!"inspecting local decl {ldecl.userName} : {declTy}"
      let some w ← getBitVecType? declTy
        | continue
      logInfo m!"..has width expr: {w}"
      if w.isFVar then
         logInfo m!"..has width fvar: {w}"
         widthVars := widthVars.insert w.fvarId!
    logInfo m!"specializing widths: '{widthVars.toList.map Expr.fvar}'"
    substWidthsToDecls 0 widthVars.toArray g

syntax (name := bvSpecialize) "bv_specialize" : tactic


def doSpecialize : TacticM Unit := do
  let g ← getMainGoal
  g.withContext do
    let newG ← specializeGoal g
    replaceMainGoal [newG]

@[tactic bvSpecialize]
def evalBvSpecialize : Tactic := fun
| `(tactic| bv_specialize) => do
    doSpecialize
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
info: specializing widths: '[w]'
---
info: Adding equation wEq_0 to goal w v : ℕ
x y : BitVec w
zs : List (BitVec v)
⊢ x = x
---
info: Added equations all widths in goal w v : ℕ
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

