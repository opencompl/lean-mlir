import SSA.Core

import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim

namespace CIRCTStream

instance : ToString DCOp.TokenStream where
  toString s := toString (Stream.toList 100 s)



theorem rewrite_n (stream_d : DCOp.TokenStream) :
    DCOp.sink ((DCOp.fork stream_d).fst) = DCOp.sink stream_d := by
  simp [DCOp.sink, DCOp.fork]
  exact rfl



theorem


-- unseal String.splitOnAux in
-- def forkToken := [DC_com| {
--   ^entry(%0: !TokenStream):
--     %dcFork = "DC.fork" (%0) : (!TokenStream) -> (!TokenStream2)
--     "return" (%dcFork) : (!TokenStream2) -> ()
--   }]

-- #check forkToken
-- #eval forkToken
-- #reduce forkToken
-- #check forkToken.denote
-- #print axioms forkToken

-- def ofList (vals : List (Option α)) : Stream α :=
--   fun i => (vals.get? i).join

-- def x : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

-- def test : DCOp.TokenStream × DCOp.TokenStream :=
--   forkToken.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

-- open Ctxt in
-- theorem equiv_forkToken (streamT : DCOp.TokenStream) :
--   (Handshake.fork streamT).fst ~ (forkToken.denote (Valuation.ofHVector (.cons streamT <| .nil))).fst := by sorry
