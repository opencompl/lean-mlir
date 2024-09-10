/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
abbrev Kind := Unit
abbrev ExprKind :=  Unit
 inductive OpKind : Kind → Kind → Type
| const : OpKind () ()

inductive Expr : ExprKind → Type where
| ops: Expr () → Expr () → Expr () -- op ;; ops.

inductive ExprEval {kindMotive : Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o) : Expr ek  → Type where
  | ops (EVAL_OPS: ExprEval opFold ops) : ExprEval opFold (Expr.ops op ops)
