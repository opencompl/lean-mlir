import Qq
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform

open Qq Lean Meta Elab.Term

open MLIR.AST in
elab "[mlir_icom| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region)
  let com := q(mkCom $ast)
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(ExceptM (Σ (Γ' : _root_.Context) (ty : InstCombine.Ty), Com Γ' ty)) ← 
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.all) <| 
        reduce com
  trace[Meta] com
  match com with
    | ~q(Except.ok $com)    => return com
    | ~q(Except.error $err) => do
        let err ← unsafe evalExpr TransformError q(TransformError) err
        throwError "Translation failed with error:\n\t{repr err}"
    | e => throwError "Translation failed to reduce, possibly too generic syntax\n\t{e}"