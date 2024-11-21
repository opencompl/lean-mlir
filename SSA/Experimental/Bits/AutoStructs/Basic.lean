/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashSet
import Std.Data.HashMap
import Std.Data.HashMap.Lemmas
import Batteries.Data.Fin.Basic
import Batteries.Data.Array.Lemmas
import Mathlib.Computability.NFA
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.List.Perm.Basic
import Mathlib.Data.List.Perm.Lattice
import Mathlib.Data.List.Perm.Subperm
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.ForMathlib
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.NFA'

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

noncomputable def RawCNFA.states (m : RawCNFA A) : Finset State := Finset.range m.stateMax

instance RawCNFA.statesFinset (m : RawCNFA A) : Fintype m.states := (Finset.range m.stateMax).fintypeCoeSort

@[simp]
lemma RawCNFA.states_lt (m : RawCNFA A) s : s ∈ m.states → s < m.stateMax := by simp [RawCNFA.states]

/--
A simulation between a concrete NFA and an abstract NFA consists in a map from
concrete to abstract states which satisfies some properties.
-/
structure RawCNFA.SimUnpacked (m : RawCNFA A) (M : NFA A Q) (R : Set Q) (T : Set (Q × A × Q)) (f : m.states → Q) where
  injective : Function.Injective f
  reduced : M.Reachable = ⊤ -- all the states are reachable
  accept s : s.val ∈ m.finals ↔ f s ∈ M.accept
  initial s : s.val ∈ m.initials ↔ f s ∈ M.start
  initial_all q : q ∈ M.start → ∃ s, f s = q ∧ s.val ∈ m.initials
  trans_match₁ s a q' : q' ∈ M.step (f s) a → f s ∈ R → (f s, a, q') ∉ T → ∃ s', f s' = q' ∧ s'.val ∈ m.trans.getD (s.val, a) ∅
  trans_match₂ s a s' : s' ∈ m.trans.getD (s.val, a) ∅ → ∃ hin : s' ∈ m.states, f ⟨s', hin⟩ ∈ M.step (f s) a

attribute [aesop 50% unsafe]
 RawCNFA.SimUnpacked.initial_all
 RawCNFA.SimUnpacked.trans_match₁
 RawCNFA.SimUnpacked.trans_match₂

def RawCNFA.Sim (m : RawCNFA A) (A : NFA A S) := ∃ f, RawCNFA.SimUnpacked m A ⊤ ∅ f

def sim_closed_set (m : RawCNFA A) (M : NFA A S) (R : Set S) (T : Set (S × A × S)) f (hcl: M.closed_set R) :
    T = ∅ →
    m.SimUnpacked M R T f → m.Sim M := by
  rintro rfl ⟨_, hr, _, _, _, h, _⟩; use f
  constructor <;> try assumption
  rintro s a q' hq' hreach _
  apply h <;> try assumption
  rw [←hr] at hreach
  apply NFA.reachable_sub_closed_set at hreach <;> assumption

end sim

section basics

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def RawCNFA.empty : RawCNFA A := {
  stateMax := 0
  initials := ∅
  finals := ∅
  trans := ∅
}

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

def RawCNFA.addInitial (m : RawCNFA A) (s : State) : RawCNFA A :=
  { m with initials := m.initials.insert s }

def RawCNFA.addFinal (m : RawCNFA A) (s : State) : RawCNFA A :=
  { m with finals := m.finals.insert s }

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

def RawCNFA.transSetBV (m : RawCNFA A) (ss : BitVec m.stateMax) (a : A) : BitVec m.stateMax :=
  (List.finRange m.stateMax).foldl (init := BitVec.zero m.stateMax) fun res n =>
    if ss[n] then res ||| m.transBV ⟨n.val, by simp [RawCNFA.states]⟩ a else res

/-
Computes the set of states of the automaton. This is only meant to be used in proofs
and is quite horrible. The alternative is to have a dependent type asserting that
all the states involved are `< stateMax` which may be a better idea...
-/
structure RawCNFA.WF (m : RawCNFA A) where
  initials_lt : ∀ s ∈ m.initials, s < m.stateMax
  finals_lt : ∀ s ∈ m.finals, s < m.stateMax
  trans_src_lt : ∀ s_a ∈ m.trans, s_a.1 < m.stateMax
  trans_tgt_lt : ∀ (s_a : State × A) ss' s', m.trans[s_a]? = some ss' → s' ∈ ss' → s' < m.stateMax

structure CNFA (n : Nat) where
  m : RawCNFA (BitVec n)
  wf : m.WF

def CNFA.Sim (m : CNFA n) (M : NFA' n) :=
  m.m.Sim M.M

attribute [simp] RawCNFA.WF.initials_lt RawCNFA.WF.trans_src_lt RawCNFA.WF.trans_tgt_lt RawCNFA.WF.finals_lt
attribute [aesop 50% unsafe] RawCNFA.WF.initials_lt RawCNFA.WF.trans_src_lt RawCNFA.WF.trans_tgt_lt RawCNFA.WF.finals_lt

@[simp, aesop 50% unsafe]
lemma RawCNFA.WF.trans_src_lt' {m : RawCNFA A} (hwf : m.WF) :
    ∀ s a, (s, a) ∈ m.trans → s < m.stateMax := by
  intros s a hin; simp [hwf.trans_src_lt _ hin]

@[simp, aesop 50% unsafe]
lemma RawCNFA.WF.trans_tgt_lt' [LawfulBEq A] {m : RawCNFA A} (hwf : m.WF) :
    ∀ s a s', s' ∈ m.trans.getD (s, a) ∅ → s' ∈ m.states := by
  intros s a s' hin
  rw [Std.HashMap.getD_eq_getD_getElem?] at hin
  rcases htrans : m.trans[(s, a)]? with ⟨⟩ | ⟨ts⟩
  · simp_all
  · simp [RawCNFA.states]; apply hwf.trans_tgt_lt (s, a) ts <;> simp_all

@[simp, aesop 50% unsafe]
lemma wf_newState (m : RawCNFA A) (hwf : m.WF) :
    m.newState.2.WF := by
  constructor <;> intros <;> apply Nat.lt_add_one_of_lt <;> simp_all [RawCNFA.newState, RawCNFA.WF]
  apply hwf.trans_tgt_lt <;> assumption

@[simp, aesop 50% unsafe]
lemma wf_addInitial (m : RawCNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addInitial s).WF := by
  constructor <;> intros <;> simp_all [RawCNFA.addInitial, RawCNFA.WF]
  { casesm* _ ∨ _ <;> subst_eqs <;> simp_all }
  { apply hwf.trans_tgt_lt <;> assumption }

@[simp, aesop 50% unsafe]
lemma wf_addFinal (m : RawCNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addFinal s).WF := by
  constructor <;> intros <;> simp_all [RawCNFA.addFinal, RawCNFA.WF] <;> aesop

@[simp, aesop 50% unsafe]
lemma states_addInitial (m : RawCNFA A) (s' : State) :
    (m.addInitial s').states = m.states := by
  simp_all [RawCNFA.addInitial, RawCNFA.states]

@[simp, aesop 50% unsafe]
lemma states_addFinal (m : RawCNFA A) (s' : State) :
    (m.addFinal s').states = m.states := by
  simp_all [RawCNFA.addFinal, RawCNFA.states]

@[simp, aesop 50% unsafe]
lemma states_addTrans (m : RawCNFA A) (a : A) (s1 s2 : State) :
    (m.addTrans a s1 s2).states = m.states := by
  simp_all [RawCNFA.addTrans, RawCNFA.states]

@[simp, aesop 50% unsafe]
lemma mem_states_newState (m : RawCNFA A) (s : State) (hin : s ∈ m.states) :
    s ∈ m.newState.2.states := by
  simp_all [RawCNFA.newState, RawCNFA.states]; omega

@[simp, aesop 50% unsafe]
lemma states_newState (m : RawCNFA A) :
    m.newState.2.states = m.states ∪ { m.stateMax } := by
  simp_all [RawCNFA.newState, RawCNFA.states, Finset.range_add]

@[simp, aesop 50% unsafe]
lemma newState_eq (m : RawCNFA A) :
    m.newState.1 = m.stateMax := by
  simp_all [RawCNFA.newState, RawCNFA.states, Finset.range_add]

@[simp, aesop 50% unsafe]
lemma mem_states_newState_self (m : RawCNFA A) :
    m.newState.1 ∈ m.newState.2.states := by
  simp_all [RawCNFA.newState, RawCNFA.states]

@[simp, aesop 50% unsafe]
lemma wf_addTrans [LawfulBEq A] (m : RawCNFA A) (hwf : m.WF) s a s' (hin : s ∈ m.states) (hin' : s' ∈ m.states) :
    (m.addTrans a s s').WF := by
  constructor <;> simp_all [RawCNFA.addTrans, RawCNFA.WF]
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

instance RawCNFA_Inhabited : Inhabited (RawCNFA A) where
  default := RawCNFA.empty

end basics

-- A generic function to define automata constructions using worklist algorithms
section worklist

variable (A : Type) [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable (S : Type) [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

structure worklist.St where
  m : RawCNFA A
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
      intro hc;
      apply st.worklist_incl at hc; simp at hc; apply Std.HashMap.get?_none_not_mem at heq; contradiction
    have worklist_incl : ∀ sa ∈ worklist, sa ∈ map := by
      simp [worklist, map]; intros sa' hin; apply Array.mem_push at hin; rcases hin with hin | heq
      { apply st.worklist_incl at hin; aesop }
      { aesop }
    let st' := { st with m, map, worklist, worklist_nodup, worklist_incl }
    (s, st')

seal worklist.St.addOrCreateState

omit [Fintype S] [LawfulBEq A] in
lemma addOrCreate_preserves_map (st : worklist.St A S) (final? : Bool) (sa sa' : S) :
    let (_, st') := st.addOrCreateState _ _  final? sa'
    st.map[sa]? = some s →
    st'.map[sa]? = some s := by
  simp_all [worklist.St.addOrCreateState]; intros hmap
  split; simp_all
  dsimp only
  simp_all [Std.HashMap.getElem?_insert]
  rintro rfl; simp_all

omit [Fintype S] [DecidableEq S] [LawfulBEq A] in
lemma addOrCreateState_preserves_mem (st : worklist.St A S) (final? : Bool) (sa sa' : S) :
    let (_, st') := st.addOrCreateState _ _  final? sa'
    sa ∈ st.map →
    sa ∈ st'.map := by
  simp_all [worklist.St.addOrCreateState]; intros hmap
  split; simp_all
  dsimp only
  simp_all [Std.HashMap.getElem?_insert]

omit [Fintype S] [DecidableEq S] [LawfulBEq A] in
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

omit [Fintype S] [LawfulBEq A] in
lemma processOneElem_preserves_map (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s s' : State) :
    let st' := processOneElem _ _  final s st (a, sa')
    st.map[sa]? = some s' →
    st'.map[sa]? = some s' := by
  -- TODO: simp [processOneElem, addOrCreate_preserves_map] used to close the goal
  simp [processOneElem]
  intros h
  rw [addOrCreate_preserves_map]
  assumption


omit [Fintype S] [DecidableEq S] [LawfulBEq A] in
lemma processOneElem_preserves_mem (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s : State) :
    let st' := processOneElem _ _  final s st (a, sa')
    sa ∈ st.map →
    sa ∈ st'.map := by
  simp [processOneElem]
  intros h
  apply addOrCreateState_preserves_mem
  assumption

omit [Fintype S] [DecidableEq S] [LawfulBEq A] in
theorem processOneElem_grow (st : worklist.St A S) (final : S → Bool) (a : A) (sa' : S) (s : State) :
      let st' := processOneElem _ _ final s st (a, sa')
      ∃ sas, List.Perm st'.map.keys (sas ++ st.map.keys) ∧ st'.worklist.toList = st.worklist.toList ++ sas := by
  simp [processOneElem]
  have h := addOrCreateState_grow _ _ st (final sa') sa'
  rcases heq : (worklist.St.addOrCreateState A S st (final ↑sa') sa') with ⟨x, st'⟩
  simp [heq] at h
  rcases h with ⟨sas, h1, h2⟩
  use sas

def worklist.initState (inits : Array S) (hinits : inits.toList.Nodup) (final? : S → Bool) : worklist.St A S :=
  let m := RawCNFA.empty (A := A)
  let mapm := inits.foldl (init := (Std.HashMap.empty, m)) fun (map, m) sa =>
    let (s, m) := m.newState
    let m := m.addInitial s
    let m := if final? sa then m.addFinal s else m
    (map.insert sa s, m)
  let map := mapm.1
  let m := mapm.2
  let worklist_incl : ∀ sa ∈ inits, sa ∈ map := by
    let mot (n : ℕ) (mapm : Std.HashMap S State × RawCNFA A) : Prop :=
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

def worklistRun' (final : S → Bool) (inits : Array S) (hinits : inits.toList.Nodup) (f : S → Array (A × S)) : RawCNFA A :=
  let st0 := worklist.initState _ _ inits hinits final
  go st0
where go (st0 : worklist.St A S) : RawCNFA A :=
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
        { simp_all }
        apply Finset.card_lt_card
        simp [worklist.St.meas, Finset.ssubset_iff, Finset.subset_iff]
        use sa
        simp [sa?] at heq'
        constructor
        { constructor
          { apply Array.back?_mem at heq'; apply st0.worklist_incl; assumption }
          { apply Array.not_elem_back_pop at heq' <;> simp_all [Array.pop, wl] } }
        constructor
        { right; apply Array.back?_mem at heq'; assumption }
        rintro sa hh; rcases hh with hnin | hin
        { simp [hnin] }
        right
        exact Array.mem_of_mem_pop st0.worklist sa hin
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
        rcases hin with ⟨hin⟩; simp_all
      have : st2.meas < st0.meas := by omega
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  termination_by st0.meas

def worklistRun (final : S → Bool) (inits : Array S)
    (hinits : inits.toList.Nodup) (f : S → Array (BitVec n × S)) : CNFA n :=
  ⟨worklistRun' _ S final inits hinits f, by sorry⟩

-- Correctness of the algorithm
variable (final : S → Bool) (f : S → Array (A × S)) (inits : Array S)
variable (M : NFA A σ)
variable (corr : S → σ)
variable (corr_inj : Function.Injective corr)
variable (final_corr : ∀ (s : S), final s ↔ corr s ∈ M.accept)
variable (hinit₁ : ∀ sa ∈ inits, corr sa ∈ M.start)
variable (hinit₂ : ∀ q ∈  M.start, ∃ sa, corr sa = q ∧ sa ∈ inits)
variable (hf₁: ∀ sa q' a, q' ∈ M.step (corr sa) a → ∃ sa', corr sa' = q' ∧ (a, sa') ∈ f sa)
variable (hf₂: ∀ sa a sa', (a, sa') ∈ f sa → corr sa' ∈ M.step (corr sa) a)

def worklist.St.visited (st : worklist.St A S) : Set S := { s : S | s ∈ st.map ∧ s ∉ st.worklist }

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma addOrCreateElem_visited final? (st : worklist.St A S) sa :
    st.addOrCreateState _ _ final? sa |>.2.visited = st.visited := by
  simp [worklist.St.visited, worklist.St.addOrCreateState]
  ext sa'
  split; simp
  simp; constructor <;> simp
  · rintro ⟨rfl | h⟩ hnin
    · exfalso; apply hnin; apply Array.mem_push_self
    · constructor; assumption; intros hin; apply hnin; apply Array.push_incl sa hin
  · rintro hin hnin; constructor
    · right; assumption
    · intros hc; apply Array.mem_push at hc
      rcases hc
      · simp_all
      · subst_eqs
        suffices _ : sa ∉ st.map by simp_all
        apply Std.HashMap.get?_none_not_mem; assumption

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_visited (st : worklist.St A S) :
    let st' := processOneElem _ _  final s st (a, sa')
    st'.visited = st.visited := by
  intros st'
  rw [←addOrCreateElem_visited _ _ (final sa') st sa']
  simp [st', processOneElem, worklist.St.visited]

def worklist.St.R (st : worklist.St A S) : Set σ := { q : σ | ∃ sa ∈ st.visited, corr sa = q }

structure StInv (T : Set (S × A × S)) (st : worklist.St A S) where
  wf : st.m.WF
  map_states : ∀ (sa : S) s, st.map[sa]? = some s → s ∈ st.m.states
  map_surj : ∀ s : st.m.states, ∃ (sa : S), st.map[sa]? = some s.val
  map_inj : ∀ (s : st.m.states) (sa sa' : S), st.map[sa]? = some s.val → st.map[sa']? = some s.val → sa = sa'
  frontier : ∀ sa a q', sa ∈ st.visited → q' ∈ M.step (corr sa) a →
               ∃ sa', corr sa' = q' ∧ (sa' ∈ st.map ∨ (sa, a, sa') ∈ T)

attribute [simp] StInv.wf StInv.map_states StInv.map_surj StInv.frontier

-- is there a better way?
local notation "StInv'" => StInv A S M corr

-- We make a map from the (nat) states of the automaton to the
-- abstract states using the axiom of choice applied to the
-- property `StInv.map_surj`
noncomputable def StInv.mFun (inv : StInv A S M corr T st) : st.m.states → S :=
  Classical.choose $ Classical.axiomOfChoice inv.map_surj

omit [Fintype S] [LawfulBEq S] [DecidableEq S] [LawfulBEq A] in
lemma StInv.mFun_spec (inv : StInv' T st) (s : st.m.states) : st.map[inv.mFun _ _ _ _ s]? = some s := by
  simp [StInv.mFun]
  apply Classical.choose_spec (Classical.axiomOfChoice inv.map_surj)

omit [Fintype S] [LawfulBEq S] [DecidableEq S] [LawfulBEq A] in
lemma StInv.mFun_eq (inv : StInv' T st) (s : st.m.states) (sa : S) :
    st.map[sa]? = some s → sa = inv.mFun _ _ _ _ s := by
  intros heq; apply inv.map_inj
  · exact heq
  · apply inv.mFun_spec

omit [Fintype S] [LawfulBEq S] [DecidableEq S] [LawfulBEq A] in
lemma StInv.mFun_inj (inv : StInv' T st) (s s' : st.m.states) :
    inv.mFun _ _ _ _ s  = inv.mFun _ _ _ _ s' → s.val = s'.val := by
  intros heq
  have h1 := inv.mFun_spec _ _ _ _ s
  have h2 := inv.mFun_spec _ _ _ _ s'
  rcases s; rcases s'
  simp_all

omit [Fintype S] [LawfulBEq S] [DecidableEq S] [LawfulBEq A] in
lemma StInv.mFun_inj' (inv : StInv' T st) : Function.Injective (inv.mFun _ _ _ _) := by
  rintro ⟨s1, hs1⟩ ⟨s2, hs2⟩ heq; simp
  apply inv.mFun_inj _ _ _ _ ⟨s1, hs1⟩ ⟨s2, hs2⟩ heq

omit [Fintype S] [DecidableEq S] [LawfulBEq A] in
lemma mFun_mem (inv : StInv' T st) (s : st.m.states) : inv.mFun _ _ _ _ s ∈ st.map :=
  Std.HashMap.mem_of_get? (inv.mFun_spec _ _ _ _ s)

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
lemma processOneElem_mem_states (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
    s ∈ (processOneElem A S final s st (a, sa)).m.states →
    s ∈ st.m.states ∨ s = st.m.stateMax := by
  simp [processOneElem_states]; split <;> simp_all

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_map (st : worklist.St A S) (final : S → Bool) (a : A) (sa sa' : S) (s : State) :
  (processOneElem A S final s st (a, sa)).map[sa']? =
    match st.map[sa']? with
    | some s => some s
    | none => if sa = sa' then some st.m.stateMax else none := by
  simp [processOneElem, worklist.St.addOrCreateState]
  split
  next s' heq =>
    dsimp
    split <;> simp_all
    split <;> simp_all
  next heq =>
    dsimp; split <;> (rw [Std.HashMap.getElem?_insert]; split <;> simp_all)

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_new_map (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
  (processOneElem A S final s st (a, sa)).map[sa]? =
    match st.map[sa]? with
    | some s => some s
    | none => some st.m.stateMax := by
  simp [processOneElem_map]

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_initials (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
    (processOneElem A S final s st (a, sa)).m.initials = st.m.initials := by
  simp [processOneElem, worklist.St.addOrCreateState, RawCNFA.addTrans, RawCNFA.newState, RawCNFA.addFinal]
  split
  · dsimp
  · split <;> dsimp

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
    simp [RawCNFA.addTrans]
  next heq =>
    dsimp
    have _ := Std.HashMap.get?_none_not_mem heq
    split
    { simp_all [RawCNFA.newState, RawCNFA.addTrans, RawCNFA.addFinal] }
    { simp_all [RawCNFA.newState, RawCNFA.addTrans] }

omit [Fintype S] [DecidableEq S] in
lemma processOneElem_trans (st : worklist.St A S) (final : S → Bool) (a b : A) (sa : S) (s s' : State) :
    if a = b ∧ s = s' then
      ∃ ssa, (processOneElem A S final s st (a, sa)).map[sa]? = some ssa ∧
        (processOneElem A S final s st (a, sa)).m.trans.getD (s', b) ∅ =
        (st.m.trans.getD (s, a) ∅ |>.insert ssa)
    else
      (processOneElem A S final s st (a, sa)).m.trans.getD (s', b) ∅ =
        st.m.trans.getD (s', b) ∅ := by
  simp [processOneElem, worklist.St.addOrCreateState]
  split
  next _ =>
    casesm _ ∧ _; subst_eqs
    dsimp
    split
    next s'' heq =>
      use s''; constructor; assumption
      have _ := Std.HashMap.mem_of_get? heq
      simp [RawCNFA.addTrans]
    next heq =>
      use st.m.stateMax
      simp
      split_ifs <;> simp_all [RawCNFA.addFinal, RawCNFA.addTrans, RawCNFA.newState]
  next heq =>
    dsimp
    split
    { simp_all [RawCNFA.newState, RawCNFA.addTrans, RawCNFA.addFinal, Std.HashMap.getD_insert]; aesop }
    { simp_all [RawCNFA.newState, RawCNFA.addTrans, RawCNFA.addFinal, Std.HashMap.getD_insert]
      split; simp_all; split <;> simp }

omit [Fintype S] [DecidableEq S] in
lemma processOneElem_trans_preserved (st : worklist.St A S) (final : S → Bool) (a b : A) (sa : S) (s s1 s2 : State) :
    s2 ∈ st.m.trans.getD (s1, b) ∅ →
    s2 ∈ (processOneElem A S final s st (a, sa)).m.trans.getD (s1, b) ∅ := by
  have h := processOneElem_trans _ _ st final a b sa s s1
  split_ifs at h
  · obtain ⟨_, _, h2⟩ := h
    simp_all
  · simp_all

noncomputable def StInv.fun (inv : StInv' T st) : st.m.states → σ := corr ∘ inv.mFun

-- why is it needed?
include corr_inj in
omit [LawfulBEq A] [Fintype S] [LawfulBEq S] [DecidableEq S] in
lemma StInv.fun_inj (inv : StInv' T st) :
    Function.Injective (inv.fun _ _ _ _) := by
  simp [StInv.fun]
  rw [Function.Injective.of_comp_iff]
  · apply mFun_inj'
  · exact corr_inj

abbrev StInv.sim {st : worklist.St A S} (inv : StInv' T st) :=
  st.m.SimUnpacked M (st.R A S corr) {(q, a, q') | ∃ sa sa', (sa, a, sa') ∈ T ∧ corr sa = q ∧ corr sa' = q' } (inv.fun A S M corr)

def processOneElem_mot (s : State) (sa : S) (n : ℕ) (st : worklist.St A S) : Prop :=
  st.map[sa]? = some s ∧
  sa ∈ st.visited ∧
  ∃ (inv : StInv A S M corr st (T := {(sa1, a, sa') | sa1 = sa ∧ ∃ k ≥ n, (f sa)[k]? = some (a, sa') })),
    inv.sim A S M corr

def processOneElem_inv {st : worklist.St A S} (s : State) (sa : S) (k : ℕ) :
    ∀ a sa', (f sa)[k]? = some (a, sa') →
    processOneElem_mot A S f M corr s sa k st →
    StInv' {(sa1, a, sa') | sa1 = sa ∧ ∃ k' ≥ k + 1, (f sa)[k']? = some (a, sa')} (processOneElem A S final s st (a, sa')) := by
  rintro a sa' hf ⟨hmap, hvisited, inv, hsim⟩
  have hmem : ∀ s (sa : S), st.map[sa]? = some s → s ∈ st.m.states := by intros; apply inv.map_states; assumption
  have _ : st.m.WF := by apply inv.wf
  constructor
  { simp only [processOneElem, worklist.St.addOrCreateState]
    split
    · apply wf_addTrans
      · assumption
      · apply hmem <;> assumption
      · apply hmem <;> assumption
    · split
      · apply wf_addTrans
        · simp; apply wf_addFinal
          · apply wf_newState st.m (by assumption)
          · apply mem_states_newState_self
        · simp only [states_addFinal, states_newState, Finset.mem_union, Finset.mem_singleton]; left; apply hmem <;> assumption
        · simp
      · apply wf_addTrans
        · simp; apply wf_newState; assumption
        · simp; left; apply hmem <;> assumption
        · simp }
  { simp only [processOneElem, worklist.St.addOrCreateState]; split
    { simp; intros; apply hmem <;> assumption }
    { dsimp only; intros sa s hin
      by_cases hnew? : sa' = sa
      { subst_eqs; simp at hin; subst_eqs; split <;> simp }
      { have _ : s ∈ st.m.states := by rw [Std.HashMap.getElem?_insert] at hin; simp_all; apply hmem <;> assumption
        split <;> simp <;> left <;> assumption } } }
  { simp only [processOneElem, worklist.St.addOrCreateState]; split
    { simp; intros s hs; apply inv.map_surj ⟨s, hs⟩ }
    { simp; intros s' hs'
      have hs' : s' ∈ st.m.newState.2.states := by split at hs' <;> simp_all [hs']
      simp at hs'
      rcases hs' with hold | rfl
      { obtain ⟨sa, hsa⟩ := inv.map_surj ⟨_, hold⟩; use sa
        rw [Std.HashMap.getElem?_insert]
        simp_all; rintro rfl; simp_all }
      { use sa'; simp_all } } }
  { rintro ⟨s', hs'⟩ sa1 sa2
    rw [processOneElem_map]
    rw [processOneElem_map]
    split <;> split
    · rintro heq1 heq2; subst_eqs
      have hs'' : s' ∈ st.m.states := by apply hmem s' sa1 (by assumption)
      apply inv.map_inj ⟨s', hs''⟩ <;> simp_all
    · rintro heq1; split <;> rintro heq2 <;> subst_eqs
      exfalso
      suffices hccl : st.m.stateMax < st.m.stateMax by simp_all
      apply st.m.states_lt
      exact hmem st.m.stateMax sa1 (by assumption)
    · rintro heq1; split <;> rintro heq2 <;> try split at heq2 <;> subst_eqs <;> try rfl
      exfalso; subst_eqs
      suffices hccl : st.m.stateMax < st.m.stateMax by simp_all
      apply st.m.states_lt
      exact hmem st.m.stateMax sa2 (by assumption)
    · simp }
  { intros sa' a q' hsa' hq'
    rw [processOneElem_visited] at hsa'
    obtain ⟨sa', h1, h2⟩ := inv.frontier sa' a q' (by simp_all [worklist.St.visited]) hq'
    use sa'; constructor; assumption
    rcases h2 with h2 | ⟨rfl, k', hk', h2⟩
    { left; apply processOneElem_preserves_mem; assumption }
    by_cases hkeq : k' = k
    on_goal 2 => right; dsimp; constructor; rfl; use k'; constructor; omega; assumption
    subst_eqs; left
    simp only [processOneElem, worklist.St.addOrCreateState]
    split; on_goal 2 => simp_all
    next _ _ heq =>
      simp_all; rw [h2] at *; casesm* _ ∧ _ ; injections; subst_eqs
      apply Std.HashMap.mem_of_get?; simp_all; rfl }

seal GetElem.getElem in
seal GetElem?.getElem? in

set_option debug.skipKernelTC true in -- deterministic timeout
def processOneElem_spec {st : worklist.St A S} (s : State) (sa : S) (k : ℕ) :
    ∀ a sa', (f sa)[k]? = some (a, sa') →
    processOneElem_mot A S f M corr s sa k st →
    processOneElem_mot A S f M corr s sa (k+1) (processOneElem A S final s st (a, sa')) := by
  intro a sa' hf ⟨hmap, hvisited, inv, hsim⟩
  have hmem : ∀ s (sa : S), st.map[sa]? = some s → s ∈ st.m.states := by intros; apply inv.map_states; assumption
  -- have hs : s ∈ st.m.states := by apply inv.map_states; assumption
  have _ : st.m.WF := by apply inv.wf
  have inv' := processOneElem_inv A S final f M corr s sa k a sa' hf ⟨hmap, hvisited, inv, hsim⟩
  have hmfun s' hs hs' : inv.mFun _ _ _ _ ⟨s', hs⟩ = inv'.mFun _ _ _ _ ⟨s', hs'⟩ := by
    have h1 := inv.mFun_spec _ _ _ _ ⟨s', hs⟩
    have h2 := inv'.mFun_spec _ _ _ _ ⟨s', hs'⟩
    apply inv'.map_inj ⟨s', hs'⟩
    · apply processOneElem_preserves_map
      exact h1
    · apply h2
  have hfun s' hs hs' : inv.fun _ _ _ _ ⟨s', hs⟩ = inv'.fun _ _ _ _ ⟨s', hs'⟩:= by
    simp [StInv.fun]; rw [hmfun]
  unfold processOneElem_mot
  constructor
  (rw [processOneElem_preserves_map]; assumption)
  constructor
  (rw [processOneElem_visited]; exact hvisited)
  use inv'; constructor
  { exact StInv.fun_inj A S M corr corr_inj inv' }
  { exact hsim.reduced }
  { rw [processOneElem_finals]
    rintro ⟨sa1, hsa1⟩
    rw [processOneElem_states] at hsa1
    split_ifs with hcond
    { split_ifs at hsa1; simp_all
      simp at hsa1; rcases hsa1 with hsa1 | rfl
      · have hneq : sa1 ≠ st.m.stateMax := by rintro rfl; simp [RawCNFA.states] at hsa1
        rw [Std.HashSet.mem_insert]; constructor
        · rintro (hc | hfin)
          dsimp at hc; exfalso; simp at hneq hc; rw [hc] at hneq; simp at hneq
          apply hsim.accept ⟨_, hsa1⟩ |>.mp at hfin
          rw [←hfun]; exact hfin
        · intros hin; rw [←hfun _ hsa1] at hin; apply hsim.accept _ |>.mpr at hin
          right; trivial
      · constructor
        · intros; rcases hcond with ⟨_, hfinal⟩
          apply final_corr _ |>.mp at hfinal
          unfold StInv.fun
          convert hfinal
          dsimp; congr; symm; apply inv'.mFun_eq; dsimp
          have hn : st.map[sa']? = none := by apply Std.HashMap.getElem?_eq_none; assumption
          rw [processOneElem_new_map, hn]
        · intros _; exact Std.HashSet.mem_insert_self }
    { simp at hcond
      split_ifs at hsa1
      { rw [hsim.accept ⟨_, hsa1⟩, ←hfun] }
      { simp at hsa1; rcases hsa1 with hsa1 | rfl
        · rw [hsim.accept ⟨_, hsa1⟩, ←hfun]
        · constructor
          · simp; intros hc; exfalso; apply inv.wf.finals_lt at hc; simp at hc
          · intros hacc; apply final_corr _ |>.mpr at hacc
            suffices hc' : final sa' = true by
              specialize hcond (by assumption)
              exfalso; rw [←Bool.false_eq_true]
              rw [←hc', ←hcond]
            convert hacc
            apply inv'.mFun_eq
            have hn : st.map[sa']? = none := by apply Std.HashMap.getElem?_eq_none; assumption
            rw [processOneElem_new_map, hn]; simp } } }
  { rintro ⟨s', hs'⟩; rw [processOneElem_initials];
    rw [processOneElem_states] at hs'
    have hin : s' ∈ st.m.newState.2.states := by
      split at hs'; exact hs'; simp; left; exact hs'
    simp at hin; rcases hin with hin | rfl
    · rw [←hfun _ hin]; rw [hsim.initial ⟨s', hin⟩]
    · constructor
      · intros h; apply inv.wf.initials_lt at h; simp at h
      · intros h; obtain ⟨s', hs', hinit⟩ := hsim.initial_all _ h
        rw [hfun _ _ (by rw [processOneElem_states]; split <;> simp)] at hs'
        apply corr_inj at hs'
        convert hinit using 1
        symm; apply inv'.mFun_inj _ _ _ _ _ _ hs' }
  { intros q hq; obtain ⟨s', hs', hin⟩ := hsim.initial_all q hq
    use ⟨s', by simp [processOneElem_states]; split <;> simp⟩
    rcases s' with ⟨s', hs''⟩
    rw [←hfun _ hs'', processOneElem_initials]; dsimp; simp_all only [ge_iff_le, and_self] }
  { rintro ⟨s', hs'⟩ b q' hq' hR hT
    apply processOneElem_mem_states _ _ _ _ a at hs'
    rcases hs' with hs' | rfl
    on_goal 2 => {
      obtain ⟨sa', hvis, hcorr⟩ := hR
      simp [processOneElem_visited] at hvis
      apply corr_inj at hcorr; subst hcorr
      rcases hvis with ⟨hmap, hwl⟩
      obtain hmap' := inv'.mFun_spec _ _ _ _ ⟨_, hs'⟩; dsimp at hmap'
      obtain ⟨s'', hs''⟩ := Std.HashMap.mem_iff_getElem?.mp hmap
      obtain rfl : s'' = st.m.stateMax := by
        apply processOneElem_preserves_map at hs''
        rw [hs''] at hmap'
        injection hmap'
      apply inv.map_states at hs''
      simp [hs'', RawCNFA.states] at hs''
    }
    obtain hT' | hsame :
       (StInv.fun A S M corr inv' ⟨s', _⟩, b, q') ∉ {(q, a, q') | ∃ sa_1 sa',
          (sa_1, a, sa') ∈ {(sa1, a, sa') | sa1 = sa ∧ ∃ k_1 ≥ k, (f sa)[k_1]? = some (a, sa')} ∧ corr sa_1 = q ∧ corr sa' = q'} ∨
        (StInv.fun A S M corr inv' ⟨s', _⟩ = corr sa ∧ b = a ∧ corr sa' = q') := by
      simp at hT
      by_cases h : StInv.fun A S M corr inv' ⟨s', by assumption⟩ = corr sa ∧ b = a ∧ corr sa' = q'
      · right; assumption
      · left; simp; rintro s1 s2 rfl k1 hk1 hfk1 hcorr rfl
        simp only [ge_iff_le, Prod.mk.eta, not_and] at h
        specialize h (by symm; apply hcorr)
        by_cases heq : k = k1
        · subst heq; rw [hfk1] at hf; injection hf with heq; simp at heq
          obtain ⟨rfl, rfl⟩ := heq
          apply h rfl rfl
        · apply hT s1 _ (by rfl) k1 (by omega) hfk1 hcorr rfl
    · -- old
      have hR' : StInv.fun A S M corr inv ⟨s', hs'⟩ ∈ worklist.St.R A S corr st := by
        obtain ⟨sa', hvis, hcorr⟩ := hR
        simp [processOneElem_visited] at hvis
        -- apply corr_inj at hcorr; subst hcorr
        dsimp [worklist.St.R]
        use sa'; constructor; assumption
        rw [hcorr]; symm; apply hfun
      rw [←hfun] at hT'
      obtain ⟨⟨s1, hs1⟩, hcorr', htrans⟩ := hsim.trans_match₁ ⟨_, hs'⟩ b q' (by simp_all) hR' hT'
      have hs1_new : s1 ∈ (processOneElem A S final s st (a, sa')).m.states := by
        rw [processOneElem_states]; split <;> simp [hs1]
      use ⟨s1, hs1_new⟩
      constructor
      · rw [←hfun]; assumption
      · apply processOneElem_trans_preserved; assumption
    · -- new
      obtain ⟨h1, h2, h3⟩ := hsame
      subst_eqs
      by_cases heq? : s' = s
      · obtain ⟨sa1, hvis, hcorr⟩ := hR
        apply corr_inj at hcorr
        subst hcorr heq?
        rw [h1] at hq'
        obtain ⟨sa2, hcorr, hnew?⟩ := inv'.frontier sa a (corr sa') (by rw [processOneElem_visited]; assumption) hq'
        apply corr_inj at hcorr; subst hcorr
        simp at hT
        rcases hnew? with hnew | habs
        · obtain ⟨s'', hs''⟩ := Std.HashMap.mem_iff_getElem?.mp hnew
          use ⟨s'', by apply inv'.map_states; assumption ⟩
          constructor
          · unfold StInv.fun; simp; congr; symm; apply inv'.mFun_eq; exact hs''
          · have h := processOneElem_trans _ _ st final a a sa2 s' s'
            simp at h
            rcases h with ⟨ssa, h1, h2⟩
            rw [h2]
            obtain rfl : ssa = s'' := by rw [hs''] at h1; injection h1 with h; exact h.symm
            exact Std.HashSet.mem_insert_self
        · simp at habs; obtain ⟨k', hk', hfk'⟩ := habs
          exfalso; apply hT sa sa2 rfl k' hk' hfk' (by symm; apply h1) rfl
      · have hR' : StInv.fun A S M corr inv ⟨s', hs'⟩ ∈ worklist.St.R A S corr st := by
          obtain ⟨sa', hvis, hcorr⟩ := hR
          simp [processOneElem_visited] at hvis
          -- apply corr_inj at hcorr; subst hcorr
          dsimp [worklist.St.R]
          use sa'; constructor; assumption
          rw [hcorr]; symm; apply hfun
        obtain ⟨⟨s1, hs1⟩, hcorr', htrans⟩ := hsim.trans_match₁ ⟨_, hs'⟩ a (corr sa') (by simp_all) hR' (by
          rintro hc; simp at hc; obtain ⟨sa1, sa2, ⟨rfl, h1⟩, h2, h3⟩ := hc
          apply corr_inj at h3; subst h3
          apply heq?
          suffices hccl : st.map[sa1]? = some s' by simp_all
          apply corr_inj at h1
          rw [←h1, ←hmfun s' (by assumption), inv.mFun_spec]; rfl
        )
        have hs1_new : s1 ∈ (processOneElem A S final s st (a, sa')).m.states := by
          rw [processOneElem_states]; split
          · simp; left; assumption
          · assumption
        use ⟨s1, hs1_new⟩
        constructor
        · rw [←hfun _ hs1, hcorr']
        · apply processOneElem_trans_preserved; assumption }
  { rintro ⟨s', hs'⟩ b s'' hs''
    have h := processOneElem_trans _ _ st final a b sa' s s'
    have hs : s ∈ st.m.states := by apply inv.map_states at hmap; assumption
    have hin := by apply inv'.wf.trans_tgt_lt'; exact hs''
    use hin
    split at h
    next heqs =>
      rcases heqs; subst_eqs
      rcases h with ⟨ssa, hmap, htrans⟩
      rw [htrans] at hs''
      simp at hs''; rcases hs'' with rfl | hs''
      · apply hf₂
        have h1 : StInv.mFun A S M corr inv' ⟨ssa, hin⟩ = sa' := by
          symm; apply inv'.mFun_eq; simp; exact hmap
        have h2 : StInv.mFun A S M corr inv' ⟨s, hs'⟩ = sa := by
          symm; apply inv'.mFun_eq; simp; apply processOneElem_preserves_map; assumption
        rw [h1, h2]
        apply Array.mem_iff_getElem?.mpr; use k
      · have hin' := by apply inv.wf.trans_tgt_lt'; assumption
        have h := hsim.trans_match₂ ⟨s, hs⟩ a s'' hs''
        simp_all only [ge_iff_le, Prod.mk.eta, exists_const]
    next hneq =>
      rw [h] at hs''
      have hin' := by apply inv.wf.trans_tgt_lt'; exact hs''
      have hs' : s' ∈ st.m.states := by
        suffices h : s' < st.m.stateMax by
          unfold RawCNFA.states
          rw [Finset.mem_range]
          exact h
        apply inv.wf.trans_src_lt' _ b
        apply Std.HashMap.mem_iff_getElem?.mpr
        rw [Std.HashMap.getD_eq_getD_getElem?] at hs''
        by_contra hc
        simp at hc
        rcases heq : st.m.trans[(s', b)]?
        · rw [heq] at hs''; simp at hs''
        · apply hc at heq; contradiction
      have h := hsim.trans_match₂ ⟨s', hs'⟩ b s'' hs''
      obtain ⟨hw, h⟩ := h
      rw [←hfun _ hs', ←hfun _ hw]
      exact h }

-- TODO: improve this proof, make it faster
def worklistGo_spec {st : worklist.St A S} (inv : StInv' ∅ st) :
    inv.sim A S M corr →
    (worklistRun'.go A S final f st |>.Sim M) := by
  induction st using worklistRun'.go.induct _ _ final f with
  | case4 st hnemp sa? hsa? => -- trivial case that's impossible
      simp [sa?, Array.back?] at hsa?
      have : st.worklist.size = 0 := by omega
      simp_all only [Array.isEmpty, decide_true, not_true_eq_false]
  | case3 st hnemp sa? sa hsa? wl' st' hc =>
    have h : sa ∈ st.map := by
      apply st.worklist_incl
      simp_all [sa?, Array.back?_mem]
    apply Std.HashMap.getElem?_eq_some_getD (fallback := 0) at h
    simp [st'] at hc
    exfalso; apply (hc _); exact h
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
  | case2 st hnemp sa? sa heq wl' st1 s hs as st2 _ _ _ _ _ ih => -- inductive case, prove the invariant is maintained
    intros hsim; unfold worklistRun'.go; simp_all [sa?]
    split
    next sa' hsome =>
      have _ : sa' = sa := by simp_all
      subst_eqs
      split
      next _ s' hmap =>
        have _ : s' = s := by simp_all
        subst_eqs
        rw [heq] at hsome; subst_eqs
        suffices hccl : processOneElem_mot A S f M corr s sa (f sa).size (Array.foldl (processOneElem A S final s) st1 (f sa)) by
          obtain ⟨_, _, inv', hsim'⟩ := hccl
          simp at inv'
          have hemp : {(sa1, a, sa') | sa1 = sa ∧ ∃ k, (f sa).size ≤ k ∧ (f sa)[k]? = some (a, sa')} = ∅ := by
            ext sa'; simp_all; rintro rfl k hge hsome
            suffices hccl : (f sa'.1)[k]? = none by simp_all
            apply Array.getElem?_size_le; assumption
          simp_all only [ge_iff_le, st2]
        apply Array.foldl_induction
        simp only [st1, wl']
        { unfold processOneElem_mot
          have inv' : StInv' {(sa1, a, sa') | sa1 = sa ∧ ∃ k ≥ 0, (f sa)[k]? = some (a, sa')} st1 := by
            constructor
            { simp [st1]; exact inv.wf }
            { simp [st1]; apply inv.map_states }
            { simp only [st1]; intros a; obtain ⟨sa, hsa⟩ := inv.map_surj a; use sa }
            { simp only [st1]; exact inv.map_inj }
            { simp only [st1, wl', worklist.St.visited]; intros sa' a q' hsa' hq'
              by_cases h : sa' = sa
              { subst h; obtain ⟨sa'', h1, h2⟩ := hf₁ _ _ _ hq'
                use sa''; constructor; assumption; right
                simp; exact Array.getElem?_of_mem h2 }
              { obtain ⟨sa', h1, h2 | himp⟩ := inv.frontier  sa' a q' (by
                  simp [worklist.St.visited]; simp_all
                  intros hc; apply hsa'.2; rw [Array.mem_pop_iff] at hc; simp_all) hq'
                on_goal 2 => simp_all
                use sa'; simp_all } }
          constructor; on_goal 1 => assumption
          have hmfun : inv.mFun _ _ _ _  = inv'.mFun _ _ _ _ := by simp [StInv.mFun]
          have hfun : inv.fun _ _ _ _ = inv'.fun _ _ _ _ := by simp [StInv.fun, hmfun]
          constructor
          { simp [worklist.St.visited]; simp_all; exact Std.HashMap.mem_of_get? hmap }
          use inv'; constructor
          { exact hsim.injective }
          { apply hsim.reduced }
          { apply hsim.accept }
          { apply hsim.initial }
          { apply hsim.initial_all }
          { rintro ⟨s1, hs1⟩ a q' hq' hin hnin
            let sa1 := inv'.mFun _ _ _ _ ⟨s1, hs1⟩
            by_cases hnew? : sa1 = sa
            { exfalso; apply hnin
              apply hf₁ at hq'; obtain ⟨sa', hcorr, hf⟩ := hq'
              use sa, sa'
              split_ands
              · rfl
              · obtain ⟨k, hk⟩ := Array.getElem?_of_mem hf
                use k
                rw [←hnew?]
                simp [hnew?, sa1] at hk ⊢; assumption
              · congr; nth_rw 1 [←hnew?]
              · assumption }
            { rw [←hfun] at *; apply hsim.trans_match₁ <;> try (simp_all; done)
              simp_all only [worklist.St.R, worklist.St.visited]
              obtain ⟨sa2, ⟨h2, h3⟩, h4⟩ := hin
              have heq : sa1 = sa2 := by apply corr_inj; rw [h4]; unfold sa1; rw [←hmfun]; unfold StInv.fun; simp -- TODO
              use sa1; simp_all; intros hc
              have heq : sa1 = sa := by apply Array.mem_pop_iff _ _ |>.mp at hc; simp_all
              simp_all}}
          { apply hsim.trans_match₂ } }
        { intros k st; apply processOneElem_spec A S final f M corr (st := st) corr_inj final_corr hf₂ s sa k
          simp; exact Array.getElem?_lt (f sa) k.isLt }
      next hnone =>
        have hnin : sa ∉ st.map := by
          intros hin
          suffices ex : ∃ s, st.map[sa]? = some s by simp_all
          simp_all
        exfalso; apply hnin; apply st.worklist_incl; exact Array.back_mem st.worklist sa hsome
    next hnone =>
      simp [Array.back?] at *
      have : st.worklist.size = 0 := by omega
      simp_all

def worklistRun'_spec : (worklistRun' A S final inits hinits f |>.Sim M) := by
  unfold worklistRun'
  simp
  have hh : StInv' ∅ (worklist.initState A S inits hinits final) := by
    sorry
  apply worklistGo_spec <;> try assumption
  sorry

end worklist

section worklist_good

variable (S : Type) [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]
variable (final : S → Bool) (f : S → Array (BitVec n × S)) (inits : Array S)
variable (M : NFA' n)
variable (corr : S → M.σ)
variable (corr_inj : Function.Injective corr)
variable (final_corr : ∀ (s : S), final s ↔ corr s ∈ M.M.accept)
variable (hinit₁ : ∀ sa ∈ inits, corr sa ∈ M.M.start)
variable (hinit₂ : ∀ q ∈  M.M.start, ∃ sa, corr sa = q ∧ sa ∈ inits)
variable (hf₁: ∀ sa q' a, q' ∈ M.M.step (corr sa) a → ∃ sa', corr sa' = q' ∧ (a, sa') ∈ f sa)
variable (hf₂: ∀ sa a sa', (a, sa') ∈ f sa → corr sa' ∈ M.M.step (corr sa) a)

def worklistRun_spec : (worklistRun S final inits hinits f |>.Sim M) :=
  worklistRun'_spec (BitVec n) S final f inits M.M corr corr_inj final_corr hf₁ hf₂

end worklist_good


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
