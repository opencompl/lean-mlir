/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashSet
import Std.Data.HashMap
import Std.Data.HashMap.Lemmas
import Mathlib.Computability.NFA
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.List.Perm
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum

abbrev State := Nat

-- where to add the wellformedness conditions? a typeclass?
/--
The definition of a computational automaton. It is meant to be more efficient
than the definition in Mathlib.
 -/
structure CNFA (A : Type 0) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A] where
  stateMax : State
  initials : Std.HashSet State
  finals : Std.HashSet State
  trans : Std.HashMap (State × A) (Std.HashSet State)
deriving Repr

section sim

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

noncomputable def CNFA.states (m : CNFA A) : Finset State := Finset.range m.stateMax

@[simp]
lemma CNFA.states_lt (m : CNFA A) s : s ∈ m.states → s < m.stateMax := by simp [CNFA.states]

/--
A simulation between a concrete NFA and an abstract NFA consists in a map from
concrete to abstract states which satisfies some properties.
-/
structure CNFA.SimUnpacked (m : CNFA A) (A : NFA A S) (R T : Set S) (f : m.states → S) where
  -- f_inj : Function.Injective f
  -- accept s : s.val ∈ m.finals ∧ f s ∈ R ∧ f s ∉ T ↔ f s ∈ A.accept -- something about R or T
  accept s : s.val ∈ m.finals ↔ f s ∈ A.accept -- something about R or T
  initial s : s.val ∈ m.initials ↔ f s ∈ A.start
  initial_all q : q ∈ A.start → ∃ s, f s = q ∧ s.val ∈ m.initials
  trans_match₁ s a q' : q' ∈ A.step (f s) a → f s ∈ R → q' ∉ T → ∃ s', f s' = q' ∧ s'.val ∈ m.trans.getD (s.val, a) ∅
  trans_match₂ s a s' : s' ∈ m.trans.getD (s.val, a) ∅ → ∃ hin : s' ∈ m.states, f ⟨s', hin⟩ ∈ A.step (f s) a
  --                                                     ^^^^^^^^^^^^^^^^^^^^^ this is a bit shady
attribute [aesop 50% unsafe]
 CNFA.SimUnpacked.initial_all
 CNFA.SimUnpacked.trans_match₁
 CNFA.SimUnpacked.trans_match₂

def CNFA.Sim (m : CNFA A) (A : NFA A S) := ∃ f, CNFA.SimUnpacked m A ⊤ ∅ f

def NFA.closed_set (M : NFA α σ) (S : Set σ) := M.start ⊆ S ∧ ∀ a, M.stepSet S a ⊆ S

def sim_closed_set (m : CNFA A) (A : NFA A S) (R T : Set S) f (hcl: A.closed_set R) :
    T = ∅ →
    m.SimUnpacked A R T f → m.Sim A :=
  sorry

end sim

section basics

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def CNFA.empty : CNFA A := {
  stateMax := 0
  initials := ∅
  finals := ∅
  trans := ∅
}

def CNFA.newState (m : CNFA A) : State × CNFA A :=
  let old := m.stateMax
  let m := { m with stateMax := old + 1 }
  (old, m)

