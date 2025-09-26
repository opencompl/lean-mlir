import LeanMLIR.MLIRSyntax.Parser
import LeanMLIR.Dialects.LLVM.Syntax
import Init.Data.Repr

open InstCombine
def parseComFromFile (fileName : String) :
    IO (Option (Σ (Γ' : Ctxt LLVM.Ty) (eff : EffectKind) (ty : List LLVM.Ty), Com LLVM Γ' eff ty)) :=
  Com.parseFromFile LLVM fileName
