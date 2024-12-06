/-
Released under Apache 2.0 license as described in the file LICENSE.


This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `grind_norm` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Attr
import Lean.Meta.ForEachExpr

import Lean

/--
Denote a bitstream into the underlying bitvector.
-/
def BitStream.denote (s : BitStream) (w : Nat) : BitVec w := s.toBitVec w

@[simp] theorem BitStream.denote_zero : BitStream.denote BitStream.zero w = 0#w := by
  simp [denote, toBitVec]
  sorry

@[simp] theorem BitStream.denote_negOne : BitStream.denote BitStream.negOne w = BitVec.allOnes w := by
  simp [denote, toBitVec]
  sorry


/-- Denote a Term into its underlying bitvector -/
def Term.denote (w : Nat) (t : Term) (vars : List (BitVec w)) : BitVec w :=
  match t with
  | var n => vars[n]!
  | zero => 0#w
  | negOne => BitVec.allOnes w
  | one  => 1#w
  | and a b => (a.denote w vars) &&& (b.denote w vars)
  | or a b => (a.denote w vars) ||| (b.denote w vars)
  | xor a b => (a.denote w vars) ^^^ (b.denote w vars)
  | not a => ~~~ (a.denote w vars)
  | add a b => (a.denote w vars) + (b.denote w vars)
  | sub a b => (a.denote w vars) - (b.denote w vars)
  | neg a => - (a.denote w vars)
  | incr a => (a.denote w vars) + 1#w
  | decr a => (a.denote w vars) - 1#w
  | ls bit a => (a.denote w vars).shiftConcat bit

theorem Term.eval_eq_denote (t : Term) (w : Nat) (vars : List (BitVec w)) :
    (t.eval (vars.map BitStream.ofBitVec)).denote w = t.denote w vars := by
  induction t generalizing w vars
  repeat sorry

