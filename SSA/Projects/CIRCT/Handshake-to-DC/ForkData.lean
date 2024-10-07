import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

theorem corec₂_eq_tok (x : DC.TokenStream):
  (corec₂ x fun x => Id.run (x 0, x 0, tail x)) = (corec₂ x fun x => Id.run (x 0, x 0, x.tail)) := by
  apply corec₂_eq_corec₂_of
  rotate_left 2
  · exact Eq.refl _
  · intro b₁ b₂ h
    simp [h]
  · intro b₁ b₂ h
    simp [h]

theorem corec₂_eq_val (x : Stream α):
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
  · rw [corec₂_eq_tok]
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
  · rw [corec₂_eq_tok]
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
theorem equiv_fork_fst (streamInt : DC.ValueStream Int) :
  (Handshake.fork streamInt).fst ~ (DCFork.denote (Valuation.ofHVector (.cons streamInt <| .nil))).fst := by
  simp [DCFork, Valuation.ofPair, Valuation.ofHVector]
  unfold Handshake.fork
  unfold DC.pack
  unfold DC.unpack
  unfold DC.fork
  /-
  streamInt : DC.ValueStream ℤ
  ⊢ (corec₂ streamInt fun x => Id.run (x 0, x 0, x.tail)).1 ~
    corec
      ((corec₂ streamInt fun x =>
            (match x 0 with
              | some val => (x 0, some (), x.tail)
              | none => (none, none, x.tail)).run).1,
        (corec₂
            (corec₂ streamInt fun x =>
                (match x 0 with
                  | some val => (x 0, some (), x.tail)
                  | none => (none, none, x.tail)).run).2
            fun x => Id.run (x 0, x 0, tail x)).1)
      fun x =>
      match x.1 0, x.2 0 with
      | some x₀, some val => (some x₀, tail x.1, tail x.2)
      | some val, none => (none, x.1, tail x.2)
      | none, some val => (none, tail x.1, x.2)
      | none, none => (none, tail x.1, tail x.2)
  -/
  simp_peephole
  sorry

theorem stream_pair_1 (s : Stream α) (f : Stream α → Option α × Option α × Stream α):
    (corec₂ s f).1 = corec s (fun x => let ⟨f1, _, f2⟩ := f x; (f1, f2)) := by sorry

inductive concrete_bisim (x y : Stream α) : Prop

-- pb: generate bisim relation defined over streams (a concrete one)
-- needs to rely on cores

def concrete_bisim' (f1 f2 : Stream α → (Option α × Stream α)) (s : Stream α) : Prop :=
    match s 0 with
    | some x => (f1 s).1 = some x ∧ -- ((f1 s).1 = some ∨ ∃ n : alwaysNoneUntil n ∧ (f1 s ).n = some
      -- ) ∧  concrete_bisim' f1 f2 s.tail
    | none => (f1 s).1 = none ∧ (f2)

theorem corec₂_eq_corec_of_corec₂ (streamInt: DC.ValueStream Int) :
    (corec₂ streamInt fun x => (x 0, x 0, x.tail)).1 ≈
    corec
      ((corec₂ streamInt fun (x : DC.ValueStream Int) =>
            (match x 0 with
              | some val => (x 0, some (), x.tail)
              | none => (none, none, x.tail))).1,
        (corec₂
            (corec₂ streamInt fun x =>
                (match x 0 with
                  | some val => (x 0, some (), x.tail)
                  | none => (none, none, x.tail))).2
            fun x => Id.run (x 0, x 0, tail x)).1)
      fun x =>
      match x.1 0, x.2 0 with
      | some x₀, some val => (some x₀, tail x.1, tail x.2)
      | some val, none => (none, x.1, tail x.2)
      | none, some val => (none, tail x.1, x.2)
      | none, none => (none, tail x.1, tail x.2) := by
  rw [stream_pair_1]
  unfold HasEquiv.Equiv
  unfold instHasEquivOfSetoid
  simp
  unfold Setoid.r
  unfold StreamSetoid
  simp
  unfold Bisim
  simp
  exists Eq
  sorry


  -- apply corec_eq_corec_of (· ≈ ·)
  -- · sorry
  -- · sorry
  -- · sorry










-- theorem determinate :
--   Set.Subsingleton (nondeterminify2 (fun s1 s2 => BranchEg1.denote (Ctxt.Valuation.ofPair s1 s2)) (s1', s2')) := by
--   intro x Hx y  Hy
--   simp [Stream.nondeterminify2, Stream.StreamWithoutNones.hasStream] at *
--   rcases Hx with ⟨ x1Stream, x1, x2Stream, x2, rfl ⟩
--   rcases Hy with ⟨ y1Stream, y1, y2Stream, y2, rfl ⟩
--   apply Quotient.sound
--   -- simp [BranchEg1]
--   -- simp [Stream.Bisim, Stream.IsBisim]
--   subst s2'; subst s1'
--   have y1' := Quotient.exact y1
--   have y2' := Quotient.exact y2
--   clear y1; clear y2
--   trans x1Stream
--   apply (equiv_arg1 _ _).symm
--   trans y1Stream
--   · assumption
--   · apply equiv_arg1
