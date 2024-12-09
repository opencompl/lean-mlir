import SSA.Projects.CIRCT.Stream.Stream
import Mathlib.Logic.Function.Iterate
import Mathlib.Data.Stream.Init

/-!
#  Equivalence for `CIRCT.Stream`

This file establishes a notion of equivalence that allows us to remove any finite sequence of
`none`s from a stream.

-/

namespace CIRCTStream
namespace Stream

@[simp] theorem head_corec : head (corec b f) = (f b).fst := rfl

@[simp] theorem tail_corec : tail (corec b f) = corec (f b).snd f := by
  funext i
  simp only [tail, Stream'.tail, Stream'.get, corec, Stream'.corec, Stream'.map, Stream'.iterate]
  congr
  induction i
  case zero => rfl
  case succ i ih  => simp only [Stream'.iterate]; congr

def IsBisim (R : Stream α → Stream α → Prop) : Prop :=
  ∀ a b, R a b → ∃ n m,
    R (a.drop (n+1)) (b.drop (m+1))
    ∧ a.get n = b.get m
    ∧ (∀ i < n, a.get i = none)
    ∧ (∀ j < m, b.get j = none)

/-- Two streams are considered equivalent if they contain the same `some _` messages,
in the same order. That is, any finite sequence of `none`s may be ignored. -/
def Bisim (x y : Stream α) : Prop :=
  ∃ R, R x y ∧ IsBisim R

/-! Set up scoped notation `x ~ y` for equivalence -/
namespace Bisim
scoped infix:50 " ~ " => Bisim

theorem unfold :
    x ~ y → ∃ n m,
      x.drop (n+1) ~ y.drop (m+1)
      ∧ x.get n = y.get m
      ∧ (∀ i < n, x.get i = none)
      ∧ (∀ j < m, y.get j = none) := by
  rintro ⟨R, hR, h_sim⟩
  have ⟨n, m, hdrop, h⟩ := h_sim _ _ hR
  exact ⟨n, m, ⟨R, hdrop, h_sim⟩, h⟩

theorem fold
-- will require double check on this
    (h : ∃ n m,
      (Stream'.drop (n+1) (x: Stream' _)) ~ (Stream'.drop (m+1) (y: Stream' _))
      ∧ x.get n = y.get m
      ∧ (∀ i < n, x.get i = none)
      ∧ (∀ j < m, y.get j = none)) :
    x ~ y := by
  let R (a b : Stream _) := (a ~ b) ∨ (a = x ∧ b = y)
  refine ⟨R, Or.inr ⟨rfl, rfl⟩, ?_⟩
  rintro a b (sim | ⟨rfl, rfl⟩)
  · have ⟨n, m, h_drop, h⟩ := unfold sim
    exact ⟨n, m, Or.inl h_drop, h⟩
  · have ⟨n, m, h_drop, h⟩ := h
    exact ⟨n, m, Or.inl h_drop, h⟩

end Bisim
open Bisim

-- the equality is not defined on stream only but on stream α
theorem isBisim_eq : IsBisim (λ (a b: Stream α) => a = b) := by
  rintro x _ rfl
  refine ⟨0, 0, rfl, rfl, ?_, ?_,⟩
  <;> (intros; contradiction)

theorem Bisim.rfl {a : Stream α} : a ~ a := by
  exact ⟨(· = ·), by rfl, isBisim_eq⟩

@[symm] theorem Bisim.symm {a b : Stream α} : a ~ b → b ~ a := by
  rintro ⟨R, h_R, h_R_isBisim⟩
  refine ⟨fun x y => R y x, h_R, ?_⟩
  intro x y h_Rxy
  have ⟨n, m, R_drop, get_eq, h_n, h_m⟩ := h_R_isBisim _ _ h_Rxy
  exact ⟨m, n, R_drop, get_eq.symm, h_m, h_n⟩

theorem Bisim.trans {a b} : a ~ b → b ~ c → a ~ c := by sorry

theorem bisim_tail_of_head_eq_none {a : Stream α} (h : a.head = none) :
    a ~ a.tail := by
  apply Bisim.fold
  refine  ⟨1, 0, rfl, rfl, ?_, ?_⟩
  · intro i i_lt
    obtain rfl : i = 0 := by omega
    exact h
  · intros; contradiction



