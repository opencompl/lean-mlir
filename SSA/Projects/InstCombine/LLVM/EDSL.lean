
import Qq
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform

open Qq
open Lean Meta Elab Term

open MLIR.AST in
elab "[mlir_icom| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region)
  let h_stx ← `(by rfl)
  let h_isSome ← elabTermEnsuringTypeQ h_stx q(mkCom $ast |>.toOption.isSome)
  let com := q(mkCom $ast |>.toOption.get $h_isSome)
  Term.synthesizeSyntheticMVarsNoPostponing
  withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
    withTransparency (mode := TransparencyMode.all) <| 
      reduce com