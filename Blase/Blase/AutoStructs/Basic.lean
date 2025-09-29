/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Mathlib.Algebra.Group.Nat.Range
import Blase.AutoStructs.BundledNfa
import Blase.FinEnum

open Rel

abbrev State := Nat

-- where to add the wellformedness conditions? a typeclass?
/--
The definition of a computational automaton. It is meant to be more efficient
than the definition in Mathlib.
 -/
structure RawCNFA (A : Type 0) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A] where
  stateMax : State
  initials : Std.HashSet State
  finals : Std.HashSet State
  trans : Std.HashMap (State × A) (Std.HashSet State)
deriving Repr

section sim

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

@[inline]
def RawCNFA.tr (m : RawCNFA A) s a := m.trans.getD (s, a) ∅

def RawCNFA.states (m : RawCNFA A) : Finset State := Finset.range m.stateMax

instance RawCNFA.statesFinset (m : RawCNFA A) : Fintype m.states := (Finset.range m.stateMax).fintypeCoeSort

@[grind, simp]
lemma RawCNFA.stateMax_nin_states (m : RawCNFA A) : ¬(m.stateMax ∈ m.states) := by
  simp [states]

@[grind, simp]
lemma RawCNFA.states_lt (m : RawCNFA A) s : s ∈ m.states → s < m.stateMax := by
  simp [RawCNFA.states]

