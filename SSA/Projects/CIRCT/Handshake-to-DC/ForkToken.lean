import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import LeanMLIR.Tactic

namespace CIRCTStream
namespace Stream.Bisim



-- // CHECK:   hw.module @test_fork(in %[[VAL_0:.*]] : !dc.token, out out0 : !dc.token, out out1 : !dc.token) {
-- // CHECK:           %[[VAL_1:.*]]:2 = dc.fork [2] %[[VAL_0]]
-- // CHECK:           hw.output %[[VAL_1]]#0, %[[VAL_1]]#1 : !dc.token, !dc.token
-- // CHECK:         }
-- handshake.func @test_fork(%arg0: none) -> (none, none) {
--   %0:2 = fork [2] %arg0 : none
--   return %0#0, %0#1 : none, none
-- }

-- removed unused inputs
unseal String.splitOnAux in
def forkToken := [DC_com| {
  ^entry(%0: !TokenStream):
    %dcFork = "DC.fork" (%0) : (!TokenStream) -> (!TokenStream2)
    "return" (%dcFork) : (!TokenStream2) -> ()
  }]

#check forkToken
#eval forkToken
#reduce forkToken
#check forkToken.denote
#print axioms forkToken

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

def test : DCOp.TokenStream × DCOp.TokenStream :=
  forkToken.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

open Ctxt in
theorem equiv_forkToken (streamT : DCOp.TokenStream) :
  (Handshake.fork streamT).fst ~ (forkToken.denote (Valuation.ofHVector (.cons streamT <| .nil))).fst := by sorry
