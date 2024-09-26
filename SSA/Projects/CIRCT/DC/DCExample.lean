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
def SourceEg1 := [DC_com| {
  ^entry():
    %src = "DC.source" () : () -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

#check SourceEg1
#eval SourceEg1
#reduce SourceEg1
#check SourceEg1.denote
#print axioms SourceEg1


-- is this in the opposite order or am I misunderstanding? if yes: why?
def test : DC.TokenStream :=
  SourceEg1.denote (Ctxt.Valuation.nil)
