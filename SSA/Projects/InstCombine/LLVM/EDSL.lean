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

#check Except.ok
#check Sigma.mk
@[inline] def _root_.Lean.Expr.app5? (e : Expr) (fName : Name) : Option (Expr × Expr × Expr × Expr × Expr) :=
  if e.isAppOfArity fName 4 then
    some (e.appFn!.appFn!.appFn!.appFn!.appArg!, e.appFn!.appFn!.appFn!.appArg!, e.appFn!.appFn!.appArg!, e.appFn!.appArg!, e.appArg!)
  else
    none

/-
https://leanprover.zulipchat.com/#narrow/stream/287929-mathlib4/topic/Cannot.20Find.20.60Real.2Eadd.60/near/402089561
> I would recommend avoiding Qq for pattern matching.
> That part of the Qq implementation is spicy.

Therefore, we choose to match on raw `Expr`.
-/
open MLIR.AST InstCombine in
elab "[alive_icom (" mvars:term,* ")| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let φ : Nat := mvars.getElems.size
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region $φ)
  let mvalues ← `(⟨[$mvars,*], by rfl⟩)
  let mvalues : Q(Vector Nat $φ) ← elabTermEnsuringType mvalues q(Vector Nat $φ)
  let com := q(mkComInstantiate (φ := $φ) $ast |>.map (· $mvalues))
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(MLIR.AST.ExceptM Op (Σ (Γ' : Ctxt Ty) (ty : Ty), Com Op Γ' ty)) ←
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding true }) do
      withTransparency (mode := TransparencyMode.all) <|
        return ←reduceAll com
  let comExpr : Expr := com
  trace[Meta] com
  trace[Meta] comExpr
  match comExpr.app3? ``Except.ok with
  | .some (_εexpr, _αexpr, aexpr) =>
      match aexpr.app4? ``Sigma.mk with
      | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
        match sndexpr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
            return sndexpr
        | .none => throwError "Found `Except.ok (Sigma.mk _ WRONG)`, Expected (Except.ok (Sigma.mk _ (Sigma.mk _ _))"
      | .none => throwError "Found `Except.ok WRONG`, Expected (Except.ok (Sigma.mk _ _))"
  | .none => throwError "Expected `Except.ok`, found {comExpr}"
macro "[alive_icom| " reg:mlir_region "]" : term => `([alive_icom ()| $reg])
