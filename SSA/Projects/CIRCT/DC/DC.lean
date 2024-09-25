import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream

namespace CIRCTStream
namespace DC

abbrev ValueStream := Stream
abbrev TokenStream := Stream Unit

def unpack (x : ValueStream α) : ValueStream α × TokenStream :=
  Stream.corec₂ (β := Stream α) (x)
    fun x => Id.run <| do
      match x 0 with
      | some _ => return (x 0, some (), x.tail)
      | none => return (none, none, x.tail)

def pack (x : ValueStream α) (y : TokenStream) : ValueStream α :=
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
| pack (t : Ty2)
| unpack (t : Ty2)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| tokenstream
| tokenstream2
| valuestream (ty2 : Ty2) : Ty -- A stream of values of type `ty2`.
| valuetokenstream (ty2 : Ty2) : Ty -- A product of streams of values of type `ty2`.
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty2 where
toType := fun
| Ty2.int => Int
| Ty2.bool => Bool

open TyDenote (toType) in
instance instDCTyDenote : TyDenote Ty where
toType := fun
| Ty.tokenstream => CIRCTStream.DC.TokenStream
| Ty.tokenstream2 => CIRCTStream.DC.TokenStream × CIRCTStream.DC.TokenStream
| Ty.valuestream ty2 => CIRCTStream.DC.ValueStream (toType ty2)
| Ty.valuetokenstream ty2 => CIRCTStream.DC.ValueStream (toType ty2) × CIRCTStream.DC.TokenStream

set_option linter.dupNamespace false in
abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .merge => [Ty.tokenstream, Ty.tokenstream]
  | .branch => [Ty.tokenstream, Ty.valuestream Ty2.bool]
  | .fork => [Ty.tokenstream]
  | .join => [Ty.tokenstream, Ty.tokenstream]
  | .select => [Ty.tokenstream, Ty.tokenstream, Ty.valuestream Ty2.bool]
  | .sink => [Ty.tokenstream]
  | .source => [Ty.tokenstream] -- how do i tell her it's a unit
  | .pack t => [Ty.valuestream t, Ty.tokenstream]
  | .unpack t => [Ty.valuestream t]

-- return type CONF
@[simp, reducible]
def Op.outTy : Op → Ty
  | .merge => Ty.tokenstream
  | .branch => Ty.tokenstream2
  | .fork => Ty.tokenstream2
  | .join => Ty.tokenstream
  | .select => Ty.tokenstream
  | .sink => Ty.tokenstream
  | .source => Ty.tokenstream -- how do i tell her it's a unit
  | .pack t => Ty.valuestream t
  | .unpack t => Ty.valuetokenstream t

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature DC := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (DC) where
    denote
    | .unpack _, arg, _ => CIRCTStream.DC.unpack (arg.getN 0)
    | .pack _, arg, _  => CIRCTStream.DC.pack (arg.getN 0) (arg.getN 1)
    | .branch, arg, _  => CIRCTStream.DC.branch (arg.getN 0) (arg.getN 1)
    | .fork, arg, _  => CIRCTStream.DC.fork (arg.getN 0)
    | .join, arg, _  => CIRCTStream.DC.join (arg.getN 0) (arg.getN 1)
    | .merge, arg, _  => CIRCTStream.DC.merge (arg.getN 0) (arg.getN 1)
    | .select, arg, _  => CIRCTStream.DC.select (arg.getN 0) (arg.getN 1) (arg.getN 2)
    | .sink, arg, _  => CIRCTStream.DC.sink (arg.getN 0)
    | .source, _, _  => CIRCTStream.DC.source ()



end Dialect
