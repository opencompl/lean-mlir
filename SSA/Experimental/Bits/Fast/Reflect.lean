/-
Released under Apache 2.0 license as described in the file LICENSE.


This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
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
def Term.denote (w : Nat) (t : Term) (vars : ℕ → BitVec w) : BitVec w :=
  match t with
  | var n => (vars n)
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

theorem Term.eval_eq_denote (t : Term) (w : Nat) (vars : ℕ → BitVec w) :
    (t.eval (fun i => BitStream.ofBitVec (vars i))).denote w = t.denote w vars := by
  induction t generalizing w vars
  repeat sorry

def Predicate.denote (p : Predicate) (w : Nat) (vars : ℕ → BitVec w) : Prop :=
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
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : ℕ → BitVec w) :
    (p.eval (fun i => BitStream.ofBitVec (vars i)) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  repeat sorry

def Reflect.Map.empty : ℕ → BitVec w := fun _ => 0#w
def Reflect.Map.set (s : BitVec w) (ix : ℕ)  (m : ℕ → BitVec w) : ℕ → BitVec w := fun j => if j = ix then s else m ix

/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic


structure ReflectResult where
  map : Array Expr
  e : Expr
  w : Expr

/-
return a new expression that this is defeq to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `Term.denote`,
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
def reflectTermUnchecked (map : Array Expr) (w : Expr) (e : Expr) : OptionT MetaM ReflectResult := do
  let ix := map.size
  let map := map.push e
  return { map := map, e := mkApp (mkConst ``Term.var) (mkNatLit ix), w := w }

/- return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
def reflectPredicate (map : Array Expr) (e : Expr)  : OptionT MetaM ReflectResult := do
  match_expr e with
  | Eq α a b =>
    let_expr BitVec w := α | OptionT.fail
    let a ←  reflectTermUnchecked map w a
    let b ← reflectTermUnchecked a.map w b
    return { map := b.map, e := mkAppN (mkConst ``Predicate.eq) #[a.e, b.e], w := w }
  | _ => OptionT.fail

/-- convert the map back into an expression. -/
def mapToExpr (xs : Array Expr) : MetaM Expr := do
  let mut out := mkConst ``Reflect.Map.empty
  let mut i := 0
  for e in xs do
    /- Append the expressions into the array -/
    out := mkAppN (mkConst ``Reflect.Map.set) #[e, mkNatLit i, out]
    i := i + 1
  return out

elab "bv_automata2" : tactic => do
  liftMetaFinishingTactic fun g => do
    let .some p ← reflectPredicate #[] (← g.getType')
      | throwError "unable to reflect predicate at goal {g}"
    let target' := (mkAppN (mkConst ``Predicate.denote) #[p.w, ← mapToExpr p.map])
    logInfo m!"target': {target'}"
    let g ← g.replaceTargetDefEq target'
    -- next, rewrite with eval_eq_denote.mp
    -- Finally, apply native_decide.
    -- g.nativeDecide

    return ()

end Reflect

