/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform

/-!
# MLIR Dialect Domain Specific Language
This file sets up generic glue meta-code to tie together the generic MLIR parser with the
`Transform` mechanism, to obtain an easy way to specify a DSL that elaborates into `Com`/`Expr`
instances for a specific dialect.
-/

namespace SSA

initialize
  Lean.registerTraceClass `SSA

open Qq Lean Meta Elab Term
open MLIR.AST

/-- `extractMetaCtxt` converts a Lean `Expr` of type `Ctxt _` into a context (i.e., list) of
Lean `Expr`s -/
partial def extractMetaCtxt {Ty : Q(Type)} (Γ : Q(Ctxt $Ty)) : MetaM (Ctxt Q($Ty)) := do
  let Γ ← whnf Γ
  match_expr Γ with
    | List.cons _ t Γ =>
        let Γ ← extractMetaCtxt Γ
        let t ← reduce t
        return Ctxt.snoc Γ t
    | List.nil _ => return Ctxt.empty
    | _ => throwError "Expected `List.cons _ _` or `List.nil`, found:\n\t{Γ}"

/-- Stitch a context of Lean expressions back into a single lean expression of type `Ctxt _` -/
def rebuildMetaCtxt {Ty : Q(Type)} : Ctxt Q($Ty) → Q(Ctxt $Ty)
  | .snoc Γ t =>
    let Γ := rebuildMetaCtxt Γ
    q(Ctxt.snoc $Γ $t)
  | .empty => q(Ctxt.empty)

/-- `ctxtNf` reduces an expression of type `Ctxt _` to something in between whnf and normal form.
`ctxtNf` recursively calls `whnf` on the tail of the list, so that the result is of the form
  `a₀ :: a₁ :: ... :: aₙ :: [] `
where each element `aᵢ` is not further reduced -/
partial def ctxtNf (as : Expr) : MetaM Expr := do
  let as ← whnf as
  match_expr as with
    | List.cons Ty a as =>
        let as ← ctxtNf as
        let a ← reduce a
        return mkAppN (.const ``Ctxt.snoc []) #[Ty, as, a]
    | _ => return as

partial def vecMap (vec : Expr) (f : Expr → MetaM Expr) : MetaM Expr := do
  let vec ← whnf vec
  match_expr vec with
    | HVector.cons α A as a x xs =>
        let x ← f x
        let xs ← vecMap xs f
        mkAppOptM ``HVector.cons #[α, A, as, a, x, xs]
    | _ => return vec

open Ctxt in
partial def varNf (Γ : Ctxt Expr) (var : Expr) : MetaM Expr := do
  let type ← inferType var
  let Ty ← mkFreshExprMVarQ q(Type)
  let t ← mkFreshExprMVarQ q($Ty)
  let Γ' := rebuildMetaCtxt Γ
  let m := q(Var $Γ' $t)
  unless ←isDefEq type m do
    throwError "Type mismatch, {var} has type:\n\t{type}\nbut was expected to have type:\n\t{m}"

  let var ← whnf var
  match_expr var with
    | Subtype.mk _α _p val _property =>
      let val ← reduce val
      /- NOTE: `evalNat` does not actually "evaluate", it just analyzes the expression and looks for
      common operetations, that's why we reduce the expression first.
      We could look into using `evalExpr`, which is unsafe, but does properly evaluate (and might
      thus be faster and more reliable, since it can handle *all* ground terms)-/
      let val ← match ←Meta.evalNat val with
        | some val => pure val
        | none => throwError "Failed to evaluate index: {val}"
      let ⟨_, v⟩ ← go (Ty:=Ty) Γ val
      return v
    | _ => throwError "Expected `Subtype.mk ...`, found:\n\t{var}"
where go {Ty : Q(Type)} (Γ : Ctxt Q($Ty)) (n : Nat) : MetaM (Expr × Expr) := do
  let (Γ, t') ← match Γ with
    | .snoc Γ t => pure (Γ, t)
    | .empty =>
      /- This should never happen for well-typed `Expr`s, since the intrinsic well-typedness
          of `Var` ensures the context is never empty -/
      throwError "Encountered an unexpected empty context"
  match n with
    | Nat.succ n =>
        let (t, v) ← go Γ n
        return (t', mkAppN (.const ``Var.toSnoc []) #[Ty, rebuildMetaCtxt Γ, t, t', v])
    | Nat.zero =>
        return (t', mkAppN (.const ``Var.last []) #[Ty, rebuildMetaCtxt Γ, t'])


mutual

/-- `exprNf` reduces an expression of type (`SSA.`)`Expr` to something in between whnf and normal form.
In particular, it's result will be of the form `Expr.mk op ...`, where `op` is in whnf. -/
partial def exprNf (expr : Expr) : MetaM Expr := do
  let expr ← whnf expr
  match_expr expr with
    | Expr.mk Op Ty inst Γ ty op ty_eq args regArgs =>
        let Ty : Q(Type) := Ty
        let Γ ← extractMetaCtxt (Ty:=Ty) (Γ : Q(Ctxt $Ty))
        let ty ← reduce ty
        let op ← reduce op
        let args ← vecMap args (varNf Γ)
        let regArgs ← vecMap regArgs comNf!
        let Γ := rebuildMetaCtxt Γ
        return mkAppN (.const ``Expr.mk []) #[Op, Ty, inst, Γ, ty, op, ty_eq, args, regArgs]
    | _ => throwError "Expected `Expr.mk ...`, found:\n\t{expr}"

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.lete`, resulting in
  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf! (com : Expr) : MetaM Expr := do
  let com ← whnf com
  match_expr com with
    | Com.lete Op Ty opSig Γ α β e body =>
        let Γ ← ctxtNf Γ
        let α ← reduce α
        let β ← reduce β
        let e ← exprNf e
        let body ← comNf! body
        return mkAppN (.const ``Com.lete []) #[Op, Ty, opSig, Γ, α, β, e, body]
    | Com.ret Op Ty opSig Γ t v =>
        let Γ ← extractMetaCtxt (Ty:=Ty) Γ
        let t ← reduce t
        let v ← varNf Γ v
        return mkAppN (.const ``Com.ret []) #[Op, Ty, opSig, rebuildMetaCtxt Γ, t, v]
    | _ => throwError "Expected `Com.lete _ _` or `Com.ret _`, found:\n\t{com}"

