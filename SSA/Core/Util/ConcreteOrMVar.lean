import Mathlib.Data.Fin.Basic
import Mathlib.Data.Vector.Basic
-- import Mathlib.Tactic


/--
  A general type that is either a concrete known value of type `α`, or one of `φ` metavariables
 -/
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

end ConcreteOrMVar
