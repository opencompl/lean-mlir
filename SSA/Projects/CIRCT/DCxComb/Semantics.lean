import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet

namespace CIRCTStream
namespace DCxCombOp

def ValueStream := Stream

def TokenStream := Stream Unit

instance : ToString TokenStream where
  toString s := toString (Stream.toList 100 s)

/- First thing we need it to pop a value from the stream of int -/

def popReady (s : ValueStream (BitVec w)) (n : Nat) : BitVec w :=
  if 0 < n then
    match s.head with
    | some e => e
    | _ => popReady s.tail (n - 1)
  else
    0#w

def pushReady (v : BitVec w) (n : Nat): (ValueStream (BitVec n)) := CIRCTStream.Stream.ofList [(v.setWidth n)]

def unpack (x : ValueStream (BitVec w)) : ValueStream (BitVec w) × TokenStream :=
  Stream.corec₂ (β := Stream (BitVec w)) (x)
    fun x => Id.run <| do
      match x 0 with
      | some _ => return (x 0, some (), x.tail)
      | none => return (none, none, x.tail)


-- stream : ... some x, none, some y, none, none ...
-- cycles : ... [checkReady] x, [checkReady] -
-- cycles: state transition relations: State -> Option value -> Option value -> Option value -> State -> Prop

-- hardware semantics: stream based semantics for hardware, timing sensitive, you will have a similar transformation
-- when going from latency insensitive streams to combinational streams.

-- purely combinational region!

-- symbolic eval at dc level, use pack/unpack nodes and evaluate region in between and extract a fun from
-- there is basically the solution (denote comb-only region)--> only lift the fun once
-- we'll start with modelling everything as streams and move on with life


def pack (x : ValueStream α) (y : TokenStream) : ValueStream α :=
  Stream.corec (β := ValueStream α × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x₀, some _ => (x₀, (x.tail, y.tail))
    | some _, none => (none, (x, y.tail)) -- wait to sync with the token stream
    | none, some _ => (none, (x.tail, y)) -- wait to sync with the value stream
    | none, none => (none, (x.tail, y.tail))

def branch (x : ValueStream (BitVec 1)): TokenStream × TokenStream  :=
  Stream.corec₂ (β := ValueStream (BitVec 1)) x fun x =>
    Id.run <| do
      match x 0 with
        | none => (none, none, (x.tail))
        | some x₀ =>
          if x₀.msb then
            (some (), none, (x.tail))
          else
            (none, some (), (x.tail))

def fork (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream) x
    fun x => Id.run <| do
      (x 0, x 0, x.tail)

def add {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.add (0#w) l

def joinTwo (x y : TokenStream) : TokenStream  :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y.tail))
    | some _, none => (none, (x, y.tail))
    | none, some _ => (none, (x.tail, y))
    | none, none => (none, (x.tail, y.tail))

def join (l : List TokenStream) : TokenStream :=
  if hz : 0 < l.length then
    l.foldl joinTwo l[0]
  else
    Stream.ofList []

def merge (x y : TokenStream) : ValueStream (BitVec 1) :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some 1, (x.tail, y))
    | some _, none => (some 1, (x.tail, y.tail))
    | none, some _ => (some 0, (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

def select (x y : TokenStream) (c : ValueStream (BitVec 1)): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × Stream (BitVec 1)) (x, y, c) fun ⟨x, y, c⟩ =>
    match x 0, y 0, c 0 with
    | some _, some _, some c₀ =>
      if c₀.msb then -- it's just one bit
        (some (), (x.tail, y, c.tail))
      else
        (some (), (x.tail, y.tail, c.tail))
    | some _, none, some c₀ =>
      if c₀.msb then
        (some (), (x.tail, y.tail, c.tail))
      else
        (none, (x, y.tail, c))
    | none, some _, some c₀ =>
      if c₀.msb then
        (none, (x.tail, y, c))
      else
        (some (), (x.tail, y.tail, c))
    | _, _, none => (none, (x, y, c.tail))
    | none, none, some _ => (none, (x.tail, y.tail, c))

def sink (x : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream) x fun x => (none, x.tail)

def source : TokenStream :=
  Stream.corec () fun () => (some (), ())

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
def mux (x : BitVec w) (y : BitVec w) (cond : BitVec 1) : BitVec w :=
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

def typeSum_l (ts : BitVec w₁ ⊕ BitVec w₂) : BitVec w₁ :=
  match ts.getLeft? with
  | some bv => bv
  | none => 0#w₁

def typeSum_r (ts : BitVec w₁ ⊕ BitVec w₂) : BitVec w₂ :=
  match ts.getRight? with
  | some bv => bv
  | none => 0#w₂

end DCxCombOp
