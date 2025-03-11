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

def effLeToExpr : {eff eff' : EffectKind} → (h : eff ≤ eff') → Q($eff ≤ $eff')
  | .impure, .impure, _ => q(EffectKind.le_refl .impure)
  | .pure, .pure, _     => q(EffectKind.le_refl .pure)
  | .pure, .impure, _   => q(EffectKind.pure_le .impure)

open DialectSignature in
/--
A dialect morphism represents a mapping from programs in the source dialect `d`
into Lean *expressions* representing programs in the target dialect `d'`.

`d` and `d'` could be the same dialect, in which case the morphism represents a
straightforward `toExpr` transform (see also `DialectMorphism.id`).

Alternatively, `d` could be a meta dialect with, e.g., embedded Lean expressions
(i.e., anti-quotations). The morphism abstractions allows us to transparently
emit such embedded anti-quotations when transforming a meta-time object into
a Lean expression.
-/
structure DialectMetaMorphism (d : Dialect) [DialectSignature d] (d' : Q(Dialect)) where
  /-- Map a source Operation into an expression of a target Operation -/
  mapOp : d.Op → Q(($d').Op)
  /-- Map a source Type into an expression of a target Type -/
  mapTy : d.Ty → Q(($d').Ty)
  /-- Transport a proof that `effectKind op ≤ eff` to
      an expression of a proof that `effectKind (mapOp op) ≤ eff`.

      NOTE: the default implementation assumes that `mapOp` preserves the
            effectKind of mapped operations.
  -/
  mapEffLe {op : d.Op} {eff : EffectKind} (h : effectKind op ≤ eff) : Lean.Expr :=
    effLeToExpr h

open DialectToExpr (toExprDialect)
/-- The trivial identity morphism, which maps programs in dialect `d` to
*expressions* of programs in dialect `d`.

That is, this morphism represents a straightforward `toExpr` transformation. -/
def DialectMetaMorphism.id (d : Dialect) [DialectSignature d]
    [ToExpr d.Op] [ToExpr d.Ty] [DialectToExpr d] :
    DialectMetaMorphism d (toExprDialect d) where
  mapOp := toExpr
  mapTy := toExpr


variable {d'} (f : DialectMetaMorphism d d') in
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
  let tyE : Q(($dE).Ty) := f.mapTy ty
  let effE : Q(EffectKind) := Lean.toExpr eff
  fun
  | ⟨op, _ty_eq, eff_le, args, regArgs⟩ =>
    let Ty := mkApp (mkConst ``Dialect.Ty) dE
    let op := f.mapOp op
    let ty_eq : Lean.Expr := mkApp2 (.const ``rfl [1]) Ty tyE
    let eff_le := f.mapEffLe eff_le

    let regArgs := Regions.toExprAux dE sig regArgs

    mkAppN (mkConst ``Expr.mk) #[
      dE, sig, effE, ΓE, tyE, op, ty_eq, eff_le, toExpr args, regArgs
    ]

partial def Regions.toExprAux {regSig : List (Ctxt d.Ty × d.Ty)}
    (dE : Q(Dialect) := d.toExpr)
    (sig : Q(DialectSignature $dE))
    (regs : HVector (fun (t : _ × _) => Com d t.1 EffectKind.impure t.2) regSig) :
    Lean.Expr :=
  let α := q(Ctxt ($dE).Ty × ($dE).Ty)
  let A :=
    q(fun (t : Ctxt ($dE).Ty × ($dE).Ty) => Com $dE t.1 EffectKind.impure t.2)
  match regSig, regs with
  | [], .nil =>
    mkApp2 (.const ``HVector.nil [0,0]) α A
  | a::as, .cons x xs =>
    let a := Lean.toExpr a
    let as := Lean.toExpr as
    let x := x.toExprAux dE sig
    let xs := Regions.toExprAux dE sig xs
    mkApp6 (.const ``HVector.cons [0,0]) α A as a x xs

end

variable {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}

/-!
## MetaMap helper
-/
section Map

/-- Map a meta morphism over a LeanMLIR program, to obtain a (Lean) `Expr` representing
the mapped program. -/
def Com.metaMap (com : Com d Γ eff ty) (f : DialectMetaMorphism d d') : MetaM Lean.Expr := do
  let dE := d.toExpr
  let sig ← synthInstanceQ q(DialectSignature $dE)
  return com.toExprAux f dE sig

/-- Map a meta morphism over a LeanMLIR expression, to obtain a (Lean) `Expr`
representing the mapped expression. -/
def Expr.metaMap (expr : Expr d Γ eff ty) (f : DialectMetaMorphism d d') : MetaM Lean.Expr := do
  let dE := d.toExpr
  let sig ← synthInstanceQ q(DialectSignature $dE)
  return expr.toExprAux f dE sig

/-!
## ToExpr
-/

/-- Build a (Lean) `Expr` to represent a LeanMLIR program. -/
def Com.toExprM (com : Com d Γ eff ty) : MetaM Lean.Expr := com.metaMap (.id _)

/-- Build a (Lean) `Expr` to represent a LeanMLIR expression. -/
def Expr.toExprM (expr : Expr d Γ eff ty) : MetaM Lean.Expr := expr.metaMap (.id _)
