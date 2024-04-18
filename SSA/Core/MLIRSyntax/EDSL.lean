import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform

/-!
# MLIR Dialect Domain Specific Language
This file sets up generic glue meta-code to tie together the generic MLIR parser with the
`Transform` mechanism, to obtain an easy way to specify a DSL that elaborates into `Com`/`Expr`
instances for a specific dialect.
-/

namespace SSA

open Qq Lean Meta Elab Term
open MLIR.AST

/-- `ctxtNf` reduces an expression of type `Ctxt _` to something in between whnf and normal form.
`ctxtNf` recursively calls `whnf` on the tail of the list, so that the result is of the form
  `a₀ :: a₁ :: ... :: aₙ :: [] `
where each element `aᵢ` is not further reduced -/
partial def ctxtNf (as : Expr) : MetaM Expr := do
  let as ← whnf as
  match_expr as with
    | List.cons _ a as =>
        let as ← ctxtNf as
        mkAppM ``Ctxt.snoc #[as, a]
    | _ => return as

partial def vecMap (vec : Expr) (f : Expr → MetaM Expr) : MetaM Expr := do
  let vec ← whnf vec
  match_expr vec with
    | HVector.cons _α _A _as _a x xs =>
        let x ← f x
        let xs ← vecMap xs f
        mkAppM ``HVector.cons #[x, xs]
    | _ => return vec

-- def argsNf (args : Expr) : MetaM Expr :=
--   vecMap args fun arg => do
--     let arg ← whnf arg
--     match_expr arg with
--       | Subtype.mk

mutual

/-- `exprNf` reduces an expression of type (`SSA.`)`Expr` to something in between whnf and normal form.
In particular, it's result will be of the form `Expr.mk op ...`, where `op` is in whnf. -/
partial def exprNf (expr : Expr) : MetaM Expr := do
  let expr ← whnf expr
  match_expr expr with
    | Expr.mk Op Ty inst Γ ty op ty_eq args regArgs =>
        let Γ ← ctxtNf Γ
        let ty ← whnf ty
        let op ← whnf op
        -- let args ← whnf        -- TODO: this should map `whnf` over each variable
        let regArgs ← vecMap regArgs comNf
        return mkAppN (.const ``Expr.mk []) #[Op, Ty, inst, Γ, ty, op, ty_eq, args, regArgs]
    | _ => throwError "Expected `Expr.mk ...`, found:\n\t{expr}"

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.lete`, resulting in
  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf (com : Expr) : MetaM Expr := do
  let com ← whnf com
  match_expr com with
    | Com.lete Op Ty opSig Γ α β e body =>
        let Γ ← ctxtNf Γ
        let α ← whnf α
        let β ← whnf β
        let e ← exprNf e
        let body ← comNf body
        return mkAppN (.const ``Com.lete []) #[Op, Ty, opSig, Γ, α, β, e, body]
    | Com.ret _Op _Ty _inst _Γ _t _ => return com
    | _ => throwError "Expected `Com.lete _ _` or `Com.ret _`, found:\n\t{com}"

end

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
    (_transformReturn  : Q(TransformReturn $Op $Ty $φ) := by exact q(by infer_instance))
    :
    TermElabM Expr := do
  let ast_stx ← `([mlir_region| $region])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let expr : Q(ExceptM $Op (Σ (Γ' : Ctxt $Ty) (ty : $Ty), Com $Op Γ' ty)) :=
    q(MLIR.AST.mkCom $ast)
  synthesizeSyntheticMVarsNoPostponing
  /- Now we repeatedly call `whnf` and then match on the resulting expression, to extract an
    expression of type `Com ..` -/
  let expr : Q(ExceptM $Op (Σ (Γ' : Ctxt $Ty) (ty : $Ty), Com $Op Γ' ty)) ← whnf expr
  match expr.app3? ``Except.ok with
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
            comNf com
        | .none => throwError "Found `Except.ok (Sigma.mk _ WRONG)`, Expected (Except.ok (Sigma.mk _ (Sigma.mk _ _))"
      | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
  | .none => throwError "Expected `Except.ok`, found {expr}"
