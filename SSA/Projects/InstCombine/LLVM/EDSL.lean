import Qq
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.Signature
import SSA.Projects.InstCombine.LLVM.CLITests

open Qq Lean Meta Elab.Term

open MLIR.AST InstCombine in
elab "[mlir_icom_test" test_name:ident "(" mvars:term,* ")| " reg:mlir_region "]" : term => do
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
    | ~q(Except.ok $comOk)  =>
      let Γ : Q(Ctxt Ty) := q(($comOk).fst)
      let ty : Q(Ty) := q($(comOk).snd.fst)
      let nm : Name := test_name.getId
      -- TODO: (@bollu) can we get this to work directly with QQ?
      --let signature : Q(CliSignature) ← getSignature q($comOk).snd.snd
      -- let hty :  Q(Ty) = MTy 0 := by
      --  sorry
      -- let hctxt :  Q(Ctxt Ty) = MLIR.AST.Context 0 := by
      --  sorry
      let test : Q(CliTest) := q({
         name := $nm,
         mvars := 0,
         context := ($comOk).fst,
         ty := $(comOk).snd.fst,
         code := ($comOk).snd.snd,
         signature := default
      } : CliTest)
      return test
    | ~q(Except.error $err) => do
        let err ← unsafe evalExpr TransformError q(TransformError) err
        throwError "Translation failed with error:\n\t{repr err}"
    | e => throwError "Translation failed to reduce, possibly too generic syntax\n\t{e}"


macro "[mlir_icom_test" test_name:ident " | " reg:mlir_region "]" : term => `([mlir_icom_test $test_name ()| $reg])

macro "[mlir_icom" "(" mvars:term,* ")| " reg:mlir_region "]" : term => `([mlir_icom_test Anonymous ($[$mvars],* )| $reg ].code)
macro "[mlir_icom" " | " reg:mlir_region "]" : term => `([mlir_icom_test Anonymous | $reg ].code)

-- | ident  (info : SourceInfo) (rawVal : Substring) (val : Name) (preresolved : List Syntax.Preresolved) : Syntax
macro "deftest" name:ident " := " test_reg:mlir_region : command => do
  let tmp_name : Ident := { raw := Syntax.ident default default (Name.append name.getId (Name.mkStr1 "_test")) []}
  `(@[reducible] def $(tmp_name) := fun w => [mlir_icom_test $name (w)| $test_reg ]
   @[reducible, llvmTest $name] def $name := fun w => {$tmp_name w with signature := getSignature! ($(tmp_name) w).code : CliTest})
