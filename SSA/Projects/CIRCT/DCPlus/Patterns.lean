import SSA.Core
import SSA.Projects.CIRCT.DCPlus.DCPlus
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

open CIRCTStream

open MLIR2DCPlus


-- theorem rewrite_a_T (d : DCPlusOp.TokenStream) (c : DCPlusOp.ValueStream (BitVec 1)):
--     (DCPlusOp.branch c d).fst =
--     (DCPlusOp.supp
--         (DCPlusOp.not (DCPlusOp.forkVal c).fst)
--         (DCPlusOp.fork d).fst
--         ) := by
--   sorry

-- theorem rewrite_a_F (d : DCPlusOp.TokenStream) (c : DCPlusOp.ValueStream (BitVec 1)):
--     (DCPlusOp.branch c d).snd =
--     (DCPlusOp.supp
--         (DCPlusOp.forkVal c).snd
--         (DCPlusOp.fork d).snd
--         ) := by
--   sorry


/-! Implement `rewrite_a` for the -/

def lhs := [DCPlus_com| {
  ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
    %branch = "DCPlus.branch" (%1, %0) : (!ValueStream_1, !TokenStream) -> (!TokenStream2)
    %fst = "DCPlus.fst" (%branch) :  (!TokenStream2) -> (!TokenStream)
    "return" (%fst) : (!TokenStream) -> ()
  }]

def rhs := [DCPlus_com| {
  ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
    %fork = "DCPlus.fork" (%0) : (!TokenStream) -> (!TokenStream2)
    %fst = "DCPlus.fst" (%fork) : (!TokenStream2) -> (!TokenStream)
    %forkVal = "DCPlus.forkVal" (%1) : (!ValueStream_1) -> (!ValueStream2_1)
    %fstValPure = "DCPlus.fstValPure" (%forkVal) : (!ValueStream2_1) -> (!ValueStream_1)
    %not = "DCPlus.not" (%fstValPure) : (!ValueStream_1) -> (!ValueStream_1)
    %supp = "DCPlus.supp" (%not, %fst) : (!ValueStream_1, !TokenStream) -> (!TokenStream)
    "return" (%supp) : (!TokenStream) -> ()
  }]


def rewrite_a_T : PeepholeRewrite DCPlus [.valuestream 1, .tokenstream] [.tokenstream] :=
  { lhs := lhs, rhs := rhs, correct :=
    by
      rw [lhs, rhs]
      simp_peephole
      intros tok val
      simp_peephole
      unfold DCPlusOp.supp DCPlusOp.branch DCPlusOp.not
      simp
      sorry
    }


def mkRewrite {Γ ty}
  (rw : PeepholeRewrite DCPlus Γ ty) :
  Σ Γ ty, PeepholeRewrite DCPlus Γ ty :=
  ⟨_, _, rw⟩

def rewrite_patterns : List (Σ Γ, Σ ty, PeepholeRewrite DCPlus Γ ty) :=[
  mkRewrite rewrite_a_T
]

def apply_patterns {Γl : List DCPlus.Ty} (fuel : Nat)
  (prog : Com DCPlus (Ctxt.ofList Γl) .pure ([.tokenstream])) :=
   multiRewritePeephole fuel rewrite_patterns prog


def example_program := [DCPlus_com| {
  ^entry(%0 : !TokenStream, %1 : !ValueStream_1):
    %branch = "DCPlus.branch" (%1, %0) : (!ValueStream_1, !TokenStream) -> (!TokenStream2)
    %fst = "DCPlus.fst" (%branch) :  (!TokenStream2) -> (!TokenStream)
    "return" (%fst) : (!TokenStream) -> ()
  }]

#eval! apply_patterns 10 example_program
