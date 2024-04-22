/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Vector.Basic
-- import Mathlib.Tactic


/--
  A general type that is either a concrete known value of type `α`, or one of `φ` metavariables
 -/
  -- TODO: Fin's story of normal forms is complex.
  -- For example, `(0 : Fin (.succ n))` and `(⟨0, by ...⟩ : Fin n)`,
  --  are two ways of spelling the same object.
  -- However, neither is superior, so it's unclear what the normal form should be.
  -- Rather, let's move the proof into the mvar,
  -- so that the user and our framework never encounters `Fin`.
inductive ConcreteOrMVar (α : Type u) (φ : Nat)
  | concrete (a : α)
  | mvar (i : Fin φ)
  deriving DecidableEq, Repr, Inhabited

instance [ToString α] : ToString (ConcreteOrMVar α n) where
  toString
  | .concrete a => s!"concrete({a})"
  | .mvar i => s!"mvar({i})"
/-- A coercion from the concrete type `α` to the `ConcreteOrMVar` -/
instance : Coe α (ConcreteOrMVar α φ) := ⟨.concrete⟩

/- In the specific case of `α := Nat`, we'd like to be able to use nat literals -/
instance : OfNat (ConcreteOrMVar Nat φ) n := ⟨.concrete n⟩

namespace ConcreteOrMVar

/- Terse notation for concrete and mvar. -/
namespace Notation
scoped notation "i" n => ConcreteOrMVar.concrete n
scoped notation "i?" f => ConcreteOrMVar.mvar f
end Notation

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

/-- Instantiate all meta-variables -/
def instantiate (as : Vector α φ) : ConcreteOrMVar α φ → α
  | .concrete w => w
  | .mvar i => as.get i

@[simp]
def instantiate_concrete_eq (as : Vector α φ) :
  (ConcreteOrMVar.concrete w).instantiate as = w := by rfl

@[simp]
lemma instantiate_mvar_zero {hφ : List.length (w :: ws) = φ} {h0 : 0 < φ} :
    ConcreteOrMVar.instantiate (Subtype.mk (w :: ws) hφ)  (ConcreteOrMVar.mvar ⟨0, h0⟩) = w := by
  simp [instantiate]
  simp [Vector.get]
  simp [List.nthLe]

@[simp]
lemma instantiate_mvar_zero' :
    (mvar (φ := 1) ⟨0, by simp⟩).instantiate (Subtype.mk [w] (by simp)) = w := by
  rfl

set_option pp.proofs.withType true in
@[simp]
lemma instantiate_mvar_zero'' :
    (mvar (φ := 1) 0).instantiate (Subtype.mk [w] h1) = w := by
  rfl


-- @[simp]
-- lemma instantiate_mvar_succ (hφ : List.length (w :: ws) = φ := by rfl) (hsucci : i+1 < φ := by omega):
--     (mvar ⟨i+1, hsucci⟩).instantiate (Subtype.mk (w :: ws) hφ) =
--     (mvar ⟨i, by sorry⟩).instantiate (Subtype.mk ws (by rfl)) := by rfl

end ConcreteOrMVar
