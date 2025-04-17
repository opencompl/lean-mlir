import SSA.Projects.CIRCT.Comb.Comb
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

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

def CombEg2 := [Comb_com| {
    ^entry(%0: !BitVec_4, %1 : !BitVec_4):
      %2 = "Comb.add" (%0, %1) : (!BitVec_4, !BitVec_4) -> !BitVec_4
      "return" (%2) : (!BitVec_4) -> ()
    }]

#print CombEg2
#eval CombEg2
#reduce CombEg2
#check CombEg2
#print axioms CombEg2

def bv1 : BitVec 4 := BitVec.ofNat 4 5 -- 0010
def bv2 : BitVec 4 := BitVec.ofNat 4 1 -- 0011

def test2 : BitVec 4 :=
  CombEg2.denote (Ctxt.Valuation.ofPair bv1 bv2)

#eval test2

def CombEg3 := [Comb_com| {
  ^entry(%0: !BitVec_4):
    %2 = "Comb.icmp_eq" (%0, %0) : (!BitVec_4, !BitVec_4, !IcmpPred) -> !Bool
    "return" (%2) : (!Bool) -> ()
  }]

#check CombEg3
#eval CombEg3
#reduce CombEg3
#check CombEg3.denote
#print axioms CombEg3

def bv1' : BitVec 4 := BitVec.ofNat 4 5 -- 0010
def eqOp : CombOp.IcmpPredicate := CombOp.IcmpPredicate.ne

def test3 : Bool :=
  CombEg3.denote (Ctxt.Valuation.ofPair eqOp bv1')

#eval test3