def Predicate.denote (p : Predicate) (w : Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .isNeg t => (t.denote w vars).slt (0#w)
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars

/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : List (BitVec w)) :
    (p.eval (vars.map BitStream.ofBitVec) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  repeat sorry

def Reflect.Map.empty : List (BitVec w) := []

def Reflect.Map.append (w : Nat) (s : BitVec w)  (m : List (BitVec w)) : List (BitVec w) := m.append [s]

def Reflect.Map.get (ix : ℕ) (s : BitVec w)  (m : List (BitVec w)) : BitVec w := m[ix]!


namespace NNF
open Lean Elab Meta


/-- convert goal to negation normal form, by running appropriate lemmas from `grind_norm`, and reverting all hypothese. -/
def runNNFSimpSet (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `grind_norm)
    | throwError m!"[nnf] Error: 'grind_norm' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `grind_norm)
    | throwError m!"[nnf] Error: 'grind_norm' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let ctx ← Simp.mkContext (simpTheorems := #[theorems]) (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

open Lean Elab Meta Tactic in
/-- Convert the goal into negation normal form. -/
elab "nnf" : tactic => do
  liftMetaTactic fun g => do
    match ← runNNFSimpSet g with
    | none => return []
    | some g => do
      -- revert after running the simp-set, so that we don't transform
      -- with `forall_and : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x)`.
      -- TODO(@bollu): This opens up an interesting possibility, where we can handle smaller problems
      -- by just working on disjunctions.
      -- let g ← g.revertAll
      return [g]

attribute [grind_norm] BitVec.not_lt
attribute [grind_norm] BitVec.not_le
attribute [- grind_norm] ne_eq -- TODO(bollu): Debate with grind maintainer about having `a ≠ b → ¬ (a = b)` in the simp-set?
@[grind_norm] theorem not_eq_iff_neq : (¬ (a = b)) = (a ≠ b) := by rfl

/--
warning: declaration uses 'sorry'
---
info: w : ℕ
⊢ (∀ (x x_1 : BitVec w), x_1 ≤ x) ∧ ∀ (x x_1 : BitVec w), x ≤ x_1 ∨ x_1 < x ∨ x ≤ x_1 ∨ x ≠ x_1
-/
#guard_msgs in example : ∀ (a b : BitVec w),  ¬ (a < b ∨ a > b ∧ a ≤ b ∧ a > b ∧ (¬ (a ≠ b))) := by
 nnf; trace_state; sorry

end NNF

/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

/-- The free variables in the term that is reflected. -/
structure ReflectMap where
  /-- Map expressions to their index in the eventual `Reflect.Map`. -/
  exprs : Std.HashMap Expr Nat


instance : EmptyCollection ReflectMap where
  emptyCollection := { exprs := ∅ }

abbrev ReflectedExpr := Expr

/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertExpr (m : ReflectMap) (e : Expr) : ReflectedExpr × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  let e :=  mkApp (mkConst ``Term.var) (mkNatLit ix)
  (e, m)
    

/--
Convert the meta-level `ReflectMap` into an object level `Reflect.Map` by
repeatedly calling `Reflect.Map.empty` and `Reflect.Map.set`.
-/
def ReflectMap.toExpr (xs : ReflectMap) (w : Expr) : MetaM ReflectedExpr := do
  let mut out := mkApp (mkConst ``Reflect.Map.empty) w
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.2 < ej.2)
  for (e, _) in exprs do
    -- The 'exprs' will be in order, with 0..n
    /- Append the expressions into the array -/
    out := mkAppN (mkConst ``Reflect.Map.append) #[w, e, out]
  return out

instance : ToMessageData ReflectMap where
  toMessageData exprs := Id.run do
    -- sort in order of index.
    let es := exprs.exprs.toArray.qsort (fun a b => a.2 < b.2)
    let mut lines := es.map (fun (e, i) => m!"{i}→{e}")
    return m!"[" ++ m!" ".joinSep lines.toList ++ m!"]"
/--
Result of reflection, where we have a collection of bitvector variables,
along with the bitwidth and the final term.
-/
structure ReflectResult where
  /-- Map of 'free variables' in the bitvector expression,
  which are indexed as Term.var. This array is used to build the environment for decide.
  -/
  map : ReflectMap
  e : ReflectedExpr

instance : ToMessageData ReflectResult where
  toMessageData result := m!"{result.e} {result.map}"

/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
def reflectTermUnchecked (map : ReflectMap) (_w : Expr) (e : Expr) : MetaM ReflectResult := do
  let (e, map) := map.findOrInsertExpr e
  return { map := map, e := e }

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
def reflectPredicateAux (map : ReflectMap) (e : Expr) : MetaM ReflectResult := do
  match_expr e with
  | Eq α a b =>
    let_expr BitVec w := α | throwError "expected equality of bitvectors"
    let a ←  reflectTermUnchecked map w a
    let b ← reflectTermUnchecked a.map w b
    return { map := b.map, e := mkAppN (mkConst ``Predicate.eq) #[a.e, b.e] }
  | Ne α a b =>
    let_expr BitVec w := α | throwError "expected disequality of bitvectors"
    let a ←  reflectTermUnchecked map w a
    let b ← reflectTermUnchecked a.map w b
    return { map := b.map, e := mkAppN (mkConst ``Predicate.neq) #[a.e, b.e] }
  | _ => throwError "expected predicate over bitvectors (no quantification), found:  {indentD e}"

/-- Name of the tactic -/
def tacName : String := "bv_automata3"
#check congrArg

/-- Find all bitwidths implicated in the given expression,
by visiting subexpressions with visitExpr:
  O(size of expr × inferType)
-/
def findExprBitwidthsAux (target : Expr) : StateT (Std.HashMap Expr Expr) MetaM Unit := do
  forEachExpr target fun e => do
    match_expr ← inferType e with
    | BitVec n => 
      -- TODO(@bollu): do we decide to normalize `n`? upto what?
      modify (fun arr => arr.insert n.cleanupAnnotations e)
    | _ => return ()

/--
Find all bitwidths implicated in the given expression.
Maps each length (the key) to an expression of that length.
-/
def findExprBitwidths (target : Expr) : MetaM (Std.HashMap Expr Expr) := do
  let (_, out) ← StateT.run (findExprBitwidthsAux target) ∅
  return out

/-- Return if expression 'e' is a bitvector of bitwidth 'w' -/
private def Expr.isBitVecOfWidth (e : Expr) (w : Expr) : MetaM Bool := do
  match_expr ← inferType e with
  | BitVec w' => return w == w'
  | _ => return false
    

/-- Revert all bitwidths of a given bitwidth and then run the continuation 'k'.
This allows
-/
def revertBVsOfWidth (g : MVarId) (w : Expr) : MetaM MVarId := g.withContext do
  let mut reverts : Array FVarId := #[]
  for d in ← getLCtx do
    if ← Expr.isBitVecOfWidth d.type w then
      reverts := reverts.push d.fvarId
  /- revert all the bitvectors of the given width in one fell swoop. -/
  let (_fvars, g) ← g.revert reverts
  return g
  

/-- 
Reflect an expression of the form:
  ∀ ⟦(w : Nat)⟧ (← focus)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.
-/
def reflectUniversalWidthBVs (g : MVarId) (target : Expr) : MetaM MVarId := do
  let ws ← findExprBitwidths target
  let ws := ws.toArray
  if h0: ws.size = 0 then throwError "found no bitvector in the target: {indentD target}"
  else if hgt: ws.size > 1 then
    let (w1, wExample1) := ws[0]
    let (w2, wExample2) := ws[1]
    let mExample := f!"{w1} → {wExample1}" ++ f!"{w2} → {wExample2}"
    throwError "found multiple bitvector widths in the target: {indentD mExample}"
  else
    -- we have exactly one width
    let (w, wExample) := ws[0]
    if !w.isFVar then
      throwError "expcted width to be a free variable, found '{w}' (bitwidth with width '{w}' is '{wExample}')"
    else
      -- invariant: w is known to be an fvar.
      let wFvar := w.fvarId!
      let result ← reflectPredicateAux ∅ target
      logInfo m!"result: {result}"
      let target := (mkAppN (mkConst ``Predicate.denote) #[result.e, w, ← result.map.toExpr w])
      let g ← g.replaceTargetDefEq target
      return g
      -- let (_newHyps, g) ← g.revert #[wFvar]
      -- return g

/--
Given a goal state of the form:
  ∀ (w : Nat)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.

decide the property by reduction to finite automata.

TODO(@bollu): Also decide properties about finite widths, by extending to the maximal width and clearing the high bits?
-/
elab "bv_reflect" : tactic => do
  liftMetaTactic fun g => do
    let g ← reflectUniversalWidthBVs g (← g.getType')
    check (Expr.mvar g)
    return [g]

/--
info: result: Predicate.eq (Term.var 0) (Term.var 1) [0→a 1→b]
---
warning: declaration uses 'sorry'
-/
#guard_msgs in example : ∀ (w : Nat) (a b : BitVec w), a = b := by
  intros w a b
  bv_reflect
  apply (Predicate.eval_eq_denote _ _ _).mp
  generalize (List.map _ _) = xs
  clear a b
  revert xs w
  native_decide
  sorry

/-- error: expcted width to be a free variable, found '10' (bitwidth with width '10' is 'b') -/
#guard_msgs in example : ∀ (a b : BitVec 10), a = b := by
  intros a b
  bv_reflect
  sorry

end Reflect

