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

-- Invariant: returns values in WHNF.
def getBitVecTypeWidth? (t : Expr) : MetaM (Option Expr) := do
  let t ← instantiateMVars t
  let t ← whnf t
  match_expr t with
  | BitVec w => return some (← whnf w)
  | _ => return none

-- In the expr, return widths.
partial def getBitVecTypeWidths (t : Expr) (out : Std.HashSet Expr) :
    MetaM (Std.HashSet Expr) := do
  if let some w ← getBitVecTypeWidth? t then do
    -- ↓ BV 1 is special, since BV 1 is isomorphic to Bool.
    if let some 1 ← getNatValue? w then
      return out
    return out.insert w
  else
    let (_f, args) := t.getAppFnArgs
    let mut out := out
    for arg in args do
      out ← getBitVecTypeWidths arg out
    return out

-- | This is mega-scuffed. We only use the args to check if we have a 'BitVec 1'
-- call. 
-- TODO: fold in the arg checking into getBitVecTypeWidths.
def genTable.getGenTable (n : Name) (args : Array Expr) : GenM (Option (Array Bool)) := do
  -- | Only special case, as it is a type constructor.
  -- All other constants are theorems, defs, etc.
  if n == ``BitVec then
    if hx : args.size ≠ 1 then
      throwError "BitVec expected 1 argument, got {args.size}"
    else
      -- BitVec 1 is isomorphic to Bool, so we don't generalize it.
      if let some 1 ← Meta.getNatValue? args[0] then
        return some #[false]
      -- Otherwise, generalize the width.
      return some #[true]
  -- TODO: make this better. Right now, we only disable 'BitVec 1'.
  -- But in general, we should disable any occurrence of 'BitVec 1'

  let constInfo ← getConstInfo n
  let ty := constInfo.type
  withTraceNode `WidthGeneralize
    (fun _ => return m!"genTable.getGenTable for {n}") do
      forallTelescope ty fun xs ret => do
        trace[WidthGeneralize] m!"getGenTable for {n} : {xs} → {ret}"
        let mut widths : Std.HashSet Expr := {}
        for x in xs do
          let ty ← inferType x
          -- TODO: add an assertion that ty is
          -- Bool, Nat, Int, or BitVec w.
          -- This lets us say that we are in the first order
          -- fragment with sorts Nat, Int, Bool, and BitVec w.
          trace[WidthGeneralize] m!"inspecting arg {x} : {ty}"
          widths ← getBitVecTypeWidths ty widths
        -- TODO: see that this needs to recurse,
        -- since we have instAdd : w -> Add (BitVec w),
        -- which needs us to recurse into Add (BitVec w)
        -- to learn that 'w' is a width.
        widths ← getBitVecTypeWidths ret widths
        trace[WidthGeneralize] m!"found concrete widths: {widths.toArray}"
        let mut out := #[]
        for (x, arg) in xs.zip args do
          -- | guard against BitVec.ofBool b -> BitVec 1
          if let some 1 ← getNatValue? arg then
            trace[WidthGeneralize] m!"arg {arg} is BitVec 1, skipping width generalization"
            out := out.push false
            continue
          let x ← whnf x
          let isWidth := widths.contains x
          trace[WidthGeneralize] m!"inspecting concrete arg {x} isWidth: {isWidth}"
          out := out.push isWidth
        trace[WidthGeneralize] m!"genTable for {n} @ {out}"
        return some out

    -- match genTable.find? n with
    -- | some arr =>
    --   if arr.size == xs.size then
    --     return some arr
    --   else
    --     return none
    -- | none => return none


partial def visit (t : Expr) : GenM Expr := do
  let t ← instantiateMVars t
  match t with
  | .app _ _ =>
    let f := t.getAppFn
    let args := t.getAppArgs
    let table ←
      if let some (f, _) := f.const? then do
        let out ← genTable.getGenTable f args
        pure out
      else
        pure none
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
      let n := 2 * i + 5
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
#guard_msgs in theorem test_bv_generalize_simple
  (x y : BitVec 32) (zs : List (BitVec 44)) :
    x = x := by
  bv_generalize
  trace_state

/-- trace: ⊢ ∀ (x y : BitVec 5) (zs : List (BitVec 7)), x = x -/
#guard_msgs in theorem test_bv_generalize_simple_spec (x y : BitVec 32) (zs : List (BitVec 44)) :
    x = x := by
  bv_generalize +specialize
  trace_state
  bv_decide

/--
trace: ⊢ ∀ (w w_1 w_2 : ℕ) (x y : BitVec w_1) (zs : List (BitVec w_2)) (z : BitVec w),
    52 + 10 = 42 → x = y → BitVec.zeroExtend w x = BitVec.zeroExtend w y + 0
---
warning: declaration uses 'sorry'
-/
#guard_msgs in theorem test_bv_generalize
      (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10)
      (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize
  trace_state
  sorry

/--
trace: ⊢ ∀ (w w_1 w_2 : ℕ) (x y : BitVec w_1) (zs : List (BitVec w_2)) (z : BitVec w),
    52 + 10 = 42 → x = y → BitVec.zeroExtend w x = BitVec.zeroExtend w y + 0
---
warning: declaration uses 'sorry'
-/
#guard_msgs in theorem test_bv_generalize_spec (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) :
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize
  trace_state
  sorry


open BitVec

/-- trace: ⊢ ∀ (x : BitVec 7), zeroExtend 7 (truncate 5 x) = x &&& 4294967295#7 -/
#guard_msgs in theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64),
  zeroExtend 64 (truncate 32 x) = x &&& 4294967295#64 := by
    intros
    bv_generalize +specialize
    trace_state
    sorry

/--
trace: ⊢ ∀ (w : ℕ) (x : BitVec 1) (y : BitVec w), x = x
---
warning: declaration uses 'sorry'
---
warning: 'intros' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
-/
#guard_msgs in theorem test_no_generalize_1 (x : BitVec 1) (y : BitVec 2) : x = x := by
   intros 
   bv_generalize
   trace_state
   sorry

end Tactic
end WidthGeneralize
