import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import LeanMLIR.Tactic

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
def joinPackUnpack := [DC_com| {
  ^entry(%0: !ValueStream_Int, %1: !ValueStream_Int):
    %unpack0 = "DC.unpack" (%0) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack1 = "DC.unpack" (%1) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack01 = "DC.fstVal" (%unpack0) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack02 = "DC.sndVal" (%unpack0) : (!ValueTokenStream_Int) -> (!TokenStream)
    %unpack11 = "DC.fstVal" (%unpack1) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack12 = "DC.sndVal" (%unpack1) : (!ValueTokenStream_Int) -> (!TokenStream)
    %join01 = "DC.join" (%unpack02, %unpack12) : (!TokenStream, !TokenStream) -> (!TokenStream)
    -- here we have an `arith` operation whose result we should pack :
    -- // CHECK:           %[[VAL_8:.*]] = arith.cmpi slt, %[[VAL_4]], %[[VAL_6]] : i64
    -- instead, I am packing `%unpack01`, for the time being
    %pack = "DC.pack" (%unpack01, %join01) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    %unpackPack = "DC.unpack" (%pack) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack0Pack1 = "DC.fstVal" (%unpackPack) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack0Pack2 = "DC.sndVal" (%unpackPack) : (!ValueTokenStream_Int) -> (!TokenStream)
    %unpack0Bis = "DC.unpack" (%0) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack0Bis1 = "DC.fstVal" (%unpack0Bis) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack0Bis2 = "DC.sndVal" (%unpack0Bis) : (!ValueTokenStream_Int) -> (!TokenStream)
    -- we currently don't support n-ary joins so will keep it binary for now
    %joinPackBis = "DC.join" (%unpack0Bis2, %unpack0Pack2) : (!TokenStream, !TokenStream) -> (!TokenStream)
    -- again avoiding `arith` operation
    %packBis = "DC.pack" (%unpack0Bis1, %joinPackBis) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    "return" (%packBis) : (!ValueStream_Int) -> ()
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
