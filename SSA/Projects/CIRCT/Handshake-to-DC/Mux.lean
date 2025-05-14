import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

-- // CHECK:   hw.module @mux4(in %[[VAL_0:.*]] : !dc.value<i2>, in %[[VAL_1:.*]] : !dc.value<i64>, in %[[VAL_2:.*]] : !dc.value<i64>, in %[[VAL_3:.*]] : !dc.value<i64>, in %[[VAL_4:.*]] : !dc.value<i64>, out out0 : !dc.value<i64>) {
-- // CHECK:           %[[VAL_5:.*]], %[[VAL_6:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i2>
-- // CHECK:           %[[VAL_7:.*]], %[[VAL_8:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
-- // CHECK:           %[[VAL_9:.*]], %[[VAL_10:.*]] = dc.unpack %[[VAL_2]] : !dc.value<i64>
-- // CHECK:           %[[VAL_11:.*]], %[[VAL_12:.*]] = dc.unpack %[[VAL_3]] : !dc.value<i64>
-- // CHECK:           %[[VAL_13:.*]], %[[VAL_14:.*]] = dc.unpack %[[VAL_4]] : !dc.value<i64>
-- // CHECK:           %[[VAL_15:.*]] = arith.constant 0 : i2
-- // CHECK:           %[[VAL_16:.*]] = arith.cmpi eq, %[[VAL_6]], %[[VAL_15]] : i2
-- // CHECK:           %[[VAL_17:.*]] = arith.select %[[VAL_16]], %[[VAL_10]], %[[VAL_8]] : i64
-- // CHECK:           %[[VAL_18:.*]] = dc.pack %[[VAL_5]], %[[VAL_16]] : i1
-- // CHECK:           %[[VAL_19:.*]] = dc.select %[[VAL_18]], %[[VAL_9]], %[[VAL_7]]
-- // CHECK:           %[[VAL_20:.*]] = arith.constant 1 : i2
-- // CHECK:           %[[VAL_21:.*]] = arith.cmpi eq, %[[VAL_6]], %[[VAL_20]] : i2
-- // CHECK:           %[[VAL_22:.*]] = arith.select %[[VAL_21]], %[[VAL_12]], %[[VAL_17]] : i64
-- // CHECK:           %[[VAL_23:.*]] = dc.pack %[[VAL_5]], %[[VAL_21]] : i1
-- // CHECK:           %[[VAL_24:.*]] = dc.select %[[VAL_23]], %[[VAL_11]], %[[VAL_19]]
-- // CHECK:           %[[VAL_25:.*]] = arith.constant -2 : i2
-- // CHECK:           %[[VAL_26:.*]] = arith.cmpi eq, %[[VAL_6]], %[[VAL_25]] : i2
-- // CHECK:           %[[VAL_27:.*]] = arith.select %[[VAL_26]], %[[VAL_14]], %[[VAL_22]] : i64
-- // CHECK:           %[[VAL_28:.*]] = dc.pack %[[VAL_5]], %[[VAL_26]] : i1
-- // CHECK:           %[[VAL_29:.*]] = dc.select %[[VAL_28]], %[[VAL_13]], %[[VAL_24]]
-- // CHECK:           %[[VAL_30:.*]] = dc.pack %[[VAL_29]], %[[VAL_27]] : i64
-- // CHECK:           hw.output %[[VAL_30]] : !dc.value<i64>
-- // CHECK:         }
-- handshake.func @mux4(%select : i2, %a : i64, %b : i64, %c : i64, %d : i64) -> i64{
--   %0 = handshake.mux %select [%a, %b, %c, %d] : i2, i64
--   return %0 : i64
-- }

