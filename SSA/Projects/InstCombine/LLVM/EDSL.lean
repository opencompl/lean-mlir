import Qq
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.Transform.Instantiate

import SSA.Projects.InstCombine.LLVM.Transform.Dialects.InstCombine

open Qq Lean Meta Elab.Term Elab Command

open MLIR

-- def elabToMlirICom (Op : Q(Type)) (mvars : Syntax.TSepArray `term ",") (reg : TSyntax `mlir_region) : 
--     TermElabM Unit := do
--   let φ : Nat := mvars.getElems.size
--   let Ty  ← mkFreshExprMVarQ q(Type)
--   let MOp ← mkFreshExprMVarQ q(Type)
--   let MTy ← mkFreshExprMVarQ q(Type)
--   let _ ← synthInstanceQ q(OpSignature $Op $Ty)
--   let _ ← synthInstanceQ q(AST.TransformDialect $MOp $MTy $φ)
--   let instInst ← synthInstanceQ q(TransformDialectInstantiate $Op $φ $Ty $MOp $MTy)

--   let ast_stx ← `([mlir_region| $reg])
--   let ast ← elabTermEnsuringTypeQ ast_stx q(AST.Region $φ)

--   let mvalues ← `(⟨[$mvars,*], by rfl⟩)
--   let mvalues : Q(Vector Nat $φ) ← elabTermEnsuringType mvalues q(Vector Nat $φ)

--   let com := q(AST.mkComInstantiate (instInst:=$instInst) $ast)
--   synthesizeSyntheticMVarsNoPostponing
--   -- let com : Q(ExceptM (Σ (Γ' : Ctxt Ty) (ty : InstCombine.Ty), Com Γ' ty)) ← 
--   --   withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
--   --     withTransparency (mode := TransparencyMode.all) <| 
--   --       return ←reduce com
--   -- trace[Meta] com
--   -- match com with
--   --   | ~q(Except.ok $comOk)  => return q(($comOk).snd.snd)
--   --   | ~q(Except.error $err) => do
--   --       let err ← unsafe evalExpr TransformError q(TransformError) err
--   --       throwError "Translation failed with error:\n\t{repr err}"
--   --   | e => throwError "Translation failed to reduce, possibly too generic syntax\n\t{e}"

--   sorry

open MLIR.AST InstCombine in
elab "[alive_icom (" mvars:term,* ")| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let φ : Nat := mvars.getElems.size
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let mvalues ← `(⟨[$mvars,*], by rfl⟩)
  let mvalues : Q(Vector Nat $φ) ← elabTermEnsuringType mvalues q(Vector Nat $φ)
  let com := q(mkComInstantiate Op $φ $ast |>.map (· $mvalues))
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(ExceptM Op (Σ (Γ' : Ctxt Ty) (ty : Ty), ICom Op Γ' ty)) ← 
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.all) <| 
        return ←reduce com
  trace[Meta] com
  match com with
    | ~q(Except.ok $comOk)  => return q(($comOk).snd.snd)
    | ~q(Except.error $err) => do
        let err ← unsafe evalExpr (TransformError Op) q(TransformError Op) err
        throwError "Translation failed with error:\n\t{repr err}"
    | e => throwError "Translation failed to reduce, possibly too generic syntax\n\t{e}"

macro "[alive_icom| " reg:mlir_region "]" : term => `([alive_icom ()| $reg])