import LeanMLIR

import SSA.Projects.CIRCT.Comb.Comb

open MLIR AST in

unseal String.splitOnAux in
def CombEg1 := [Comb_com| {
  ^entry(%0: i1):
    "return" (%0) : (i1) -> ()
  }]

#check CombEg1
#reduce CombEg1
#check CombEg1.denote
#print axioms CombEg1

def CombEg2 := [Comb_com| {
    ^entry(%0: i4, %1 : i4, %2 : i4):
      %3 = "Comb.add" (%0, %1, %2) : (i4, i4, i4) -> i4
      "return" (%3) : (i4) -> ()
    }]

#print CombEg2
#reduce CombEg2
#check CombEg2
#print axioms CombEg2

def bv1 : BitVec 4 := BitVec.ofNat 4 5 -- 0010
def bv2 : BitVec 4 := BitVec.ofNat 4 1 -- 0011
def bv3 : BitVec 4 := BitVec.ofNat 4 2 -- 0011



def CombEg3 := [Comb_com| {
  ^entry(%0: i4, %1 : i4):
    %2 = "Comb.icmp_slt" (%0, %1) : (i4, i4) -> i1
    "return" (%2) : (i1) -> ()
  }]

#check CombEg3
#reduce CombEg3
#check CombEg3.denote
#print axioms CombEg3

def bv1' : BitVec 4 := BitVec.ofNat 4 1
def bv2' : BitVec 4 := BitVec.ofNat 4 6


def CombEg4 := [Comb_com| {
  ^entry(%0: i4, %1 : i4):
    %2 = "Comb.icmp_eq" (%0, %1) : (i4, i4) -> i1
    "return" (%2) : (i1) -> ()
  }]

#check CombEg4
#reduce CombEg4
#check CombEg4.denote
#print axioms CombEg4

def bv1'' : BitVec 4 := BitVec.ofNat 4 3
def bv2'' : BitVec 4 := BitVec.ofNat 4 3


def CombEg5 := [Comb_com| {
  ^entry(%0: i1, %1: i1):
    %2 = "Comb.replicate_3" (%0) : (i1) -> (i3)
    "return" (%2) : (i3) -> ()
}]

#check CombEg5
#reduce CombEg5
#check CombEg5.denote
#print axioms CombEg5

def bv0 : BitVec 1 := BitVec.ofNat 1 1


def CombEg6 := [Comb_com| {
    ^entry (%0 : i4, %1 : i4, %2 : i1):
      %3 = "Comb.mux" (%0, %1, %2) : (i4, i4, i1) -> i4
      "return" (%3) : (i4) -> ()
}]

#check CombEg6
#reduce CombEg6
#check CombEg6.denote
#print axioms CombEg6

def bv6₁ : BitVec 4 := BitVec.ofNat 4 1
def bv6₂ : BitVec 4 := BitVec.ofNat 4 3
def bv6c : BitVec 1 := BitVec.ofNat 1 1
