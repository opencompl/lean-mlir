import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

-- // CHECK-LABEL:   hw.module @constant(out out0 : !dc.value<i32>) {
-- // CHECK:           %[[VAL_1:.*]] = dc.source
-- // CHECK:           %[[VAL_2:.*]] = arith.constant 42 : i32
-- // CHECK:           %[[VAL_3:.*]] = dc.pack %[[VAL_1]], %[[VAL_2]] : i32
-- // CHECK:           hw.output %[[VAL_3]] : !dc.value<i32>
-- // CHECK:         }
-- handshake.func @constant() -> (i32) {
--   %0 = arith.constant 42 : i32
--   return %0 : i32
-- }

-- added int input because we can't declare actual int values AFAIK
unseal String.splitOnAux in
def sourcePack := [DC_com| {
  ^entry(%0 : !ValueStream_Int):
    %source = "DC.source" (%0) : () -> (!ValueStream_Int)
    -- again avoiding `arith` operation
    %packSource = "DC.pack" (%0, %source) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    "return" (%packSource) : (!ValueStream_Int) -> ()
  }]

#check sourcePack
#eval sourcePack
#reduce sourcePack
#check sourcePack.denote
#print axioms sourcePack

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCOp.ValueStream Int := ofList [some 1, none, some 2, some 5, none]

def test : DCOp.ValueStream Int :=
  sourcePack.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))
