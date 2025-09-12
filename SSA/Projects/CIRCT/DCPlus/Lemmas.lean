import SSA.Core
import SSA.Projects.CIRCT.DCPlus.DCPlus
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

open CIRCTStream


theorem rewrite_a_T (d : DCPlusOp.TokenStream) (c : DCPlusOp.ValueStream (BitVec 1)):
    (DCPlusOp.branch c d).fst =
    (DCPlusOp.supp
        (DCPlusOp.not (DCPlusOp.forkVal c).fst)
        (DCPlusOp.fork d).fst
        ) := by
  sorry

theorem rewrite_a_F (d : DCPlusOp.TokenStream) (c : DCPlusOp.ValueStream (BitVec 1)):
    (DCPlusOp.branch c d).snd =
    (DCPlusOp.supp
        (DCPlusOp.forkVal c).snd
        (DCPlusOp.fork d).snd
        ) := by
  sorry
