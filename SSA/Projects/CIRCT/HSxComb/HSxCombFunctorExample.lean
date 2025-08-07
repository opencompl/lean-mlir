import SSA.Projects.CIRCT.HSxComb.HSxCombFunctor
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
def ex1 := [HSxComb_com| {
  ^entry(%0: !Stream_BitVec_1):
    "return" (%0) : (!Stream_BitVec_1) -> ()
  }]

#check ex1

instance [ToString w] : ToString (Option w) where
  toString
    | some x => s!"(some {toString x})"
    | none   => "(none)"

instance [ToString w] : ToString (Stream w) where
  toString s := toString (Stream.toList 10 s)

-- unseal String.splitOnAux in
def exampleMerge := [HSxComb_com| {
  ^entry(%0: !Stream_BitVec_8, %1: !Stream_BitVec_8):
    %src = "HSxComb.merge" (%0, %1) : (!Stream_BitVec_8, !Stream_BitVec_8) -> (!Stream_BitVec_8)
    "return" (%src) : (!Stream_BitVec_8) -> ()
  }]

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def input1 : Stream (BitVec 8) := ofList [some 1, none, some 17, some 42, none]
def input2 : Stream (BitVec 8) := ofList [none, some 3, some 17, some 42, none]

def testExampleMerge : Stream (BitVec 8) :=
  exampleMerge.denote (Ctxt.Valuation.ofHVector (.cons input2 <| .cons input1 <| .nil))

#eval testExampleMerge

-- unseal String.splitOnAux in
def exampleMergeAdd := [HSxComb_com| {
  ^entry(%0: !Stream_BitVec_8, %1: !Stream_BitVec_8, %2: !Stream_BitVec_8):
    %src = "HSxComb.merge" (%0, %1) : (!Stream_BitVec_8, !Stream_BitVec_8) -> (!Stream_BitVec_8)
    %add = "HSxComb.add" (%src, %2) : (!Stream_BitVec_8, !Stream_BitVec_8) -> (!Stream_BitVec_8)
    "return" (%add) : (!Stream_BitVec_8) -> ()
  }]


def input3 : Stream (BitVec 8) := ofList [none, some 1, some 9, some 13, none]

def testExampleMergeAdd : Stream (BitVec 8) :=
  exampleMergeAdd.denote (Ctxt.Valuation.ofHVector (.cons input3 <| .cons input2 <| .cons input1 <| .nil))

#eval testExampleMergeAdd
