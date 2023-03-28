import SSA.DependentTypedSSA.Semantics

namespace AST

open Kind

inductive subEnv' : Kind → Type
| sub : subEnv' ((Kind.int.pair .int).arrow .int)

def subEnv : Env := subEnv'

def x_sub_x : Expr subEnv (Context.single Kind.int) .int :=
  Expr._let (subEnv'.sub) (Tuple.pair (Tuple.var ⟨rfl⟩) (Tuple.var ⟨rfl⟩)) <|
  Expr.retμrn Var.zero

def subSem : Semantics subEnv
  | _, subEnv'.sub => fun x => x.1 - x.2

theorem eval_x_sub_x : x_sub_x.eval subSem = fun _ => 0 := by
  simp [x_sub_x, subSem]

end AST