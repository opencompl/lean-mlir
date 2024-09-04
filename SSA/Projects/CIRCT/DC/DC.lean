import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream

namespace CIRCTStream
namespace DC

abbrev ValueStream := Stream
abbrev TokenStream := Stream Unit

def DCToken := Stream' Unit
def DCValue := Stream' Type

-- take a stream x in input, dequeue x0
def fork (x : Stream α) : Stream α × Stream α :=
  Stream.corec₂ (β := Stream α) x
    fun x => Id.run <| do
      let x0 := x 0
      let x' := x.tail
      (x0, x0, x')


-- stream semantics was a nice abstraction to avoid formalizing handshake protocols
-- can we still keep that?
-- we'd like to have better representation of the separation between control and data
-- this is most likely wrong but we need to think more
def unpack (x : ValueStream α) : Val × TokenStream := sorry


-- takes a stream and a value, packs the value into the token
def pack' (x : α) (stream : TokenStream) : ValueStream α :=
  Stream.corec (β := TokenStream) (stream)
    fun t => Id.run <| do
      match t 0 with
      | some _ => return (some x, t.tail)
      | none => return (none, t.tail)

def pack (x : ValueStream α) (stream : TokenStream) : ValueStream α := x


end DC

namespace DC'

inductive Token (A : Type _) where
  | consumed
  | ready (a : A)
  | notready

abbrev DCValue A := Token A
abbrev DCToken := DCValue Unit

def merge : DCToken × DCToken × DCToken → ( → Prop
-- if a.ready ∧ b.read => change a to consumed, b remains ready, outpt
end DC'

end CIRCTStream
