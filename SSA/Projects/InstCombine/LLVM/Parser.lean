import SSA.Core.MLIRSyntax.Parser
import SSA.Projects.InstCombine.LLVM.EDSL
import Init.Data.Repr

open MLIR AST InstCombine
def regionTransform (region : Region 0) : Except ParseError
  (Σ (Γ' : Context) (eff : EffectKind) (ty : Ty), Com LLVM Γ' eff ty) :=
    let res := mkCom (d:= LLVM) region
    match res with
      | Except.error e => Except.error s!"Error:\n{reprStr e}"
      | Except.ok res => Except.ok res

def parseComFromFile (fileName : String) :
 IO (Option (Σ (Γ' : Context) (eff : EffectKind) (ty : InstCombine.Ty), Com LLVM Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform

def parseComFromFileRiscV (fileName : String) :
 IO (Option (Σ (Γ' : Context) (eff : EffectKind) (ty : InstCombine.Ty), Com LLVM Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform
