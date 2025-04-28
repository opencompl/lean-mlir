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
def BranchEg := [DC_com| {
  ^entry(%0 : !ValueStream_i_8):
    %unpack = "DC.unpack" (%0) : (!ValueStream_i_8) -> (!ValueTokenStream_i_8)
    %value = "DC.fstVal" (%unpack) : (!ValueTokenStream_i_8) -> (!ValueStream_i_8)
    %token = "DC.sndVal" (%unpack) : (!ValueTokenStream_i_8) -> (!TokenStream)

    "return" (%token) : (!TokenStream) -> ()
  }]

-- %combop = "Comb.and" (%2, %2) : (i8, i8) -> (i8)
-- %truefalse = "DC.unpack" (%0) : (!ValueStream_i_8) -> (!TokenStream2)

-- #check BranchEg
-- #eval BranchEg
-- #reduce BranchEg
-- #check BranchEg.denote
-- #print axioms BranchEg

-- def ofList (vals : List (Option α)) : Stream α :=
--   fun i => (vals.get? i).join

-- def c : DC.ValueStream Bool := ofList [some true, none, some false, some true, some false]
-- def x : DC.ValueStream Int := ofList [some 1, none, some 2, some 3, none]
-- def u : DC.TokenStream := ofList [some (), none, some (), some (), none]

-- def test2 : DC.TokenStream :=
--   BranchEg.denote (Ctxt.Valuation.ofHVector (.cons c <| .cons x <| .cons u <| .nil))
