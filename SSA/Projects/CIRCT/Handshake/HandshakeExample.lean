import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

namespace CIRCTStream


open MLIR AST in

instance : ToString (Stream (BitVec w)) where
  toString s :=
    let l := Stream.toList 100 s
    toString l

unseal String.splitOnAux in
def BranchEg1 := [handshake_com| {
  ^entry(%0: !Stream_BitVec_1, %1: !Stream_BitVec_1):
    %out = "handshake.branch" (%0, %1) : (!Stream_BitVec_1, !Stream_BitVec_1) -> (!Stream2_BitVec_1)
    %outf = "handshake.fst" (%out) : (!Stream2_BitVec_1) -> (!Stream_BitVec_1)
    %outs = "handshake.snd" (%out) : (!Stream2_BitVec_1) -> (!Stream_BitVec_1)
    %out2 = "handshake.merge" (%outs, %outf) : (!Stream_BitVec_1, !Stream_BitVec_1) -> (!Stream_BitVec_1)
    "return" (%out2) : (!Stream_BitVec_1) -> ()
  }]

#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def ofList (vals : List (Option α)) : Stream α :=
  fun i => vals[i]?.join

def c : Stream (BitVec 1) := ofList [some 1, none, some 0, some 1, some 0]
def x : Stream (BitVec 1) := ofList [some 1, none, some 1, some 0, none]

-- is this in the opposite order or am I misunderstanding? if yes: why?
def test : Stream (BitVec 1) :=
  BranchEg1.denote (Ctxt.Valuation.ofPair c x) |>.getN 0


unseal String.splitOnAux in
def SyncEg1 := [handshake_com| {
  ^entry(%0: !Stream_BitVec_8, %1: !Stream_BitVec_8):
    %out = "handshake.sync" (%0, %1) : (!Stream_BitVec_8, !Stream_BitVec_8) -> (!Stream2_BitVec_8)
    %outf = "handshake.fst" (%out) : (!Stream2_BitVec_8) -> (!Stream_BitVec_8)
    "return" (%outf) : (!Stream_BitVec_8) -> ()
  }]

#check SyncEg1
#eval SyncEg1
#reduce SyncEg1
#check SyncEg1.denote
#print axioms SyncEg1


def i : Stream (BitVec 8) := ofList [1#8, none, 1#8, 4#8, 0#8]
def j : Stream (BitVec 8) := ofList [none, 3#8, none]

def testSync : Stream (BitVec 8) :=
  SyncEg1.denote (Ctxt.Valuation.ofPair j i) |>.getN 0

#eval testSync

namespace Stream


open Ctxt in
theorem equiv_arg1 (x1Stream x2Stream : Stream (BitVec 1)) :
    x1Stream ≈ (BranchEg1.denote (Valuation.ofPair x1Stream x2Stream) |>.getN 0) := by
  simp [BranchEg1, Valuation.ofPair, Valuation.ofHVector]
  let v := (@Valuation.ofPair MLIR2Handshake.Ty _ (MLIR2Handshake.Ty.stream (MLIR2Handshake.Ty2.bitvec 1)) (MLIR2Handshake.Ty.stream (MLIR2Handshake.Ty2.bitvec 1)) x1Stream x2Stream)
  simp_peephole at v
  sorry

theorem determinate :
    Set.Subsingleton (nondeterminify2 (fun s1 s2 =>
      BranchEg1.denote (Ctxt.Valuation.ofPair s1 s2) |>.getN 0) (s1', s2')
    ) := by
  intro x Hx y  Hy
  simp [Stream.nondeterminify2, Stream.StreamWithoutNones.hasStream] at *
  rcases Hx with ⟨ x1Stream, x1, x2Stream, x2, rfl ⟩
  rcases Hy with ⟨ y1Stream, y1, y2Stream, y2, rfl ⟩
  apply Quotient.sound
  -- simp [BranchEg1]
  -- simp [Stream.Bisim, Stream.IsBisim]
  subst s2'; subst s1'
  have y1' := Quotient.exact y1
  have y2' := Quotient.exact y2
  clear y1; clear y2
  trans x1Stream
  apply (equiv_arg1 _ _).symm
  trans y1Stream
  · assumption
  · apply equiv_arg1
