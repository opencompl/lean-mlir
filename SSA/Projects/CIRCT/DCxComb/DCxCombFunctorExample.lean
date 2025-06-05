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

unseal String.splitOnAux in
def ex1 := [DCxComb_com| {
  ^entry(%0 : !TokenStream):
    "return" (%0) : (!TokenStream) -> ()
  }]

#check ex1
