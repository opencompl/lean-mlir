/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform
import SSA.Core.Framework.Trace

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

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.var`, resulting in
  `Com.var (Expr.mk ...) <| Com.var (Expr.mk ...) <| Com.var (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf (com : Expr) : MetaM Expr := do
  let com ← whnf com
  match_expr com with
    | Com.var d opSig Γ eff α β e body =>
        let Γ ← ctxtNf Γ
        let eff ← whnf eff
        let α ← whnf α
        let β ← whnf β
        let e ← whnf e
        let body ← comNf body
        return mkAppN (.const ``Com.var []) #[d, opSig, Γ, eff, α, β, e, body]
    | Com.ret _d _inst _Γ _eff _t _ => return com
    | _ => throwError "Expected `Com.var _ _` or `Com.ret _`, found:\n\t{com}"

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
def elabIntoCom (region : TSyntax `mlir_region) (d : Q(Dialect)) {φ : Q(Nat)}
    (_dialectSignature : Q(DialectSignature $d) := by exact q(by infer_instance))
    (_transformTy      : Q(TransformTy $d $φ)     := by exact q(by infer_instance))
    (_transformExpr    : Q(TransformExpr $d $φ)   := by exact q(by infer_instance))
    (_transformReturn  : Q(TransformReturn $d $φ) := by exact q(by infer_instance)) :
    TermElabM Expr := do
  let com : Q(ExceptM $d (Σ Γ' eff ty, Com $d Γ' eff ty)) ←
    withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} building `Com` expression") <| do
    let ast_stx ← `([mlir_region| $region])
    let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
    return q(MLIR.AST.mkCom $ast)
  withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} synthesizingMVars") <|
    synthesizeSyntheticMVarsNoPostponing

  withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} unwrapping `Com` expression") <| do
    /- Now we repeatedly call `whnf` and then match on the resulting expression, to extract an
      expression of type `Com ..` -/
    let com : Q(ExceptM $d (Σ Γ' eff ty, Com $d Γ' eff ty)) ← whnf com
    match com.app3? ``Except.ok with
    | .some (_εexpr, _αexpr, expr) =>
        let (expr : Q(Σ Γ eff ty, Com $d Γ eff ty)) ← whnf expr
        match expr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, (_Γ : Q(Ctxt ($d).Ty)), expr) =>
          let (expr : Q(Σ eff ty, Com $d $_Γ eff ty)) ← whnf expr
          match expr.app4? ``Sigma.mk with
          | .some (_αexpr, _βexpr, (_eff : Q(EffectKind)), expr) =>
            match expr.app4? ``Sigma.mk with
            | .some (_αexpr, _βexpr, (_ty : Q(List ($d).Ty)), (com : Q(Com $d $_Γ $_eff $_ty))) =>
                /- Finally, use `comNf` to ensure the resulting expression is of the form
                    `Com.var (Expr.mk ...) <| Com.var (Expr.mk ...) ... <| Com.rete _`,
                  where the arguments to `Expr.mk` are not reduced -/
                withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} reducing `Com` expression") <|
                  comNf com
            | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
          | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
        | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
    | .none => throwError "Expected `Except.ok`, found {com}"

end SSA
