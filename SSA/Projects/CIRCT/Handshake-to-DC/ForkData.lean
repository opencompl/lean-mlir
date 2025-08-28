import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

theorem corec₂_eq_tok (x : DCOp.TokenStream):
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

theorem EqIsBisim {α} : @IsBisim α Eq := by
  simp [IsBisim]
  intros a; exists 0; exists 0
  and_intros; all_goals first | rfl | intros _ h; cases h

theorem fork_hs_dc_equiv_fst (x : DCOp.TokenStream):
    (DCOp.fork (x)).fst ~ (HandshakeOp.fork (x)).fst := by
  simp [Bisim, DCOp.fork, HandshakeOp.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq_tok]
    rfl
  · apply EqIsBisim

theorem fork_hs_dc_equiv_snd (x : DCOp.TokenStream):
    (DCOp.fork (x)).snd ~ (HandshakeOp.fork (x)).snd := by
  simp [Bisim, DCOp.fork, HandshakeOp.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq_tok]
    rfl
  · apply EqIsBisim


/- prove that dc fork with a value is eqv to handshake fork -/

/- step 1: write dc circuit -/

unseal String.splitOnAux in
def DCFork := [DC_com| {
  ^entry(%0 : !ValueStream_8):
    %unpack12 = "DC.unpack" (%0) : (!ValueStream_8) -> (!ValueTokenStream_8)
    %unpack1 = "DC.fstVal" (%unpack12) : (!ValueTokenStream_8) -> (!ValueStream_8)
    %unpack2 = "DC.sndVal" (%unpack12) : (!ValueTokenStream_8) -> (!TokenStream)
    %fork12 = "DC.fork" (%unpack2) : (!TokenStream) -> (!TokenStream2)
    %fork1 = "DC.fst" (%fork12) : (!TokenStream2) -> (!TokenStream)
    %fork2 = "DC.snd" (%fork12) : (!TokenStream2) -> (!TokenStream)
    %pack1 = "DC.pack" (%unpack1, %fork1) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    %pack2 = "DC.pack" (%unpack1, %fork2) : (!ValueStream_8, !TokenStream) -> (!ValueStream_8)
    %pack12 = "DC.pair" (%pack1, %pack2) : (!ValueStream_8, !ValueStream_8) -> (!ValueStream2_8)
    "return" (%pack12) : (!ValueStream2_8) -> ()
  }]

/- step 2: denote dc circuit -/

#check DCFork
#eval DCFork
#reduce DCFork
#check DCFork.denote
#print axioms DCFork

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals[i]?).join

def x : DCOp.ValueStream (BitVec 8) := ofList [some 1, none, some 2, some 5, none]

def test : DCOp.ValueStream (BitVec 8) × DCOp.ValueStream (BitVec 8) :=
  DCFork.denote (Ctxt.Valuation.ofHVector (.cons x <| .nil))

/- step 3: prove equivalence -/

theorem corec₂_corec1 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).1 = corec s (fun s' => let ⟨ a, _, b ⟩ := f s'; (a, b) ) := by rfl

theorem corec₂_corec2 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).2 = corec s (fun s' => let ⟨ _, a, b ⟩ := f s'; (a, b) ) := by rfl

-- this function maps a stream α to a stream α × stream unit st stream unit stores
-- whether the stream has something in there
-- def map_to_unit_pair (x : Stream α) (z : Stream α × Stream Unit) : Prop :=
--     x = z.1 ∧ x.map (·.map (λ _ => ())) = z.2

