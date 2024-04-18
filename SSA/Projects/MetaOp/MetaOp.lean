import SSA.Core.Framework
import Qq

/-!
# Meta Dialect
This file sets up a generic "meta" dialect, which serves as a mid-point between having a Lean `Expr`
of type `Com`, and having an object level `Com`.

-/

namespace SSA

def MetaOp (Op : Type) [Lean.ToExpr Op] : Type :=
  { e : Lean.Expr // ∃ (op : Op), e = Lean.toExpr op }

def MetaTy (Ty : Type) [Lean.ToExpr Ty] : Type :=
  { e : Lean.Expr // ∃ (ty : Ty), e = Lean.toExpr ty }

/-
NOTE: the current approach checks that the expr `e` is *syntactically equal* to `Lean.toExpr op`/`ty`,
which effectively mandates that `e` is in normal form (since that is most likely the form that
`toExpr` produces).

We'd like to weaken the assumption to just require that `e` is *def-eq*, but `isDefEq` operates in
`MetaM`. I'm not sure how to state "`e` is def-eq to `Lean.toExpr op`" as a `Prop`. -/

variable (Op) {Ty} [Lean.ToExpr Op] [Lean.ToExpr Ty]

noncomputable instance [OpSignature Op Ty] : OpSignature (MetaOp Op) (MetaTy Ty) where
  signature := fun ⟨_, h_eq⟩ =>
    have op : Op := h_eq.choose
    (fun ty => ⟨Lean.toExpr ty, by use ty⟩) <$> OpSignature.signature op
