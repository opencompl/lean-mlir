import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Comb.Comb
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
def popExample := [DC_com| {
  ^entry(%0 : !ValueStream_8):
    %unpack = "DC.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %value = "DC.fstVal" (%unpack) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %readyValue = "DC.popReady_10" (%value) : (!ValueStream_8) -> (i8)
    "return" (%readyValue) : (i8) -> ()
  }]

#check popExample
#eval popExample
#reduce popExample
#check popExample.denote
#print axioms popExample

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCOp.ValueStream (BitVec 8) := ofList [none, some 5, none, some 2, some 3, none]

def test2 : BitVec 8 :=
  popExample.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

#eval test2
