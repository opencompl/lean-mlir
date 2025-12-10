import LeanMLIR

import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
import SSA.Projects.CIRCT.Stream.Basic
namespace HandshakeStream

open MLIR AST in

instance : ToString DCOp.TokenStream where
  toString s := toString (toList 10 s)

instance [ToString w] : ToString (Option w) where
  toString
    | some x => s!"(some {toString x})"
    | none   => "(none)"

instance [ToString w] : ToString (DCOp.ValueStream w) where
  toString s := toString (toList 10 s)

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

def ofList' (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def inputSource : DCOp.TokenStream := ofList' [some (), none, some (), some (), none]


def exampleFst := [DCxComb_com| {
  ^entry(%0: !TokenStream2):
    %src = "DCxComb.fst" (%0) : (!TokenStream2) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

def tok1 : DCOp.TokenStream := ofList' [some (), none, some (), some (), none]
def tok2 : DCOp.TokenStream := ofList' [none, some (), some (), some (), none]
def inputFst : (DCOp.TokenStream × DCOp.TokenStream) := (tok1, tok2)

def testExampleFst : DCOp.TokenStream := sorry
  -- exampleFst.denote (Ctxt.Valuation.ofHVector (.cons inputFst <| .nil))



def exampleSnd := [DCxComb_com| {
  ^entry(%0: !TokenStream2):
    %src = "DCxComb.snd" (%0) : (!TokenStream2) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

-- def inputSnd : (CIRCTStream.DCOp.TokenStream × CIRCTStream.DCOp.TokenStream) := (tok1, tok2)

-- def testExampleSnd : DCOp.TokenStream :=
--   exampleSnd.denote (Ctxt.Valuation.ofHVector (.cons inputSnd <| .nil))

-- #eval testExampleSnd

def exampleFstVal := [DCxComb_com| {
  ^entry(%0: !ValueTokenStream_8):
    %src = "DCxComb.fstVal" (%0) : (!ValueTokenStream_8) -> (!ValueStream_8)
    "return" (%src) : (!ValueStream_8) -> ()
  }]

def val1 : DCOp.ValueStream (BitVec 8) := ofList' [some 1, none, some 2, some 3, none]
def inputFstVal : (DCOp.ValueStream (BitVec 8) × DCOp.TokenStream) := (val1, tok2)

-- def testExampleFstVal : DCOp.ValueStream (BitVec 8) :=
--   exampleFstVal.denote (Ctxt.Valuation.ofHVector (.cons inputFstVal <| .nil))

-- #eval testExampleFstVal

def exampleSndVal := [DCxComb_com| {
  ^entry(%0: !ValueTokenStream_8):
    %src = "DCxComb.sndVal" (%0) : (!ValueTokenStream_8) -> (!TokenStream)
    "return" (%src) : (!TokenStream) -> ()
  }]

-- def testExampleSndVal : DCOp.TokenStream :=
--   exampleSndVal.denote (Ctxt.Valuation.ofHVector (.cons inputFstVal <| .nil))

-- #eval testExampleSndVal

def exampleAdd := [DCxComb_com| {
  ^entry(%0: !ValueStream_8, %1: !ValueStream_8):
    %src = "DCxComb.add" (%0, %1) : (!ValueStream_8, !ValueStream_8) -> (!ValueStream_8)
    "return" (%src) : (!ValueStream_8) -> ()
  }]

-- def val2 : DCOp.ValueStream (BitVec 8) := ofList [some 5, some 0, some 2, some 3, none]

-- def testExampleAdd : DCOp.ValueStream (BitVec 8) :=
--   exampleAdd.denote (Ctxt.Valuation.ofHVector (.cons val1 <| .cons val2 <| .nil))

-- #eval testExampleAdd
