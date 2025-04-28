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

def test1 : DCOp.TokenStream :=
  SourceEg.denote (Ctxt.Valuation.nil)


unseal String.splitOnAux in
def BranchEg := [DC_com| {
  ^entry(%0: !TokenStream, %1: !ValueStream_Int, %2: !ValueStream_Bool):
    %truefalse = "DC.branch" (%2) : (!ValueStream_Bool) -> (!TokenStream2)
    %truet = "DC.fst" (%truefalse) : (!TokenStream2) -> (!TokenStream)
    %falset = "DC.snd" (%truefalse) : (!TokenStream2) -> (!TokenStream)
    %packtrue = "DC.pack" (%1, %truet) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    %packfalse = "DC.pack" (%1, %falset) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    %out = "DC.select" (%truet, %falset, %2) : (!TokenStream, !TokenStream, !ValueStream_Bool) -> (!TokenStream)
    "return" (%0) : (!TokenStream) -> ()
  }]

#check BranchEg
#eval BranchEg
#reduce BranchEg
#check BranchEg.denote
#print axioms BranchEg

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def c : DCOp.ValueStream Bool := ofList [some true, none, some false, some true, some false]
def x : DCOp.ValueStream Int := ofList [some 1, none, some 2, some 3, none]
def u : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

def test2 : DCOp.TokenStream :=
  BranchEg.denote (Ctxt.Valuation.ofHVector (.cons c <| .cons x <| .cons u <| .nil))
