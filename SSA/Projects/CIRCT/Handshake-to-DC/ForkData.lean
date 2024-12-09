import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

theorem corec₂_eq_tok (x : DC.TokenStream):
  (corec₂ x fun x => (x 0, x 0, tail x)) = (corec₂ x fun x => Id.run (x 0, x 0, x.tail)) := by
  apply corec₂_eq_corec₂_of
  rotate_left 2
  · exact Eq.refl _
  · intro b₁ b₂ h
    simp [h]
    and_intros <;> rfl
  · intro b₁ b₂ h
    simp [h]
    and_intros <;> rfl

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

theorem fork_hs_dc_equiv_fst (x : DC.TokenStream):
    (DC.fork (x)).fst ~ (Handshake.fork (x)).fst := by
  simp [Bisim, DC.fork, Handshake.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq_tok]
    rfl
  · apply EqIsBisim

theorem fork_hs_dc_equiv_snd (x : DC.TokenStream):
    (DC.fork (x)).snd ~ (Handshake.fork (x)).snd := by
  simp [Bisim, DC.fork, Handshake.fork]
  exists Eq
  and_intros
  · rw [corec₂_eq_tok]
    rfl
  · apply EqIsBisim


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

theorem corec₂_corec1 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).1 = corec s (fun s' => let ⟨ a, _, b ⟩ := f s'; (a, b) ) := by rfl

theorem corec₂_corec2 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).2 = corec s (fun s' => let ⟨ _, a, b ⟩ := f s'; (a, b) ) := by rfl

-- this function maps a stream α to a stream α × stream unit st stream unit stores
-- whether the stream has something in there
def map_to_unit_pair (x : Stream α) (z : Stream α × Stream Unit) : Prop :=
    x = z.1 ∧ x.map (·.map (λ _ => ())) = z.2

