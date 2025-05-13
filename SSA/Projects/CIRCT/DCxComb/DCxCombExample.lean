import SSA.Projects.CIRCT.DCxComb.DCxComb
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

namespace CIRCTStream

open MLIR AST in

unseal String.splitOnAux in
def popExample := [DCxComb_com| {
  ^entry(%0 : !ValueStream_8):
    %unpack = "DCxComb.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %value = "DCxComb.fstVal" (%unpack) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %token = "DCxComb.sndVal" (%unpack) : (!ValueTokenStream_8) -> (!TokenStream)
    %readyValue = "DCxComb.popReady_10" (%value) : (!ValueStream_8) -> (i8)
    %addValue = "DCxComb.add" (%readyValue, %readyValue) : (i8, i8) -> (i8)
    %pushValue = "DCxComb.pushReady_8" (%addValue) : (i8) -> (!ValueStream_8)
    -- correct pushready to take a stream in innpu
    "return" (%pushValue) : (!ValueStream_8) -> ()
  }]

#check popExample
#eval popExample
#reduce popExample
#check popExample.denote
#print axioms popExample

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCxCombOp.ValueStream (BitVec 8) := ofList [none, some 5, none, some 2, some 3, none]

def test2 : Stream (BitVec 8) :=
  popExample.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

#eval test2.take 10
