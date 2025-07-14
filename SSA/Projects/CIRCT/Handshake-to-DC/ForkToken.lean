import SSA.Projects.CIRCT.DCxComb.DCxCombFunctor
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

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
def forkToken := [DCxComb_com| {
  ^entry(%0: !TokenStream):
    %dcFork = "DCxComb.fork" (%0) : (!TokenStream) -> (!TokenStream2)
    "return" (%dcFork) : (!TokenStream2) -> ()
  }]

#check forkToken
#eval forkToken
#reduce forkToken
#check forkToken.denote
#print axioms forkToken

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def x : DCOp.TokenStream := ofList [some (), none, some (), some (), none]

def test : DCOp.TokenStream × DCOp.TokenStream :=
  forkToken.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

open Ctxt in
theorem equiv_forkToken (streamT : DCOp.TokenStream) :
    (HandshakeOp.fork streamT).fst ~ (forkToken.denote (Valuation.ofHVector (.cons streamT <| .nil))).fst := by
  simp only [forkToken, get?.eq_1, Var.zero_eq_last, Valuation.ofHVector, Ctxt.ofList.eq_1,
    Com.denote_var, EffectKind.toMonad_pure, Com.denote_ret, Valuation.snoc_last, Id.pure_eq,
    Id.bind_eq]
  simp [HandshakeOp.fork, MLIR2DC.Op.fork]
  sorry
