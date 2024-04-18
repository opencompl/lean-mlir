import SSA.Core.Framework
import Qq

/-!
# Meta Dialect
This file sets up a generic "meta" dialect, which serves as a mid-point between having a Lean `Expr`
of type `Com`, and having an object level `Com`.

-/

namespace SSA

variable (Op) {Ty} [OpSignature Op Ty] [Lean.ToExpr Op] [Lean.ToExpr Ty]

def MetaOp : Type :=
  { e : Lean.Expr // ∃ (op : Op), e = Lean.toExpr op }

def MetaTy : Type :=
  { e : Lean.Expr // ∃ (ty : Ty), e = Lean.toExpr ty }
