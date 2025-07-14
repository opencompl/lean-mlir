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

-- unseal String.splitOnAux in
def exampleSink := [DCxComb_com| {
  ^entry(%0: !TokenStream):
    %src = "DCxComb.sink" (%0) : (!TokenStream) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def inputSource : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

def testExampleSource : DCOp.TokenStream :=
  exampleSink.denote (Ctxt.Valuation.ofHVector (.cons inputSource <| .nil))

#eval testExampleSource

def exampleFst := [DCxComb_com| {
  ^entry(%0: !TokenStream2):
    %src = "DCxComb.fst" (%0) : (!TokenStream2) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

def tok1 : CIRCTStream.DCOp.TokenStream := ofList [some (), none, some (), some (), none]
def tok2 : CIRCTStream.DCOp.TokenStream := ofList [some (), some (), some (), some (), none]
def inputFst : (CIRCTStream.DCOp.TokenStream × CIRCTStream.DCOp.TokenStream) := (tok1, tok2)

def testExampleFst : DCOp.TokenStream :=
  exampleFst.denote (Ctxt.Valuation.ofHVector (.cons inputFst <| .nil))

#eval testExampleFst
