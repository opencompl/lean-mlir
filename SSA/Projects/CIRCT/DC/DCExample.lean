import SSA.Core

import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim

namespace CIRCTStream

instance : ToString DCOp.TokenStream where
  toString s := toString (Stream.toList 100 s)

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

def test1 : DCOp.TokenStream :=
  SourceEg.denote (Ctxt.Valuation.nil)

#eval test1

unseal String.splitOnAux in
def BranchEg := [DC_com| {
  ^entry(%0: !TokenStream, %1: !ValueStream_8, %2: !ValueStream_1):
    %truefalse = "DC.branch" (%2) : (!ValueStream_1) -> (!TokenStream2)
    %truet = "DC.fst" (%truefalse) : (!TokenStream2) -> (!TokenStream)
    %falset = "DC.snd" (%truefalse) : (!TokenStream2) -> (!TokenStream)
    %packtrue = "DC.pack" (%1, %truet) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    %packfalse = "DC.pack" (%1, %falset) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    %out = "DC.select" (%truet, %falset, %2) : (!TokenStream, !TokenStream, !ValueStream_1) -> (!TokenStream)
    "return" (%0) : (!TokenStream) -> ()
  }]

#check BranchEg
#eval BranchEg
#reduce BranchEg
#check BranchEg.denote
#print axioms BranchEg

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals[i]?).join

def c : DCOp.ValueStream (BitVec 1) := ofList [some 1, none, some 0, some 1, some 0]
def x : DCOp.ValueStream (BitVec 8) := ofList [some 1, none, some 2, some 3, none]
def u : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

def test2 : DCOp.TokenStream :=
  BranchEg.denote (Ctxt.Valuation.ofHVector (.cons c <| .cons x <| .cons u <| .nil))

#eval test2
