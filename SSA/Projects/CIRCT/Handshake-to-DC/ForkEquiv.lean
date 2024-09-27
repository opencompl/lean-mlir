import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

theorem corec₂_eq (x : DC.TokenStream):
  (corec₂ x fun x => Id.run (x 0, x 0, tail x)) = (corec₂ x fun x => Id.run (x 0, x 0, x.tail)) := by
  apply corec₂_eq_corec₂_of
  rotate_left 2
  · exact Eq.refl _
  · intro b₁ b₂ h
    simp [h]
  · intro b₁ b₂ h
    simp [h]

theorem fork_hs_dc_equiv_fst (x : DC.TokenStream):
    (DC.fork (x)).fst ~ (Handshake.fork (x)).fst := by
  simp [Bisim, DC.fork, Handshake.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq]
    rfl
  · simp [IsBisim]
    intros a
    exists 0
    exists 0
    and_intros
    · rfl
    · rfl
    · intros i h
      cases h
    · intros i h
      cases h

theorem fork_hs_dc_equiv_snd (x : DC.TokenStream):
    (DC.fork (x)).snd ~ (Handshake.fork (x)).snd := by
  simp [Bisim, DC.fork, Handshake.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq]
    rfl
  · simp [IsBisim]
    intros a
    exists 0
    exists 0
    and_intros
    · rfl
    · rfl
    · intros i h
      cases h
    · intros i h
      cases h


/- prove that dc fork with a value is eqv to handshake fork -/

/- step 1: write dc circuit -/

unseal String.splitOnAux in
def DCFork := [DC_com| {
  ^entry(%0 : !ValueStream_Int):
    %unpack12 = "DC.unpack" (%0) : (!ValueStream_Int) -> (!ValueTokenStream_Int)
    %unpack1 = "DC.fstVal" (%unpack12) : (!ValueTokenStream_Int) -> (!ValueStream_Int)
    %unpack2 = "DC.sndVal" (%unpack12) : (!ValueTokenStream_Int) -> (!TokenStream)
    %fork12 = "DC.fork" (%unpack2) : (!TokenStream) -> (!TokenStream2)
    %fork1 = "DC.fst" (%fork12) : (!TokenStream2) -> (!TokenStream)
    %fork2 = "DC.snd" (%fork12) : (!TokenStream2) -> (!TokenStream)
    %pack1 = "DC.pack" (%unpack1, %fork1) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    %pack2 = "DC.pack" (%unpack1, %fork2) : (!ValueStream_Int, !TokenStream) -> (!ValueStream_Int)
    %pack12 = "DC.pair" (%pack1, %pack2) : (!ValueStream_Int, !ValueStream_Int) -> (!ValueStream2_Int)
    "return" (%pack12) : (!ValueStream2_Int) -> ()
  }]

/- step 2: denote dc circuit -/

#check DCFork
#eval DCFork
#reduce DCFork
#check DCFork.denote
#print axioms DCFork

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : DC.ValueStream Int := ofList [some 1, none, some 2, some 5, none]

def test : DC.ValueStream Int × DC.ValueStream Int :=
  DCFork.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

/- step 3: prove equivalence -/

open Ctxt in
theorem equiv_fork (streamInt : DC.ValueStream Int) :
  (Handshake.fork streamInt) = DCFork.denote (Valuation.ofHVector (.cons streamInt <| .nil)) := by
  sorry
