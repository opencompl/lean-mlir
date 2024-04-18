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
    (_opSignature : Q(OpSignature $Op $Ty $m) := by exact q(by infer_instance))
    (φ : Q(Nat) := q(0))
    (_transformTy      : Q(TransformTy $Op $Ty $φ)     := by exact q(by infer_instance))
    (_transformExpr    : Q(TransformExpr $Op $Ty $φ)   := by exact q(by infer_instance))
    (_transformReturn  : Q(TransformReturn $Op $Ty $φ) := by exact q(by infer_instance))
    :
    TermElabM Expr := do
  let ast_stx ← `([mlir_region| $region])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let com : Q(MLIR.AST.ExceptM $Op (Σ Γ' eff ty, Com $Op Γ' eff ty)) :=
    q(MLIR.AST.mkCom $ast)
  synthesizeSyntheticMVarsNoPostponing
  /-  Now reduce the term. We do this so that the resulting term will be of the form
        `Com.lete _ <| Com.lete _ <| ... <| Com.ret _`,
      rather than still containing the `Transform` machinery applied to a raw AST.
      This has the side-effect of also fully reducing the expressions involved.
      We reduce with mode `.default` so that a dialect can prevent reduction of specific parts
      by marking those `irreducible` -/
  let com : Q(MLIR.AST.ExceptM $Op (Σ Γ' eff ty, Com $Op Γ' eff ty)) ←
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := .default) <|
        return ←reduce com
  let comExpr : Expr := com
  trace[Meta] com
  trace[Meta] comExpr

  match comExpr.app3? ``Except.ok with
  | .some (_εexpr, _αexpr, aexpr) =>
      match aexpr.app4? ``Sigma.mk with
      | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
        match sndexpr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
          match sndexpr.app4? ``Sigma.mk with
          | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
            return sndexpr
          | .none => throwError "Expected `Sigma.mk _ _`, found {sndexpr}"
        | .none => throwError "Expected `Sigma.mk _ _`, found {sndexpr}"
      | .none => throwError "Expected `Sigma.mk _ _`, found {aexpr}"
  | .none => throwError "Expected `Except.ok _`, found {comExpr}"