theorem tail_bisim_of_bisim_of_head_eq {a b : Stream α} (h_sim : a ~ b) (head_eq : a.head = b.head) :
    a.tail ~ b.tail := by
  apply Bisim.fold
  rcases h_sim.unfold       with ⟨n,  m,  h_sim_drop,  h_eq,  h_n,  h_m⟩
  rcases h_sim_drop.unfold  with ⟨n', m', h_sim_drop', h_eq', h_n', h_m'⟩
  simp only [Stream'.get_drop, Stream'.drop_drop] at *

  match n, m with
    | 0,   0   => exact h_sim_drop.unfold
    | n+1, m+1 =>
        refine ⟨n, m, h_sim_drop, h_eq, ?_, ?_⟩
        · intros; apply h_n; omega
        · intros; apply h_m; omega
    | 0,   m+1 =>
        have b_head_eq_none : b.head = none       := h_m 0 (by omega)
        have a_head_eq_none : a.head = none       := by simp_all
        have b_get_eq_none  : b.get (m+1) = none  := by simpa [← a_head_eq_none] using h_eq.symm
        simp only [show m' + 1 + (m + 2) = m' + m + 3 by omega] at h_sim_drop'

        refine ⟨n', m'+m+1, h_sim_drop', h_eq', h_n', ?_⟩
        intro j j_lt
        by_cases lt_m : j < m
        · apply h_m; omega
        · obtain ⟨j, rfl⟩ := Nat.exists_eq_add_of_le (by omega : m ≤ j)
          match j with
          | 0    => exact b_get_eq_none
          | j+1  =>
            simp only [← h_m' j (by omega), tail, Stream'.get_tail]
            congr 1
            omega
    | n+1, 0 =>
        have a_head_eq_none : a.head = none       := h_n 0 (by omega)
        have b_head_eq_none : b.head = none       := by simp_all
        have a_get_eq_none  : a.get (n+1) = none  := by simpa [← b_head_eq_none] using h_eq
        simp only [show n' + 1 + (n + 2) = n' + n + 3 by omega] at h_sim_drop'

        refine ⟨n'+n+1, m', h_sim_drop', h_eq', ?_, h_m'⟩
        intro j j_lt
        by_cases lt_m : j < n
        · apply h_n; omega
        · obtain ⟨j, rfl⟩ := Nat.exists_eq_add_of_le (by omega : n ≤ j)
          match j with
          | 0    => exact a_get_eq_none
          | j+1  =>
            simp only [← h_n' j (by omega), tail, Stream'.get_tail]
            congr 1
            omega

theorem tail_bisim_iff_bisim_of_head {a b : Stream α} (head_eq : a.head = b.head) :
    a.tail ~ b.tail ↔ a ~ b := by
  constructor
  · intro sim_tail
    apply fold
    cases h_a_head : a.head
    case some =>
      refine ⟨0, 0, sim_tail, head_eq, ?_, ?_,⟩
      <;> (intros; contradiction)
    case none =>
      have ⟨n, m, h_sim, h_eq, h_n, h_m⟩ := sim_tail.unfold
      refine ⟨n+1, m+1, h_sim, h_eq, ?_, ?_⟩
      <;> intro i i_lt
      · cases i
        case zero   => exact h_a_head
        case succ i => exact h_n i (by omega)
      · cases i
        case zero   => simpa [h_a_head] using head_eq.symm
        case succ i => exact h_m i (by omega)
  · exact (tail_bisim_of_bisim_of_head_eq · head_eq)

/-- `stuck` is the stream with only `none`s -/
-- had to give stuck a type too otherwise all the other defs would break, is this correct?
-- stuck still contains `none` elements only
def stuck (α : Type) : Stream α := Stream'.const none

-- objective of the theorem: prove that stuck.head = none by theorem rfl
@[simp] theorem head_stuck (α : Type) : (stuck α).head = none := rfl
@[simp] theorem tail_stuck (α : Type) : (stuck α).tail = stuck α := rfl

