import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream


-- // CHECK:   hw.module @test_fork(in %[[VAL_0:.*]] : !dc.token, out out0 : !dc.token, out out1 : !dc.token) {
-- // CHECK:           %[[VAL_1:.*]]:2 = dc.fork [2] %[[VAL_0]]
-- // CHECK:           hw.output %[[VAL_1]]#0, %[[VAL_1]]#1 : !dc.token, !dc.token
-- // CHECK:         }
-- handshake.func @test_fork(%arg0: none) -> (none, none) {
--   %0:2 = fork [2] %arg0 : none
--   return %0#0, %0#1 : none, none
-- }

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

-- def join(x c : Stream) : Stream := sorry



-- stream semantics was a nice abstraction to avoid formalizing handshake protocols
-- can we still keep that?
-- we'd like to have better representation of the separation between control and data
-- this is most likely wrong but we need to think more
def unpack (x : ValueStream α) : Val × TokenStream := sorry


-- takes a stream and a value, packs the value into the token
def pack' (x : Option Bool) (stream : TokenStream) : ValueStream α := sorry

def pack (x : ValueStream α) (stream : TokenStream) : ValueStream α := x



end DC
