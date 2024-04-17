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

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.lete`, resulting in
  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf {Op Ty : Q(Type)} {Γ : Q(Ctxt $Ty)} {ty : Q($Ty)}
    {_sig : Q(OpSignature $Op $Ty)}
    (com : Q(Com $Op $Γ $ty)) : MetaM Q(Com $Op $Γ $ty) := do
  let com : Q(Com $Op $Γ $ty) ← whnf com
  match com with
    | ~q(Com.lete (α:=$eTy) $e $body) =>
        let e' : Q(Expr $Op $Γ $eTy) ← whnf e
        let body' ← comNf body
        return q(Com.lete $e' $body')
    | as => return as

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
def elabIntoCom (region : TSyntax `mlir_region) (Op : Q(Type)) {Ty : Q(Type)}
    (_opSignature : Q(OpSignature $Op $Ty) := by exact q(by infer_instance))
    (φ : Q(Nat) := q(0))
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
