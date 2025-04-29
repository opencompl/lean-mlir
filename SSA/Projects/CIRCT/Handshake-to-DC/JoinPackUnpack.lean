import SSA.Projects.CIRCT.DCxComb.DCxComb

import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim


-- // CHECK:   hw.module @top(in %[[VAL_0:.*]] : !dc.value<i64>, in %[[VAL_1:.*]] : !dc.value<i64>, in %[[VAL_2:.*]] : !dc.token, out out0 : !dc.value<i64>, out out1 : !dc.token) {
-- // CHECK:           %[[VAL_3:.*]], %[[VAL_4:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i64>
-- // CHECK:           %[[VAL_5:.*]], %[[VAL_6:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
-- // CHECK:           %[[VAL_7:.*]] = dc.join %[[VAL_3]], %[[VAL_5]]
-- // CHECK:           %[[VAL_8:.*]] = arith.cmpi slt, %[[VAL_4]], %[[VAL_6]] : i64
-- // CHECK:           %[[VAL_9:.*]] = dc.pack %[[VAL_7]], %[[VAL_8]] : i1
-- // CHECK:           %[[VAL_10:.*]], %[[VAL_11:.*]] = dc.unpack %[[VAL_9]] : !dc.value<i1>
-- // CHECK:           %[[VAL_12:.*]], %[[VAL_13:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
-- // CHECK:           %[[VAL_14:.*]], %[[VAL_15:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i64>
-- // CHECK:           %[[VAL_16:.*]] = dc.join %[[VAL_10]], %[[VAL_12]], %[[VAL_14]]
-- // CHECK:           %[[VAL_17:.*]] = arith.select %[[VAL_11]], %[[VAL_13]], %[[VAL_15]] : i64
-- // CHECK:           %[[VAL_18:.*]] = dc.pack %[[VAL_16]], %[[VAL_17]] : i64
-- // CHECK:           hw.output %[[VAL_18]], %[[VAL_2]] : !dc.value<i64>, !dc.token
-- // CHECK:         }
-- handshake.func @top(%arg0: i64, %arg1: i64, %arg8: none, ...) -> (i64, none) {
--     %0 = arith.cmpi slt, %arg0, %arg1 : i64
--     %1 = arith.select %0, %arg1, %arg0 : i64
--     return %1, %arg8 : i64, none
-- }


