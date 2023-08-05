import Mathlib.Algebra.Order.Ring.Canonical
import Mathlib.Data.Nat.Basic

instance : OrderedCancelAddCommMonoid ℕ :=
  { Nat.commSemiring, Nat.linearOrder with
    lt := Nat.lt, add_le_add_left := @Nat.add_le_add_left,
    le_of_add_le_add_left := @Nat.le_of_add_le_add_left,
  }

-- The failure seems specific to that instance, if we have a different instance with `sorry`,
-- then the mutual def below will compile without failure
-- instance : OrderedCancelAddCommMonoid ℕ := sorry

mutual
  inductive Expr : Type
    | add : Nat → Com → Expr
    | zero : Expr

  inductive Com : Type
    | ret : Expr → Com
end

mutual
  -- `fail to show termination`, but only if the `OrderedCancelAddCommMonoid` instance is defined
  def Expr.eval : Expr → Nat
    | .add m c => m + c.eval
    | .zero => 0

  def Com.eval : Com → Nat
    | .ret e => e.eval
end