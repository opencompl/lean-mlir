import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.HSxComb.HSxCombFunctor
import SSA.Projects.CIRCT.Comb.Comb


namespace CIRCTStream

open MLIR AST in

instance : ToString DCOp.TokenStream where
  toString s := toString (Stream.toList 10 s)

instance : ToString (CIRCTStream.Stream (BitVec w))where
  toString s := toString (Stream.toList 10 s)

instance [ToString w] : ToString (Option w) where
  toString
    | some x => s!"(some {toString x})"
    | none   => "(none)"

instance [ToString w] : ToString (DCOp.ValueStream w) where
  toString s := toString (Stream.toList 10 s)

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals[i]?).join

/--
We start from the Handshake circuit:
  handshake.func @add(%a : i32, %b : i32, %none: none) -> i32{
    %add1 = comb.add %a, %a : i32
    %syncadd:3 = handshake.sync %none, %add1, %b : none, i32, i32
    %add2 = comb.add %syncadd#1, %a : i32
    return %add2: i32
  }
-/
def handshakeAdd := [HSxComb_com| {
  ^entry(%a: !Stream_BitVec_32, %b: !Stream_BitVec_32):
    %add1 = "HSxComb.add" (%a, %a) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream_BitVec_32)
    %syncAdd = "HSxComb.sync" (%add1, %b) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream2_BitVec_32)
    %syncAdd1 = "HSxComb.snd" (%syncAdd) : (!Stream2_BitVec_32) -> !Stream_BitVec_32
    %add2 = "HSxComb.add" (%syncAdd1, %a) : (!Stream_BitVec_32, !Stream_BitVec_32) -> (!Stream_BitVec_32)
    "return" (%add2) : (!Stream_BitVec_32) -> ()
  }]

/--
We obtain the DC circuit from here: https://github.com/luisacicolini/circt/blob/simulation-dc-examples/simulation-example/test-add/add-to-dc-m1-c-m2.mlir
after lowering, materialization and canonicalization passes.
  module {
    hw.module @add(in %a : !dc.value<i32>, in %b : !dc.value<i32>, in %none : !dc.token, in %clk : !seq.clock {dc.clock}, in %rst : i1 {dc.reset}, out out0 : !dc.value<i32>) {
      %false = hw.constant false
      %token, %output = dc.unpack %a : !dc.value<i32>
      %0:3 = dc.fork [3] %token
      %1 = comb.extract %output from 0 : (i32) -> i31
      %2 = comb.concat %1, %false : i31, i1
      %token_0, %output_1 = dc.unpack %b : !dc.value<i32>
      %3 = dc.join %0#0, %none, %token_0, %0#2, %0#1
      %4 = comb.add %2, %output : i32
      %5 = dc.pack %3, %4 : i32
      hw.output %5 : !dc.value<i32>
    }
  }
-/
def DCcanAdd := [DCxComb_com| {
  ^entry(%a: !ValueStream_32, %b: !ValueStream_32):
    %unpacka = "DCxComb.unpack" (%a) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output = "DCxComb.fstVal" (%unpacka) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token = "DCxComb.sndVal" (%unpacka) : (!ValueTokenStream_32) -> (!TokenStream)
    -- our fork currently only dispatches two elements
    %0 = "DCxComb.fork" (%token) : (!TokenStream) -> (!TokenStream2)
    %fst0 = "DCxComb.fst" (%0) : (!TokenStream2) -> (!TokenStream)
    %snd0 = "DCxComb.snd" (%0) : (!TokenStream2) -> (!TokenStream)
    -- we replace the extract + concat optimization with shlPar
    %2 = "DCxComb.shlPar_1" (%output) : (!ValueStream_32) -> (!ValueStream_32)
    %unpackb = "DCxComb.unpack" (%b) : (!ValueStream_32) -> (!ValueTokenStream_32)
    %output1 = "DCxComb.fstVal" (%unpackb) : (!ValueTokenStream_32) -> (!ValueStream_32)
    %token0 = "DCxComb.sndVal" (%unpackb) : (!ValueTokenStream_32) -> (!TokenStream)
    -- join also only supports two operands atm
    %3 = "DCxComb.join" (%fst0, %token0) : (!TokenStream, !TokenStream) -> (!TokenStream)
    %4 = "DCxComb.add" (%2, %output) : (!ValueStream_32, !ValueStream_32) -> (!ValueStream_32)
    -- %5 = "DCxComb.pack" (%4, %3) : (!TokenStream, !ValueStream_32) -> (!ValueStream_32)
    "return" (%a) : (!ValueStream_32) -> ()
  }]

/-
Q: is it easier to prove correctness of e.g. canonicalization at DC level?
-/