-- usede bools for convenience
unseal String.splitOnAux in
def mux := [DC_com| {
  ^entry(%0: !ValueStream_Bool, %1: !ValueStream_Bool, %2: !ValueStream_Bool, %3: !ValueStream_Bool, %4: !ValueStream_Bool):
    %unpack0 = "DC.unpack" (%0) : (!ValueStream_Bool) -> (!ValueTokenStream_Bool)
    %unpack1 = "DC.unpack" (%1) : (!ValueStream_Bool) -> (!ValueTokenStream_Bool)
    %unpack2 = "DC.unpack" (%2) : (!ValueStream_Bool) -> (!ValueTokenStream_Bool)
    %unpack3 = "DC.unpack" (%3) : (!ValueStream_Bool) -> (!ValueTokenStream_Bool)
    %unpack4 = "DC.unpack" (%4) : (!ValueStream_Bool) -> (!ValueTokenStream_Bool)
    %unpack01 = "DC.fstVal" (%unpack0) : (!ValueTokenStream_Bool) -> (!ValueStream_Bool)
    %unpack02 = "DC.sndVal" (%unpack0) : (!ValueTokenStream_Bool) -> (!TokenStream)
    %unpack11 = "DC.fstVal" (%unpack1) : (!ValueTokenStream_Bool) -> (!ValueStream_Bool)
    %unpack12 = "DC.sndVal" (%unpack1) : (!ValueTokenStream_Bool) -> (!TokenStream)
    %unpack21 = "DC.fstVal" (%unpack2) : (!ValueTokenStream_Bool) -> (!ValueStream_Bool)
    %unpack22 = "DC.sndVal" (%unpack2) : (!ValueTokenStream_Bool) -> (!TokenStream)
    %unpack31 = "DC.fstVal" (%unpack3) : (!ValueTokenStream_Bool) -> (!ValueStream_Bool)
    %unpack32 = "DC.sndVal" (%unpack3) : (!ValueTokenStream_Bool) -> (!TokenStream)
    %unpack41 = "DC.fstVal" (%unpack4) : (!ValueTokenStream_Bool) -> (!ValueStream_Bool)
    %unpack42 = "DC.sndVal" (%unpack4) : (!ValueTokenStream_Bool) -> (!TokenStream)
    -- packing and selecting other input Bool values since we have no `arith` operations
    %pack1 = "DC.pack" (%unpack11, %unpack02) : (!ValueStream_Bool, !TokenStream) -> (!ValueStream_Bool)
    %select1 = "DC.select" (%unpack22, %unpack12, %pack1) : (!TokenStream, !TokenStream, !ValueStream_Bool) -> (!TokenStream)
    %pack2 = "DC.pack" (%unpack21, %unpack02) : (!ValueStream_Bool, !TokenStream) -> (!ValueStream_Bool)
    %select2 = "DC.select" (%select1, %unpack32, %pack2) : (!TokenStream, !TokenStream, !ValueStream_Bool) -> (!TokenStream)
    %pack3 = "DC.pack" (%unpack31, %unpack02) : (!ValueStream_Bool, !TokenStream) -> (!ValueStream_Bool)
    %select3 = "DC.select" (%select2, %unpack42, %pack3) : (!TokenStream, !TokenStream, !ValueStream_Bool) -> (!TokenStream)
    %pack4 = "DC.pack" (%unpack41, %select3) : (!ValueStream_Bool, !TokenStream) -> (!ValueStream_Bool)
    "return" (%pack4) : (!ValueStream_Bool) -> ()
  }]

#check mux
#eval mux
#reduce mux
#check mux.denote
#print axioms mux

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def a : DCOp.ValueStream Bool := ofList [true, true, none, none, false]
def b : DCOp.ValueStream Bool := ofList [true, true, none, none, false]
def c : DCOp.ValueStream Bool := ofList [true, true, none, none, false]
def d : DCOp.ValueStream Bool := ofList [true, true, none, none, false]
def e : DCOp.ValueStream Bool := ofList [true, true, none, none, false]

def test : DCOp.ValueStream Bool :=
  mux.denote (Ctxt.Valuation.ofHVector (.cons a <| .cons b <| .cons c <| .cons d <| .cons e <| .nil))
