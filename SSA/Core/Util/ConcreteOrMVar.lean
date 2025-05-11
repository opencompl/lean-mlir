/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Vector.Basic
-- import Mathlib.Tactic


/--
  A general type that is either a concrete known value of type `α`, or one of `φ` metavariables
 -/
inductive ConcreteOrMVar (α : Type u) (φ : Nat)
  | concrete (a : α)
  | mvar (i : Fin φ)
  deriving DecidableEq, Inhabited, Lean.ToExpr

-- TODO: consolidate into a single "toGeneric", that converts these
-- back into MLIR data structures.

instance : Repr (ConcreteOrMVar Nat φ) where
  reprPrec x _prec :=
    match x with
    | .concrete a => f!"i{a}"
    | .mvar i => f!"mvar({i})"

open Lean in
instance : ToFormat (ConcreteOrMVar Nat φ) where
  format x :=
    match x with
    | .concrete a => f!"i{a}"
    | .mvar i => f!"mvar({i})"

instance : ToString (ConcreteOrMVar Nat φ) where
  toString x :=
    match x with
    | .concrete a => s!"i{a}"
    | .mvar i => s!"mvar({i})"

/-- A coercion from the concrete type `α` to the `ConcreteOrMVar` -/
instance : Coe α (ConcreteOrMVar α φ) := ⟨.concrete⟩

/- In the specific case of `α := Nat`, we'd like to be able to use nat literals -/
instance : OfNat (ConcreteOrMVar Nat φ) n := ⟨.concrete n⟩

namespace ConcreteOrMVar

/-- If there are no meta-variables, `ConcreteOrMVar` is just the concrete type `α` -/
def toConcrete : ConcreteOrMVar α 0 → α
  | .concrete a => a

@[simp]
theorem toConcrete_concrete : toConcrete (.concrete a) = a := rfl

/--
  Provide a value for one of the metavariables.
  Specifically, the metavariable with the maximal index `φ` out of `φ+1` total metavariables.
  All other metavariables indices' are left as-is, but cast to `Fin φ` -/
def instantiateOne (a : α) : ConcreteOrMVar α (φ+1) → ConcreteOrMVar α φ
  | .concrete w => .concrete w
  | .mvar i => i.lastCases
      (.concrete a)       -- `i = Fin.last`
      (fun j => .mvar j)  -- `i = Fin.castSucc j`

/-- Instantiate all meta-variables using values -/
def instantiate (as : List.Vector α φ) : ConcreteOrMVar α φ → α
  | .concrete w => w
  | .mvar i => as.get i

open Lean in
/-- Instantiate all meta-variables using Lean expressions,
resulting in a Lean expression of type `α`. -/
def metaInstantiate [ToExpr α] (as : Vector Lean.Expr φ) : ConcreteOrMVar α φ → Lean.Expr
  | .concrete w => toExpr w
  | .mvar i => as[i]

/-- We choose ConcreteOrMVar.concrete to be our simp normal form. -/
@[simp]
def ofNat_eq_concrete (x : Nat) :
    (OfNat.ofNat x) = (ConcreteOrMVar.concrete x : ConcreteOrMVar Nat φ) := rfl

@[simp]
def instantiate_ofNat_eq (as : List.Vector Nat φ) (x : Nat) :
   ConcreteOrMVar.instantiate as (OfNat.ofNat x) = x := rfl

@[simp]
lemma instantiate_mvar_zero {hφ : List.length (w :: ws) = φ} {h0 : 0 < φ} :
    ConcreteOrMVar.instantiate (Subtype.mk (w :: ws) hφ)  (ConcreteOrMVar.mvar ⟨0, h0⟩) = w := by
  simp [instantiate]
  simp [List.Vector.get]

@[simp]
lemma instantiate_mvar_zero' :
    (mvar (φ := 1) ⟨0, by simp⟩).instantiate (Subtype.mk [w] (by simp)) = w := rfl

@[simp]
lemma instantiate_mvar_zero'' :
    (mvar (φ := 1) 0).instantiate (Subtype.mk [w] h1) = w := rfl

end ConcreteOrMVar
