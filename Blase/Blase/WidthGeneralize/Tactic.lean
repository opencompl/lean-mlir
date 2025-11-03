import Mathlib.Data.Fintype.Defs
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.MultiWidth.Preprocessing
import Blase.KInduction.KInduction
import Blase.AutoStructs.FormulaToAuto
import Blase.ReflectMap
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
  table := table.insert ``BitVec.signExtend #[true, true, false]
  table := table.insert ``BitVec.truncate #[true, true, false]
  table := table.insert ``BitVec.instOfNat #[true, false, false]
  -- table := table.insert ``instHAndOfAndOp #[true, false, false]
  table := table.insert ``BitVec.instAndOp #[true]
  table := table.insert ``BitVec.instAdd #[true]
  table := table.insert ``BitVec.instSub #[true]
  table := table.insert ``BitVec.instMul #[true]
  table := table.insert ``BitVec.instDiv #[true]
  table := table.insert ``BitVec.instOfNat #[true, false]
  table := table.insert ``BitVec.ofNat #[true, false]
  table

partial def visit (t : Expr) : GenM Expr := do
  let t ← instantiateMVars t
  match t with
  | .app _ _ =>
    let f := t.getAppFn
    let args := t.getAppArgs
    let table :=
      if let some (f, _) := f.const? then
        genTable[f]?
      else
        none
    let bv? (n : Nat) :=
      match table with
      | .some xs => xs.getD n false
      | .none => false
    args.zipIdx.foldlM (init := f) fun res (arg, i) => do
      let arg ← if bv? i then State.add? arg else visit arg
      pure <| .app res arg
  | .forallE n e₁ e₂ info =>
    pure <| .forallE n (← visit e₁) (← visit e₂) info
  | e =>
    pure e

def doBvGeneralize (g : MVarId) : GenM (Expr × MVarId) := do
  let lctx ← getLCtx
  let mut allFVars := #[]
  for h in lctx do
    if not h.isImplementationDetail then
      allFVars := allFVars.push h.fvarId
  let (_, g) ← g.revert allFVars
  let e ← visit (← g.getType)
  let mut newVars := #[]
  for x in (←get).mapping.elements do
    newVars := newVars.push x

  let e ← mkForallFVars newVars e (binderInfoForMVars := .default)
  let e ← instantiateMVars e
  pure (e, g)

axiom specializeAxiom : ∀ P, P

def specializeGoal (g : MVarId) (lengthCount : Nat) : TacticM Unit := do
  let t ← g.getType
  let newT ← forallTelescope t fun xs t => do
    let mut t := t
    let mut substs := FVarSubst.empty
    for i in [0:lengthCount] do
      let n := 2 * i + 1
      substs := substs.insert xs[i]!.fvarId! (mkNatLit n)
    let ys := xs.drop lengthCount
    let newT ← mkForallFVars ys t (binderInfoForMVars := .default)
    pure <| substs.apply newT
  let newGoal ← mkFreshExprMVar (some newT)
  let sorryExpr ← mkAppM ``specializeAxiom #[t]
  g.assign sorryExpr
  replaceMainGoal [newGoal.mvarId!]

structure GenConfig where
  specialize : Bool := false

declare_config_elab elabGenConfig GenConfig

/--
This tactic tries to generalize the bitvector widths, and only the bitvector
widths. See `genTable` if the tactic fails to generalize the right parameters
of a function over bitvectors.
-/
syntax (name := bvGeneralize) "bv_generalize" Lean.Parser.Tactic.optConfig : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize $cfg) => do
  let cfg ← elabGenConfig cfg
  let g₀ ← getMainGoal
  g₀.withContext do
    let ((e, g), s) ← (doBvGeneralize g₀).run default
    g.withContext do
      let g' ← mkFreshExprMVar (some e)
      let mut newVals := #[]
      for x in s.mapping.elements do
        newVals := newVals.push (s.invMapping[x]!)
      g.assign <| mkAppN g' newVals
      replaceMainGoal [g'.mvarId!]
      if cfg.specialize then
        specializeGoal g'.mvarId! s.invMapping.size
| _ => throwUnsupportedSyntax

-- TODO: the `bv_generalize` tactic fails when a bit vector is already width generic

/--
error: unsolved goals
⊢ ∀ (w w_1 : ℕ) (x y : BitVec w) (zs : List (BitVec w_1)), x = x
---
trace: ⊢ ∀ (w w_1 : ℕ) (x y : BitVec w) (zs : List (BitVec w_1)), x = x
-/
#guard_msgs in theorem test_bv_generalize_simple (x y : BitVec 32) (zs : List (BitVec 44)) :
    x = x := by
  bv_generalize
  trace_state

/-- trace: ⊢ ∀ (x y : BitVec 1) (zs : List (BitVec 3)), x = x -/
#guard_msgs in theorem test_bv_generalize_simple_spec (x y : BitVec 32) (zs : List (BitVec 44)) :
    x = x := by
  bv_generalize +specialize
  trace_state
  bv_decide

/--
error: unsolved goals
⊢ ∀ (w w_1 w_2 : ℕ) (x y : BitVec w_1) (zs : List (BitVec w_2)) (z : BitVec w),
    52 + 10 = 42 → x = y → BitVec.zeroExtend w x = BitVec.zeroExtend w y + 0
---
trace: ⊢ ∀ (w w_1 w_2 : ℕ) (x y : BitVec w_1) (zs : List (BitVec w_2)) (z : BitVec w),
    52 + 10 = 42 → x = y → BitVec.zeroExtend w x = BitVec.zeroExtend w y + 0
-/
#guard_msgs in theorem test_bv_generalize (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize
  trace_state

/--
trace: ⊢ ∀ (x y : BitVec 3) (zs : List (BitVec 5)) (z : BitVec 1),
    52 + 10 = 42 → x = y → BitVec.zeroExtend 1 x = BitVec.zeroExtend 1 y + 0
-/
#guard_msgs in theorem test_bv_generalize_spec (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize +specialize
  trace_state
  bv_decide

open BitVec

-- (kernel) application type mismatch
--   instHAndOfAndOp
-- argument has type
--   AndOp (BitVec 64)
-- but function has type
--   [AndOp (BitVec w)] → HAnd (BitVec w) (BitVec w) (BitVec w)

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64),
  zeroExtend 64 (truncate 32 x) = x &&& 4294967295#64 := by
    intros
    bv_generalize +specialize
    sorry



end Tactic
end WidthGeneralize
