import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2

namespace CombOp

inductive IcmpPredicate where
  | eq
  | ne
  | slt
  | sle
  | sgt
  | sge
  | ult
  | ule
  | ugt
  | uge
deriving Inhabited, DecidableEq, Repr

instance : ToString IcmpPredicate where
  toString
  | .eq  => "eq"
  | .ne  => "ne"
  | .slt => "slt"
  | .sle => "sle"
  | .sgt => "sgt"
  | .sge => "sge"
  | .ult => "ult"
  | .ule => "ule"
  | .ugt => "ugt"
  | .uge => "uge"

/-- Variadic `add` operation with a list of bitvectors with width `w` as input -/
def add {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.add (0#w) l

/-- Variadic `and` operation with a list of bitvectors with width `w` as input -/
def and {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.and (0#w) l

/-- Concatenate a list of bitvecs `xs`, where the length of bitvec `xs[i]` is given by
  element `ls[i]` in a list of nat `ls` -/
def concat {ls : List Nat} (xs : HVector BitVec ls) : BitVec (List.sum ls) :=
  match (xs) with
  | (.nil) => 0#0
  | (.cons x xs) =>
     let xsSum := concat xs
     x ++ xsSum

/-- Extract the `lb` lower bits from BitVec `x` -/
def extract (x : BitVec w) (lb : Nat) : BitVec (w - lb) :=
  BitVec.truncate (w - lb) (BitVec.ushiftRight x lb)

/-- Boolean comparison between two input BitVecs -/
def icmp {w : Nat} (p : IcmpPredicate) (x y : BitVec w) : BitVec 1 :=
  match p with
  | .eq  => BitVec.ofBool (x == y)
  | .ne => BitVec.ofBool (x != y)
  | .sgt => BitVec.ofBool (y.slt x)
  | .sge => BitVec.ofBool (y.sle x)
  | .slt => BitVec.ofBool (x.slt y)
  | .sle => BitVec.ofBool (x.sle y)
  | .ugt => BitVec.ofBool (x > y)
  | .uge => BitVec.ofBool (x ≥ y)
  | .ult => BitVec.ofBool (x < y)
  | .ule => BitVec.ofBool (x ≤ y)

/-- Variadic `mul` operation with a list of bitvectors with width `w` as input -/
def mul {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.mul (1#w) l

/- Generic `mux` operation for any types α, β -/
def mux (x : BitVec w) (y : BitVec w) (cond : BitVec q) : BitVec w :=
  if cond.msb then x else y

/-- Variadic `or` operation with a list of bitvectors with width `w` as input -/
def or {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.or (BitVec.zero w) l

/-- Returns boolean parity value of BitVec `x` -/
def parity (x : BitVec w) : BitVec 1 :=
  BitVec.ofBool ((BitVec.umod x 2#w) == 1)

/-- Replicate input BitVec `x` `n` times -/
def replicate (x : BitVec w) (n : Nat) : BitVec (w * n) :=
  BitVec.replicate n x

/-- Shift left -/
def shl (x y : BitVec w) : BitVec w :=
  x <<< y

/-- Unsigned shift right -/
def shru (x y : BitVec w) : BitVec w :=
  BitVec.ushiftRight x y.toNat

/-- Variadic `xor` operation with a list of bitvectors with width `w` as input -/
def xor {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.xor (BitVec.zero w) l

end CombOp