def CNFA.addTrans (m : CNFA A) (a : A) (s s' : State) : CNFA A :=
  let ns := m.trans.getD (s, a) ∅
  let ns := ns.insert s'
  { m with trans :=  m.trans.insert (s, a) ns }

def CNFA.addManyTrans (m : CNFA A) (a : List A) (s s' : State) : CNFA A :=
  a.foldl (init := m) fun m a => m.addTrans a s s'

def CNFA.addInitial (m : CNFA A) (s : State) : CNFA A :=
  { m with initials := m.initials.insert s }

def CNFA.addFinal (m : CNFA A) (s : State) : CNFA A :=
  { m with finals := m.finals.insert s }

def CNFA.transSet (m : CNFA A) (ss : Std.HashSet State) (a : A) : Std.HashSet State :=
  ss.fold (init := ∅) fun ss' s =>
    ss'.insertMany $ m.trans.getD (s, a) ∅

/-
Computes the set of states of the automaton. This is only meant to be used in proofs
and is quite horrible. The alternative is to have a dependent type asserting that
all the states involved are `< stateMax` which may be a better idea...
-/
structure CNFA.WF (m : CNFA A) where
  initials_lt : ∀ s ∈ m.initials, s < m.stateMax
  -- finals_lt : ∀ s ∈ m.finals, s < m.stateMax
  trans_src_lt : ∀ s_a ∈ m.trans, s_a.1 < m.stateMax
  trans_tgt_lt : ∀ (s_a : State × A) ss' s', m.trans[s_a]? = some ss' → s' ∈ ss' → s' < m.stateMax
  -- or
  -- trans_tgt_lt : ∀ (s_a : State × A) ss' s', m.trans[s_a]? = some ss' → s' ∈ ss' → s' < m.stateMax
  -- but there is no lemma about `Std.HashMap.all` :-(

attribute [simp] CNFA.WF.initials_lt CNFA.WF.trans_src_lt CNFA.WF.trans_tgt_lt
attribute [aesop 50% unsafe] CNFA.WF.initials_lt CNFA.WF.trans_src_lt CNFA.WF.trans_tgt_lt

@[simp, aesop 50% unsafe]
lemma CNFA.WF.trans_src_lt' {m : CNFA A} (hwf : m.WF) :
    ∀ s a, (s, a) ∈ m.trans → s < m.stateMax := by
  intros s a hin; simp [hwf.trans_src_lt _ hin]

@[simp, aesop 50% unsafe]
lemma wf_newState (m : CNFA A) (hwf : m.WF) :
    m.newState.2.WF := by
  constructor <;> intros <;> apply Nat.lt_add_one_of_lt <;> simp_all [CNFA.newState, CNFA.WF]
  apply hwf.trans_tgt_lt <;> assumption

@[simp, aesop 50% unsafe]
lemma wf_addInitial (m : CNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addInitial s).WF := by
  constructor <;> intros <;> simp_all [CNFA.addInitial, CNFA.WF]
  { casesm* _ ∨ _ <;> subst_eqs <;> simp_all }
  { apply hwf.trans_tgt_lt <;> assumption }

@[simp, aesop 50% unsafe]
lemma wf_addFinal (m : CNFA A) (hwf : m.WF) :
    (m.addFinal s).WF := by
  constructor <;> intros <;> simp_all [CNFA.addFinal, CNFA.WF]
  apply hwf.trans_tgt_lt <;> assumption

@[simp, aesop 50% unsafe]
lemma states_addInitial (m : CNFA A) (s' : State) :
    (m.addInitial s').states = m.states := by
  simp_all [CNFA.addInitial, CNFA.states]

@[simp, aesop 50% unsafe]
lemma states_addFinal (m : CNFA A) (s' : State) :
    (m.addFinal s').states = m.states := by
  simp_all [CNFA.addFinal, CNFA.states]

@[simp, aesop 50% unsafe]
lemma states_addTrans (m : CNFA A) (a : A) (s1 s2 : State) :
    (m.addTrans a s1 s2).states = m.states := by
  simp_all [CNFA.addTrans, CNFA.states]

@[simp, aesop 50% unsafe]
lemma mem_states_newState (m : CNFA A) (s : State) (hin : s ∈ m.states) :
    s ∈ m.newState.2.states := by
  simp_all [CNFA.newState, CNFA.states]; omega

@[simp, aesop 50% unsafe]
lemma states_newState (m : CNFA A) :
    m.newState.2.states = m.states ∪ { m.stateMax } := by
  simp_all [CNFA.newState, CNFA.states, Finset.range_add]

@[simp, aesop 50% unsafe]
lemma newState_eq (m : CNFA A) :
    m.newState.1 = m.stateMax := by
  simp_all [CNFA.newState, CNFA.states, Finset.range_add]

@[simp, aesop 50% unsafe]
lemma mem_states_newState_self (m : CNFA A) :
    m.newState.1 ∈ m.newState.2.states := by
  simp_all [CNFA.newState, CNFA.states]

@[simp, aesop 50% unsafe]
lemma wf_addTrans [LawfulBEq A] (m : CNFA A) (hwf : m.WF) s a s' (hin : s ∈ m.states) (hin' : s' ∈ m.states) :
    (m.addTrans a s s').WF := by
  constructor <;> simp_all [CNFA.addTrans, CNFA.WF]
  { intros s a htin; casesm* _ ∨ _ <;> aesop }
  { rintro s1 b ss'1 s'1 hsome hmem
    rw [Std.HashMap.getElem?_insert] at hsome; split at hsome; simp_all
    { casesm* _ ∧ _; subst_eqs; simp_all; cases_type Or; simp_all
      by_cases hmem : (s, a) ∈ m.trans
      { apply Std.HashMap.getElem?_eq_some_getD (fallback := ∅) at hmem
        apply hwf.trans_tgt_lt _ _ _ hmem; assumption }
      { have : m.trans.getD (s, a) ∅ = ∅ := by apply Std.HashMap.getD_eq_fallback; assumption
        simp_all }
     }
    { apply hwf.trans_tgt_lt _ _ _ hsome; assumption }}

instance CNFA_Inhabited : Inhabited (CNFA A) where
  default := CNFA.empty

end basics

-- A generic function to define automata constructions using worklist algorithms
section worklist

variable (A : Type) [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable (S : Type) [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

structure worklist.St where
  m : CNFA A
  map : Std.HashMap S State := ∅
  worklist : Array S := ∅
  worklist_nodup : worklist.toList.Nodup
  worklist_incl : ∀ sa ∈ worklist, sa ∈ map

attribute [aesop 10% unsafe] worklist.St.worklist_nodup worklist.St.worklist_incl
attribute [simp] worklist.St.worklist_nodup worklist.St.worklist_incl

def worklist.St.meas (st : worklist.St A S) : ℕ :=
  Finset.card $ Finset.univ |>.filter fun x => x ∉ st.map.keys ∨ x ∈ st.worklist.toList


theorem List.perm_subset_iff_right {l1 l2 : List α} (hperm : l1.Perm l2) (l : List α) :
  l ⊆ l1 ↔ l ⊆ l2 := by
  constructor
  { intros hincl x hin; apply List.Perm.mem_iff (a := x) at hperm ; apply hperm.mp; apply hincl; assumption }
  { intros hincl x hin; apply List.Perm.mem_iff (a := x) at hperm ; apply hperm.mpr; apply hincl; assumption }

open List in
theorem list_perm_trick (x y a b c : List α) :
    y ~ b ++ x → x ~ a ++ c → y ~ a ++ b ++ c := by
  intros h1 h2
  have hi : b ++ x ~ b ++ (a ++ c) := by apply Perm.append_left; assumption
  have := perm_append_comm_assoc b a c
  have := h1.trans (hi.trans this)
  aesop

def worklist.St.addOrCreateState (st : worklist.St A S) (final? : Bool) (sa : S) : State × worklist.St A S :=
  match heq : st.map[sa]? with
  | some s => (s, st)
  | none =>
    let (s, m) := st.m.newState
    let m := if final? then m.addFinal s else m
    let map := st.map.insert sa s
    let worklist := st.worklist.push sa
    have worklist_nodup : worklist.toList.Nodup := by
      simp [worklist]; apply List.nodup_middle.mpr; simp
      intros hc; apply Array.Mem.mk at hc; apply st.worklist_incl at hc; simp at hc; apply Std.HashMap.get?_none_not_mem at heq; contradiction
    have worklist_incl : ∀ sa ∈ worklist, sa ∈ map := by
      simp [worklist, map]; intros sa' hin; apply Array.mem_push at hin; rcases hin with hin | heq
      { apply st.worklist_incl at hin; aesop }
      { aesop }
    let st' := { st with m, map, worklist, worklist_nodup, worklist_incl }
    (s, st')

omit [Fintype S] in
lemma addOrCreate_preserves_map (st : worklist.St A S) (final? : Bool) (sa sa' : S) :
    let (_, st') := st.addOrCreateState _ _  final? sa'
    st.map[sa]? = some s →
    st'.map[sa]? = some s := by
  simp_all [worklist.St.addOrCreateState]; intros hmap
  split; simp_all
  dsimp only
  simp_all [Std.HashMap.getElem?_insert]
  rintro rfl; simp_all

omit [Fintype S] in
lemma addOrCreate_preserves_mem (st : worklist.St A S) (final? : Bool) (sa sa' : S) :
    let (_, st') := st.addOrCreateState _ _  final? sa'
    sa ∈ st.map →
    sa ∈ st'.map := by
  simp_all [worklist.St.addOrCreateState]; intros hmap
  split; simp_all
  dsimp only
  simp_all [Std.HashMap.getElem?_insert]

omit [Fintype S] [DecidableEq S] in
theorem addOrCreateState_grow (st : worklist.St A S) (b : Bool) (sa : S) :
    let (_, st') := st.addOrCreateState _ _ b sa
    ∃ sas, List.Perm st'.map.keys (sas ++ st.map.keys) ∧ st'.worklist.toList = st.worklist.toList ++ sas := by
  unfold worklist.St.addOrCreateState
  simp
  generalize_proofs pf1 pf2
  split; simp
  use [sa]
  simp
  apply Std.HashMap.insert_keys_perm_new
  apply Std.HashMap.get?_none_not_mem; assumption

def processOneElem (final : S → Bool) (s : State) (st : worklist.St A S) : A × S → worklist.St A S :=
  fun (a', sa') =>
    let (s', st') := st.addOrCreateState _ _ (final sa') sa'
    let m := st'.m.addTrans a' s s'
    { st' with m }

omit [Fintype S] in
lemma processOneElem_preserves_map (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s : State) :
    let st' := processOneElem _ _  final s st (a, sa')
    st.map[sa]? = some s →
    st'.map[sa]? = some s := by
  simp_all [processOneElem, addOrCreate_preserves_map]

omit [Fintype S] in
lemma processOneElem_preserves_mem (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s : State) :
    let st' := processOneElem _ _  final s st (a, sa')
    sa ∈ st.map →
    sa ∈ st'.map := by
  simp_all [processOneElem, addOrCreate_preserves_mem]

-- omit [Fintype S] in
-- lemma processOneElem_preserves_wf (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s : State) :
--     let st' := processOneElem _ _  final s st (a, sa')
--     st.m.WF →
--     st'.m.WF := by
--   simp_all [processOneElem, worklist.St.addOrCreateState]
--   intros hwf
--   split <;> simp_all [wf_addTrans]

omit [Fintype S] [DecidableEq S] in
theorem processOneElem_grow (st : worklist.St A S) (final : S → Bool) (a : A) (sa' : S) (s : State) :
      let st' := processOneElem _ _ final s st (a, sa')
      ∃ sas, List.Perm st'.map.keys (sas ++ st.map.keys) ∧ st'.worklist.toList = st.worklist.toList ++ sas := by
  simp [processOneElem]
  have h := addOrCreateState_grow _ _ st (final sa') sa'
  rcases heq : (worklist.St.addOrCreateState A S st (final ↑sa') sa') with ⟨x, st'⟩
  simp [heq] at h
  rcases h with ⟨sas, h1, h2⟩
  use sas

def worklist.initState (inits : Array S) (hinits : inits.toList.Nodup) : worklist.St A S :=
  let m := CNFA.empty (A := A)
  let mapm := inits.foldl (init := (Std.HashMap.empty, m)) fun (map, m) sa =>
    let (s, m) := m.newState
    let m := m.addInitial s
    (map.insert sa s, m)
  let map := mapm.1
  let m := mapm.2
  let worklist_incl : ∀ sa ∈ inits, sa ∈ map := by
    let mot (n : ℕ) (mapm : Std.HashMap S State × CNFA A) : Prop :=
      ∀ sa, ∀ k < n, inits[k]? = some sa → sa ∈ mapm.1
    suffices hccl : mot inits.size mapm by
      simp_all [mot]; intros sa hin
      apply Array.getElem_of_mem at hin; rcases hin with ⟨k, hk, heq⟩
      apply hccl _ _ hk (by simp_all [Array.getElem?_eq_getElem])
    apply Array.foldl_induction; simp [mot]
    intros i map ih; simp [mot] at ih ⊢
    intros sa k hk hsome
    apply Nat.lt_add_one_iff_lt_or_eq.mp at hk; rcases hk with hk | rfl
    { right; apply ih _ _ hk hsome }
    { left; simp_all [Array.getElem?_eq_getElem]  }
  { m, map, worklist := inits, worklist_nodup := hinits, worklist_incl }

def worklistRun (final : S → Bool) (f : S → Array (A × S)) (inits : Array $ S) (hinits : inits.toList.Nodup) : CNFA A :=
  let st0 := worklist.initState _ _ inits hinits
  go st0
where go (st0 : worklist.St A S) : CNFA A :=
  if hemp : st0.worklist.isEmpty then st0.m else
  let sa? := st0.worklist.back?
  match heq : sa? with
  | some sa =>
    let wl := st0.worklist.pop
    let st1 := { st0 with worklist := wl,
                          worklist_nodup := by simp [wl]; apply List.dropLast_nodup; exact st0.worklist_nodup;
                          worklist_incl := by intros _ hin; apply Array.mem_of_mem_pop at hin; apply st0.worklist_incl; assumption }
    if let some s := st1.map.get? sa then
      let a := f sa
      let st2 := a.foldl (init := st1) (processOneElem _ _ final s)
      -- why is ~ not a valid token here?
      open List in
      have hgrow : ∃ sas, st2.map.keys ~ (sas ++ st1.map.keys) ∧ st2.worklist.toList = st1.worklist.toList ++ sas := by
        rcases a with ⟨al⟩
        unfold st2
        generalize hst1 : st1 = x; clear hst1; revert x
        induction al with
        | nil => simp
        | cons asa al ih =>
          simp; simp at ih; intros st
          let wl' := processOneElem A S final s st asa
          rcases ih wl' with ⟨sas', h1', h2'⟩; clear ih
          rcases processOneElem_grow _ _ st final asa.1 asa.2 s with ⟨sas, h1, h2⟩
          use (sas ++ sas')
          constructor
          { simp [wl'] at h1'; apply list_perm_trick; exact h1'; exact h1 }
          { simp [wl', h2] at h2'; aesop }
      have hincl : ∀ k, k ∈ st1.map → k ∈ st2.map := by
        intros k; rcases hgrow with ⟨sas, hkeys, -⟩;
        have := @(List.perm_subset_iff_right hkeys st1.map.keys).mpr (by aesop) k; aesop
      have : st1.meas < st0.meas := by
        rcases heq' : sa? with ⟨⟩ | ⟨sa⟩
        { aesop }
        apply Finset.card_lt_card
        simp [worklist.St.meas, Finset.ssubset_iff, Finset.subset_iff]
        use sa
        simp [sa?] at heq'
        constructor
        { constructor
          { apply Array.back?_mem at heq'; apply st0.worklist_incl; assumption }
          { apply Array.not_elem_back_pop at heq' <;> simp_all [Array.pop, wl] } }
        constructor
        { right; apply Array.back?_mem at heq'; apply Array.Mem.val; assumption}
        rintro sa hh; rcases hh with hnin | hin
        { simp [hnin] }
        right
        apply List.mem_of_mem_dropLast; assumption
      have : st2.meas ≤ st1.meas := by
        apply Finset.card_le_card
        simp [worklist.St.meas, Finset.subset_iff]
        intros sa' h
        rcases h with hnin | hin
        { left; simp [st1] at hincl; intros hc; apply hnin; apply hincl; assumption }
        by_cases hnew : sa' ∈ st0.map
        all_goals try (left; trivial)
        right
        simp [st1] at hgrow
        rcases hgrow with ⟨sas, hkeys2, hwl2⟩
        simp [hwl2] at hin
        have hnin : sa'∉ sas := by
          intros hc
          have hdisj : st0.map.keys.Disjoint sas := by
            have : (sas ++ st0.map.keys).Nodup := by
              apply List.Perm.nodup
              assumption
              apply st2.map.keys_nodup
            simp [List.nodup_append_comm, List.disjoint_of_nodup_append, this]
          apply hdisj
          { simp_all [Std.HashMap.mem_keys_iff_mem]; apply hnew }
          { apply hc }
        rcases hin <;> trivial
      have : st2.meas < st0.meas := by omega
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  termination_by st0.meas

/-
Lean fails to generate a fuctional induction predicate for the actual function above,
so we remove some proofs to bypass this issue until it's resolved.
See issue https://github.com/leanprover/lean4/issues/5767
 -/
def worklistRun' (final : S → Bool) (f : S → Array (A × S)) (inits : Array $ S) (hinits : inits.toList.Nodup) : CNFA A :=
  let st0 := worklist.initState _ _ inits hinits
  go st0
where go (st0 : worklist.St A S) : CNFA A :=
  if hemp : st0.worklist.isEmpty then st0.m else
  match heq : st0.worklist.back? with
  | some sa =>
    let wl := st0.worklist.pop
    let st1 := { st0 with worklist := wl,
                          worklist_nodup := by simp [wl]; apply List.dropLast_nodup; exact st0.worklist_nodup;
                          worklist_incl := by intros _ hin; apply Array.mem_of_mem_pop at hin; apply st0.worklist_incl; assumption }
    if let some s := st1.map.get? sa then
      let a := f sa
      let st2 := a.foldl (init := st1) (processOneElem _ _ final s)
      -- why is ~ not a valid token here?
      open List in
      have hgrow : ∃ sas, st2.map.keys ~ (sas ++ st1.map.keys) ∧ st2.worklist.toList = st1.worklist.toList ++ sas := by
        rcases a with ⟨al⟩
        unfold st2
        generalize hst1 : st1 = x; clear hst1; revert x
        induction al with
        | nil => simp
        | cons asa al ih =>
          simp; simp at ih; intros st
          let wl' := processOneElem A S final s st asa
          rcases ih wl' with ⟨sas', h1', h2'⟩; clear ih
          rcases processOneElem_grow _ _ st final asa.1 asa.2 s with ⟨sas, h1, h2⟩
          use (sas ++ sas')
          constructor
          { simp [wl'] at h1'; apply list_perm_trick; exact h1'; exact h1 }
          { simp [wl', h2] at h2'; aesop }
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  decreasing_by sorry

-- Correctness of the algorithm

variable (final : S → Bool) (f : S → Array (A × S)) (inits : Array S)
variable (M : NFA A σ)
variable (corr : S → σ)
variable (corr_inj : Function.Injective corr)
variable (hinit₁ : ∀ sa ∈ inits, corr sa ∈ M.start)
variable (hinit₂ : ∀ q ∈  M.start, ∃ sa, corr sa = q ∧ sa ∈ inits)
variable (hf₁: ∀ sa q' a, q' ∈ M.step (corr sa) a → ∃ sa', corr sa' = q' ∧ (a, sa') ∈ f sa)
variable (hf₂: ∀ sa a sa', (a, sa') ∈ f sa → corr sa' ∈ M.step (corr sa) a)

def worklist.St.visited (st : worklist.St A S) : Set S := { s : S | s ∈ st.map ∧ s ∉ st.worklist }

lemma visited_addOrCreateElem (st : worklist.St A S) :
    st.addOrCreateState _ _ final? sa |>.2.visited = st.visited := by
  sorry

lemma visited_processOneElem (st : worklist.St A S) :
    let st' := processOneElem _ _  final s st (a, sa')
    st'.visited = st.visited := by
  sorry

-- this is wrong!
-- either we need to change R to be the succesors of visited not in T,
-- or we should change Sim to take two sets, the finished sets for the source and the target set.
-- The latter sounds weird...

def worklist.St.R (st : worklist.St A S) : Set σ := { q : σ | ∃ sa ∈ st.visited, corr sa = q }

structure StInv (T : Set S) (st : worklist.St A S) where
  wf : st.m.WF
  map_states : ∀ (sa : S) s, st.map[sa]? = some s → s ∈ st.m.states
  map_surj : ∀ s : st.m.states, ∃ (sa : S), st.map[sa]? = some s.val
  frontier : ∀ sa a q', sa ∈ st.visited → q' ∈ M.step (corr sa) a →
               ∃ sa', corr sa' = q' ∧ (sa' ∈ st.map ∨ sa' ∈ T)

attribute [simp] StInv.wf StInv.map_states StInv.map_surj StInv.frontier

-- is there a better way?
local notation "StInv'" => StInv A S M corr

-- We make a map from the (nat) states of the automaton to the
-- abstract states using the axiom of choice applied to the
-- property `StInv.map_inj`
noncomputable def StInv.mFun (inv : StInv A S M corr T st) : st.m.states → S :=
  Classical.choose $ Classical.axiomOfChoice inv.map_surj

omit [Fintype S] [LawfulBEq S] [DecidableEq S] in
lemma StInv.mFun_spec (inv : StInv' T st) (s : st.m.states) : st.map[inv.mFun _ _ _ _ s]? = some s := by
  simp [StInv.mFun]
  apply Classical.choose_spec (Classical.axiomOfChoice inv.map_surj)

lemma mFun_mem (inv : StInv' T st) (s : st.m.states) : inv.mFun _ _ _ _ s ∈ st.map := by
  sorry

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_states (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
  (processOneElem A S final s st (a, sa)).m.states =
    if sa ∉ st.map then st.m.newState.2.states else st.m.states := by
  simp [processOneElem, worklist.St.addOrCreateState]
  split
  next s' heq =>
    dsimp
    have _ := Std.HashMap.mem_of_get? heq
    split_ifs; simp_all
  next heq =>
    dsimp
    have _ := Std.HashMap.get?_none_not_mem heq
    split <;> simp_all

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_finals (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
  (processOneElem A S final s st (a, sa)).m.finals =
    if sa ∉ st.map ∧ final sa then st.m.finals.insert st.m.stateMax else st.m.finals := by
  simp [processOneElem, worklist.St.addOrCreateState]
  split
  next s' heq =>
    dsimp
    have _ := Std.HashMap.mem_of_get? heq
    split_ifs <;> simp_all
    simp [CNFA.addTrans]
  next heq =>
    dsimp
    have _ := Std.HashMap.get?_none_not_mem heq
    split
    { simp_all [CNFA.newState, CNFA.addTrans, CNFA.addFinal] }
    { simp_all [CNFA.newState, CNFA.addTrans] }



noncomputable def StInv.fun (inv : StInv' T st) : st.m.states → σ := corr ∘ inv.mFun

abbrev StInv.sim {st : worklist.St A S} (inv : StInv' T st) :=
  st.m.SimUnpacked M (st.R A S corr) {q | ∃ sa ∈ T, corr sa = q } (inv.fun A S M corr)

def processOneElem_mot (s : State) (sa : S) (n : ℕ) (st : worklist.St A S) : Prop :=
  st.map[sa]? = some s ∧
  ∃ (inv : StInv A S M corr st (T := {sa' | ∃ a, ∃ k ≥ n, (f sa)[k]? = some (a, sa') })),
    inv.sim A S M corr

set_option trace.split.failure true in
def processOneElem_spec {st : worklist.St A S} (s : State) (sa : S) (k : ℕ) :
    ∀ a sa', (f sa)[k]? = some (a, sa') →
    processOneElem_mot A S f M corr s sa k st →
    processOneElem_mot A S f M corr s sa (k+1) (processOneElem A S final s st (a, sa')) := by
  intro a sa' hf ⟨hmap, inv, hsim⟩
  have hmem : ∀ s (sa : S), st.map[sa]? = some s → s ∈ st.m.states := by intros; apply inv.map_states; assumption
  -- have hs : s ∈ st.m.states := by apply inv.map_states; assumption
  have _ : st.m.WF := by apply inv.wf
  constructor
  { simp_all [processOneElem_preserves_map] }
  have inv' : StInv' {sa' | ∃ a, ∃ k' ≥ k + 1, (f sa)[k']? = some (a, sa')} (processOneElem A S final s st (a, sa')) := by
    constructor
    { simp_all only [processOneElem, worklist.St.addOrCreateState]; aesop }
    { simp_all only [processOneElem, worklist.St.addOrCreateState]; split
      { aesop }
      { dsimp only; intros sa s hin
        by_cases hnew? : sa' = sa
        { subst_eqs; simp at hin; subst_eqs; aesop }
        { have _ : s ∈ st.m.states := by rw [Std.HashMap.getElem?_insert] at hin; aesop
          aesop } } }
    { simp_all only [processOneElem, worklist.St.addOrCreateState]; split
      { simp; intros s hs; apply inv.map_surj ⟨s, hs⟩ }
      { simp; intros s' hs'
        have hs' : s' ∈ st.m.newState.2.states := by aesop
        simp at hs'
        rcases hs' with hold | rfl
        { obtain ⟨sa, hsa⟩ := inv.map_surj ⟨_, hold⟩; use sa
          rw [Std.HashMap.getElem?_insert]
          simp_all; rintro rfl; simp_all }
        { use sa'; simp_all } } }
    { intros sa' a q' hsa' hq'
      rw [visited_processOneElem] at hsa'
      obtain ⟨sa', h1, h2⟩ := inv.frontier sa' a q' (by simp_all [worklist.St.visited]) hq'
      use sa'; constructor; assumption
      rcases h2 with h2 | ⟨a, k', hk', h2⟩
      { left; apply processOneElem_preserves_mem; assumption }
      by_cases hkeq : k' = k
      on_goal 2 => right; use a, k'; constructor; omega; assumption
      subst_eqs; left
      simp only [processOneElem, worklist.St.addOrCreateState]
      split; on_goal 2 => simp_all
      next _ _ heq => simp_all; rw [h2] at *; casesm* _ ∧ _ ; injections; subst_eqs; aesop }

  use inv'; constructor
  { rw [processOneElem_finals]
    rintro ⟨sa1, hsa1⟩
    rw [processOneElem_states] at hsa1
    split_ifs
    { split_ifs at hsa1; simp_all; sorry }
    { split_ifs at hsa1
      { sorry }
      { sorry }
    }
  }
  { sorry }
  { sorry }
  { sorry }
  { sorry }

-- TODO: improve this proof, make it faster
def worklistGo_spec {st : worklist.St A S} (inv : StInv' ∅ st) :
    inv.sim A S M corr →
    (worklistRun'.go A S final f st |>.Sim M) := by
  induction st using worklistRun'.go.induct _ _ final f with
  | case3 st0 hnemp hemp => -- trivial case that's impossible
      simp [Array.back?] at *
      have : st0.worklist.size = 0 := by omega
      simp_all only [zero_le, tsub_eq_zero_of_le, le_refl, List.length_eq_zero]
  | case1 st hemp => -- exit case, prove that the invariant + empty worklist implies the postcondition
    have : st.worklist = #[] := by
      simp only [Array.isEmpty] at hemp; apply Array.eq_empty_of_size_eq_zero; simp_all only [decide_eq_true_eq]
    intros hsim; unfold worklistRun'.go; simp_all; apply sim_closed_set _ _ _ _ _ _ (by simp_all) hsim
    simp [NFA.closed_set]; constructor
    { intros q hq; simp [worklist.St.R]
      obtain ⟨s, hmap, _⟩ := hsim.initial_all q hq
      use (inv.mFun _ _ _ _ s); constructor
      · simp [worklist.St.visited]; constructor
        { apply mFun_mem }
        { simp_all }
      · exact hmap }
    intros a q' hq'
    simp [NFA.mem_stepSet] at hq'; obtain ⟨q, ⟨sa, ⟨hin, -⟩, rfl⟩, hstep⟩ := hq'
    apply inv.frontier at hstep; rcases hstep with ⟨sa, rfl, hsa⟩
    simp_all [worklist.St.R, worklist.St.visited]; use sa
    simp_all [worklist.St.visited]
  | case2 st hnemp sa heq wl st1 ih => -- inductive case, prove the invariant is maintained
    intros hsim; unfold worklistRun'.go; simp_all
    split
    next sa hsome =>
      split
      next _ s hmap =>
        rw [heq] at hsome; subst_eqs
        suffices hccl : processOneElem_mot A S f M corr s sa (f sa).size (Array.foldl (processOneElem A S final s) st1 (f sa)) by
          obtain ⟨_, inv', hsim'⟩ := hccl
          simp at inv'
          have hemp : {sa' | ∃ a k, (f sa).size ≤ k ∧ (f sa)[k]? = some (a, sa')} = ∅ := by
            ext sa'; simp_all; intros a k hge hsome
            suffices hccl : (f sa)[k]? = none by simp_all
            apply Array.get?_len_le; assumption
          simp_all only [ge_iff_le]
        apply Array.foldl_induction
        simp only [st1, wl]
        { unfold processOneElem_mot
          have inv' : StInv' {sa' | ∃ a, ∃ k ≥ 0, (f sa)[k]? = some (a, sa')} st1 := by
            constructor
            { simp [st1]; exact inv.wf }
            { simp [st1]; apply inv.map_states }
            { simp only [st1]; intros a; obtain ⟨sa, hsa⟩ := inv.map_surj a; use sa }
            { simp only [st1, wl, worklist.St.visited]; intros sa' a q' hsa' hq'
              by_cases h : sa' = sa
              { subst h; obtain ⟨sa'', h1, h2⟩ := hf₁ _ _ _ hq'
                use sa''; constructor; assumption; right
                simp; use a; exact Array.getElem?_of_mem h2 }
              { obtain ⟨sa', h1, h2 | himp⟩ := inv.frontier  sa' a q' (by
                  simp [worklist.St.visited]; simp_all
                  intros hc; apply hsa'.2; rw [Array.mem_pop_iff] at hc; simp_all) hq'
                on_goal 2 => simp_all
                use sa'; simp_all } }
          constructor; on_goal 1 => assumption
          have hmfun : inv.mFun _ _ _ _  = inv'.mFun _ _ _ _ := by simp [StInv.mFun]
          have hfun : inv.fun _ _ _ _ = inv'.fun _ _ _ _ := by simp [StInv.fun, hmfun]
          use inv'; constructor
          { apply hsim.accept }
          { apply hsim.initial }
          { apply hsim.initial_all }
          { rintro ⟨s1, hs1⟩ a q' hq' hin hnin
            let sa1 := inv'.mFun _ _ _ _ ⟨s1, hs1⟩
            by_cases hnew? : sa1 = sa
            { exfalso; apply hnin
              apply hf₁ at hq'; obtain ⟨sa', hcorr, hf⟩ := hq'
              use sa'
              constructor <;> try assumption
              obtain ⟨k, hk⟩ := Array.getElem?_of_mem hf
              use a, k
              constructor; omega
              rw [←hnew?]
              simp [hnew?, sa1] at hk ⊢; assumption}
            { rw [←hfun] at *; apply hsim.trans_match₁ <;> try (simp_all; done)
              simp_all only [worklist.St.R, worklist.St.visited]
              obtain ⟨sa2, ⟨h2, h3⟩, h4⟩ := hin
              have heq : sa1 = sa2 := by apply corr_inj; rw [h4]; unfold sa1; rw [←hmfun]; unfold StInv.fun; simp -- TODO
              use sa1; simp_all; intros hc
              have heq : sa1 = sa := by apply Array.mem_pop_iff _ _ |>.mp at hc; simp_all
              simp_all}}
          { apply hsim.trans_match₂ } }
        { intros k st; apply processOneElem_spec A S final f M corr (st := st) s sa k
          simp; exact Array.getElem?_lt (f sa) k.isLt }
      next hnone =>
        have hnin : sa ∉ st.map := by
          intros hin
          suffices ex : ∃ s, st.map[sa]? = some s by simp_all
          use ?_; exact Std.HashMap.getElem?_eq_some_getD (fallback := 0) hin
        exfalso; apply hnin; apply st.worklist_incl; exact Array.back_mem st.worklist sa hsome
    next hnone =>
      simp [Array.back?] at *
      have : st.worklist.size = 0 := by omega
      simp_all

end worklist


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
  1. change the representation, eg. transitions as
        Array (Array (A × State))
  as in LASH, or with BDD as in MONA
  2. Use the interleaving technique to reduce the number of transitions:
  instead of having the alphabet `BitVec n`, it's simply `Bool` and the
  representation of (a00, a01, .., a0k)(a10, a11, .., a1k)...(an0, an1, .., ank)
  is (a00 a10 ... an0 a01 a11 ... an1 ...... ank)
-/
