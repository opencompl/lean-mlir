import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream

namespace CIRCTStream
namespace DC

abbrev ValueStream := Stream
abbrev TokenStream := Stream Unit

def unpack (x : Stream α) : ValueStream α × TokenStream :=
  Stream.corec₂ (β := Stream α) (x)
    fun x => Id.run <| do
      match x 0 with
      | some _ => return (x 0, some (), x.tail)
      | none => return (none, none, x.tail)

def pack (x : ValueStream α) (y : TokenStream) : Stream α :=
  Stream.corec (β := ValueStream α × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x₀, some _ => (x₀, (x.tail, y.tail))
    | some _, none => (none, (x, y.tail)) -- wait to sync with the token stream
    | none, some _ => (none, (x.tail, y)) -- wait to sync with the value stream
    | none, none => (none, (x.tail, y.tail))

-- weirdly enough the docs says that c must be a Value type (not token),
-- but I don't see how this would be useful? I left stream bool now, but I don't like it that much
def branch (x : TokenStream) (c : Stream Bool): TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream × Stream Bool) (x, c) fun ⟨x, c⟩ =>
    Id.run <| do
      match c 0, x 0 with
        | none, _ => (none, none, (x, c.tail))
        | _, none => (none, none, (x.tail, c))
        | some c₀, some _ =>
          if c₀ then
            (some (), none, (x.tail, c.tail))
          else
            (none, some (), (x.tail, c.tail))

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

def merge (x y : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y))
    | some _, none => (some (), (x.tail, y.tail))
    | none, some _ => (some (), (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

-- same issue as branch for the condition stream
def select (x y : TokenStream) (c : Stream Bool): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × Stream Bool) (x, y, c) fun ⟨x, y, c⟩ =>
    match x 0, y 0, c 0 with
    | some _, some _, some c₀ =>
      if c₀ then
        (some (), (x.tail, y, c.tail))
      else
        (some (), (x.tail, y.tail, c.tail))
    | some _, none, some c₀ =>
      if c₀ then
        (some (), (x.tail, y.tail, c.tail))
      else
        (none, (x, y.tail, c))
    | none, some _, some c₀ =>
      if c₀ then
        (none, (x.tail, y, c))
      else
        (some (), (x.tail, y.tail, c))
    | _, _, none => (none, (x, y, c.tail))
    | none, none, some _ => (none, (x.tail, y.tail, c))

def sink (x : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream) x fun x => (none, x.tail)

def source (a : Unit) : TokenStream :=
  Stream.corec a fun a => (some a, a)

end DC
end CIRCTStream

section Dialect

inductive Ty2
  | int : Ty2
  | bool : Ty2
deriving Inhabited, DecidableEq, Repr

inductive Op
| merge
| branch
| fork
| join
| select
| sink
| source
| pack
| unpack
deriving Inhabited, DecidableEq, Repr

end Dialect
