import Mathlib.Tactic.Linarith

inductive Vector (α : Type) : Nat → Type
  | nil : Vector α 0
  | cons : α → Vector α n → Vector α (n+1)


def Vector.sum : Vector Nat n → Nat
  | nil => 0
  | cons x xs => x + sum xs


class OpType (Op : Type) where
  arity : Op → Nat
  eval (o : Op) : Vector Nat (arity o) → Nat

export OpType (arity)

/--
  A simple expression tree
-/
inductive ExprRec (Op: Type) [OpType Op] : Nat → Type where
  /-- generic operation -/
  | op (o : Op) : Vector (ExprRec Op 0) n → Vector Nat m → (n + m = arity o) → ExprRec Op m


variable {Op: Type} [OpType Op]


def ExprRec.eval : ExprRec Op m → Nat
  | .op o .nil xs h => OpType.eval o (cast (by simp_all) xs)
  | .op o (.cons e es) xs h => eval (.op o es (.cons (eval e) xs) (by rw[←h]; linarith))