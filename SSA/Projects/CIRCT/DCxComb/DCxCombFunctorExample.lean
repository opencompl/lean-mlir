import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
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
def ex1 := [DCxComb_com| {
  ^entry(%0: !TokenStream):
    "return" (%0) : (!TokenStream) -> ()
  }]

#check ex1

unseal String.splitOnAux in
def exampleSource := [DCxComb_com| {
  ^entry():
    %src = "DCxComb.source" () : () -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

#check exampleSource

unseal String.splitOnAux in
def exampleSink := [DCxComb_com| {
  ^entry(%0: !TokenStream):
    %src = "DCxComb.sink" (%0) : (!TokenStream) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

#check exampleSource
def u : DCOp.TokenStream := ofList [some (), none, some (), some (), none]
set_option diagnostics true

def testExampleSource : DCOp.TokenStream :=
  exampleSource.denote (Ctxt.Valuation.ofHVector (.cons u <| .nil))

#eval testExampleSource
