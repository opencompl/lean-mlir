import Qq
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform

open Qq Lean Meta Elab.Term

open MLIR.AST InstCombine in
elab "[mlir_icom (" mvars:ident,* ")| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let φ : Nat := mvars.getElems.size
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let mvalues ← `(⟨[$mvars,*], by rfl⟩)
  let mvalues : Q(Vector Nat $φ) ← elabTermEnsuringType mvalues q(Vector Nat $φ)
  let com := q(mkComInstantiate $ast |>.map (· $mvalues))
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(ExceptM (Σ (Γ' : Ctxt Ty) (ty : InstCombine.Ty), Com Γ' ty)) ← 
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.all) <| 
        return ←reduce com
  trace[Meta] com
  match com with
    | ~q(Except.ok $comOk)    => return comOk
    | ~q(Except.error $err) => do
        let err ← unsafe evalExpr TransformError q(TransformError) err
        throwError "Translation failed with error:\n\t{repr err}"
    | e => throwError "Translation failed to reduce, possibly too generic syntax\n\t{e}"

macro "[mlir_icom| " reg:mlir_region "]" : term => `([mlir_icom ()| $reg])