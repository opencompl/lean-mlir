import SSA.Projects.CIRCT.Stream.Basic

/-! This file contains the lemmas we use to reason about `HandshakeStream.Stream`-/

namespace HandshakeStream

@[simp] theorem head_corec : head (HandshakeStream.corec b f) = (f b).fst :=
  by rfl

@[simp] theorem tail_corec :
    tail (HandshakeStream.corec b f) = HandshakeStream.corec (f b).snd f := by
  funext i
  simp only [tail, Stream'.tail, Stream'.get, corec, Stream'.corec, Stream'.map, Stream'.iterate]
  congr
  induction i
  case zero => rfl
  case succ i ih  => simp only [Stream'.iterate]; congr

theorem unfold :
    x ~ y → ∃ n m,
      x.drop (n+1) ~ y.drop (m+1)
      ∧ x.get n = y.get m
      ∧ (∀ i < n, x.get i = none)
      ∧ (∀ j < m, y.get j = none) := by
  intro hyp
  rw [Bisim] at hyp
  exact hyp

theorem fold
    (h : ∃ n m,
      (Stream'.drop (n+1) (x: Stream' _)) ~ (Stream'.drop (m+1) (y: Stream' _))
      ∧ x.get n = y.get m
      ∧ (∀ i < n, x.get i = none)
      ∧ (∀ j < m, y.get j = none)) :
    x ~ y := by
  rw [Bisim]
  simp only
  exact h

theorem bisim_tail_of_head_eq_none {a : Stream α} (h : a.head = none) :
    a ~ a.tail := by
  apply fold
  refine  ⟨1, 0, rfl, (by simp), ?_, ?_⟩
  · intro i i_lt
    obtain rfl : i = 0 := by omega
    exact h
  · intros; contradiction

theorem tail_bisim_of_bisim_of_head_eq {a b : Stream α} (h_sim : a ~ b) (head_eq : a.head = b.head) :
    a.tail ~ b.tail := by
  apply fold
  rw [Bisim] at h_sim
  rcases h_sim       with ⟨n,  m,  h_sim_drop,  h_eq,  h_n,  h_m⟩
  rw [Bisim] at h_sim_drop
  rcases h_sim_drop  with ⟨n', m', h_sim_drop', h_eq', h_n', h_m'⟩
  simp only [Stream'.get_drop, Stream'.drop_drop] at *
  match n, m with
    | 0, 0  =>  sorry
    | n+1, m+1 =>
        refine ⟨n, m,
          (by simp;
              rw [Bisim]
              simp_all
              sorry), h_eq, ?_, ?_⟩
        · intros; apply h_n; omega
        · intros; apply h_m; omega
    | 0,   m+1 =>
        have b_head_eq_none : b.head = none       := h_m 0 (by omega)
        have a_head_eq_none : a.head = none       := by simp_all
        have b_get_eq_none  : b.get (m+1) = none  := by simpa [← a_head_eq_none] using h_eq.symm
        simp at h_sim_drop'
        sorry
    | n+1, 0 =>
        have a_head_eq_none : a.head = none       := h_n 0 (by omega)
        have b_head_eq_none : b.head = none       := by simp_all
        have a_get_eq_none  : a.get (n+1) = none  := by simpa [← b_head_eq_none] using h_eq
        simp at h_sim_drop'
        sorry

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
      rw [Bisim] at sim_tail
      have ⟨n, m, h_sim, h_eq, h_n, h_m⟩ := sim_tail
      refine ⟨n+1, m+1, h_sim, h_eq, ?_, ?_⟩
      <;> intro i i_lt
      · cases i
        case zero   => exact h_a_head
        case succ i => exact h_n i (by omega)
      · cases i
        case zero   => simpa [h_a_head] using head_eq.symm
        case succ i => exact h_m i (by omega)
  · exact (tail_bisim_of_bisim_of_head_eq · head_eq)

@[simp] theorem head_stuck (α : Type) : (stuck α).head = none :=  by rfl
@[simp] theorem tail_stuck (α : Type) : (stuck α).tail = stuck α := by rfl