-- also changed to return a single value, the third arg is not used anyways
unseal String.splitOnAux in
def joinPackUnpack := [DCxComb_com| {
  ^entry(%0: !ValueStream_64, %1: !ValueStream_64):
    -- // CHECK:           %[[VAL_3:.*]], %[[VAL_4:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i64>
    %unpack0 = "DCxComb.unpack" (%0) : (!ValueStream_64) -> (!ValueTokenStream_64)
    %unpack0val = "DCxComb.fstVal" (%unpack0) : (!ValueTokenStream_64) -> (!ValueStream_64)
    %unpack0tok = "DCxComb.sndVal" (%unpack0) : (!ValueTokenStream_64) -> (!TokenStream)
    -- // CHECK:           %[[VAL_5:.*]], %[[VAL_6:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
    %unpack1 = "DCxComb.unpack" (%1) : (!ValueStream_64) -> (!ValueTokenStream_64)
    %unpack1val = "DCxComb.fstVal" (%unpack1) : (!ValueTokenStream_64) -> (!ValueStream_64)
    %unpack1tok = "DCxComb.sndVal" (%unpack1) : (!ValueTokenStream_64) -> (!TokenStream)
    -- // CHECK:           %[[VAL_7:.*]] = dc.join %[[VAL_3]], %[[VAL_5]]
    %join01 = "DCxComb.join" (%unpack0tok, %unpack1tok) : (!TokenStream, !TokenStream) -> (!TokenStream)
    -- // CHECK:           %[[VAL_8:.*]] = arith.cmpi slt, %[[VAL_4]], %[[VAL_6]] : i64
    %readyVal0 = "DCxComb.popReady_100" (%unpack0val) : (!ValueStream_64) -> (i64)
    %readyVal1 = "DCxComb.popReady_100" (%unpack1val) : (!ValueStream_64) -> (i64)
    %slt = "DCxComb.icmp_slt" (%readyVal0, %readyVal1) : (i64, i64) -> (i1)
    %sltStream = "DCxComb.pushReady_1" (%slt) : (i1) -> (!ValueStream_1)
    -- // CHECK:           %[[VAL_9:.*]] = dc.pack %[[VAL_7]], %[[VAL_8]] : i1
    %pack = "DCxComb.pack" (%sltStream, %join01) : (!ValueStream_1, !TokenStream) -> (!ValueStream_1)
    -- // CHECK:           %[[VAL_10:.*]], %[[VAL_11:.*]] = dc.unpack %[[VAL_9]] : !dc.value<i1>
    %unpackP = "DCxComb.unpack" (%pack) : (!ValueStream_1) -> (!ValueTokenStream_1)
    %unpackPval = "DCxComb.fstVal" (%unpackP) : (!ValueTokenStream_1) -> (!ValueStream_1)
    %unpackPtok = "DCxComb.sndVal" (%unpackP) : (!ValueTokenStream_1) -> (!TokenStream)
    -- // CHECK:           %[[VAL_12:.*]], %[[VAL_13:.*]] = dc.unpack %[[VAL_1]] : !dc.value<i64>
    %unpackBis0 = "DCxComb.unpack" (%0) : (!ValueStream_64) -> (!ValueTokenStream_64)
    %unpackBis0val = "DCxComb.fstVal" (%unpackBis0) : (!ValueTokenStream_64) -> (!ValueStream_64)
    %unpackBis0tok = "DCxComb.sndVal" (%unpackBis0) : (!ValueTokenStream_64) -> (!TokenStream)
    -- // CHECK:           %[[VAL_14:.*]], %[[VAL_15:.*]] = dc.unpack %[[VAL_0]] : !dc.value<i64>
    %unpackBis1 = "DCxComb.unpack" (%1) : (!ValueStream_64) -> (!ValueTokenStream_64)
    %unpackBis1val = "DCxComb.fstVal" (%unpackBis1) : (!ValueTokenStream_64) -> (!ValueStream_64)
    %unpackBis1tok = "DCxComb.sndVal" (%unpackBis1) : (!ValueTokenStream_64) -> (!TokenStream)
    -- // CHECK:           %[[VAL_16:.*]] = dc.join %[[VAL_10]], %[[VAL_12]], %[[VAL_14]]]
    %joinPackBis = "DCxComb.join" (%unpackPtok, %unpackBis0tok, %unpackBis1tok) : (!TokenStream, !TokenStream, !TokenStream) -> (!TokenStream)
    -- // CHECK:           %[[VAL_17:.*]] = arith.select %[[VAL_11]], %[[VAL_13]], %[[VAL_15]] : i64
    %readyValP = "DCxComb.popReady_100" (%unpackPval) : (!ValueStream_1) -> (i1)
    %readyValBis0 = "DCxComb.popReady_100" (%unpackBis0val) : (!ValueStream_64) -> (i64)
    %readyValBis1 = "DCxComb.popReady_100" (%unpackBis1val) : (!ValueStream_64) -> (i64)
    %muxOut = "DCxComb.mux" (%readyValBis0, %readyValBis1, %readyValP) : (i64, i64, i1) -> (i64)
    -- // CHECK:           %[[VAL_18:.*]] = dc.pack %[[VAL_16]], %[[VAL_17]] : i64
    %streamVal = "DCxComb.pushReady_64" (%muxOut) : (i64) -> (!ValueStream_64)
    -- %packBis = "DCxComb.pack" (%muxOut, %joinPackBis) : (!ValueStream_64, !TokenStream) -> (!ValueStream_64)
    "return" (%0) : (!ValueStream_64) -> ()
  }]

#check joinPackUnpack
#eval joinPackUnpack
#reduce joinPackUnpack
#check joinPackUnpack.denote
#print axioms joinPackUnpack

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCOp.ValueStream Int := ofList [some 1, none, some 2, some 5, none]
def y : DCOp.ValueStream Int := ofList [some 1, some 2, none, none, some 3]

def test : DCOp.ValueStream Int :=
  joinPackUnpack.denote (Ctxt.Valuation.ofHVector (.cons x <| .cons y <| .nil))
