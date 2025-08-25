/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.Transform
import SSA.Core.Framework.ToExpr

/-!
# MLIR Dialect Domain Specific Language (v2)
This file sets up generic glue meta-code to tie together the generic MLIR parser with the
`Transform` mechanism, to obtain an easy way to specify a DSL that elaborates into `Com`/`Expr`
instances for a specific dialect.

This is an alternative implementation to `EDSL.lean`, which aims to compute more with meta-time
objects, instead of kernel reducing `Expr`s, in an attempt to avoid some of the pittfals
that kernel reduction causes.

## A Note to Dialect Implementors

To use this elaborator, we first need to register appropriate typeclasses that
instruct Lean how to transform the various components of your dialect into Lean
expressions.

To start, we need to tell Lean how to convert the Dialect operations and types.
This is done through the `Lean.ToExpr` typeclass, and it generally suffices to
add `deriving Lean.ToExpr` at the end of your `Op` and `Ty` type definitions.

Then, we need to register two specific expressions, one that represents the
dialect itself, and a second that represents the dialect monad (i.e., the
definition of `Dialect.m _`). These are defined as an instance of `DialectToExpr`,
which cannot be derived. Luckily, these are pretty straightforward to define:
```
instance : DialectToExpr FooDialect where
  toExprDialect := Expr.const ``FooDialect []
  toExprM := Expr.const ``Id [0]
```

See the documentation of `Expr.const` for more detail, but briefly: the first
argument is the name of a constant (i.e., a definition), the second is a list
of universe parameters. Dialect will generally not be universe polymorphic, so
an empty list should suffice. The `Id` monad, on the other hand, *is* universe
polymorphic, so we specify that we want `Id.{0}`.


With these instances defined, we can register an elaborator that will parse
programs in our dialect:
```
elab "[FooDialect| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg FooDialect
```

-/

namespace SSA

open Qq Lean Meta Elab Term
open MLIR.AST

private unsafe def evalExprOfTypeRegionAux (φ : Nat) : Q(Region $φ) → MetaM (Region φ) :=
  evalExpr (Region φ) q(Region $φ)
/-
SAFETY: the `implemented_by` is safe, *assuming* that `Region φ` and `q(Region φ)`
  are the same; this means we trust Qq to construct the right `Expr`.
-/
@[implemented_by evalExprOfTypeRegionAux]
partial def evalExprOfTypeRegion (φ : Nat) : Q(Region $φ) → MetaM (Region φ) :=
  default

def elabIntoComObj (region : TSyntax `mlir_region) (d : Dialect) {φ : Nat}
    [DialectSignature d] [Repr d.Ty]
    [TransformTy d φ] [TransformExpr d φ] [TransformReturn d φ] :
    TermElabM (Σ Γ eff ty, Com d Γ eff ty) := withRef region <| do
  withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} elaborating MLIR DSL") <| do
  trace[LeanMLIR.Elab] "syntax: {region}"

  let ast : Region φ ←
    withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} evaluating AST expression") <| do
    let stx  ← `([mlir_region| $region])
    let expr ← elabTermEnsuringTypeQ stx q(Region $φ)
    synthesizeSyntheticMVarsNoPostponing
    let expr ← instantiateMVars expr
    let reg ← evalExprOfTypeRegion φ expr
    trace[LeanMLIR.Elab] "{repr reg}"
    pure reg

  withTraceNode `LeanMLIR.Elab (return m!"{exceptEmoji ·} parsing AST") <| do
    let res ← match mkCom ast with
      | .error (e : TransformError) => throwError (repr e)
      | .ok res => pure res
    trace[LeanMLIR.Elab] "context: {repr res.1}"
    pure res

def elabIntoCom' (region : TSyntax `mlir_region) (d : Dialect) {φ : Nat}
    [ToExpr d.Op] [ToExpr d.Ty] [DialectToExpr d]
    [DialectSignature d] [Repr d.Ty]
    [TransformTy d φ] [TransformExpr d φ] [TransformReturn d φ] :
    TermElabM Expr := withRef region <| do
  let ⟨_Γ, _eff, _ty, com⟩ ← elabIntoComObj region d
  let c ← com.toExprM
  trace[LeanMLIR.Elab] "Elaborated Com:\n{c}"
  Meta.check c
  return c

end SSA