theorem head_isNone_of_bisim_stuck {α : Type} (x : Stream α) : x ~ stuck α → x.head = none := by
  intro hyp
  rw [Bisim] at hyp
  have ⟨n, _, _, w₁, w₂, _⟩ := hyp
  cases n with
  | zero => exact w₁
  | succ n => exact w₂ 0 (by simp)

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
  · rintro rfl;
    exact rfl

noncomputable def nonesUntilSome (x : Stream α) (not_stuck : x ≠ stuck α) : Nat :=
  prop.choose
where
  prop : ∃ i, (x.drop i).head.isSome ∧ ∀ j < i, x.get j = none := by
    by_contra h
    apply not_stuck
    funext i
    induction i using Nat.strongRecOn
    next i ih =>
      simp only [Stream'.get, Stream'.drop, Nat.zero_add, not_exists, not_and, not_forall] at h
      specialize h i
      cases hx : x i
      case none   => rfl
      case some _ =>
        simp only [hx, Option.isSome_some, exists_prop, true_implies] at h
        have ⟨j, hj1, hj2⟩ := h
        specialize ih j hj1
        contradiction

noncomputable def dropLeadingNones (x : Stream α) (not_stuck : x ≠ stuck α) : Stream α :=
  x.drop (nonesUntilSome x not_stuck)

theorem nonesUntilSome_spec (x : Stream α) (not_stuck : x ≠ stuck α) :
    (dropLeadingNones x not_stuck).head.isSome
    ∧ ∀ j < nonesUntilSome x not_stuck, x.get j = none :=
  (nonesUntilSome.prop x not_stuck).choose_spec


open Classical in
/--
  `removeNone` will (noncomputably) remove all `none`s *between messages* in a stream.
  Thus, if the original stream has infinitely many `some _` messages,
  then `x.removeNone` will have no`none`s.
  Otherwise, the original stream has an infinite suffix `none, none, ...` at the end,
  and `x.removeNone` will also have such a suffix (but no other `none`s).
  This requires examing a potentially unbounded amount of messages into the future
  (to determine if there will ever be another `some _`), thus cannot be computable.
-/
noncomputable def removeNone (x : Stream α) : Stream α :=
  if h : x ≠ stuck α then
    dropLeadingNones x h
  else
    x



open Classical in
@[simp] theorem head_removeNone (x : Stream α) :
    (HandshakeStream.removeNone x).head =
      if h : x ≠ stuck α then
        (HandshakeStream.dropLeadingNones x h).head
      else
        none := by
  by_cases h : x = stuck α <;> simp [h, removeNone]

open Classical in
@[simp] theorem removeNone_stuck : HandshakeStream.removeNone (stuck α) = stuck α := by
  simp only [removeNone, ne_eq]
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
  grind

open Classical in
@[simp] theorem tail_removeNone (x : Stream α) :
    (HandshakeStream.removeNone x).tail =
      if h : x ≠ stuck α then
        HandshakeStream.removeNone (HandshakeStream.dropLeadingNones x h).tail
      else
        stuck α := by
  by_cases h : x = stuck α
  · simp [h]
  · simp [h, removeNone]
    intros h
    sorry

theorem removeNone_equiv (x : Stream α) :
    (HandshakeStream.removeNone x )~ x := by
  apply Bisim.coinduct (· = HandshakeStream.removeNone ·)
  · rintro _ x rfl
    · use 0
      simp only [Nat.zero_add, Nat.not_lt_zero, false_implies, implies_true, true_and]
      by_cases x_eq_stuck : x = stuck α
      case pos =>
        subst x_eq_stuck
        refine ⟨0, ?_, ?_, by intros; contradiction⟩
        · show tail _ = removeNone (stuck α).tail; simp
          rfl
        · show head _ = none; simp
          rfl
      case neg =>
        have ⟨_, h2⟩ := nonesUntilSome_spec x x_eq_stuck
        refine ⟨nonesUntilSome x x_eq_stuck, ?_, ?_, h2⟩
        · show (HandshakeStream.removeNone x).tail = removeNone (Stream'.drop _ x)
          have (w : Nat) : x.drop (w + 1) = tail (x.drop w) := by simp [tail]
          rw [this]
          simp [x_eq_stuck]
          rfl
        · show (HandshakeStream.removeNone x).head = _
          simp [head_removeNone, ne_eq, x_eq_stuck, dropLeadingNones]
  · rfl

/--
  info: 'HandshakeStream.removeNone_equiv' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]
