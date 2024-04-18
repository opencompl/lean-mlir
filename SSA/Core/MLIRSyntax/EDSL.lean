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

#check Com.lete
#check Com.ret

/-- `comNf` reduces an expression of type `Com` to something in between whnf and normal form.
`comNf` recursively calls `whnf` on the expression and body of a `Com.lete`, resulting in
  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) <| ... <| Com.rete _`
where the arguments to `Expr.mk` are not reduced -/
partial def comNf (com : Expr) : MetaM Expr := do
  let com ← whnf com
  match_expr com with
    | Com.lete Op Ty m opSig Γ eff α β e body =>
        let Γ ← ctxtNf Γ
        let α ← whnf α
        let β ← whnf β
        let e ← whnf e
        let body ← comNf body
        return mkAppN (.const ``Com.lete []) #[Op, Ty, m, opSig, Γ, eff, α, β, e, body]
    | Com.ret _Op _Ty _m _inst _Γ _t _eff _v => return com
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
def elabIntoCom (region : TSyntax `mlir_region) (Op : Q(Type)) {Ty : Q(Type)} {m : Q(Type → Type)}
    {φ : Q(Nat)}
    (_opSignature : Q(OpSignature $Op $Ty $m) := by exact q(by infer_instance))
    (_transformTy      : Q(TransformTy $Op $Ty $φ)     := by exact q(by infer_instance))
    (_transformExpr    : Q(TransformExpr $Op $Ty $φ)   := by exact q(by infer_instance))
    (_transformReturn  : Q(TransformReturn $Op $Ty $φ) := by exact q(by infer_instance)) :
    TermElabM Expr := do
  let com : Q(ExceptM $Op (Σ Γ eff ty, Com $Op Γ eff ty)) ←
    withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} building `Com` expression") <| do
    let ast_stx ← `([mlir_region| $region])
    let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
    return q(MLIR.AST.mkCom $ast)
  withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} synthesizingMVars") <|
    synthesizeSyntheticMVarsNoPostponing

  withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} unwrapping `Com` expression") <| do
    /- Now we repeatedly call `whnf` and then match on the resulting expression, to extract an
      expression of type `Com ..` -/
    let com : Q(ExceptM $Op (Σ Γ eff ty, Com $Op Γ eff ty)) ← whnf com
    match com.app3? ``Except.ok with
    | .some (_ε, _α, expr) =>
        let (expr : Q(Σ Γ eff ty, Com $Op Γ eff ty)) ← whnf expr
        match expr.app4? ``Sigma.mk with
        | .some (_α, _β, (_Γ : Q(Ctxt $Ty)), expr) =>
          let (expr : Q(Σ eff ty, Com $Op $_Γ eff ty)) ← whnf expr
          match expr.app4? ``Sigma.mk with
          | .some (_α, _β, (_eff : Q(EffectKind)), expr) =>
            let (expr : Q(Σ ty, Com $Op $_Γ $_eff ty)) ← whnf expr
            match expr.app4? ``Sigma.mk with
            | .some (_α, _β, (_ty : Q($Ty)), (com : Q(Com $Op $_Γ $_eff $_ty))) =>
              /- Finally, use `comNf` to ensure the resulting expression is of the form
                  `Com.lete (Expr.mk ...) <| Com.lete (Expr.mk ...) ... <| Com.rete _`,
                where the arguments to `Expr.mk` are not reduced -/
              withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} reducing `Com` expression") <|
                comNf com
            | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
          | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
        | .none => throwError "Expected (Sigma.mk _ _), found {expr}"
    | .none => throwError "Expected `Except.ok`, found {com}"