theorem tail_iterate'' {α} {n} {s : Stream' α} : Stream'.iterate Stream'.tail s n m = s (n + m) := by
  induction n generalizing m; dsimp [Stream'.iterate]; simp
  dsimp [Stream'.iterate]
  rename_i n hn
  have : (Stream'.iterate Stream'.tail s n).tail m = Stream'.iterate Stream'.tail s n (m + 1) := by rfl
  rw [this]; rw [hn];
  have : n + (m + 1) = n + 1 + m := by omega
  rw [this]

@[simp]
theorem tail_iterate' {α} {n} {s : Stream' α} : Stream'.iterate Stream'.tail s n 0 = s n :=
  tail_iterate''

@[simp]
theorem Handshake.fork_eq (s : Stream α) :
    (Handshake.fork s).fst = s := by
  simp [Handshake.fork, Id.run]
  rw [corec₂_corec1]
  simp [corec, Stream'.corec]
  funext i
  have : (fun (x : Stream α) => x.tail) = Stream'.tail := by ext x; rfl
  simp [Stream'.map, Stream'.get]
  rw [this, tail_iterate']

@[simp]
theorem DC.fork_eq (s : Stream Unit) :
    (DC.fork s).fst = s := by
  simp [DC.fork]
  rw [corec₂_corec1]
  simp [corec, Stream'.corec]
  funext i
  have : (fun (x : Stream Unit) => x.tail) = Stream'.tail := by ext x; rfl
  simp [Stream'.map, Stream'.get]
  rw [this, tail_iterate']

theorem DC.unpack_fst (s : Stream α) :
    (DC.unpack s).fst = s := by
  sorry

theorem DC.unpack_snd (s : Stream α) :
    (DC.unpack s).snd = s := by
  sorry

@[simp]
theorem DC.pack_unpack (s : Stream α ) :
    DC.pack (DC.unpack s).1 (DC.unpack s).2 = s := by
  unfold DC.pack DC.unpack
  rw [corec₂_corec1]
  simp only [Id.pure_eq, Id.run]
  unfold corec
  simp



open Ctxt in
theorem equiv_fork_fst (streamInt : DC.ValueStream Int) :
  (Handshake.fork streamInt).fst ~ (DCFork.denote (Valuation.ofHVector (.cons streamInt <| .nil))).fst := by
  simp [DCFork, Valuation.ofPair, Valuation.ofHVector]
  simp_peephole
  unfold Bisim
  refine ⟨Eq, ?_, EqIsBisim⟩
  rw [DC.fork_eq]
  simp


open Ctxt in
theorem equiv_fork_fst2 (streamInt : DC.ValueStream Int) :
  (Handshake.fork streamInt).fst ~ (DCFork.denote (Valuation.ofHVector (.cons streamInt <| .nil))).fst := by
  simp only [MLIR2DC.instDialectDenoteDC, DCFork, EffectKind.pure_sup_pure_eq,
    DerivedCtxt.ofCtxt, DerivedCtxt.snoc, get?.eq_1, Var.zero_eq_last, zero_add, Var.succ_eq_toSnoc,
    Nat.reduceAdd, Valuation.ofHVector, Ctxt.ofList, Com.denote_var, Com.denote_ret, Id.pure_eq,
    Id.bind_eq]
  unfold Handshake.fork DC.pack DC.unpack DC.fork
  simp_peephole
  unfold Bisim; exists Eq
  rw [corec₂_corec1]
  and_intros
  · apply corec_eq_corec_of (R := map_to_unit_pair)
    · intros a b hm
      and_intros
      all_goals
        unfold CIRCTStream.Stream.tail
        rcases hm with ⟨ heq, hmap ⟩; subst_vars
        rcases b with ⟨ b1, b2 ⟩; dsimp only at *
        rcases hb1 : b1 0 with _ | val <;> cases hb2 : b2 0
          <;> first | rfl | simp [Id.run, Stream'.map_tail, hmap]
        rw [Stream'.ext_iff] at hmap; specialize hmap 0
        simp_all [Stream'.get, Stream'.map, Option.map_none']
    · unfold map_to_unit_pair
      and_intros
      · simp; rw [corec₂_corec1]
        have h : ((fun s' => match
            Id.run (match s' 0 with
              | some val => (s' 0, some (), s'.tail)
              | none => (none, none, s'.tail)) with
          | (a, fst, b) => (a, b)) : Stream Int → Option Int × Stream Int) =
          (fun s' => (s' 0, s'.tail)) := by
          ext s' <;> cases h : s' 0 <;> simp_all [Id.run]
        dsimp only [MLIR2DC.instTyDenoteTy2, TyDenote.toType] at *;
        unfold DC.unpack.match_1 equiv_fork_fst2.match_1 at *
        rw [h]
        unfold corec
        rw [Stream'.ext_iff]; intro n
        clear h
        rw [Stream'.corec_def]; simp only [Stream'.get_map]
        unfold Stream Stream.tail at *
        have {α} : ((fun x => x.tail) : Stream' α → Stream' α) = Stream'.tail := by rfl
        rw [this]; unfold Stream'.get
        rw [tail_iterate']
      · simp only; rw [corec₂_corec1, corec₂_corec2]
        dsimp [Id.run]
        have h : ((fun s' => match
            Id.run (match s' 0 with
              | some val => (s' 0, some (), s'.tail)
              | none => (none, none, s'.tail)) with
          | (fst, a, b) => (a, b)) : Stream Int → Option Unit × Stream Int) =
          (fun s' => (Option.map (fun _ => ()) (s' 0), s'.tail)) := by
          ext s' <;> cases h : s' 0 <;> simp_all [Id.run]
        dsimp only [MLIR2DC.instTyDenoteTy2, TyDenote.toType] at *;
        unfold DC.unpack.match_1 equiv_fork_fst2.match_1 at *
        sorry
  · apply EqIsBisim

theorem stream_pair_1 (s : Stream α) (f : Stream α → Option α × Option α × Stream α):
    (corec₂ s f).1 = corec s (fun x => let ⟨f1, _, f2⟩ := f x; (f1, f2)) := by
  rfl

def IsBisim' (R' : Stream α → Stream α → Prop) : Prop :=
  ∀ a b, R' a b → ∃ n m,
    R' (a.drop (n+1)) (b.drop (m+1))
    ∧ a.get n = b.get m
    ∧ (∀ i < n, a.get i = none)
    ∧ (∀ j < m, b.get j = none)
