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
@[implemented_by evalExprOfTypeRegionAux]
partial def evalExprOfTypeRegion (φ : Nat) : Q(Region $φ) → MetaM (Region φ) :=
  default

def elabIntoCom' (region : TSyntax `mlir_region) (d : Dialect) {φ : Nat}
    [ToExpr d.Op] [ToExpr d.Ty] [DialectToExpr d]
    [DialectSignature d] [Repr d.Ty]
    [TransformTy d φ] [TransformExpr d φ] [TransformReturn d φ] :
    TermElabM Expr := withRef region <| do
  let ast : Region φ ←
    withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} evaluating AST expression") <| do
    let stx  ← `([mlir_region| $region])
    let expr ← elabTermEnsuringTypeQ stx q(Region $φ)
    withTraceNode `elabIntoCom (fun _ => return m!"parsed Expr … ") <| do
      trace[elabIntoCom] "{expr}"
    -- SAFETY: the next line is safe, *assuming* that `Region φ` and `q(Region φ)`
    --         are the same; this means we trust Qq to construct the right `Expr`.
    evalExprOfTypeRegion φ expr

  let ⟨_Γ, _eff, _ty, com⟩ ←
    withTraceNode `elabIntoCom (return m!"{exceptEmoji ·} parsing AST") <| do
    match mkCom ast with
    | .error (e : TransformError d.Ty) => throwError (repr e)
    | .ok res => pure res

  com.toExprM

end SSA