end

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.lete`, resulting in
  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf (com : Expr) : MetaM Expr := do
  let com ← whnf com
  match_expr com with
    | Com.lete Op Ty opSig Γ α β e body =>
        let Γ ← ctxtNf Γ
        let α ← reduce α
        let β ← reduce β
        let e ← whnf e
        let body ← comNf body
        return mkAppN (.const ``Com.lete []) #[Op, Ty, opSig, Γ, α, β, e, body]
    | Com.ret Op Ty opSig Γ t v =>
        let Γ ← extractMetaCtxt (Ty:=Ty) Γ
        let t ← reduce t
        let v ← varNf Γ v
        return mkAppN (.const ``Com.ret []) #[Op, Ty, opSig, rebuildMetaCtxt Γ, t, v]
    | _ => throwError "Expected `Com.lete _ _` or `Com.ret _`, found:\n\t{com}"

/--
`elabIntoCom` is a building block for defining a dialect-specific DSL based on the geneeric MLIR
syntax parser.

For example, if `FooOp` is the type of operations of a "Foo" dialect, we can build a term elaborator
for this dialect as follows:
```
elab "[foo_com| " reg:mlir_region "]" : term => SSA.elabIntoCom reg q(FooOp)
--     ^^^^^^^                                                        ^^^^^
```
-/
def elabIntoCom (region : TSyntax `mlir_region) (Op : Q(Type)) {Ty : Q(Type)} {φ : Q(Nat)}
    (_opSignature : Q(OpSignature $Op $Ty) := by exact q(by infer_instance))
    (_transformTy      : Q(TransformTy $Op $Ty $φ)     := by exact q(by infer_instance))
    (_transformExpr    : Q(TransformExpr $Op $Ty $φ)   := by exact q(by infer_instance))
    (_transformReturn  : Q(TransformReturn $Op $Ty $φ) := by exact q(by infer_instance)) :
    TermElabM Expr := do
  let com : Q(ExceptM $Op (Σ (Γ' : Ctxt $Ty) (ty : $Ty), Com $Op Γ' ty)) ←
    withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} building `Com` expression") <| do
    let ast_stx ← `([mlir_region| $region])
    let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
    return q(MLIR.AST.mkCom $ast)
  withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} synthesizingMVars") <|
    synthesizeSyntheticMVarsNoPostponing

  withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} unwrapping `Com` expression") <| do
    /- Now we repeatedly call `whnf` and then match on the resulting expression, to extract an
      expression of type `Com ..` -/
    let com : Q(ExceptM $Op (Σ (Γ' : Ctxt $Ty) (ty : $Ty), Com $Op Γ' ty)) ← whnf com
    match com.app3? ``Except.ok with
    | .some (_εexpr, _αexpr, expr) =>
        let (expr : Q(Σ Γ ty, Com $Op Γ ty)) ← whnf expr
        match expr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, (_Γ : Q(Ctxt $Ty)), expr) =>
          let (expr : Q(Σ ty, Com $Op $_Γ ty)) ← whnf expr
          match expr.app4? ``Sigma.mk with
          | .some (_αexpr, _βexpr, (_ty : Q($Ty)), (com : Q(Com $Op $_Γ $_ty))) =>
              /- Finally, use `comNf` to ensure the resulting expression is of the form
                  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) ... <| Com.rete _`,
                where the arguments to `Expr.mk` are not reduced -/
              withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} reducing `Com` expression") <|
                comNf com
          | .none => throwError "Found `Except.ok (Sigma.mk _ WRONG)`, Expected (Except.ok (Sigma.mk _ (Sigma.mk _ _))"
        | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
    | .none => throwError "Expected `Except.ok`, found {com}"
