import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

namespace CIRCTStream

open MLIR AST in

unseal String.splitOnAux in
def SourceEg := [DC_com| {
  ^entry():
    %src = "DC.source" () : () -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

#check SourceEg
#eval SourceEg
#reduce SourceEg
#check SourceEg.denote
#print axioms SourceEg

def test : DC.TokenStream :=
  SourceEg.denote (Ctxt.Valuation.nil)