theorem tail_iterate'' {α} {n} {s : Stream' α} : Stream'.iterate Stream'.tail s n m = s (n + m) := by
  induction n generalizing m; dsimp [Stream'.iterate]; simp
  dsimp [Stream'.iterate]
  rename_i n hn
  have : (Stream'.iterate Stream'.tail s n).tail m = Stream'.iterate Stream'.tail s n (m + 1) := by rfl
  rw [this]; rw [hn];
  have : n + (m + 1) = n + 1 + m := by omega
  rw [this]

theorem tail_iterate' {α} {n} {s : Stream' α} : Stream'.iterate Stream'.tail s n 0 = s n :=
  tail_iterate''

open Ctxt in
theorem equiv_fork_fst (streamInt : DCOp.ValueStream (BitVec 8)) :
  (HandshakeOp.fork streamInt).fst ~ (DCFork.denote (Valuation.ofHVector (.cons streamInt <| .nil))).fst := by
  unfold HandshakeOp.fork DCFork
  simp_peephole
  unfold Bisim; exists Eq
  rw [corec₂_corec1]
  refine
    (and_symm_left
          (fun x =>
            DCOp.pack (fun x => (DCOp.unpack fun x => streamInt x).1 x)
              (fun x => (DCOp.fork fun x => (DCOp.unpack fun x => streamInt x).2 x).1 x) x)
          (corec streamInt fun s' =>
            match Id.run (s' 0, s' 0, s'.tail) with
            | (a, fst, b) => (a, b))
          (IsBisim Eq)).mp
      ?_
  unfold DCOp.pack DCOp.unpack DCOp.fork
  simp_peephole

  · sorry
      -- and_intros
      -- all_goals
      --   unfold CIRCTStream.Stream.tail
      --   rcases hm with ⟨ heq, hmap ⟩; subst_vars
      --   rcases b with ⟨ b1, b2 ⟩; dsimp only at *
      --   rcases hb1 : b1 0 with _ | val <;> cases hb2 : b2 0
      --     <;> first | rfl | simp [Id.run, Stream'.map_tail, hmap]
      --   rw [Stream'.ext_iff] at hmap; specialize hmap 0
      --   simp_all [Stream'.get, Stream'.map]
    -- · unfold map_to_unit_pair
    --   and_intros
    --   · simp only; rw [corec₂_corec1]
    --     have h : ((fun s' => match
    --         Id.run (match s' 0 with
    --           | some _ => (s' 0, some (), s'.tail)
    --           | none => (none, none, s'.tail)) with
    --       | (a, _, b) => (a, b)) : Stream Int → Option Int × Stream Int) =
    --       (fun s' => (s' 0, s'.tail)) := by
    --       ext s' <;> cases h : s' 0 <;> simp_all [Id.run]
    --     dsimp only [MLIR2DC.instTyDenoteTy2, TyDenote.toType] at *;
    --     unfold DC.unpack.match_1 equiv_fork_fst.match_1 at *
    --     rw [h]
    --     unfold corec
    --     rw [Stream'.ext_iff]; intro n
    --     clear h
    --     rw [Stream'.corec_def]; simp
    --     unfold Stream Stream.tail at *
    --     have {α} : ((fun x => x.tail) : Stream' α → Stream' α) = Stream'.tail := by rfl
    --     rw [this]; unfold Stream'.get
    --     rw [tail_iterate']
    --   · simp only; rw [corec₂_corec1, corec₂_corec2]
    --     dsimp only [Id.run]
    --     have h : ((fun s' => match
    --         Id.run (match s' 0 with
    --           | some _ => (s' 0, some (), s'.tail)
    --           | none => (none, none, s'.tail)) with
    --       | (_, a, b) => (a, b)) : Stream Int → Option Unit × Stream Int) =
    --       (fun s' => (Option.map (fun _ => ()) (s' 0), s'.tail)) := by
    --       ext s' <;> cases h : s' 0 <;> simp_all [Id.run]
    --     unfold CIRCTStream.DC.unpack.match_1 CIRCTStream.Stream.Bisim.corec₂_corec1.match_1 CIRCTStream.Stream.Bisim.equiv_fork_fst.match_2 CIRCTStream.Stream.Bisim.equiv_fork_fst.match_1 at *
    --     dsimp only [Id.run, TyDenote.toType] at *
    --     rw [h]; clear h
    --     unfold corec
    --     rw [Stream'.ext_iff]; intro n
    --     rw [Stream'.corec_def]; simp only [Stream'.get_map]
    --     unfold Stream Stream.tail at *
    --     have {α} : ((fun x => x.tail) : Stream' α → Stream' α) = Stream'.tail := by rfl
    --     rw [this]; unfold Stream'.get
    --     rw [tail_iterate', Stream'.corec_def, this]
    --     unfold Stream'.map Stream'.get
    --     dsimp only
    --     rw [tail_iterate']
  · apply EqIsBisim

theorem stream_pair_1 (s : Stream α) (f : Stream α → Option α × Option α × Stream α):
    (corec₂ s f).1 = corec s (fun x => let ⟨f1, _, f2⟩ := f x; (f1, f2)) := by
  rfl


inductive concrete_bisim (x y : Stream α) : Prop

-- pb: generate bisim relation defined over streams (a concrete one)
-- needs to rely on cores

def IsBisim' (R' : Stream α → Stream α → Prop) : Prop :=
  ∀ a b, R' a b → ∃ n m,
    R' (a.drop (n+1)) (b.drop (m+1))
    ∧ a.get n = b.get m
    ∧ (∀ i < n, a.get i = none)
    ∧ (∀ j < m, b.get j = none)

theorem corec₂_eq_corec_of_corec₂ (streamInt: DCOp.ValueStream Int) :
    (corec₂ streamInt fun x => (x 0, x 0, x.tail)).1 ≈
    corec
      ((corec₂ streamInt fun (x : DCOp.ValueStream Int) =>
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
  simp only
  unfold Setoid.r StreamSetoid
  simp only
  unfold Bisim
  sorry
  -- simp only
  -- exists Eq
  -- and_intros
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
