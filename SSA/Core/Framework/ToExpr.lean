/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import Qq

/-!
## ToExpr instances
Define a `ToExpr` instance for core datastructures

-/
open Lean (ToExpr toExpr MetaM mkAppN mkConst mkApp mkApp2 mkApp6)
open Qq

variable {d : Dialect} [DialectSignature d]
  [Lean.ToExpr d.Ty] [Lean.ToExpr d.Op] [DialectToExpr d]

private def effLeToExpr : {eff eff' : EffectKind} → (h : eff ≤ eff') → Q($eff ≤ $eff')
  | .impure, .impure, _ => q(EffectKind.le_refl .impure)
  | .pure, .pure, _     => q(EffectKind.le_refl .pure)
  | .pure, .impure, _   => q(EffectKind.pure_le .impure)

mutual

partial def Com.toExprAux {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}
    (dE : Q(Dialect) := d.toExpr)
    (sig : Q(DialectSignature $dE))
    (com : Com d Γ eff ty) : Lean.Expr :=
  let ΓE : Q(Ctxt ($dE).Ty) := Lean.toExpr Γ
  let tyE : Q(($dE).Ty) := Lean.toExpr ty
  let effE : Q(EffectKind) := Lean.toExpr eff
  match com with
  | .ret v =>
    let v := toExpr v
    mkAppN (mkConst ``Com.ret) #[dE, sig, ΓE, tyE, effE, v]
  | .var (α := eTy) e body =>
    let eTyE := toExpr eTy
    let e := e.toExprAux dE sig
    let body := body.toExprAux dE sig
    mkAppN (mkConst ``Com.var) #[dE, sig, ΓE, effE, eTyE, tyE, e, body]

partial def Expr.toExprAux {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}
    (dE : Q(Dialect) := d.toExpr)
    (sig : Q(DialectSignature $dE))
    : Expr d Γ eff ty → Lean.Expr :=
  let ΓE : Q(Ctxt ($dE).Ty) := Lean.toExpr Γ
  let tyE : Q(($dE).Ty) := Lean.toExpr ty
  let effE : Q(EffectKind) := Lean.toExpr eff
  fun
  | ⟨op, _ty_eq, eff_le, args, regArgs⟩ =>
    let Ty := mkApp (mkConst ``Dialect.Ty) dE
    let ty_eq : Lean.Expr := mkApp2 (.const ``rfl [1]) Ty tyE
    let eff_le := effLeToExpr eff_le

    let regArgs := Regions.toExprAux dE sig regArgs

    mkAppN (mkConst ``Expr.mk) #[
      dE, sig, effE, ΓE, tyE, toExpr op, ty_eq, eff_le, toExpr args, regArgs
    ]

partial def Regions.toExprAux {regSig : List (Ctxt d.Ty × d.Ty)}
    (dE : Q(Dialect) := d.toExpr)
    (sig : Q(DialectSignature $dE))
    (regs : HVector (fun (t : _ × _) => Com d t.1 EffectKind.impure t.2) regSig) :
    Lean.Expr :=
  let Ty := Lean.toTypeExpr d.Ty
  let A : Lean.Expr := q(fun (t : _ × _) => Com $dE t.1 EffectKind.impure t.2)
  match regSig, regs with
  | [], .nil =>
    mkApp2 (.const ``HVector.nil [0,0]) Ty A
  | a::as, .cons x xs =>
    let a := Lean.toExpr a
    let as := Lean.toExpr as
    let x := x.toExprAux dE sig
    let xs := Regions.toExprAux dE sig xs
    mkApp6 (.const ``HVector.cons [0,0]) Ty A as a x xs

end

variable {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}

/-- Build a (Lean) `Expr` to represent a LeanMLIR program -/
def Com.toExprM (com : Com d Γ eff ty) : MetaM Lean.Expr := do
  let dE := d.toExpr
  let sig ← synthInstanceQ q(DialectSignature $dE)
  return com.toExprAux dE sig

/-- Build a (Lean) `Expr` to represent a LeanMLIR expression -/
def Expr.toExprM (expr : Expr d Γ eff ty) : MetaM Lean.Expr := do
  let dE := d.toExpr
  let sig ← synthInstanceQ q(DialectSignature $dE)
  return expr.toExprAux dE sig
