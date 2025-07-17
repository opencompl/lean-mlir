import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
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
  ^entry(%0: !ValueStream_8, %1: !ValueStream_8):
    %unpack0 = "DCxComb.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %unpack1 = "DCxComb.unpack" (%1) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %unpack01 = "DCxComb.fstVal" (%unpack0) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %unpack02 = "DCxComb.sndVal" (%unpack0) : (!ValueTokenStream_8) -> (!TokenStream)
    %unpack11 = "DCxComb.fstVal" (%unpack1) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %unpack12 = "DCxComb.sndVal" (%unpack1) : (!ValueTokenStream_8) -> (!TokenStream)
    %join01 = "DCxComb.join" (%unpack02, %unpack12) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %slt = "DCxComb.icmp_slt" (%unpack01, %unpack11) : (!ValueStream_8, !ValueStream_8) -> (!ValueStream_8)
    -- here we have an `arith` operation whose result we should pack :
    -- // CHECK:           %[[VAL_8:.*]] = arith.cmpi slt, %[[VAL_4]], %[[VAL_6]] : i64
    -- instead, I am packing `%unpack01`, for the time being
    %pack = "DCxComb.pack" (%unpack01, %join01) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    %unpackPack = "DCxComb.unpack" (%pack) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %unpack0Pack1 = "DCxComb.fstVal" (%unpackPack) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %unpack0Pack2 = "DCxComb.sndVal" (%unpackPack) : (!ValueTokenStream_8) -> (!TokenStream)
    %unpack0Bis = "DCxComb.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %unpack0Bis1 = "DCxComb.fstVal" (%unpack0Bis) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %unpack0Bis2 = "DCxComb.sndVal" (%unpack0Bis) : (!ValueTokenStream_8) -> (!TokenStream)
    -- we currently don't support n-ary joins so will keep it binary for now
    %joinPackBis = "DCxComb.join" (%unpack0Bis2, %unpack0Pack2) : (!TokenStream, !TokenStream) -> (!TokenStream)
    -- again avoiding `arith` operation
    %packBis = "DCxComb.pack" (%unpack0Bis1, %joinPackBis) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    "return" (%packBis) : (!ValueStream_8) -> ()
  }]

#check joinPackUnpack
#eval joinPackUnpack
#reduce joinPackUnpack
#check joinPackUnpack.denote
#print axioms joinPackUnpack

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def x : DCOp.ValueStream (BitVec 8) := ofList [some 1, none, some 2, some 5, none]
def y : DCOp.ValueStream (BitVec 8) := ofList [some 1, some 2, none, none, some 3]

def test : DCOp.ValueStream (BitVec 8) :=
  joinPackUnpack.denote (Ctxt.Valuation.ofHVector (.cons x <| .cons y <| .nil))
