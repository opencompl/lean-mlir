/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import Qq

/-!
## ToExpr instances
Define a `ToExpr` instance for core datastructures

-/
open Lean (ToExpr toExpr MetaM mkAppN mkConst mkApp mkApp2 mkApp3 mkApp4 mkApp6)
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

/-- Obtain an Lean expression of a list, from a list of Lean expressions. -/
protected def List.foldToExpr {α : Q(Type)} : List Q($α) → Q(List $α) :=
  List.foldr (fun a as => q($a :: $as)) q([])
/-- Obtain an Lean expression of a product, from a product of Lean expressions. -/
protected def Prod.foldToExpr {α β : Q(Type)} : Q($α) × Q($β) → Q($α × $β) :=
  Function.uncurry <| mkApp4 (.const ``Prod [1,1]) α β

namespace DialectMetaMorphism

variable {d'} (f : DialectMetaMorphism d d')

def mapList (Γ : List d.Ty) : Q(List $(d').Ty) := (f.mapTy <$> Γ).foldToExpr
def mapCtxt (Γ : Ctxt d.Ty) : Q(Ctxt $(d').Ty) :=
  let Γ := f.mapList Γ.toList
  q(Ctxt.ofList $Γ)

def mapVar {Γ : Ctxt d.Ty} (v : Γ.Var ty) : Q(Ctxt.Var $(f.mapCtxt Γ) $(f.mapTy ty)) :=
  let Ty := q(($d').Ty)
  let Γ := f.mapCtxt Γ
  let ty := f.mapTy ty
  let i := toExpr v.1
  Ctxt.mkVar Ty Γ ty i none

def mapVarVec {Γ : Ctxt d.Ty} {argSig} (args : HVector (Γ.Var) argSig) :
    Q(HVector (Ctxt.Var $(f.mapCtxt Γ)) $(f.mapList argSig)) :=
  let Ty : Q(Type) := q(($d').Ty)
  let Γ := f.mapCtxt Γ
  let A : Q($Ty → Type) := q(($Γ).Var)
  let nil : (ts : Q(List $Ty)) × Q(HVector $A $ts) := ⟨q([]), q(.nil)⟩
  let res := (args.foldr · nil) <| fun t v ⟨ts, xs⟩ =>
    let t := f.mapTy t
    let v := Ctxt.mkVar Ty Γ t (toExpr v.1) none
    ⟨q($t :: $ts), q($v ::ₕ $xs)⟩
  res.snd

end DialectMetaMorphism

variable {d'} (f : DialectMetaMorphism d d')
  (dE : Q(Dialect)) (sig : Q(DialectSignature $dE)) in
mutual

partial def Com.toExprAux {Γ : Ctxt d.Ty} {eff : EffectKind} {ty}
    (com : Com d Γ eff ty) : Lean.Expr :=
  let ΓE : Q(Ctxt ($dE).Ty) := f.mapCtxt Γ
  let tyE : Q(List ($dE).Ty) := f.mapList ty
  let effE : Q(EffectKind) := Lean.toExpr eff
  match com with
  | .rets vs =>
    let vs := f.mapVarVec vs
    mkAppN (mkConst ``Com.rets) #[dE, sig, ΓE, tyE, effE, vs]
  | .var (ty := eTy) e body =>
    let eTyE := f.mapList eTy
    let e := e.toExprAux
    let body := body.toExprAux
    mkAppN (mkConst ``Com.var) #[dE, sig, ΓE, effE, eTyE, tyE, e, body]

partial def Expr.toExprAux {Γ : Ctxt d.Ty} {eff : EffectKind} {ty} :
    Expr d Γ eff ty → Lean.Expr :=
  let ΓE : Q(Ctxt ($dE).Ty) := f.mapCtxt Γ
  let tyE : Q(List ($dE).Ty) := f.mapList ty
  let effE : Q(EffectKind) := Lean.toExpr eff
  fun
  | ⟨op, _ty_eq, eff_le, args, regArgs⟩ =>
    let Ty : Q(Type) := mkApp (mkConst ``Dialect.Ty) dE
    let op := f.mapOp op
    let ty_eq : Lean.Expr := mkApp2 (.const ``rfl [1]) q(List $Ty) tyE
    let eff_le := f.mapEffLe eff_le

    let args := f.mapVarVec args
    let regArgs := Regions.toExprAux regArgs

    mkAppN (mkConst ``Expr.mk) #[
      dE, sig, effE, ΓE, tyE, op, ty_eq, eff_le, args, regArgs
    ]

partial def Regions.toExprAux {regSig : RegionSignature d.Ty}
    (regs : HVector (fun (t : _ × _) => Com d t.1 EffectKind.impure t.2) regSig) :
    Lean.Expr :=
  let α := q(Ctxt ($dE).Ty × List ($dE).Ty)
  let A :=
    q(fun (t : Ctxt ($dE).Ty × List ($dE).Ty) => Com $dE t.1 EffectKind.impure t.2)
  match regSig, regs with
  | [], .nil =>
    mkApp2 (.const ``HVector.nil [0,0]) α A
  | a::as, .cons x xs =>
    let pToExpr (a) := Prod.foldToExpr <| a.map f.mapCtxt f.mapList
    let a := pToExpr a
    let as := (as.map pToExpr).foldToExpr

    let x := x.toExprAux
    let xs := Regions.toExprAux xs
    mkApp6 (.const ``HVector.cons [0,0]) α A as a x xs

end



variable {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}

/-!
## MetaMap helper
-/
section Map
variable {ty : _}

/-- Map a meta morphism over a LeanMLIR program, to obtain a (Lean) `Expr` representing
the mapped program. -/
def Com.metaMap (com : Com d Γ eff ty) (f : DialectMetaMorphism d d') : MetaM Lean.Expr := do
  let sig ← synthInstanceQ q(DialectSignature $d')
  return com.toExprAux f d' sig

/-- Map a meta morphism over a LeanMLIR expression, to obtain a (Lean) `Expr`
representing the mapped expression. -/
def Expr.metaMap (expr : Expr d Γ eff ty) (f : DialectMetaMorphism d d') : MetaM Lean.Expr := do
  let sig ← synthInstanceQ q(DialectSignature $d')
  return expr.toExprAux f d' sig

/-!
## ToExpr
-/

/-- Build a (Lean) `Expr` to represent a LeanMLIR program. -/
def Com.toExprM (com : Com d Γ eff ty) : MetaM Lean.Expr := com.metaMap (.id _)

/-- Build a (Lean) `Expr` to represent a LeanMLIR expression. -/
def Expr.toExprM (expr : Expr d Γ eff ty) : MetaM Lean.Expr := expr.metaMap (.id _)
