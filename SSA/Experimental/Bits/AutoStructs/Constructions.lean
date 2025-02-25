import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic.ApplyFun
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.ForMathlib
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.BundledNfa
import SSA.Experimental.Bits.AutoStructs.Worklist

section sink

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

@[inline]
def RawCNFA.addSink (m : RawCNFA A) : RawCNFA A := m.createSink.2

@[inline]
def CNFA.addSink (m : CNFA n) : CNFA n := ⟨m.m.addSink, wf_createSink m.wf⟩

lemma addSink_spec (m : CNFA n) (M : NFA' n) :
    m.Sim M →
    m.addSink.Sim M.complete := by
  rintro ⟨Ri, hsim⟩
  let R (s : State) (q : M.complete.σ) :=
    s = m.m.stateMax ∧ q = .inr () ∨
      ∃ qᵢ, s ∈ m.m.states ∧ q = .inl qᵢ ∧ Ri s qᵢ
  use R; constructor
  · simp [CNFA.addSink, RawCNFA.addSink, NFA'.complete, NFA.complete, R]
    rintro s; constructor
    · rintro q hin hRi; exact hsim.accept hRi
    · rintro rfl hc; apply m.wf.finals_lt at hc; simp_all
  · simp [CNFA.addSink, RawCNFA.addSink, NFA'.complete, NFA.complete, R]
    rintro s (rfl | hi); (right; rfl); left
    have ⟨q, hs, hRi⟩ := hsim.initial₁ hi
    exact ⟨q, hs, m.wf.initials_lt hi, hRi⟩
  · simp [CNFA.addSink, RawCNFA.addSink, NFA'.complete, NFA.complete, R]
    rintro q hq; obtain ⟨s, hi, hRi⟩ := hsim.initial₂ hq
    use s, .inr hi, m.wf.initials_lt hi, hRi
  · simp [CNFA.addSink, RawCNFA.addSink, NFA'.complete, NFA.complete, R]
    rintro s s' a; constructor
    on_goal 2 => rintro rfl (⟨_, rfl⟩ | hh); rfl; simp_all
    rintro q hs hRi (⟨rfl, rfl⟩ | ⟨hs1, hs2, htr⟩)
    · simp at hs
    · obtain ⟨_, _, _⟩ := hsim.trans_match₁ hRi htr; tauto
  · simp [CNFA.addSink, RawCNFA.addSink, NFA'.complete, NFA.complete, R]
    rintro s a q q' hs hRi hst
    obtain ⟨s', htr, _⟩ := hsim.trans_match₂ hRi hst (by simp) (by simp)
    have hs' : s' ∈ m.m.states := m.wf.trans_tgt_lt' _ _ _ htr
    use s'; tauto

def RawCNFA.flipFinals (m : RawCNFA A) : RawCNFA A :=
  let oldFinals := m.finals
  let newFinals := (List.range m.stateMax).foldl (init := ∅) fun fins s =>
    if oldFinals.contains s then fins else fins.insert s
  { m with finals := newFinals }

lemma RawCNFA.flipFinals_wf {m : RawCNFA A} (hwf : m.WF) : m.flipFinals.WF := by
  simp [flipFinals]
  constructor <;> simp_all

  let motive (fs : Std.HashSet State) := ∀ s ∈ fs, s ∈ m.states
  suffices h : motive $ List.foldl
      (fun fins s => if m.finals.contains s = true then fins else fins.insert s)
      ∅ (List.range m.stateMax) by
    exact h
  apply List.foldlRecOn
  · simp [motive]
  · simp [motive]
    rintro _ _ _ _ _ hif
    split_ifs at hif <;> simp_all
    rcases hif <;> simp_all [states]
  · intros; apply hwf.trans_tgt_lt <;> assumption

def CNFA.flipFinals (m : CNFA n) : CNFA n := ⟨m.m.flipFinals, m.m.flipFinals_wf m.wf⟩

@[simp]
lemma CNFA.flipFinals_finals {m : CNFA n} {s} :
    s ∈ m.flipFinals.m.finals ↔ (s ∈ m.m.states ∧ s ∉ m.m.finals) := by
  let motive (X : List State) := ∀ acc (s : State),
    (s ∈ X.foldl (init := acc) fun (fins : Std.HashSet State) s =>
          if m.m.finals.contains s then fins else fins.insert s) ↔
      (s ∈ acc ∨ (s ∈ X ∧ s ∉ m.m.finals))
  suffices h : motive (List.range m.m.stateMax) by
    simp only [flipFinals, RawCNFA.flipFinals, wf]
    rw [h]; simp [RawCNFA.states]
  generalize (List.range m.m.stateMax) = states
  induction states; simp [motive]
  case cons st states ih =>
    rintro acc s
    simp only [List.foldl_cons, List.mem_cons]
    rw [ih]; simp [←Std.HashSet.mem_iff_contains]
    constructor
    · rintro (hin | ⟨hin, hnin⟩)
      · split_ifs at hin
        · tauto
        simp only [Std.HashSet.mem_insert, beq_iff_eq] at hin
        rcases hin with rfl | hin <;> tauto
      · tauto
    · rintro (hin | ⟨(rfl | hin), hnin⟩)
      · left; split_ifs <;> simp_all
      · left; simp_all
      · right; simp_all

lemma CNFA.flipFinals_spec {m : CNFA n} {M : NFA' n} :
    m.Sim M → m.flipFinals.Sim M.flipAccept := by
  rintro ⟨R, hsim⟩; use (λ s q => R s q ∧ s ∈ m.m.states); constructor
  · rintro s q ⟨hR, hs⟩
    simp only [flipFinals_finals, hsim.accept hR, true_and, NFA'.flipAccept, NFA.flipAccept, hs]
    rfl
  · rintro s hinit; obtain ⟨q, hq, hR⟩ := hsim.initial₁ hinit
    use q, hq, hR, m.flipFinals.wf.initials_lt hinit
  · rintro s hinit; obtain ⟨q, hq, hR⟩ := hsim.initial₂ hinit
    use q, hq, hR, m.flipFinals.wf.initials_lt hq
  · rintro s s' a q ⟨hR, hst⟩ htr
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₁ hR htr
    use q', hst, hR', m.flipFinals.wf.trans_tgt_lt' _ _ _ htr
  · rintro s s' a q ⟨hR, hst⟩ htr - -
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₂ hR htr (by simp) (by simp)
    use q', hst, hR', m.flipFinals.wf.trans_tgt_lt' _ _ _ hst

end sink

section generic_prod

variable {α} [BEq α] [Hashable α] [LawfulBEq α]
variable {β} [BEq β] [Hashable β] [LawfulBEq β]
variable {S₁ : Finset α} {S₂ : Finset β}
variable {γ} (f : S₁ → S₂ → γ) (hinj : Function.Injective2 f)
variable {m₁ : Std.HashSet α} (hm₁ : ∀ s₁ ∈ m₁, s₁ ∈ S₁)
variable {m₂ : Std.HashSet β} (hm₂ : ∀ s₂ ∈ m₂, s₂ ∈ S₂)

-- generalize to push (f s₁ s₂)
-- generalize lemmas to an initial a

@[inline]
def product.prodArray' (a : Array γ) :=
  m₁.attachWith _ hm₁ |>.fold (init := a) fun is s1 =>
    m₂.attachWith _ hm₂ |>.fold (init := is) fun is s2 =>
      is.push (f s1 s2)

@[inline]
def product.prodArray := prodArray' f hm₁ hm₂ (Array.mkEmpty <| m₁.size * m₂.size)

include hinj in
omit [BEq α] [Hashable α] [LawfulBEq α] in
lemma product.prodArray_spec_helper
    (is : Array γ) (hnd : is.toList.Nodup)
    (s : S₁) (hnew : ∀ s₂, f s s₂ ∉ is):
  let motive (a : Array γ) (S : Set S₂)  :=
    a.toList.Nodup ∧
    (∃ r, a.toList = is.toList ++ r ∧ (∀ z ∈ r, ∃ s₁ s₂, z = f s₁ s₂)) ∧
    ∀ s1 s2, f s1 s2 ∈ a ↔ s1 ≠ s ∧ f s1 s2 ∈ is ∨ s1 = s ∧ s2 ∈ S
  let body := m₂.attachWith _ hm₂ |>.fold (init := is) fun is s2 =>
      is.push (f s s2)
  motive body (m₂.attachWith _ hm₂).toSet := by
  rintro motive; simp only
  apply Std.HashSet.fold_induction
  · simp only [motive, hnd, true_and]; use ⟨[], by simp⟩; rintro s₁ s₂
    simp only [ne_eq, Set.mem_empty_iff_false, and_false, or_false, iff_and_self]
    rintro hin rfl; exact hnew _ hin
  rintro a s₂ S hnin ih; split_ands
  · simp; apply List.Nodup.append ih.1 (by simp)
    simp only [List.disjoint_singleton, Array.mem_toList]
    rintro hin
    rcases ih.2.2 _ _ |>.mp hin with hl | hr
    · simp at hl
    · simp [hnin] at hr
  · obtain ⟨_, ⟨r, hr1, hr2⟩, _⟩ := ih; use r ++ [f s s₂]
    simp only [Array.push_toList, hr1, List.append_assoc, List.mem_append, List.mem_singleton, true_and]
    rintro z (hz | rfl)
    · apply hr2 _ hz
    · tauto
  · rintro s₁' s₂'
    simp [Array.mem_push, ih.2, ne_eq, Prod.mk.injEq, Set.union_singleton, Set.mem_insert_iff,
      Function.Injective2.eq_iff hinj]
    tauto

include hinj in
lemma product.prodArray'_spec_full {aᵢ : Array γ} (hnd: aᵢ.toList.Nodup) (hnin : ∀ s₁ s₂, f s₁ s₂ ∉ aᵢ) :
    (product.prodArray' f hm₁ hm₂ aᵢ).toList.Nodup ∧
    (∃ r, (product.prodArray' f hm₁ hm₂ aᵢ).toList = aᵢ.toList ++ r ∧ (∀ z ∈ r, ∃ s₁ s₂, z = f s₁ s₂)) ∧
    ∀ s₁ s₂, f s₁ s₂ ∈ product.prodArray' f hm₁ hm₂ aᵢ ↔ (s₁.val ∈ m₁ ∧ s₂.val ∈ m₂) := by
  let motive (a : Array γ) (S : Set S₁) :=
    a.toList.Nodup ∧
    (∃ r, a.toList = aᵢ.toList ++ r ∧ (∀ z ∈ r, ∃ s₁ s₂, z = f s₁ s₂)) ∧
     ∀ s1 s2, f s1 s2 ∈ a ↔ s1 ∈ S ∧ s2.val ∈ m₂
  suffices h : motive (product.prodArray' f hm₁ hm₂ aᵢ) (m₁.attachWith _ hm₁).toSet by
    rcases h with ⟨hn, hz, hc⟩; use hn; simp_all
  simp [product.prodArray']
  apply Std.HashSet.fold_induction
  · simp [motive, *]
  rintro a s S hnin ih
  obtain ⟨hnd, ⟨r, happ, hf⟩, hels⟩ := prodArray_spec_helper f hinj hm₂ a ih.1 s
    (by rintro hin; simp [ih.2.2, hnin])
  obtain ⟨r', happ', hf'⟩ := ih.2.1
  simp only [Set.union_singleton, hnd, hels, ne_eq, ih.2.2, Std.HashSet.mem_toSet, Std.HashSet.mem_attachWith_mem,
    Set.mem_insert_iff, true_and, motive]; constructor
  · use (r' ++ r); simp only [happ, happ', List.append_assoc, List.mem_append, true_and]
    rintro z (hz | hz)
    · apply hf' _ hz
    · apply hf _ hz
  simp only [Subtype.forall, Std.HashSet.mem_attachWith_mem]; rintro s₁ hs₁ s₂ hs₂; constructor
  · rintro (⟨h1, h2⟩ | ⟨rfl, h⟩) <;> simp [*]
  · rintro ⟨rfl | h1, h⟩ <;> simp [*]; exact ne_or_eq ⟨s₁, hs₁⟩ s

include hinj in
lemma product.prodArray'_spec {aᵢ : Array γ} (hnd: aᵢ.toList.Nodup) (hnin : ∀ s₁ s₂, f s₁ s₂ ∉ aᵢ) :
    ∀ s₁ s₂, f s₁ s₂ ∈ product.prodArray' f hm₁ hm₂ aᵢ ↔ (s₁.val ∈ m₁ ∧ s₂.val ∈ m₂) :=
  (prodArray'_spec_full _ hinj _ _ hnd hnin).2.2

include hinj in
lemma product.prodArray_spec_full :
    (product.prodArray f hm₁ hm₂).toList.Nodup ∧
    ∀ s₁ s₂, f s₁ s₂ ∈ product.prodArray f hm₁ hm₂ ↔ (s₁.val ∈ m₁ ∧ s₂.val ∈ m₂) := by
  simp only [prodArray]
  obtain ⟨h1, _, h2⟩ := prodArray'_spec_full (aᵢ := #[]) f hinj hm₁ hm₂ (by simp) (by simp)
  simp [h1, h2]

include hinj in
@[simp]
lemma product.prodArray_spec :
    ∀ s₁ s₂, f s₁ s₂ ∈ product.prodArray f hm₁ hm₂ ↔ (s₁.val ∈ m₁ ∧ s₂.val ∈ m₂) :=
  prodArray_spec_full _ hinj _ _ |>.2

end generic_prod

section product

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def product.inits (m₁ m₂ : CNFA n) :=
  product.prodArray Prod.mk @m₁.wf.initials_lt @m₂.wf.initials_lt

def product.inits_nodup : inits m₁ m₂ |>.toList.Nodup := by
  refine (prodArray_spec_full _ ?_ _ _).1
  rintro _ _ _ _ ⟨rfl, rfl⟩; trivial

@[simp]
lemma product.inits_spec :
    ∀ s₁ s₂, (s₁, s₂) ∈ inits m₁ m₂ ↔ (s₁.val ∈ m₁.m.initials ∧ s₂.val ∈ m₂.m.initials) := by
  rintro s₁ s₂; simp only [inits]
  rw [prodArray_spec Prod.mk]
  rintro _ _ _ _ ⟨rfl, rfl⟩; trivial

def product (final? : Bool → Bool → Bool) (m₁ m₂ : CNFA n) : CNFA n :=
  worklistRun (m₁.m.states × m₂.m.states) final (product.inits m₁ m₂)
    (by exact product.inits_nodup) f
where final (ss : m₁.m.states × m₂.m.states) := final? (ss.1 ∈ m₁.m.finals) (ss.2 ∈ m₂.m.finals)
      f (ss : m₁.m.states × m₂.m.states) :=
        let (s1, s2) := ss
        (FinEnum.toList (α := BitVec n)).foldl (init := Array.empty) fun as a =>
          product.prodArray' (λ s₁ s₂ ↦ (a, (s₁, s₂))) (m₁.wf.trans_tgt_lt' s1 a) (m₂.wf.trans_tgt_lt' s2 a) as

noncomputable def to_prop (f : Bool → Bool → Bool) (p1 p2 : Prop) : Prop :=
  f (@Decidable.decide p1 (Classical.propDecidable _)) (@Decidable.decide p2 (Classical.propDecidable _))

lemma product.f_spec {m₁ m₂ : CNFA n} {s₁ : m₁.m.states} {s₂ : m₂.m.states} :
    ∀ a s₁' s₂',
      (a, (s₁', s₂')) ∈ f m₁ m₂ (s₁, s₂) ↔ s₁'.val ∈ m₁.m.tr s₁ a ∧ s₂'.val ∈ m₂.m.tr s₂ a := by
  suffices heq :
      ∀ as a (hnd : as.toList.Nodup) (hnd' : (FinEnum.toList (α := BitVec n)).Nodup)
       (hnew : ∀ b s₁ s₂, (b, s₁, s₂) ∈ as → b ∉ (FinEnum.toList (α := BitVec n))) s₁' s₂',
        (a, (s₁', s₂')) ∈
          ((FinEnum.toList (α := BitVec n)).foldl (init := as) fun as a =>
          product.prodArray' (λ s₁' s₂' ↦ (a, (s₁', s₂'))) (m₁.wf.trans_tgt_lt' s₁ a) (m₂.wf.trans_tgt_lt' s₂ a) as) ↔
        (a, (s₁', s₂')) ∈ as ∨ a ∈ (FinEnum.toList (α := BitVec n)) ∧ s₁'.val ∈ m₁.m.tr s₁ a ∧ s₂'.val ∈ m₂.m.tr s₂ a by
    rintro a s₁' s₂'; rw [f, heq]
    · simp; rintro h; apply Array.not_mem_empty at h; trivial
    · exact List.dedup_eq_self.mp rfl
    · exact FinEnum.nodup_toList
    · rintro _ _ _ h; apply Array.not_mem_empty at h; trivial
  induction (FinEnum.toList (α := BitVec n))
  case nil =>
    simp only [List.foldl_nil, List.not_mem_nil, false_and, iff_false, Subtype.forall, CNFA.wf]
    intros _ _ _ _ _ _; tauto
  case cons a as ih =>
    rintro bs b hnd hnd' hnew s₁' s₂'
    obtain ⟨hnd'', ⟨r, hr, hf⟩, hin⟩ := prodArray'_spec_full (fun s₁' s₂' => (a, s₁', s₂'))
      (by rintro _ _ _ _ ⟨rfl, rfl, rfl⟩; tauto)
      (m₁.wf.trans_tgt_lt' s₁ a) (m₂.wf.trans_tgt_lt' s₂ a)
      hnd
      (by dsimp; rintro s₁ s₂ hin; apply hnew at hin; simp at hin)
    dsimp
    have hmem : ∀ b s₁' s₂', b ≠ a → (b, s₁', s₂') ∈ prodArray' (fun s₁' s₂' => (a, s₁', s₂'))
        (m₁.wf.trans_tgt_lt' s₁ a) (m₂.wf.trans_tgt_lt' s₂ a) bs → (b, s₁', s₂') ∈ bs := by
      rintro b s₁' s₂' hneq hin
      rw [Array.mem_def] at hin ⊢; simp only [hr, List.mem_append] at hin
      rcases hin with hin | hin; assumption
      obtain ⟨_, _, ⟨rfl, -, -⟩⟩ := hf _ hin; simp at hneq
    rw [ih] <;> clear ih; rotate_left
    · apply hnd''
    · exact (List.nodup_cons.mp hnd').2
    · rintro b s₁' s₂' hin; by_cases heq : b = a
      · subst heq; apply List.Nodup.not_mem hnd'
      · specialize hnew b s₁' s₂' (hmem b s₁' s₂' heq hin); simp at hnew; simp [hnew]
    by_cases heq :  b = a
    · subst heq
      simp [hin]; clear hin; constructor
      · rintro (⟨h1, h2⟩ | ⟨_, h1, h2⟩) <;> right <;> simp [h1, h2]
      · rintro (hc | ⟨h1, h2⟩)
        · apply hnew at hc; simp at hc
        · left; simp [h1, h2]
    · simp only [List.mem_cons, heq, false_or]; constructor
      · rintro (hin | hin)
        · left; apply hmem _ _ _ heq hin
        · right; exact hin
      · rintro (hin | hin)
        · left; rw [Array.mem_def] at hin ⊢; rw [hr]; simp [hin]
        · right; exact hin

lemma product.sim {m1 m2 : CNFA n}:
    m1.Sim M1 → m2.Sim M2 →
    (nfa (product.inits m1 m2) (final final? m1 m2) (f m1 m2)).Bisim (M1.M.product (to_prop final?) M2.M) := by
  rintro ⟨R₁, hsim₁⟩ ⟨R₂, hsim₂⟩
  let R : Rel (m1.m.states × m2.m.states) (M1.σ × M2.σ) :=
    λ (s₁, s₂) (q₁, q₂) ↦ R₁ s₁ q₁ ∧ R₂ s₂ q₂
  use R; constructor
  · rintro ⟨s₁, s₂⟩ ⟨q₁, q₂⟩ ⟨hR₁, hR₂⟩
    simp [nfa, to_prop, final]
    rw [←hsim₁.accept hR₁, ←hsim₂.accept hR₂]; congr
  · constructor
    · rintro ⟨s₁, s₂⟩ hstart
      simp [nfa, inits_spec] at hstart; rcases hstart with ⟨h₁, h₂⟩
      obtain ⟨q₁, hq₁, hR₁⟩ := hsim₁.initial₁ h₁
      obtain ⟨q₂, hq₂, hR₂⟩ := hsim₂.initial₁ h₂
      use (q₁, q₂); simp [NFA.product, R, *]
    · rintro ⟨q₁, q₂⟩ ⟨hst₁, hst₂⟩
      apply hsim₁.initial₂ at hst₁; obtain ⟨s₁, hi₁, hR₁⟩ := hst₁
      apply hsim₂.initial₂ at hst₂; obtain ⟨s₂, hi₂, hR₂⟩ := hst₂
      simp only [nfa, Set.mem_setOf_eq, Prod.exists, inits_spec, exists_and_left, exists_prop]
      have hin₁ : s₁ ∈ m1.m.states := by apply m1.wf.initials_lt hi₁
      have hin₂ : s₂ ∈ m2.m.states := by apply m2.wf.initials_lt hi₂
      use ⟨s₁, hin₁⟩, ⟨s₂, hin₂⟩
  · rintro ⟨s₁, s₂⟩ ⟨q₁, q₂⟩ a ⟨s₁', s₂'⟩ ⟨hR₁, hR₂⟩ hst
    simp [nfa, f_spec] at hst; rcases hst with ⟨hst₁, hst₂⟩
    obtain ⟨q₁', hst₁, hR₁'⟩ := hsim₁.trans_match₁ hR₁ hst₁
    obtain ⟨q₂', hst₂, hR₂'⟩ := hsim₂.trans_match₁ hR₂ hst₂
    simp [NFA.product]
    use q₁', q₂'
  · rintro ⟨s₁, s₂⟩ ⟨q₁, q₂⟩ a ⟨q₁', q₂'⟩ ⟨hR₁, hR₂⟩ hst
    simp [NFA.product] at hst; rcases hst with ⟨hst₁, hst₂⟩
    obtain ⟨s₁', hst₁, hR₁'⟩ := hsim₁.trans_match₂ hR₁ hst₁ (by simp) (by simp)
    obtain ⟨s₂', hst₂, hR₂'⟩ := hsim₂.trans_match₂ hR₂ hst₂ (by simp) (by simp)
    have hin₁ : s₁' ∈ m1.m.states := by apply m1.wf.trans_tgt_lt' _ _ _ hst₁;
    have hin₂ : s₂' ∈ m2.m.states := by apply m2.wf.trans_tgt_lt' _ _ _ hst₂
    simp only [nfa, Set.mem_setOf_eq, Prod.exists, f_spec, exists_and_left, exists_prop]
    use ⟨s₁', hin₁⟩, ⟨s₂', hin₂⟩

def CNFA.inter (m1 m2 : CNFA n) : CNFA n := product (fun b1 b2 => b1 && b2) m1 m2
def CNFA.union (m1 m2 : CNFA n) : CNFA n :=
  product (fun b1 b2 => b1 || b2) m1.addSink m2.addSink

def CNFA.product_spec (final? : Bool → Bool → Bool) (m1 m2 : CNFA n)
  {M1 : NFA' n} {M2 : NFA' n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (product final? m1 m2).Sim (NFA'.product (to_prop final?) M1 M2) := by
  rintro hs₁ hs₂
  apply bisim_comp
  · apply worklistRun_spec
  apply product.sim <;> assumption

def CNFA.inter_spec (m1 m2 : CNFA n)
  {M1 : NFA' n} {M2 : NFA' n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (m1.inter m2).Sim (M1.inter M2) := by
  intros h1 h2
  simp [NFA'.inter_eq, CNFA.inter]
  have heq : And = to_prop (fun x y => x && y) := by
    ext x y; simp [to_prop]
  simp [heq]
  apply product_spec <;> assumption

def CNFA.union_spec (m1 m2 : CNFA n)
  {M1 : NFA' n} {M2 : NFA' n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (m1.union m2).Sim (M1.union M2) := by
  intros h1 h2
  simp [NFA'.union_eq, CNFA.union]
  have heq : Or = to_prop (fun x y => x || y) := by
    ext x y; simp [to_prop]
  simp [heq]
  apply product_spec <;> apply addSink_spec <;> assumption

end product

def HashSet.inter [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Std.HashSet A :=
  m1.fold (init := Std.HashSet.empty) fun mi x => if m2.contains x then mi.insert x else mi

def Std.HashSet.isDisjoint [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  (HashSet.inter m1 m2).isEmpty

def HashSet.areIncluded [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  m1.all (fun x => m2.contains x)

section determinization

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

-- TODO: I'd rather use hashsets, but I don't think the following holds
-- `Fintype α → Fintype (HashSet α)`

def BitVec.any (b : BitVec w) (f : Fin w → Bool → Bool) :=
  List.finRange w |>.any fun n => f n (b[n])

theorem BitVec.any_iff_exists {bv : BitVec w} :
    bv.any p ↔ ∃ (i : Fin w), p i (bv.getLsbD i) := by
  simp [any]

-- could this become a `where` clause in `determinize`?
def CNFA.determinize.inits (m : CNFA n) : Array (BitVec m.m.stateMax) :=
  #[BitVec.ofFn (fun n => n ∈ m.m.initials)]

def CNFA.determinize (m : CNFA n) : CNFA n :=
  worklistRun (BitVec m.m.stateMax)
    (fun ss => ss.any fun n b => b == true && n ∈ m.m.finals)
    (determinize.inits m)
    (by apply List.nodup_singleton)
    f
where
  f := fun (ss : BitVec m.m.stateMax) =>
        (FinEnum.toList (BitVec n)).foldl (init := Array.empty) fun ts a =>
          let ss' := m.m.transSetBV ss a
          ts.push (a, ss')

private def bv_to_set (bv : BitVec w) : Set State :=
  { s | bv.getLsbD s }

@[simp]
lemma bv_to_set_or {m : CNFA n} (x y : BitVec m.m.stateMax) :
    (s ∈ bv_to_set (x ||| y)) ↔ (s ∈ bv_to_set x ∨ s ∈ bv_to_set y) := by
  simp [bv_to_set]

@[simp]
lemma bv_to_set_shift (x s : Nat) :
    (s ∈ bv_to_set (1#w <<< x)) ↔ (s = x ∧ x < w) := by
  simp_all [bv_to_set]
  omega

lemma bv_to_set_ext : bv_to_set bv₁ = bv_to_set bv₂ ↔ bv₁ = bv₂ := by
  constructor
  · rintro heq; ext i hi
    rw [Set.ext_iff] at heq
    simp_all [bv_to_set]
    apply heq
  · tauto

@[simp]
lemma transBV_spec {m : CNFA n} {res} {s : m.m.states} :
    s' ∈ bv_to_set (m.m.transBV' res s a) ↔
      (s' ∈ bv_to_set res ∨ s' ∈ m.m.tr s a) := by
  let motive (bv : BitVec m.m.stateMax) (X : Set State) :=
    ∀ s' (hlt : s' < m.m.stateMax),
      s' ∈ bv_to_set bv ↔ (s' ∈ bv_to_set res ∨ s' ∈ X)
  suffices h : motive (m.m.transBV' res s a) (m.m.tr s a).toSet by
    by_cases hlt : s' < m.m.stateMax
    · simp_all [motive]
    · constructor
      · simp_all [bv_to_set]
      · rintro (h | h); simp_all [bv_to_set]
        apply m.wf.trans_tgt_lt' at h; simp_all only [RawCNFA.states, not_lt, Finset.mem_range]
        suffices _ : m.m.stateMax < m.m.stateMax by simp_all
        exact Nat.lt_of_le_of_lt hlt h
  apply Std.HashSet.fold_induction
  · simp [motive]
  rintro bv s S hnin ih s' hlt
  simp only [bv_to_set_or, bv_to_set_shift, Set.union_singleton, Set.mem_insert_iff]
  constructor
  · rintro (hold | ⟨rfl, hin⟩)
    · apply ih _ hlt |>.mp at hold; tauto
    · tauto
  · rintro (hold | rfl | hS)
    · left; apply (ih _ hlt).mpr; tauto
    · tauto
    · left; apply (ih _ hlt).mpr; tauto

@[simp]
lemma transSetBV_spec {m : CNFA n} {ss : BitVec m.m.stateMax} :
    s' ∈ bv_to_set (m.m.transSetBV ss a) ↔
      ∃ s ∈ bv_to_set ss, s' ∈ m.m.tr s a := by
  let motive (X : List (Fin m.m.stateMax)):= ∀ (res : BitVec m.m.stateMax) s',
    (s' ∈  bv_to_set (X.foldl (init := res) fun res n =>
            if ss.getLsbD n.val then m.m.transBV' res ⟨n.val, by simp [RawCNFA.states]⟩ a else res) ↔
      (s' ∈ bv_to_set res ∨ ∃ s ∈ bv_to_set ss, ∃ hlt, ⟨s, hlt⟩ ∈ X ∧ s' ∈ m.m.tr s a))
  suffices h : motive (List.finRange m.m.stateMax) by
    have h := h (BitVec.zero _) s'
    unfold RawCNFA.transSetBV
    rw [h]
    simp only [bv_to_set, BitVec.zero_eq, BitVec.getLsbD_zero, Bool.false_eq_true, Set.setOf_false,
      Set.mem_empty_iff_false, Set.mem_setOf_eq, List.length_finRange, false_or]
    constructor
    · rintro ⟨s', hin, _, _, htr⟩; use s', hin, htr
    · rintro ⟨s, hin, htr⟩
      have hlt : s ∈ m.m.states := by apply m.wf.trans_src_lt'' htr
      use s, hin, by simp [hlt], by simp, htr
  generalize List.finRange m.m.stateMax = states
  induction states
  case nil => simp [motive]
  case cons st states ih =>
    rintro res s'
    simp only [List.foldl_cons, List.length_cons, motive]
    rw [ih]
    constructor
    · rintro (hold | hnew)
      · split_ifs at hold with heq
        · simp at hold; rcases hold with hin | hin
          · simp [hin]
          · right; use st, heq, st.isLt, by simp
        · left; exact hold
      · right; simp only [List.mem_cons, exists_and_right]
        rcases hnew with ⟨s, hin, hlt, hsts, htr⟩
        use s, hin, ⟨hlt, by simp [hsts]⟩
    · simp only [List.mem_cons, exists_and_right, Fin.getElem_fin]
      rintro (hold | hnew)
      · left; split_ifs <;> simp_all
      · rcases hnew with ⟨s, hin, ⟨hlt, rfl, hsts⟩, hstr⟩
        · left; rw [hin]; simp [hstr]
        · right; use s, hin, ⟨hlt, by assumption⟩

lemma CNFA.determinize.f_spec {m : CNFA n} {a : BitVec n} {sa sa' : BitVec m.m.stateMax} :
    (a, sa') ∈ f m sa ↔ (∀ {s'}, s' ∈ bv_to_set sa' ↔ ∃ s ∈ bv_to_set sa, s' ∈ m.m.tr s a) := by
  suffices h : ∀ (acc : Array _) a sa',
      ((a, sa') ∈
        (FinEnum.toList (BitVec n)).foldl (init := acc) fun ts a =>
          let ss' := m.m.transSetBV sa a
          ts.push (a, ss')) ↔
        ((a, sa') ∈ acc ∨ a ∈ FinEnum.toList (BitVec n) ∧ ∀ {s'}, s' ∈ bv_to_set sa' ↔ ∃ s ∈ bv_to_set sa, s' ∈ m.m.tr s a) by
    specialize h Array.empty a sa'
    simp only [FinEnum.mem_toList, true_and] at h
    unfold f
    rw [h]
    simp only [or_iff_right_iff_imp]
    rintro h; exfalso; exact (Array.mem_empty_iff (a, sa')).mp h
  generalize FinEnum.toList (BitVec n) = as
  induction as
  case nil =>
    simp [List.foldl_nil, List.not_mem_nil, false_and, iff_false]
  case cons a as ih =>
    rintro acc b sa'
    simp
    rw [ih]
    simp only [Array.mem_push, Prod.mk.injEq]
    constructor
    · rintro (hin | hin)
      on_goal 2 => tauto
      rcases hin with hin | ⟨rfl, rfl⟩
      · simp [hin]
      right; simp
    · rintro (hacc | ⟨hb, hin⟩)
      · tauto
      rcases hb with rfl | hb
      · left; right; simp only [true_and]
        apply bv_to_set_ext.mp; ext s'; simp_all
      · right; tauto

def CNFA.determinize_spec (m : CNFA n)
  {M : NFA' n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  rcases hsim with ⟨Ri, hsim⟩
  apply bisim_comp
  · apply worklistRun_spec
  let R : Rel (BitVec m.m.stateMax) (Set M.σ) :=
    λ ss qs ↦ Ri.set_eq (bv_to_set ss) qs
  use R; constructor
  · simp [nfa', nfa, NFA'.determinize, NFA.toDFA, BitVec.any_iff_exists]
    rintro q₁ q₂ hR; constructor
    · rintro ⟨i, hi, ha⟩
      obtain ⟨s, hsq₂, hRi⟩ := hR.1 hi
      use s, hsq₂, hsim.accept hRi |>.mp ha
    · rintro ⟨s, hs, ha⟩
      obtain ⟨i, hlsb, hRi⟩ := hR.2 hs
      have hlt : i < m.m.stateMax :=
        BitVec.lt_of_getLsbD hlsb
      use ⟨i, hlt⟩, hlsb, hsim.accept hRi |>.mpr ha
  · have heq : R (BitVec.ofFn fun n_1 => decide (↑n_1 ∈ m.m.initials)) M.M.start := by
      constructor
      · rintro s hi
        obtain ⟨hlt, hinit⟩ := BitVec.ofFn_getLsbD_true.mp hi
        simp at hinit
        exact hsim.initial₁ hinit
      · rintro q hstart
        obtain ⟨s, hinit, hRi⟩ := hsim.initial₂ hstart
        simp [bv_to_set]
        have hlt : s ∈ m.m.states := by apply m.wf.initials_lt hinit
        simp [RawCNFA.states] at hlt
        use s, (by apply BitVec.ofFn_getLsbD_true.mpr; use hlt; simp [hinit])
    simp only [determinize.inits, nfa', nfa, NFA'.determinize, NFA.toDFA, Array.mem_toArray,
      List.mem_singleton, Set.setOf_eq_eq_singleton, beq_true, DFA.toNFA_start]
    constructor
    · rintro bv hin
      simp only [Set.mem_singleton_iff] at hin; subst hin
      use M.M.start; simp [heq]
    · simp [heq]
  · simp [nfa', nfa, NFA'.determinize, NFA.toDFA, determinize.f_spec]
    rintro q₁ q₂ a q₁' hR hq₁'; constructor
    · rintro s' hs'; obtain ⟨s, hs, htr⟩ := hq₁'.mp hs'
      obtain ⟨q, hq, hRi⟩ := hR.1 hs
      obtain ⟨q', hq', hRi'⟩ := hsim.trans_match₁ hRi htr
      simp_all only [NFA.mem_stepSet]; tauto
    · simp only [NFA.mem_stepSet]; rintro q' ⟨q, hq, hst⟩
      obtain ⟨s, hs, hRi⟩ := hR.2 hq
      obtain ⟨s', hs', hRi'⟩ := hsim.trans_match₂ hRi hst (by simp) (by simp)
      use s'; simp_all only [Set.top_eq_univ, and_true]; tauto
  · simp [nfa', nfa, NFA'.determinize, NFA.toDFA, determinize.f_spec]
    rintro q₁ q₂ a hR
    use m.m.transSetBV q₁ a
    constructor
    · intros s; rw [transSetBV_spec]
    constructor
    · intro s' h; obtain ⟨s, hs, htr⟩ := transSetBV_spec.mp h
      obtain ⟨q, hq, hRi⟩ := hR.1 hs
      obtain ⟨q', hst, hRi'⟩ := hsim.trans_match₁ hRi htr
      use q'; simp_all only [Set.top_eq_univ, and_true, NFA.mem_stepSet]; use q
    · simp [NFA.mem_stepSet]
      rintro q' q hq hst
      obtain ⟨s, hs, hRi⟩ := hR.2 hq
      obtain ⟨s', htr, hRi'⟩ := hsim.trans_match₂ hRi hst (by simp) (by simp)
      use s'; simp_all [transSetBV_spec]; tauto


def CNFA.neg (m : CNFA n) : CNFA n := m.determinize.flipFinals

def CNFA.neg_spec (m : CNFA n)  {M : NFA' n} (hsim : m.Sim M) :
    m.neg.Sim M.neg := by
  rw [NFA'.neg_eq, CNFA.neg]
  apply CNFA.flipFinals_spec
  apply determinize_spec m hsim

end determinization

section equality

-- variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

-- private structure isIncluded.State where
--   visited : List (_root_.State × Std.HashSet _root_.State) := ∅ -- TODO: slow
--   worklist : List (_root_.State × Std.HashSet _root_.State) := ∅

-- TODO: this function is not correct yet... it should be a more optimized
-- procedure to check that the languages of two automata are included.
/- Returns true when `L(m1) ⊆ L(m2)` -/
-- def RawCNFA.isIncluded (m1 m2 : RawCNFA A) : Bool :=
--   let st := { visited := [], worklist := m1.initials.fold (init := []) fun res s1 => (s1, m2.initials) :: res }
--   go st
-- where go (st : isIncluded.State) : Bool :=
--   if let some ((s1, ss1), worklist) := st.worklist.next? then
--     let st := { st with worklist }
--     if m1.initials.contains s1 ∧ ss1.isDisjoint m2.finals then
--       false
--     else
--       let st := { st with visited := (s1, ss1) :: st.visited }
--       let st := (FinEnum.toList (α := A)).foldl (init := st) fun st a =>
--         let ss2 := m2.transSet ss1 a
--         (m1.trans.getD (s1, a) ∅).fold (init := st) fun st s2 =>
--           if st.worklist.any (fun (s'', ss'') => s'' = s2 && HashSet.areIncluded ss'' ss2) ||
--             st.visited.any (fun (s'', ss'') => s'' = s2 && HashSet.areIncluded ss'' ss2) then
--             st
--           else
--             { st with worklist := (s2, ss2)::st.worklist }
--       go st
--   else
--     true
--   decreasing_by sorry

-- end equality

section emptiness

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def CNFA.isEmpty (m : CNFA n) : Bool := m.m.finals.isEmpty

theorem CNFA.isEmpty_spec {m : CNFA n} {M : NFA' n} :
    m.Sim M → m.isEmpty → M.accepts = ∅ := by
  rintro ⟨R, hsim⟩ hemp
  apply Set.eq_empty_of_forall_not_mem
  rintro w ⟨w', ⟨q, ha, he⟩, ww⟩
  obtain ⟨s, hR⟩ := hsim.rel_eval he
  obtain hfin := hsim.accept hR |>.mpr ha
  exact Std.HashSet.isEmpty_iff_forall_not_mem.mp hemp _ hfin

def CNFA.isUniversal (m : CNFA n) : Bool := m.neg.isEmpty

theorem CNFA.isUniversal_spec {m : CNFA n} {M : NFA' n} :
    m.Sim M → m.isUniversal → M.accepts = ⊤ := by
  rintro hsim huniv
  simp [isUniversal] at huniv
  have hsim' : m.neg.Sim M.neg := neg_spec m hsim
  have _ := isEmpty_spec hsim' huniv
  simp_all

/-- Recognizes the empty word -/
def RawCNFA.emptyWord : RawCNFA A :=
  let m := RawCNFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  m

def CNFA.emptyWord : CNFA n := ⟨RawCNFA.emptyWord, by simp_all [RawCNFA.emptyWord]; aesop⟩

/-- Returns true when `L(m) ∪ {ε} = A*`. This is useful because the
    bitvector of with width zero has strange properties.
 -/
def CNFA.isUniversal' (m : CNFA n) : Bool :=
  m.union CNFA.emptyWord |> CNFA.isUniversal

-- TODO: this relies on the fact that all states are reachable!
-- should derive from the fact that all states of M are reachable.
def RawCNFA.isNotEmpty (m : RawCNFA A) : Bool := !m.finals.isEmpty

end emptiness

section lift_proj

variable {n : Nat}

-- Morally, n2 >= n1

@[inline]
def RawCNFA.lift (m₁: RawCNFA (BitVec n1)) (f : Fin n1 → Fin n2) : RawCNFA (BitVec n2) :=
  let trans := (List.range m₁.stateMax).foldl (init := Std.HashMap.empty) fun m2 s => processState m2 s
  { m₁ with trans }
where
  @[inline]
  processState trans s :=
    (FinEnum.toList (BitVec n2)).foldl (init := trans) fun trans (bv : BitVec n2) =>
      processTrans trans s bv
  @[inline]
  processTrans trans s bv :=
      let newtrans := m₁.tr s (bv.transport f)
      let oldtrans := trans.getD (s, bv) ∅
      let tr := newtrans.union oldtrans
      if tr.isEmpty then trans else trans.insert (s, bv) tr

lemma RawCNFA.lift_wf (m : RawCNFA (BitVec n₁)) {f : Fin n₁ → Fin n₂} (hwf : m.WF) :
    m.lift f |>.WF := by
  have hss : (m.lift f).states = m.states := rfl
  constructor <;> simp_all [hss, lift]
  · let motive (X : Std.HashMap (State × BitVec n₂) (Std.HashSet State)) := ∀ s a, (s, a) ∈ X → s ∈ m.states
    suffices h : motive (List.foldl (fun m2 s => lift.processState m f m2 s) Std.HashMap.empty (List.range m.stateMax)) by
      exact h
    apply List.foldlRecOn
    · simp [motive]
    rintro trans ih s hs; simp_all [motive]
    suffices h : motive (lift.processState m f trans s) by exact h
    apply List.foldlRecOn
    · exact ih
    rintro trans' ih' a ha; simp [motive, lift.processTrans] at ih' ⊢
    rintro s₀ a₀; split_ifs
    · apply ih'
    simp only [Std.HashMap.mem_insert, beq_iff_eq, Prod.mk.injEq]
    rintro (⟨rfl, rfl⟩ | hin)
    · simp_all [states]
    · apply ih'; assumption
  · let motive (X : Std.HashMap (State × BitVec n₂) (Std.HashSet State)) :=
      ∀ (s : State) (a : BitVec n₂) (ss' : Std.HashSet State) s',
        X[(s, a)]? = some ss' → s' ∈ ss' → s' ∈ m.states
    suffices h : motive (List.foldl (fun m2 s => lift.processState m f m2 s) Std.HashMap.empty (List.range m.stateMax)) by
      exact h
    apply List.foldlRecOn
    · simp [motive]
    rintro trans ih s hs; simp_all [motive]
    suffices h : motive (lift.processState m f trans s) by exact h
    apply List.foldlRecOn
    · exact ih
    rintro trans' ih' a ha; simp_all [motive, lift.processTrans]
    rintro s₀ a₀ ss' s' heq hin; split_ifs at heq
    · apply ih' _ _ _ _ heq hin
    by_cases heq? : (s, a) = (s₀, a₀)
    · rcases heq? with ⟨rfl, rfl⟩
      simp at heq; subst heq; simp_all
      rcases hin with hin | hin
      · exact hwf.trans_tgt_lt' _ _ _ hin
      · rcases htr : trans'[(s, a)]? with _ | ss'
        · rw [Std.HashMap.getD_eq_getD_getElem?, htr] at hin; simp at hin
        · rw [Std.HashMap.getD_eq_getD_getElem?, htr] at hin; apply ih' s a ss' _ htr hin
    · simp only [Std.HashMap.getElem?_insert, beq_iff_eq, Prod.mk.injEq] at heq
      rw [ite_cond_eq_false] at heq
      on_goal 2 => simp_all
      exact ih' _ _ _ _ heq hin

@[inline]
def CNFA.lift (m: CNFA n1) (f : Fin n1 → Fin n2) : CNFA n2 :=
  ⟨m.m.lift f, m.m.lift_wf m.wf⟩

@[simp]
lemma RawCNFA.lift_processTrans_spec {m : CNFA n₁} {f : Fin n₁ → Fin n₂} :
    s' ∈ (lift.processTrans m.m f trs s₀ a).getD (s, b) ∅ ↔
      s' ∈ trs.getD (s, b) ∅ ∨ s = s₀ ∧ a = b ∧ s' ∈ m.m.tr s (b.transport f) := by
  simp only [lift.processTrans, Std.HashSet.isEmpty_union_iff_isEmpty]
  split_ifs with hcond
  · constructor
    · rintro h; exact .inl h
    rintro (h | ⟨rfl, rfl, h⟩)
    · exact h
    exfalso
    exact Std.HashSet.not_mem_of_isEmpty hcond.1 h
  · rw [Std.HashMap.getD_insert]
    split_ifs with hcond
    · simp at hcond; rcases hcond with ⟨rfl, rfl⟩; clear hcond
      simp only [Std.HashSet.mem_union, true_and]
      tauto
    · constructor
      · tauto
      rintro (h | ⟨rfl, rfl, h⟩)
      · assumption
      · simp at hcond

@[simp]
lemma RawCNFA.lift_processState_spec {m : CNFA n₁} {f : Fin n₁ → Fin n₂} :
    s' ∈ (lift.processState m.m f trs s₀).getD (s, b) ∅ ↔
      s' ∈ trs.getD (s, b) ∅ ∨ s = s₀ ∧ s' ∈ m.m.tr s (b.transport f) := by
  let motive (as : List (BitVec n₂)) := ∀ trs s',
    s' ∈ (as.foldl (init := trs) fun trans (bv : BitVec n₂) =>
            lift.processTrans m.m f trans s₀ bv).getD (s, b) ∅ ↔
      s' ∈ trs.getD (s, b) ∅ ∨ s = s₀ ∧ b ∈ as ∧ s' ∈ m.m.tr s (b.transport f)
  suffices h : motive (FinEnum.toList (BitVec n₂)) by
    simp only [FinEnum.mem_toList, true_and, motive] at h
    simp [←h, lift.processState]
  generalize (FinEnum.toList (BitVec n₂)) = as
  induction as
  case nil =>  simp [motive]
  case cons a as ih =>
    simp [motive]
    rintro trs s'
    rw [ih]; simp only [lift_processTrans_spec]
    aesop

@[simp]
def CNFA.lift_tr (m : CNFA n₁) (f : Fin n₁ → Fin n₂) :
    s' ∈ (m.lift f).m.tr s a ↔ s' ∈ m.m.tr s (a.transport f) := by
  simp only [RawCNFA.tr, lift, RawCNFA.lift]
  let motive as := ∀ s' trans s a,
    s' ∈ (List.foldl (fun m2 s =>
      RawCNFA.lift.processState m.m f m2 s) trans as).getD (s, a) ∅ ↔
    s' ∈ trans.getD (s, a) ∅ ∨ s ∈ as ∧ s' ∈ m.m.trans.getD (s, BitVec.transport f a) ∅
  suffices h : motive (List.range m.m.stateMax) by
    simp [motive] at h
    rw [h]
    simp only [Std.HashMap.getD_empty, Std.HashSet.not_mem_emptyc, false_or, and_iff_right_iff_imp]
    rintro hin
    have h := m.wf.trans_src_lt'' hin
    simp [RawCNFA.states] at h; exact h
  generalize List.range m.m.stateMax = states
  induction states
  case nil => simp [motive]
  case cons st states ih =>
    simp only [List.foldl_cons, List.mem_cons, motive]
    rintro s' trans s a
    rw [ih]; simp only [RawCNFA.lift_processState_spec]
    aesop

def CNFA.lift_spec (m : CNFA n1) (f : Fin n1 → Fin n2) {M : NFA' n1} :
    m.Sim M → (m.lift f |>.Sim (M.lift f)) := by
  rintro ⟨R, hsim⟩; use R; constructor
  · exact hsim.accept
  · exact hsim.initial₁
  · exact hsim.initial₂
  · rintro s s' a q hR htr
    simp at htr
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₁ hR htr
    simp [NFA'.lift]; use q', hst, hR'
  · rintro s s' a q hR htr
    simp at htr
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₂ hR htr (by simp) (by simp)
    simp [NFA'.proj]; use q', hst, hR'

-- Morally, n1 >= n2
@[inline]
def RawCNFA.proj (m1: RawCNFA (BitVec n1)) (f : Fin n2 → Fin n1) : RawCNFA (BitVec n2) :=
  let trans := m1.trans.keysArray.foldl (init := Std.HashMap.empty) process
  { m1 with trans }
where
  @[inline]
  process trans := fun (s, bv) =>
    let tr := m1.tr s bv
    let bv' := bv.transport f
    let oldtrans := trans.getD (s, bv') ∅
    trans.insert (s, bv') (tr.union oldtrans)

lemma RawCNFA.proj_wf (m : RawCNFA (BitVec n₁)) {f : Fin n₂ → Fin n₁} (hwf : m.WF) :
    m.proj f |>.WF := by
  have hss : (m.proj f).states = m.states := rfl
  constructor <;> simp_all [hss, proj]
  · let motive (_ : Nat) (X : Std.HashMap (State × BitVec n₂) (Std.HashSet State)) := ∀ s a, (s, a) ∈ X → s ∈ m.states
    suffices h : motive (m.trans.keysArray.size) (m.proj f).trans by
      exact h
    simp only [proj]; apply Array.foldl_induction
    · simp [motive]
    rintro i trans ih s hs; simp_all [motive, proj.process]
    rintro (⟨rfl, rfl⟩ | hin)
    · have : m.trans.keysArray[i.val] ∈ m.trans := by
        rw [←Std.HashMap.mem_keysArray]; simp
      apply hwf.trans_src_lt' this
    · apply ih; assumption
  · let motive (_ : Nat) (X : Std.HashMap (State × BitVec n₂) (Std.HashSet State)) :=
      ∀ (s : State) (a : BitVec n₂) (ss' : Std.HashSet State) s',
        X[(s, a)]? = some ss' → s' ∈ ss' → s' ∈ m.states
    suffices h : motive (m.trans.keysArray.size) (m.proj f).trans by
      exact h
    simp only [proj]; apply Array.foldl_induction
    · simp [motive]
    rintro i trans ih s₀ a₀ ss' s' heq hin
    simp only [proj.process, Std.HashMap.getElem?_insert, beq_iff_eq, Prod.mk.injEq] at heq
    split_ifs at heq with h
    on_goal 2 => tauto
    · rcases h with ⟨rfl, rfl⟩
      simp at heq; subst heq; simp at hin
      rcases hin with hin | hin
      · exact WF.trans_tgt_lt' hwf _ _ _ hin
      · rw [Std.HashMap.getD_eq_getD_getElem?] at hin
        rcases htr : trans[(m.trans.keysArray[i.val].1, BitVec.transport f m.trans.keysArray[i.val].2)]? with _ | ss'
        · rw [htr] at hin; simp at hin
        · rw [htr] at hin; apply ih _ _ _ _ htr hin

@[inline]
def CNFA.proj (m: CNFA n2) (f : Fin n1 → Fin n2) : CNFA n1 :=
  ⟨m.m.proj f, m.m.proj_wf m.wf⟩

@[simp]
def CNFA.proj_tr (m : CNFA n₂) (f : Fin n₁ → Fin n₂) :
    s' ∈ (m.proj f).m.tr s a ↔ (∃ a', a'.transport f = a ∧ s' ∈ m.m.tr s a') := by
  simp [proj, RawCNFA.proj, RawCNFA.tr]
  let motive (k : Nat) (trans : Std.HashMap (State × BitVec n₁) (Std.HashSet State)) := ∀ s' a,
    s' ∈ trans.getD (s, a) ∅ ↔
      (∃ a', (s, a') ∈ m.m.trans.keysArray.take k ∧ a'.transport f = a ∧ s' ∈ m.m.tr s a')
  suffices h : motive (m.m.trans.keysArray.size) (m.proj f).m.trans by
    simp_all [motive, proj, RawCNFA.proj]; constructor
    · tauto
    · rintro ⟨a', rfl, htr⟩
      have hin : (s, a') ∈ m.m.trans := by
        rw [Std.HashMap.getD_eq_getD_getElem?] at htr
        rcases heq : m.m.trans[(s, a')]? with _ | ss'
        · simp [heq] at htr
        · exact Std.HashMap.mem_of_getElem? heq
      use a', hin, rfl, htr
  apply Array.foldl_induction
  · simp [motive]
  rintro i trans ih; simp [motive, RawCNFA.proj.process] at ih ⊢
  let t := m.m.trans.keysArray[i.val]
  rintro s' a
  rw [Std.HashMap.getD_insert]
  split_ifs with hcond
  · simp at hcond; rcases hcond with ⟨rfl, rfl⟩; simp [ih]
    constructor
    · rintro (hin | ⟨a', hin, heq, hin'⟩)
      · use t.2
        simp +zetaDelta only [Prod.mk.eta, Array.mem_iff_getElem, Array.getElem_extract, zero_add,
          Array.size_extract, tsub_zero, lt_inf_iff, hin, and_self, and_true]
        use i.val, by simp +zetaDelta
      · use a'; simp [heq, hin']
        simp only [Array.mem_iff_getElem, Array.getElem_extract, zero_add, Array.size_extract,
          Fin.is_le', inf_of_le_left, tsub_zero, lt_inf_iff] at hin ⊢
        rcases hin with ⟨j, hj, heq⟩; use j, by omega
    · rintro ⟨a', hin, heq, hin'⟩
      by_cases heq? : a' = t.2
      · subst heq?; tauto
      simp [Array.mem_iff_getElem] at hin ⊢
      rcases hin with ⟨j, hj, heq⟩
      have hneq : j ≠ i := by
        rintro rfl; apply heq?; apply_fun Prod.snd at heq; exact heq.symm
      right; use a'; simp_all only [←heq, ne_eq, and_self, and_true]
      use j, by omega
  · simp only [ih, Array.mem_iff_getElem, Array.getElem_extract, zero_add, Array.size_extract,
    Fin.is_le', inf_of_le_left, tsub_zero, lt_inf_iff, motive]
    constructor
    · rintro ⟨a', ⟨j, _, _⟩, htp, hin⟩; use a', ⟨j, by use by omega⟩
    · rintro ⟨a', ⟨j, _, heq⟩, htp, hin⟩
      have _ : j ≠ i := by
        rintro rfl; simp [←htp, heq] at hcond
      use a', ⟨j, by use by omega⟩

def CNFA.proj_spec (m : CNFA n2) (f : Fin n1 → Fin n2) {M : NFA' n2} :
    m.Sim M → (m.proj f |>.Sim (M.proj f)) := by
  rintro ⟨R, hsim⟩; use R; constructor
  · exact hsim.accept
  · exact hsim.initial₁
  · exact hsim.initial₂
  · rintro s s' a q hR htr
    simp at htr; rcases htr with ⟨a', rfl, htr⟩
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₁ hR htr
    simp [NFA'.proj]; use q', ⟨a', rfl, hst⟩, hR'
  · rintro s s' a q hR htr
    simp at htr; rcases htr with ⟨a', rfl, htr⟩
    obtain ⟨q', hst, hR'⟩ := hsim.trans_match₂ hR htr (by simp) (by simp)
    simp [NFA'.proj]; use q', ⟨a', rfl, hst⟩, hR'

end lift_proj
