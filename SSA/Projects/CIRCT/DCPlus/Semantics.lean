import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet

namespace CIRCTStream
namespace DCPlusOp

def ValueStream := Stream

def TokenStream := Stream Unit

def VariadicValueStream (w : Nat) := CIRCTStream.Stream (List (BitVec w))

def fork (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream) x
    fun x => Id.run <| do
      (x 0, x 0, x.tail)

def join (x y : TokenStream) : TokenStream  :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y.tail))
    | some _, none => (none, (x, y.tail))
    | none, some _ => (none, (x.tail, y))
    | none, none => (none, (x.tail, y.tail))

def merge (x y : TokenStream) : ValueStream (BitVec 1) :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some 1, (x.tail, y))
    | some _, none => (some 1, (x.tail, y.tail))
    | none, some _ => (some 0, (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

def mux (x y : TokenStream) (c : ValueStream (BitVec 1)): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × ValueStream (BitVec 1)) (x, y, c)
  fun ⟨x, y, c⟩ =>
    match (c 0) with
    | none => (none, x, y, c.tail) -- wait on 'c'.
    | some 1#1 =>
      match (x 0) with
      | none => (none, x.tail, y, c) -- have 'c', wait on 'x'.
      | some _ => (some (), x.tail, y, c.tail) -- consume 'c' and 'x'.
    | some 0#1 =>
      match (y 0) with
      | none => (none, x, y.tail, c) -- hace 'c', wait on 'y'.
      | some _ => (some (), x, y.tail, c.tail) -- consume 'c' and 'y'.

def cMerge (x y : TokenStream) : ValueStream (BitVec 1) × TokenStream :=
  Stream.corec₂ (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (some 1, some x', (x.tail, y))
    | some x', none => (some 1, some x', (x.tail, y.tail))
    | none, some y' => (some 0, some y', (x.tail, y.tail))
    | none, none => (none, none, (x.tail, y.tail))

def branch (c : ValueStream (BitVec 1)) (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := ValueStream (BitVec 1) × TokenStream) (c, x) fun ⟨c, x⟩ =>
    Id.run <| do
      match c 0 with
        | none => (none, none, (c.tail, x))
        | some x₀ =>
          if x₀.msb then
            (some (), none, (c.tail, x.tail))
          else
            (none, some (), (c.tail, x.tail))

def source : TokenStream :=
  Stream.corec () fun () => (some (), ())

def sink (x : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream) x fun x => (none, x.tail)

def supp (c : ValueStream (BitVec 1)) (x : TokenStream) : TokenStream := (branch c x).snd

end DCPlusOp

end CIRCTStream
