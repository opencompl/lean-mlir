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
  com.toExprM

end SSA
