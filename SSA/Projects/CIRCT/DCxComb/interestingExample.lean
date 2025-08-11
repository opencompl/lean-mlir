import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

namespace CIRCTStream

open MLIR AST in

instance : ToString DCOp.TokenStream where
  toString s := toString (Stream.toList 10 s)

instance [ToString w] : ToString (Option w) where
  toString
    | some x => s!"(some {toString x})"
    | none   => "(none)"

instance [ToString w] : ToString (DCOp.ValueStream w) where
  toString s := toString (Stream.toList 10 s)

unseal String.splitOnAux in
def ex1 := [DCxComb_com| {
  ^entry(%0: !ValueStream_8, %1: !ValueStream_8, %2: !ValueStream_8, %3: !TokenStream):
    -- unpack 1
    %unpack = "DCxComb.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %val = "DCxComb.fstVal" (%unpack) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %tok = "DCxComb.sndVal" (%unpack) : (!ValueTokenStream_8) -> (!TokenStream)
    -- add 1
    %add1 = "DCxComb.add" (%val, %val) : (!ValueStream_8, !ValueStream_8) -> (!ValueStream_8)
    -- join
    %join = "DCxComb.join" (%tok, %3) : (!TokenStream, !TokenStream) -> (!TokenStream)
    -- unpack 2
    %unpack1 = "DCxComb.unpack" (%1) : (!ValueStream_8) -> (!ValueTokenStream_1)
    %val1 = "DCxComb.fstVal" (%unpack1) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %tok1 = "DCxComb.sndVal" (%unpack1) : (!ValueTokenStream_8) -> (!TokenStream)
    -- add 2
    %add2 = "DCxComb.add" (%add1, %val1) : (!ValueStream_8, !ValueStream_8) -> (!ValueStream_8)
    "return" (%add2) : (!ValueStream_8) -> ()
  }]