/--
A simulation between a concrete NFA and an abstract NFA consists in a relation
between concrete and abstract states which satisfies some properties, as defined
in Kozen 1997.
-/
structure RawCNFA.Simul (m : RawCNFA A) (M : NFA A Q) (R : Rel State Q) (D : Set Q) (T : Set (Q × A × Q)) where
  accept {s q} : s ~[R] q → (s ∈ m.finals ↔ q ∈ M.accept)
  initial₁ {s} : s ∈ m.initials → ∃ q ∈ M.start, s ~[R] q
  initial₂ {q} : q ∈ M.start → ∃ s ∈ m.initials, s ~[R] q
  trans_match₁ {s s' a q} : s ~[R] q → s' ∈ m.tr s a → ∃ q', q' ∈ M.step q a ∧ s' ~[R] q'
  trans_match₂ {s a q q'} : s ~[R] q → q' ∈ M.step q a → q ∈ D → (q, a, q') ∉ T → ∃ s', s' ∈ m.tr s a ∧ s' ~[R] q'

@[simp]
lemma RawCNFA.Simul.initial {m : RawCNFA A} {M : NFA A Q} (hsim : m.Simul M R ⊤ ∅) :
    R.set_eq m.initials.toSet M.start := by
  constructor
  · rintro s h; exact hsim.initial₁ h
  · rintro q h; exact hsim.initial₂ h

lemma RawCNFA.Simul.rel_preserved_letter {m : RawCNFA A} {M : NFA A Q} (hsim : m.Simul M R ⊤ ∅) :
    R.set_eq S₁ Q₁ → ∃ S₂, R.set_eq S₂ (M.stepSet Q₁ a) := by
  rintro hR
  use {s' | ∃ s ∈ S₁, s' ∈ m.tr s a }
  constructor
  · rintro s' ⟨s, hs, htr⟩
    obtain ⟨q₁, hq₁, hR₁⟩ := hR.1 hs
    obtain ⟨q₂, hst, hR₂⟩ := hsim.trans_match₁ hR₁ htr
    use q₂
    simp_all only [Set.top_eq_univ, NFA.stepSet, Set.mem_iUnion, exists_prop, and_true]
    use q₁, hq₁
  · rintro q₂ ⟨Q₂, ⟨q₁, rfl⟩, Q, ⟨hq₁, rfl⟩, hst⟩
    obtain ⟨s₁, hs₁, hR₁⟩ := hR.2 hq₁
    obtain ⟨s₂, htr, hR₂⟩ := hsim.trans_match₂ hR₁ hst (by simp) (by simp)
    use s₂, ⟨s₁, by tauto⟩

lemma RawCNFA.Simul.rel_preserved_word {m : RawCNFA A} {M : NFA A Q} (hsim : m.Simul M R ⊤ ∅) :
    R.set_eq S₁ Q₁ → ∃ S₂, R.set_eq S₂ (M.evalFrom Q₁ w) := by
  induction w using List.reverseRecOn
  case nil => rintro h; use S₁; simp [h]
  case append_singleton w a ih =>
    rintro h; obtain ⟨S₂, hR⟩ := ih h; clear ih
    simp only [NFA.evalFrom_append_singleton]
    exact hsim.rel_preserved_letter hR

lemma RawCNFA.Simul.eval_set_eq {m : RawCNFA A} {M : NFA A Q} (hsim : m.Simul M R ⊤ ∅) :
    ∃ S, R.set_eq S (M.eval w) :=
  hsim.rel_preserved_word (hsim.initial)

lemma RawCNFA.Simul.rel_eval {m : RawCNFA A} {M : NFA A Q} (hsim : m.Simul M R ⊤ ∅) :
    q ∈ M.eval w → ∃ s, s ~[R] q := by
  rintro h
  obtain ⟨S, heq⟩ := hsim.eval_set_eq
  obtain ⟨s, hs, hR⟩ := heq.2 h
  exact ⟨s, hR⟩

/--
Similarity is the greatest simulation
-/
def RawCNFA.Sim (m : RawCNFA A) (A : NFA A S) := ∃ R, RawCNFA.Simul m A R ⊤ ∅

lemma sim_full_cod (m : RawCNFA A) (M : NFA A Q) (D : Set Q) (T : Set (Q × A × Q)) R :
    T = ∅ →
    m.Simul M R D T →
    R.cod = D →
    m.Sim M := by
  rintro rfl ⟨_, _, _, _, h⟩ hcod; use R
  constructor <;> try assumption
  rintro s a q q' hR hst hD _
  apply h <;> try assumption
  rw [←hcod]; use s

lemma bisimul_comp {m : RawCNFA A} :
    m.Simul M₁ R₁ ⊤ ∅ → M₁.Bisimul R₂ M₂ →
    m.Simul M₂ (R₁.comp R₂) ⊤ ∅ := by
  rintro h₁ h₂; constructor
  · rintro s q₁ ⟨q₂, hR₁, hR₂⟩; rw [h₁.accept hR₁, h₂.accept hR₂]
  · rintro s hs
    obtain ⟨q₁, hi₁, hq₁⟩ := h₁.initial₁ hs
    obtain⟨q₂, hi₂, hq₂⟩ := h₂.start.1 hi₁
    use q₂, hi₂, q₁
  · rintro q₂ hi₂
    obtain⟨q₁, hi₁, hq₂⟩ := h₂.start.2 hi₂
    obtain ⟨s, hsi, hs⟩ := h₁.initial₂ hi₁
    use s, hsi, q₁
  · rintro s s' a q₂ ⟨q₁, hR₁, hR₂⟩ htr
    obtain ⟨q₁', hst, hq₁'⟩ := h₁.trans_match₁ hR₁ htr
    obtain ⟨q₂', hst', hq₂'⟩ := h₂.trans_match₁ hR₂ hst
    use q₂', hst', q₁', hq₁', hq₂'
  · rintro s a q₂ q₂' ⟨q₁, hR₁, hR₂⟩ hst - -
    obtain ⟨q₁', hst', hR₂'⟩:= h₂.trans_match₂ hR₂ hst
    obtain ⟨s', htr, hR₁'⟩ := h₁.trans_match₂ hR₁ hst' (by simp) (by simp)
    use s', htr, q₁'

lemma bisim_comp (m : RawCNFA A) :
    m.Sim M₁ → M₁.Bisim M₂ → m.Sim M₂ := by
  rintro ⟨R₁, h₁⟩ ⟨R₂, h₂⟩
  exact ⟨_, bisimul_comp h₁ h₂⟩

end sim

section basics

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def RawCNFA.empty : RawCNFA A := {
  stateMax := 0
  initials := ∅
  finals := ∅
  trans := ∅
}

@[grind, simp] lemma RawCNFA.empty_mem_initials {s : State} : s ∉ empty (A := A).initials := by simp [empty]
@[grind, simp] lemma RawCNFA.empty_mem_finals {s : State} : s ∉ empty (A := A).finals := by simp [empty]
@[grind, simp] lemma RawCNFA.empty_mem_tr {s s' : State} : s' ∉ empty (A := A).tr s a := by simp [empty, tr]
@[grind =, simp] lemma RawCNFA.empty_trans : empty (A := A).trans = ∅ := by rfl
@[grind =, simp] lemma RawCNFA.empty_states : empty (A := A).states = ∅ := by rfl
@[grind =, simp] lemma RawCNFA.empty_tr {s : State} : empty (A := A).tr s a = ∅ := by simp [empty, tr]

def RawCNFA.newState (m : RawCNFA A) : State × RawCNFA A :=
  let old := m.stateMax
  let m := { m with stateMax := old + 1 }
  (old, m)

def RawCNFA.addTrans (m : RawCNFA A) (a : A) (s s' : State) : RawCNFA A :=
  let ns := m.trans.getD (s, a) ∅
  let ns := ns.insert s'
  { m with trans :=  m.trans.insert (s, a) ns }


def RawCNFA.addManyTrans (m : RawCNFA A) (a : List A) (s s' : State) : RawCNFA A :=
  a.foldl (init := m) fun m a => m.addTrans a s s'

@[grind, simp]
lemma RawCNFA.addManyTrans_nil (m : RawCNFA A) {s s' : State} :
    m.addManyTrans [] s s' = m :=
  rfl

@[grind =, simp]
lemma RawCNFA.addManyTrans_cons (m : RawCNFA A) {s s' : State} :
    m.addManyTrans (a::as) s s' = (m.addTrans a s s').addManyTrans as s s' :=
  rfl

def RawCNFA.addInitial (m : RawCNFA A) (s : State) : RawCNFA A :=
  { m with initials := m.initials.insert s }

@[grind =, simp]
lemma RawCNFA.addInitial_initials {m : RawCNFA A} : (m.addInitial s).initials = m.initials.insert s := by
  rfl

@[grind =, simp]
lemma RawCNFA.addInitial_finals {m : RawCNFA A} : (m.addInitial s).finals = m.finals := by
  rfl

@[grind =, simp]
lemma RawCNFA.addInitial_tr {m : RawCNFA A} : (m.addInitial s'').tr s a = m.tr s a := by
  rfl

def RawCNFA.addFinal (m : RawCNFA A) (s : State) : RawCNFA A :=
  { m with finals := m.finals.insert s }

@[grind =, simp]
lemma RawCNFA.addFinal_initials {m : RawCNFA A} : (m.addFinal s).initials = m.initials := by
  rfl

@[grind =, simp]
lemma RawCNFA.addFinal_finals {m : RawCNFA A} : (m.addFinal s).finals = m.finals.insert s := by
  rfl

@[grind =, simp]
lemma RawCNFA.addFinal_tr {m : RawCNFA A} : (m.addFinal s').tr s a = m.tr s a := by
  rfl

def RawCNFA.createSink (m : RawCNFA A) : State × RawCNFA A :=
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := FinEnum.toList (α := A).foldl (init := m) fun m a =>
    m.addTrans a s s
  (s, m)

def RawCNFA.transSet (m : RawCNFA A) (ss : Std.HashSet State) (a : A) : Std.HashSet State :=
  ss.fold (init := ∅) fun ss' s =>
    ss'.insertMany $ m.trans.getD (s, a) ∅

def RawCNFA.transBV (m : RawCNFA A) (s : m.states) (a : A) : BitVec m.stateMax :=
  let ts := m.trans.getD (s, a) ∅
  BitVec.ofFn (fun n => n ∈ ts)

def RawCNFA.transBV' (m : RawCNFA A) (res : BitVec m.stateMax) (s : m.states) (a : A) : BitVec m.stateMax :=
  let ts := m.tr s a
  ts.fold (init := res) fun res s => res ||| 1#m.stateMax <<< s

-- def RawCNFA.transSetBV (m : RawCNFA A) (ss : BitVec m.stateMax) (a : A) : BitVec m.stateMax :=
--   (List.finRange m.stateMax).foldl (init := BitVec.zero m.stateMax) fun res n =>
--     if ss[n] then res ||| m.transBV ⟨n.val, by simp [RawCNFA.states]⟩ a else res
def RawCNFA.transSetBV (m : RawCNFA A) (ss : BitVec m.stateMax) (a : A) : BitVec m.stateMax :=
  (List.finRange m.stateMax).foldl (init := BitVec.zero m.stateMax) fun res n =>
    if ss.getLsbD n.val then m.transBV' res ⟨n.val, by simp [RawCNFA.states]⟩ a else res

@[grind =, simp, aesop 50% unsafe]
lemma states_addInitial (m : RawCNFA A) (s' : State) :
    (m.addInitial s').states = m.states := by
  simp_all [RawCNFA.addInitial, RawCNFA.states]

@[grind =, simp, aesop 50% unsafe]
lemma states_addFinal (m : RawCNFA A) (s' : State) :
    (m.addFinal s').states = m.states := by
  simp_all [RawCNFA.addFinal, RawCNFA.states]

@[grind =, simp, aesop 50% unsafe]
lemma states_addTrans (m : RawCNFA A) (a : A) (s1 s2 : State) :
    (m.addTrans a s1 s2).states = m.states := by
  rfl

@[grind =, simp, aesop 50% unsafe]
lemma states_addManyTrans (m : RawCNFA A) (as : List A) (s1 s2 : State) :
    (m.addManyTrans as s1 s2).states = m.states := by
  simp [RawCNFA.addManyTrans]
  let motive (m' : RawCNFA A) := m'.states = m.states
  suffices h : motive (m.addManyTrans as s1 s2) by exact h
  apply List.foldlRecOn <;> simp_all [motive]

@[grind =, simp, aesop 50% unsafe]
lemma addTrans_initials (m : RawCNFA A) (a : A) (s1 s2 : State) :
    (m.addTrans a s1 s2).initials = m.initials := by
  rfl

@[grind =, simp, aesop 50% unsafe]
lemma addTrans_finals (m : RawCNFA A) (a : A) (s1 s2 : State) :
    (m.addTrans a s1 s2).finals = m.finals := by
  rfl

@[grind =, simp]
lemma addTrans_tr_eq (m : RawCNFA A) [LawfulBEq A] (a : A) (s₁ s₂ : State) :
    (m.addTrans a s₁ s₂).tr s₁ a = (m.tr s₁ a).insert s₂ := by
  simp [RawCNFA.addTrans, RawCNFA.tr]

@[grind =, simp]
lemma addTrans_tr_neq (m : RawCNFA A) [LawfulBEq A] {a : A} {s₁ s₁' s₂ : State} (hneq : s₁ ≠ s₁') :
    (m.addTrans a s₁ s₂).tr s₁' a = m.tr s₁' a := by
  grind [RawCNFA.addTrans, RawCNFA.tr, Std.HashMap.getD_insert]

@[grind =] -- TODO: should I?
lemma addTrans_tr (m : RawCNFA A) [LawfulBEq A] {a b : A} {s₁ s₁' s₂ : State} :
    (m.addTrans a s₁ s₂).tr s₁' b = if s₁ = s₁' ∧ a = b then (m.tr s₁ a).insert s₂ else m.tr s₁' b := by
  grind [RawCNFA.addTrans, RawCNFA.tr, Std.HashMap.getD_insert]

@[grind, simp]
lemma mem_addTrans_tr (m : RawCNFA A) [LawfulBEq A] (a : A) (s1 s2 : State) :
    s' ∈ (m.addTrans a s1 s2).tr s b ↔
      (s = s1 ∧ s' = s2 ∧ b = a) ∨ s' ∈ m.tr s b := by
  simp [addTrans_tr]
  split_ifs with hcond
  · rcases hcond with ⟨rfl, rfl⟩
    simp_all only [Std.HashSet.mem_insert, beq_iff_eq, and_true, true_and]; grind
  · grind

@[grind, simp, aesop 50% unsafe]
lemma mem_states_newState (m : RawCNFA A) (s : State) (hin : s ∈ m.states) :
    s ∈ m.newState.2.states := by
  simp_all [RawCNFA.newState, RawCNFA.states]; omega

@[grind =, simp]
lemma newState_tr {m : RawCNFA A} : m.newState.2.tr s a = m.tr s a := by rfl

@[grind =, simp, aesop 50% unsafe]
lemma states_empty :
    RawCNFA.empty (A := A).states = ∅ := by
  simp_all [RawCNFA.empty, RawCNFA.states]

@[grind =, simp, aesop 50% unsafe]
lemma states_newState (m : RawCNFA A) :
    m.newState.2.states = m.states ∪ { m.stateMax } := by
  simp_all [RawCNFA.newState, RawCNFA.states, Finset.range_add]

@[grind =, simp, aesop 50% unsafe]
lemma newState_initials (m : RawCNFA A) :
    m.newState.2.initials = m.initials := by
  rfl

@[grind =, simp, aesop 50% unsafe]
lemma newState_finals (m : RawCNFA A) :
    m.newState.2.finals = m.finals := by
  rfl

@[grind =, simp, aesop 50% unsafe]
lemma newState_eq (m : RawCNFA A) :
    m.newState.1 = m.stateMax := by
  simp_all [RawCNFA.newState]

@[grind, simp, aesop 50% unsafe]
lemma mem_states_newState_self (m : RawCNFA A) :
    m.newState.1 ∈ m.newState.2.states := by
  simp_all [RawCNFA.newState, RawCNFA.states]

@[grind =, simp]
lemma addTrans_stateMax {m : RawCNFA A} : (m.addTrans a s s').stateMax = m.stateMax := rfl
@[grind =, simp]
lemma addFinal_stateMax {m : RawCNFA A} : (m.addFinal s).stateMax = m.stateMax := rfl
@[grind =, simp]
lemma addInitial_stateMax {m : RawCNFA A} : (m.addInitial s).stateMax = m.stateMax := rfl

/--
An automaton is well-formed if all the states it mentions are valid, in that they are `< stateMax`.
-/
structure RawCNFA.WF (m : RawCNFA A) where
  initials_lt : ∀ {s}, s ∈ m.initials → s ∈ m.states
  finals_lt : ∀ {s}, s ∈ m.finals → s ∈ m.states
  trans_src_lt : ∀ s_a ∈ m.trans, s_a.1 ∈ m.states
  trans_tgt_lt : s' ∈ m.tr s a → s' ∈ m.states

structure CNFA (n : Nat) where
  m : RawCNFA (BitVec n)
  wf : m.WF

attribute [simp] CNFA.wf

def CNFA.Sim (m : CNFA n) (M : NFA' n) :=
  m.m.Sim M.M

attribute [grind, simp] RawCNFA.WF.initials_lt RawCNFA.WF.trans_src_lt RawCNFA.WF.trans_tgt_lt RawCNFA.WF.finals_lt
attribute [grind, aesop 50% unsafe] RawCNFA.WF.initials_lt RawCNFA.WF.trans_src_lt RawCNFA.WF.trans_tgt_lt RawCNFA.WF.finals_lt

@[grind, simp, aesop 50% unsafe]
lemma RawCNFA.WF.trans_src_lt' {m : RawCNFA A} (hwf : m.WF) :
    ∀ {s a}, (s, a) ∈ m.trans → s ∈ m.states := by
  intros s a hin; simp [hwf.trans_src_lt _ hin]

-- Until we change the internal repr /
lemma RawCNFA.WF.trans_tgt_lt_equiv_internal {m : RawCNFA A} [LawfulBEq A] :
    (∀ s a s', s' ∈ m.tr s a → s' ∈ m.states) ↔
    (∀ (s_a : State × A) (ss' s'), m.trans[s_a]? = some ss' → s' ∈ ss' → s' ∈ m.states) := by
  simp only [RawCNFA.tr]
  simp only [Std.HashMap.getD_eq_getD_getElem?]
  constructor
  · rintro h ⟨s₁, a⟩ ss' s₂ htr hin
    rcases htrans : m.trans[(s₁, a)]? with ⟨⟩ | ⟨ts⟩
    · simp_all
    · simp_all only [Option.some.injEq]
      subst htr
      apply h s₁ a
      simp [htrans, hin]
  · rintro h s₁ a s₂ htr
    rcases htrans : m.trans[(s₁, a)]? with ⟨⟩ | ⟨ts⟩
    · simp_all
    · apply h (s₁, a) _ _ htrans
      simpa [htrans] using htr

lemma RawCNFA.WF.trans_tgt_lt_internal {m : RawCNFA A} (hwf : m.WF) [LawfulBEq A] :
   ∀ {s_a : State × A} {ss' s'}, m.trans[s_a]? = some ss' → s' ∈ ss' → s' ∈ m.states := by
  rw [←trans_tgt_lt_equiv_internal]
  exact fun s a s' a_1 => hwf.trans_tgt_lt a_1


@[grind, simp, aesop 50% unsafe]
lemma RawCNFA.WF.trans_src_lt'' [LawfulBEq A] {m : RawCNFA A} (hwf : m.WF) :
    ∀ {s a s'}, s' ∈ m.tr s a → s ∈ m.states := by
  rintro s a s' hin
  suffices hin : (s, a) ∈ m.trans by
    apply trans_src_lt' hwf hin
  unfold tr at hin
  rw [Std.HashMap.getD_eq_getD_getElem?] at hin
  rcases heq : m.trans[(s, a)]? with a | b
  · simp [heq] at hin
  · exact Std.HashMap.mem_of_getElem? heq

@[grind, simp, aesop 50% unsafe]
lemma wf_empty :
    RawCNFA.empty (A := A).WF := by
  constructor <;> simp

@[grind, simp, aesop 50% unsafe]
lemma wf_newState (m : RawCNFA A) (hwf : m.WF) :
    m.newState.2.WF := by
  constructor <;> intros <;> simp [RawCNFA.states] <;>
    apply Nat.lt_add_one_of_lt <;> simp_all [RawCNFA.newState]
  have h := @hwf.trans_tgt_lt
  simp [RawCNFA.states] at h
  apply h <;> assumption

@[grind =, simp]
lemma RawCNFA.same_stateMax (m : RawCNFA A) x y (z : Std.HashMap (State × A) (Std.HashSet State)) :
    (RawCNFA.mk m.stateMax x y z).states = m.states := by
  simp [RawCNFA.states]

@[grind =, simp]
lemma RawCNFA.empty_stateMax : empty (A := A).stateMax = 0 := rfl

@[grind, simp, aesop 50% unsafe]
lemma wf_addInitial (m : RawCNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addInitial s).WF := by
  constructor <;> intros <;> simp_all [RawCNFA.addInitial]
  { casesm* _ ∨ _ <;> subst_eqs <;> simp_all }
  { apply hwf.trans_tgt_lt <;> assumption }

@[grind, simp, aesop 50% unsafe]
lemma wf_addFinal (m : RawCNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addFinal s).WF := by
  constructor <;> intros <;> simp_all [RawCNFA.addFinal] <;> aesop

@[grind, simp, aesop 50% unsafe]
lemma wf_addTrans [LawfulBEq A] (m : RawCNFA A) (hwf : m.WF) s a s' (hin : s ∈ m.states) (hin' : s' ∈ m.states) :
    (m.addTrans a s s').WF := by
  constructor
  · simp_all
  · simp_all
  · rintro ⟨s, a⟩ htin; simp_all only [RawCNFA.addTrans, Std.HashMap.mem_insert, beq_iff_eq,
    Prod.mk.injEq, RawCNFA.same_stateMax]; grind
  · grind

@[grind, simp, aesop 50% unsafe]
lemma wf_addManyTrans [LawfulBEq A] (m : RawCNFA A) (hwf : m.WF) s as s'
  (hin : s ∈ m.states) (hin' : s' ∈ m.states) :
    (m.addManyTrans as s s').WF := by
  induction as generalizing m <;> simp_all

@[grind, simp]
lemma wf_createSink [LawfulBEq A] {m : RawCNFA A} (hwf : m.WF) : m.createSink.2.WF := by
  let motive (m' : RawCNFA A) := m'.WF ∧ m.stateMax ∈ m'.states
  suffices _ : motive m.createSink.2 by simp_all [motive]
  simp only [RawCNFA.createSink, newState_eq]
  apply List.foldlRecOn <;> simp_all [motive]

@[grind =, simp]
lemma createSink_states [LawfulBEq A] {m : RawCNFA A} : m.createSink.2.states = m.states ∪ {m.stateMax} := by
  let motive (m' : RawCNFA A) := m'.states = m.states ∪ {m.stateMax}
  suffices _ : motive m.createSink.2 by simp_all [motive]
  simp only [RawCNFA.createSink, newState_eq]
  apply List.foldlRecOn <;> simp_all [motive]

@[grind =, simp]
lemma createSink_initials [LawfulBEq A] {m : RawCNFA A} : m.createSink.2.initials = m.initials.insert m.stateMax := by
  let motive (m' : RawCNFA A) := m'.initials = m.initials.insert m.stateMax
  suffices _ : motive m.createSink.2 by simp_all [motive]
  simp only [RawCNFA.createSink, newState_eq]
  apply List.foldlRecOn <;> simp_all [motive]

@[grind =, simp]
lemma createSink_finals [LawfulBEq A] {m : RawCNFA A} : m.createSink.2.finals = m.finals := by
  let motive (m' : RawCNFA A) := m'.finals = m.finals
  suffices _ : motive m.createSink.2 by simp_all [motive]
  simp only [RawCNFA.createSink, newState_eq]
  apply List.foldlRecOn <;> simp_all [motive]

@[grind, simp]
lemma createSink_trans [LawfulBEq A] {m : RawCNFA A} (hwf : m.WF) :
    s₂ ∈ m.createSink.2.tr s₁ a ↔
      (s₁ = m.stateMax ∧ s₂ = m.stateMax) ∨
      (s₁ ∈ m.states ∧ s₂ ∈ m.states ∧ s₂ ∈ m.tr s₁ a) := by
  unfold RawCNFA.createSink
  simp
  let motive (mᵢ : RawCNFA A) (hwf : mᵢ.WF) (as : List A) :=
    mᵢ.states = m.states ∪ {m.stateMax} →
    ∀ a,
      s₂ ∈ (as.foldl (λ (m' : RawCNFA A) a => m'.addTrans a m.stateMax m.stateMax)
              (init := mᵢ)).tr s₁ a ↔
        (s₁ = m.stateMax ∧ s₂ = m.stateMax ∧ a ∈ as) ∨
        (s₂ ∈ mᵢ.tr s₁ a)
  suffices h : motive (m.newState.2.addInitial m.stateMax) (by simp_all) (FinEnum.toList A) by
    simp only [FinEnum.mem_toList, and_true, motive] at h
    rw [h] <;> simp only [RawCNFA.addInitial_tr, newState_tr,
                          states_addInitial, states_newState]
    constructor; on_goal 2 => tauto
    rintro (h | h); (exact .inl h); right
    use (RawCNFA.WF.trans_src_lt'' hwf h),
        (RawCNFA.WF.trans_tgt_lt hwf h),
        h
  generalize_proofs hwf'; revert hwf'
  generalize (m.newState.2.addInitial m.stateMax) = mi
  induction FinEnum.toList A generalizing mi
  case nil =>
    rintro hwf'; simp [motive]
  case cons a as ih =>
    simp [motive]
    rintro hwf' hstates b
    simp [motive] at ih
    rw [ih]
    · simp only [mem_addTrans_tr]; tauto
    · simp [hwf', hstates]
    · simp [hstates]

def CNFA.transSet (m : CNFA n) (ss : Std.HashSet m.m.states) (a : BitVec n) : Std.HashSet m.m.states :=
  ss.fold (init := ∅) fun ss' (s : m.m.states) =>
    let ssn := (m.m.tr s a).attachWith (λ s ↦ s ∈ m.m.states) (by simp only; rintro x hx; aesop)
    ss'.insertMany ssn

instance RawCNFA_Inhabited : Inhabited (RawCNFA A) where
  default := RawCNFA.empty

structure RawCNFA.SimulFun (m : RawCNFA A) (M : NFA A Q) (f : m.states ≃ Q)  where
  accept {q} : ((f.invFun q).val ∈ m.finals ↔ q ∈ M.accept)
  initial {q} : q ∈ M.start ↔ (f.invFun q).val ∈ m.initials
  trans_match {a q q'} : q' ∈ M.step q a ↔ (f.invFun q').val ∈ m.tr (f.invFun q) a

lemma simulFun_sim_raw [LawfulBEq A] {m : RawCNFA A} (hwf : m.WF) f :
    m.SimulFun M f → m.Sim M := by
  rintro hsim; use {(s, q) | (f.invFun q).val = s}; constructor
  · rintro s q rfl; exact hsim.accept
  · rintro s hin; use f ⟨s, hwf.initials_lt hin⟩
    simp only [Equiv.invFun_as_coe, Set.mem_setOf_eq, Equiv.symm_apply_apply, and_true]
    obtain heq : s = (f.invFun (f ⟨s, hwf.initials_lt hin⟩)) := by simp
    rw [heq, ←hsim.initial] at hin; assumption
  · rintro q hin; rw [hsim.initial] at hin; simp_all
  · rintro s s' a q rfl htr
    have hs' := hwf.trans_tgt_lt htr
    obtain heq : s' = (f.invFun (f ⟨s', hs'⟩)) := by simp
    rw [heq, ←hsim.trans_match] at htr
    use (f ⟨s', hs'⟩)
    clear heq; simp_all
  · rintro s a q q' rfl hst - -
    rw [hsim.trans_match] at hst; simp_all

lemma simulFun_sim {m : CNFA n} f :
    m.m.SimulFun M.M f → m.Sim M := by
  rintro hsim
  apply simulFun_sim_raw m.wf f hsim

def CNFA.toNFA (m : CNFA n) : NFA (BitVec n) m.m.states where
  start := { s | s.val ∈ m.m.initials }
  accept := { s | s.val ∈ m.m.finals }
  step s₁ a := { s₂ | s₂.val ∈ m.m.tr s₁.val a }

def CNFA.toNFA' (m : CNFA n) : NFA' n := ⟨_, m.toNFA⟩

lemma CNFA.canonicalSimul (m : CNFA n) : m.m.Simul m.toNFA {(s, s') | s = s'.val} ⊤ ∅ := by
  simp [toNFA]
  have hwf := m.wf
  constructor <;> aesop

lemma CNFA.canonicalSim (m : CNFA n) : m.m.Sim m.toNFA := by
  exact ⟨_, m.canonicalSimul⟩

def RawCNFA.recognizes (m : RawCNFA A) (L : Language A) :=
  ∃ (σ : Type) (M : NFA A σ), m.Sim M ∧ M.accepts = L

def CNFA.recognizes (m : CNFA n) (L : Language (BitVec n)) :=
  ∃ (M : NFA' n), m.Sim M ∧ M.M.accepts = L

def CNFA.bv_recognizes (m : CNFA n) (L : Set (BitVecs n)) :=
  ∃ L', m.recognizes L' ∧ L = dec '' L'

lemma simul_equiv {m : CNFA n} {M : NFA' n} :
    m.Sim M → m.toNFA'.M.Bisim M.M := by
  rintro ⟨R, h₂, h₃, h₄, h₅, h₆⟩
  use {(s, q) | s.val ~[R] q}
  simp [CNFA.toNFA', CNFA.toNFA]
  constructor
  · simp only [Set.mem_setOf_eq, Subtype.forall]; grind
  · simp
    constructor
    · simp_all
    · simp_all
      rintro q hst
      obtain ⟨s, hi, hR⟩ := h₄ hst
      aesop
  · simp only [Set.mem_setOf_eq, Subtype.forall]; grind
  · simp only [Set.mem_setOf_eq, Subtype.exists, exists_and_left, exists_prop, Subtype.forall]
    rintro s₁ hs₁ q₁ a q₂ hR₁ hst
    obtain ⟨s₂, htr, hR₂⟩:= h₆ hR₁ hst (by simp) (by simp)
    use s₂, htr, RawCNFA.WF.trans_tgt_lt m.wf htr, hR₂

lemma language_stable_sim {m : CNFA n} {M₁ M₂ : NFA' n} :
    m.Sim M₁ → m.Sim M₂ → M₁.M.accepts = M₂.M.accepts := by
  rintro h₁ h₂
  suffices hsim: M₁.M.Bisim M₂.M by
    simp [NFA.bisim_accepts hsim]
  apply simul_equiv at h₁
  apply simul_equiv at h₂
  exact h₁.symm.comp h₂

lemma CNFA.recognizes_functional {m : CNFA n} :
    m.recognizes L₁ → m.recognizes L₂ → L₁ = L₂ := by
  rintro ⟨M₁, hs₁, rfl⟩ ⟨M₂, hs₂, rfl⟩
  exact language_stable_sim hs₁ hs₂

@[grind, simp]
lemma sim_toNFA_eq_accepts {m : CNFA n} {M : NFA' n} (hsim : m.Sim M) :
    m.toNFA.accepts = M.M.accepts := by
  have : m.toNFA = m.toNFA'.M := by rfl
  rw [this]
  apply NFA.bisim_accepts
  apply simul_equiv hsim

lemma CNFA.bv_recognizes_equiv {m : CNFA n} :
    m.bv_recognizes L ↔ ∃ (M : NFA' n), m.Sim M ∧ M.accepts = L := by
  simp [bv_recognizes, NFA'.accepts, recognizes]
  aesop

lemma CNFA.bv_recognizes_functional {m : CNFA n} :
    m.bv_recognizes L₁ → m.bv_recognizes L₂ → L₁ = L₂ := by
  rintro ⟨L₁', h₁, rfl⟩ ⟨L₂', h₂, rfl⟩
  rw [recognizes_functional h₁ h₂]

end basics

/-   TODOs and NOTES
  TODOs:
  1. to detect overflow (eg `AdditionNoOverflows?` in `HackersDelight.lean`), abs, ...
  2. clarify what happens with automata over the alphabet `BitVec 0`...
  3. Maybe we can deal with some shifts and powers of 2 if they are of the form `k` or `w - k`.

  To deal with the fact that some results only hold for `w > 0`,
  we could first try to prove `w > 0` with omega, and then use this
  fact automatically?

  Possible improvements for performance:
  0. Implement language equality directly instead of encoding it
  1. change the representation, eg. transitions ass
        Array (Array (A × State))
  as in LASH, or with BDD as in MONA
  2. Use the interleaving technique to reduce the number of transitions:
  instead of having the alphabet `BitVec n`, it's simply `Bool` and the
  representation of (a00, a01, .., a0k)(a10, a11, .., a1k)...(an0, an1, .., ank)
  is (a00 a10 ... an0 a01 a11 ... an1 ...... ank)
-/