-/
#guard_msgs in
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

theorem corec_prod_eq_corec_prod_of
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
    corec_prod b₁ f₁ = corec_prod b₂ f₂ := by sorry

theorem head_dropLeadingNones_eq_of_bisim {x y} (h : x ~ y) (x_neq_stuck : x ≠ stuck α)
    (y_neq_stuck : y ≠ stuck α := fun h' => x_neq_stuck (eq_stuck_iff_equiv.mp (h' ▸ h))) :
    head (HandshakeStream.dropLeadingNones x x_neq_stuck) = head (HandshakeStream.dropLeadingNones y y_neq_stuck) := by
  have ⟨x_spec₁, x_spec₂⟩ := nonesUntilSome_spec x x_neq_stuck
  have ⟨y_spec₁, y_spec₂⟩ := nonesUntilSome_spec y y_neq_stuck
  rw [Bisim] at h
  have ⟨n, m, h_drop, h_eq, hn, hm⟩ := h
  simp only [head, dropLeadingNones, Stream'.get_drop] at *
  generalize nonesUntilSome x x_neq_stuck = xn at *
  generalize nonesUntilSome y y_neq_stuck = yn at *
  clear x_neq_stuck y_neq_stuck
  induction xn using Nat.strongRecOn generalizing x y yn
  next xn x_ih =>
    have : n ≤ xn := by
      by_contra h; simp [hn xn (by omega)] at x_spec₁
    rcases (by omega : n < xn ∨ n = xn) with n_lt | rfl
    · obtain ⟨xn, rfl⟩ := Nat.exists_eq_add_of_lt n_lt
      sorry
    · sorry


theorem tail_dropLeadingNones_bisim {x y} (h : x ~ y) (x_neq_stuck : x ≠ stuck α)
    (y_neq_stuck : y ≠ stuck α := fun h' => x_neq_stuck (eq_stuck_iff_equiv.mp (h' ▸ h))) :
    tail (HandshakeStream.dropLeadingNones x x_neq_stuck) ~ tail (HandshakeStream.dropLeadingNones y y_neq_stuck) := by
  sorry

-- doubt
open Classical in
theorem removeNone_eq_of_equiv {α : Type} {x y : Stream α} (h_sim : x ~ y) :
    HandshakeStream.removeNone x = HandshakeStream.removeNone y := by
  sorry

theorem syncMap₂_eq_syncMap₂ {f : α → β → γ}
    (hxs : xs ~ xs') (hys : ys ~ ys') :
    syncMap₂ f xs ys ~ syncMap₂ f xs' ys' := by
  sorry


theorem syncMap2_flip {f : α → β → γ} :
  syncMap₂ f xs ys = syncMap₂ (fun y x => f x y) ys xs := by  sorry

theorem syncMap3_flip23 {f : α → β → γ → δ} :
  syncMap₃ f xs ys zs = syncMap₃ (fun x z y => f x y z) xs zs ys := by  sorry


theorem syncMap₃_eq_syncMap₃
    (hxs : xs ~ xs') (hys : ys ~ ys') (hzs : zs ~ zs') :
    syncMap₃ f xs ys zs ~ syncMap₃ f xs' ys' zs' := by
  -- apply corec_eq_corec_of
  sorry

@[simp]
theorem syncMap2_syncMap2_eq_syncMap3 (f : α → β → γ) (g : γ → ε → φ)
    (as : Stream α) (bs : Stream β) (es : Stream ε) :
    syncMap₂ g (syncMap₂ f as bs) es = syncMap₃ (fun a b e => g (f a b) e) as bs es := by
  -- I believe this is equal, but it might only be bisim (~)
  sorry

-- theorem syncMap₃_eq_syncMap₃_iff {f g : α → β → γ}
--     (h : ∀ a b c, f a b c = g a b c) :
--     syncMap₂ f xs ys = syncMap₂ g xs ys := by
--   sorry
