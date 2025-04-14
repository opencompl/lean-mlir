import SSA.Projects.CIRCT.Comb.Comb
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
def CombEg1 := [Comb_com| {
  ^entry(%0: !Bool):
    "return" (%0) : (!Bool) -> ()
  }]

#check CombEg1
#eval CombEg1
#reduce CombEg1
#check CombEg1.denote
#print axioms CombEg1

unseal String.splitOnAux in
def CombEg2 := [Comb_com| {
  ^entry(%0: !IcmpPred_dv):
    "return" (%0) : (!IcmpPred_dv) -> ()
  }]

#check CombEg2
#eval CombEg2
#reduce CombEg2
#check CombEg2.denote
#print axioms CombEg2

def CombEg3 := [Comb_com| {
  ^entry(%0: !IcmpPred_neq):
    "return" (%0) : (!IcmpPred_neq) -> ()
  }]

#check CombEg3
#eval CombEg3
#reduce CombEg3
#check CombEg3.denote
#print axioms CombEg3

def CombEg4 := [Comb_com| {
  ^entry(%0: !BitVec_4):
    -- %1 = "Comb.modu" (%0, %0) : (!bv_4, !BitVec_4) -> (!BitVec_4)
    "return" (%0) : (!BitVec_4) -> ()
  }]

#check CombEg4
#eval CombEg4
#reduce CombEg4
#check CombEg4.denote
#print axioms CombEg4


def CombEg5 := [Comb_com| {
    ^entry(%0: !List_4):
      %1 = "Comb.add" (%0) : (!List_4) -> !BitVec_4
      "return" (%1) : (!BitVec_4) -> ()
    }]

#print CombEg5
#eval CombEg5
#reduce CombEg5
#check CombEg5
#print axioms CombEg5



def l : List (BitVec 4) := [BitVec.ofNat 4 1, BitVec.ofNat 4 2, BitVec.ofNat 4 3, BitVec.ofNat 4 4]

def lh : HVector TyDenote.toType [MLIR2Comb.Ty.list 4] := HVector.cons l .nil

#check HVector.cons

def test : BitVec 4 := CombEg5.denote (Ctxt.Valuation.ofHVector lh)

#eval test

-- def x : DC.ValueStream Int := ofList [some 1, none, some 2, some 3, none]
-- def u : DC.TokenStream := ofList [some (), none, some (), some (), none]

-- def test2 : DC.TokenStream :=
--   BranchEg.denote (Ctxt.Valuation.ofHVector (.cons c <| .cons x <| .cons u <| .nil))
