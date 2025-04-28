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
    ^entry(%0: i4, %1 : i4):
      %2 = "Comb.add" (%0, %1) : (i4, i4) -> i4
      "return" (%2) : (i4) -> ()
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
  ^entry(%0: i4, %1 : i4):
    %2 = "Comb.icmp_slt" (%0, %1) : (i4, i4) -> !Bool
    "return" (%2) : (!Bool) -> ()
  }]

#check CombEg3
#eval CombEg3
#reduce CombEg3
#check CombEg3.denote
#print axioms CombEg3

def bv1' : BitVec 4 := BitVec.ofNat 4 1
def bv2' : BitVec 4 := BitVec.ofNat 4 6

def test3 : Bool :=
  CombEg3.denote (Ctxt.Valuation.ofPair bv2' bv1')

#eval test3

def CombEg4 := [Comb_com| {
  ^entry(%0: i4, %1 : i4):
    %2 = "Comb.icmp_eq" (%0, %1) : (i4, i4) -> !Bool
    "return" (%2) : (!Bool) -> ()
  }]

#check CombEg4
#eval CombEg4
#reduce CombEg4
#check CombEg4.denote
#print axioms CombEg4

def bv1'' : BitVec 4 := BitVec.ofNat 4 3
def bv2'' : BitVec 4 := BitVec.ofNat 4 3

def test4 : Bool :=
  CombEg4.denote (Ctxt.Valuation.ofPair bv2'' bv1'')

#eval test4

def CombEg5 := [Comb_com| {
  ^entry(%0: i1, %1: i1):
    %2 = "Comb.replicate_3" (%0) : (i1) -> (i3)
    "return" (%2) : (i3) -> ()
}]

#check CombEg5
#eval CombEg5
#reduce CombEg5
#check CombEg5.denote
#print axioms CombEg5

def bv0 : BitVec 1 := BitVec.ofNat 1 1

def test5 : BitVec 3 :=
  CombEg5.denote (Ctxt.Valuation.ofPair bv0 bv0)

#eval test5
