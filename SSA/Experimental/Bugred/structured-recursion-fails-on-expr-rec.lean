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

/--
  A simple expression tree
-/
inductive ExprRec (Op: Type) [OpType Op] where
  /-- constant -/
  | const : Nat → ExprRec Op
  /-- generic operation -/
  | op (o : Op) : Vector (ExprRec Op) (OpType.arity o) → ExprRec Op

/--
  A partially evaluated expression tree
-/
inductive ExprRecEval (Op: Type) [OpType Op] where
  /-- constant -/
  | const : Nat → ExprRecEval Op
  /-- sum a specific number of arguments (non-variadic, but arbirary number of operands) -/
  | op (o : Op) : Vector (ExprRecEval Op) n → Vector Nat m → (n + m = (OpType.arity o)) → ExprRecEval Op


variable {Op: Type} [OpType Op]

def ExprRecEval.eval : ExprRecEval Op → Nat
  | .const n => n
  | .op o .nil xs h => OpType.eval o (cast (by simp_all) xs)
  | .op o (.cons e es) xs h => eval (.op o es (.cons (eval e) xs) (by rw[←h]; linarith))
