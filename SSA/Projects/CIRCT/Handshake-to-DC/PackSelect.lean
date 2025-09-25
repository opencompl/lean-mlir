import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import LeanMLIR.Tactic

namespace CIRCTStream
namespace Stream.Bisim

-- // CHECK:   hw.module @mux(in %[[VAL_0:.*]] : !dc.value<i1>, in %[[VAL_1:.*]] : !dc.value<i64>, in %[[VAL_2:.*]] : !dc.value<i64>, out out0 : !dc.value<i64>) {
-- // CHECK:           %[[VAL_3:.*]], %[[VAL_4:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i1>
-- // CHECK:           %[[VAL_5:.*]], %[[VAL_6:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
-- // CHECK:           %[[VAL_7:.*]], %[[VAL_8:.*]] = dc.unpack %[[VAL_2]] : !dc.value<i64>
-- // CHECK:           %[[VAL_9:.*]] = arith.constant false
-- // CHECK:           %[[VAL_10:.*]] = arith.cmpi eq, %[[VAL_4]], %[[VAL_9]] : i1
-- // CHECK:           %[[VAL_11:.*]] = arith.select %[[VAL_10]], %[[VAL_8]], %[[VAL_6]] : i64
-- // CHECK:           %[[VAL_12:.*]] = dc.pack %[[VAL_3]], %[[VAL_10]] : i1
-- // CHECK:           %[[VAL_13:.*]] = dc.select %[[VAL_12]], %[[VAL_7]], %[[VAL_5]]
-- // CHECK:           %[[VAL_14:.*]] = dc.pack %[[VAL_13]], %[[VAL_11]] : i64
-- // CHECK:           hw.output %[[VAL_14]] : !dc.value<i64>
-- // CHECK:         }
-- handshake.func @mux(%select : i1, %a : i64, %b : i64) -> i64{
--   %0 = handshake.mux %select [%a, %b] : i1, i64
--   return %0 : i64
-- }

-- since again we cannot generate `arith` constants we shall use `%2: !ValueStream_Bool`
unseal String.splitOnAux in
def packSelect := [DC_com| {
  ^entry(%0: !ValueStream_Int, %1: !ValueStream_Int, %2: !ValueStream_Int, %3: !ValueStream_Bool):
    %unpack0 = "DC.unpack" (%0) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack1 = "DC.unpack" (%1) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack2 = "DC.unpack" (%2) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack01 = "DC.fstVal" (%unpack0) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack02 = "DC.sndVal" (%unpack0) : (!ValueTokenStream_Int) -> (!TokenStream)
    %unpack11 = "DC.fstVal" (%unpack1) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack12 = "DC.sndVal" (%unpack1) : (!ValueTokenStream_Int) -> (!TokenStream)
    %unpack21 = "DC.fstVal" (%unpack2) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack22 = "DC.sndVal" (%unpack2) : (!ValueTokenStream_Int) -> (!TokenStream)
    -- ignore `arith` operations:
    -- // CHECK:           %[[VAL_10:.*]] = arith.cmpi eq, %[[VAL_4]], %[[VAL_9]] : i1
    -- // CHECK:           %[[VAL_11:.*]] = arith.select %[[VAL_10]], %[[VAL_8]], %[[VAL_6]] : i64
    %pack1 = "DC.pack" (%3, %unpack02) : (!ValueStream_Bool, !TokenStream) -> (!ValueStream_Bool)
    %select = "DC.select" (%unpack22, %unpack12, %pack1) : (!TokenStream, !TokenStream, !ValueStream_Bool) -> (!TokenStream)
    %pack2 = "DC.pack" (%unpack21, %select) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    "return" (%pack2) : (!ValueStream_Int) -> ()
  }]

#check packSelect
#eval packSelect
#reduce packSelect
#check packSelect.denote
#print axioms packSelect

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCOp.ValueStream Int := ofList [some 1, none, some 2, some 5, none]
def y : DCOp.ValueStream Int := ofList [some 1, some 2, none, none, some 3]
def z : DCOp.ValueStream Int := ofList [some 1, some 2, none, none, some 3]
def c : DCOp.ValueStream Bool := ofList [true, true, none, none, false]



def test : DCOp.ValueStream Int :=
  packSelect.denote (Ctxt.Valuation.ofHVector (.cons c <| .cons z <| .cons y <| .cons x <| .nil))