theorem head_isNone_of_bisim_stuck {α : Type} (x : Stream α) : x ~ stuck α → x.head = none := by
  rintro ⟨R, h_Rx, h_sim⟩
  rcases h_sim _ _ h_Rx with ⟨n, m, h_saturate_drop, (h_eq : _ = none), h_n, -⟩
  simp only [stuck, Stream'.drop_const] at h_saturate_drop
  cases n
  case zero   => exact h_eq
  case succ n => exact h_n 0 (Nat.zero_lt_succ n)

/-- The only stream bisimilar to `stuck` is `stuck` itself -/
@[simp] theorem eq_stuck_iff_equiv {x}  :
    x ~ stuck α ↔ x = stuck α:= by
  constructor
  · intro h_sim; funext ind
    induction ind generalizing x with
    | zero      => exact head_isNone_of_bisim_stuck _ h_sim
    | succ _ ih =>
      have : x.head = (stuck α).head := head_isNone_of_bisim_stuck _ h_sim
      have : x.tail ~ (stuck α).tail := (tail_bisim_iff_bisim_of_head this |>.mpr h_sim)
      apply ih this
  · rintro rfl; exact Bisim.rfl

noncomputable def nonesUntilSome (x : Stream α) (not_stuck : x ≠ stuck α) : Nat :=
  prop.choose
where
  prop : ∃ i, (x.drop i).head.isSome ∧ ∀ j < i, x.get j = none := by
    by_contra h
    apply not_stuck
    funext i
    induction i using Nat.strongInductionOn
    next i ih =>
      simp only [Stream'.get, Stream'.drop, Nat.zero_add, not_exists, not_and, not_forall,
        Classical.not_imp] at h
      specialize h i
      cases hx : x i
      case none   => rfl
      case some _ =>
        simp only [hx, Option.isSome_some, exists_prop, true_implies] at h
        have ⟨j, hj1, hj2⟩ := h
        specialize ih j hj1
        contradiction

noncomputable def dropLeadingNones (x : Stream α) (not_stuck : x ≠ stuck α) : Stream α:=
  x.drop (nonesUntilSome x not_stuck)

theorem nonesUntilSome_spec (x : Stream α) (not_stuck : x ≠ stuck α) :
    (dropLeadingNones x not_stuck).head.isSome
    ∧ ∀ j < nonesUntilSome x not_stuck, x.get j = none :=
  (nonesUntilSome.prop x not_stuck).choose_spec

open Classical in
/-- `removeNone` will (noncomputably) remove all `none`s *between messages* in a stream.
Thus, if the original stream has infinitely many `some _` messages,
then `x.removeNone` will have no`none`s.
Otherwise, the original stream has an infinite suffix `none, none, ...` at the end,
and `x.removeNone` will also have such a suffix (but no other `none`s).

This requires examing a potentially unbounded amount of messages into the future
(to determine if there will ever be another `some _`), thus cannot be computable. -/
noncomputable def removeNone (x : Stream α) : Stream α :=
  Stream.corec x fun x =>
    if h : x ≠ stuck α then
      let x := x.dropLeadingNones h
      (x.head, x.tail)
    else
      (none, x)

open Classical in
@[simp] theorem head_removeNone (x : Stream α) :
    x.removeNone.head =
      if h : x ≠ stuck α then
        (x.dropLeadingNones h).head
      else
        none := by
  by_cases h : x = stuck α <;> simp [h, removeNone]

open Classical in
@[simp] theorem removeNone_stuck : (stuck α).removeNone = stuck α := by
  simp only [removeNone, corec, Stream'.corec, ne_eq]
  have :
      Stream'.iterate (fun x => Prod.snd <|
          if h : ¬x = stuck α then
            ((dropLeadingNones x h).head, (dropLeadingNones x h).tail)
          else
            (none, x)
        ) (stuck α)
      = Stream'.const (stuck α) := by
    funext i
    simp only [dite_not, Stream'.const]
    induction i
    case zero       => rfl
    case succ i ih  => simp [Stream'.iterate, ih]
  rw [this]
  simp;
  rfl

open Classical in
@[simp] theorem tail_removeNone (x : Stream α) :
    x.removeNone.tail =
      if h : x ≠ stuck α then
        (x.dropLeadingNones h).tail.removeNone
      else
        stuck α := by
  by_cases h : x = stuck α
  · simp [h]
  · simp [h, removeNone]

theorem removeNone_equiv (x : Stream α) :
    x.removeNone ~ x := by
  use (· = ·.removeNone), rfl
  rintro _ x rfl
  · use 0
    simp only [Nat.zero_add, Nat.not_lt_zero, false_implies, implies_true, true_and]
    by_cases x_eq_stuck : x = stuck α
    case pos =>
      subst x_eq_stuck
      refine ⟨0, ?_, ?_, by intros; contradiction⟩
      · show tail _ = removeNone (stuck α).tail; simp
      · show head _ = none; simp
    case neg =>
      have ⟨_, h2⟩ := nonesUntilSome_spec x x_eq_stuck
      refine ⟨nonesUntilSome x x_eq_stuck, ?_, ?_, h2⟩
      · show x.removeNone.tail = removeNone (Stream'.drop _ x)
        have (w) : x.drop (w + 1) = tail (x.drop w) := by simp [tail]
        rw [this]
        simp [x_eq_stuck]
        rfl
      · show x.removeNone.head = _
        simp only [head_removeNone, ne_eq, x_eq_stuck, dropLeadingNones]
        simp [head]


#print axioms removeNone_equiv

-- doubt
theorem corec_eq_corec_of
    (R : β₁ → β₂→ Prop)
    (f₁ : β₁ → (Option α × β₁) )
    (f₂ : β₂ → (Option α × β₂))
    (h : ∀ b₁ b₂, R b₁ b₂ →
      (f₁ b₁).fst = (f₂ b₂).fst
      ∧ R (f₁ b₁).snd (f₂ b₂).snd)
    {b₁ : β₁} {b₂ : β₂} (hR : R b₁ b₂):
    corec b₁ f₁ = corec b₂ f₂ := by
  funext i
  simp only [corec, Stream'.corec_def, Stream'.map, Stream'.get]
  suffices
    ∀ i, R (Stream'.iterate (f₁ · |>.snd) b₁ i) (Stream'.iterate (f₂ · |>.snd) b₂ i)
  from (h _ _ (this i)).left

  intro i
  induction i generalizing b₁ b₂
  case zero       => exact hR
  case succ i ih  => exact (h _ _ (ih hR)).right

theorem corec₂_eq_corec₂_of
    (R : β₁ → β₂→ Prop)
    (f₁ : β₁ → (Option α₁ × Option α₂ × β₁) )
    (f₂ : β₂ → (Option α₁ × Option α₂ × β₂))
    (h : ∀ b₁ b₂, R b₁ b₂ →
      (f₁ b₁).fst = (f₂ b₂).fst
      ∧ R (f₁ b₁).snd.snd (f₂ b₂).snd.snd)
    (h2 : ∀ b₁ b₂, R b₁ b₂ →
      (f₁ b₁).snd.fst = (f₂ b₂).snd.fst
      ∧ R (f₁ b₁).snd.snd (f₂ b₂).snd.snd)
    {b₁ : β₁} {b₂ : β₂} (hR : R b₁ b₂):
    corec₂ b₁ f₁ = corec₂ b₂ f₂ := by sorry
  -- funext i
  -- simp only [corec, Stream'.corec_def, Stream'.map, Stream'.get]
  -- suffices
  --   ∀ i, R (Stream'.iterate (f₁ · |>.snd) b₁ i) (Stream'.iterate (f₂ · |>.snd) b₂ i)
  -- from (h _ _ (this i)).left
  -- intro i
  -- induction i generalizing b₁ b₂
  -- case zero       => exact hR
  -- case succ i ih  => exact (h _ _ (ih hR)).right

-- unfold quot stuff to reduce to bisim stuff





theorem head_dropLeadingNones_eq_of_bisim {x y} (h : x ~ y) (x_neq_stuck : x ≠ stuck α)
    (y_neq_stuck : y ≠ stuck α := fun h' => x_neq_stuck (eq_stuck_iff_equiv.mp (h' ▸ h))) :
    head (x.dropLeadingNones x_neq_stuck) = head (y.dropLeadingNones y_neq_stuck) := by
  have ⟨x_spec₁, x_spec₂⟩ := nonesUntilSome_spec x x_neq_stuck
  have ⟨y_spec₁, y_spec₂⟩ := nonesUntilSome_spec y y_neq_stuck
  have ⟨n, m, h_drop, h_eq, hn, hm⟩ := h.unfold
  simp only [head, dropLeadingNones, Stream'.get_drop, Nat.zero_add] at *
  generalize nonesUntilSome x x_neq_stuck = xn at *
  generalize nonesUntilSome y y_neq_stuck = yn at *
  clear x_neq_stuck y_neq_stuck
  induction xn using Nat.strongInductionOn generalizing x y yn
  next xn x_ih =>
    have : n ≤ xn := by
      by_contra h; simp [hn xn (by omega)] at x_spec₁
    rcases (by omega : n < xn ∨ n = xn) with n_lt | rfl
    · obtain ⟨xn, rfl⟩ := Nat.exists_eq_add_of_lt n_lt
      clear this n_lt
      specialize @x_ih xn (by omega) (x.drop (n+1)) (y.drop (m+1)) h_drop ?_ ?_ ?_ ?_
      · sorry
      · sorry
      · intros i hi; apply x_spec₂; sorry
      stop
      apply x_ih
    · sorry


theorem tail_dropLeadingNones_bisim {x y} (h : x ~ y) (x_neq_stuck : x ≠ stuck α)
    (y_neq_stuck : y ≠ stuck α := fun h' => x_neq_stuck (eq_stuck_iff_equiv.mp (h' ▸ h))) :
    tail (x.dropLeadingNones x_neq_stuck) ~ tail (y.dropLeadingNones y_neq_stuck) := by
  sorry

-- doubt
open Classical in
theorem removeNone_eq_of_equiv {α : Type} {x y : Stream α} (h_sim : x ~ y) :
    x.removeNone = y.removeNone := by
  apply corec_eq_corec_of (· ~ ·) _ _ _ h_sim
  intro a b h_sim
  simp only [ne_eq, dite_not]
  by_cases h : a = stuck α
  · subst h
    obtain rfl : b = stuck α := eq_stuck_iff_equiv.mp h_sim.symm
    simp [eq_stuck_iff_equiv, and_self]
  · have : b ≠ stuck α := by rintro rfl ; exact h <| eq_stuck_iff_equiv.mp h_sim
    simp [h, this, head_dropLeadingNones_eq_of_bisim h_sim, tail_dropLeadingNones_bisim h_sim]

def StreamWithoutNones' (α : Type) : Type :=
  Quot (Bisim : Stream α → Stream α → Prop)

instance StreamSetoid (α : Type) : Setoid (Stream α) where
  iseqv := Equivalence.mk (@Bisim.rfl α) Bisim.symm Bisim.trans

def StreamWithoutNones (α : Type) : Type :=
  Quotient (StreamSetoid α)

#print axioms StreamWithoutNones

def remNone {α : Type} (lst : Stream α) : (StreamWithoutNones α) := Quotient.mk _ lst

def StreamWithoutNones.hasStream (x : StreamWithoutNones α) : Set (Stream α):=
  { y | x = Quotient.mk _ y }

-- A determinate component
def nondeterminify (f : Stream α → Stream α) (x : StreamWithoutNones α) : Set (StreamWithoutNones α) :=
  -- Quotient.lift (fun (a : Stream) =>
  --   ({ b | (f a) ∈ StreamWithoutNones.hasStream b } : Set StreamWithoutNones)
  -- ) (by sorry) x
  { Quotient.mk _ (f y) | y ∈ StreamWithoutNones.hasStream x }

#print nondeterminify

def nondeterminify2 (f : Stream α → Stream α → Stream α) (x : StreamWithoutNones α × StreamWithoutNones α) : Set (StreamWithoutNones α) :=
  -- Quotient.lift (fun (a : Stream) =>
  --   ({ b | (f a) ∈ StreamWithoutNones.hasStream b } : Set StreamWithoutNones)
  -- ) (by sorry) x
  { x1 | ∃ y1 y2, (y1 ∈ StreamWithoutNones.hasStream x.fst)
                  ∧ (y2 ∈ StreamWithoutNones.hasStream x.snd)
                  ∧ Quotient.mk _ (f y1 y2) = x1 }
