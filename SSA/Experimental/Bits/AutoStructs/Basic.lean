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
-- Maybe we'll need to generalize to a relation at some point?
structure CNFA.Sim' (m : CNFA A) (A : NFA A S) (R : Set S) where
  f : m.states → S
  -- f_inj : Function.Injective f
  accept s : s.val ∈ m.finals ↔ f s ∈ A.accept
  initial s : s.val ∈ m.initials ↔ f s ∈ A.start
  initial_all q : q ∈ A.accept → ∃ s, f s = q ∧ s.val ∈ m.initials
  trans_match s a q' : q' ∈ A.step (f s) a ∧ q' ∈ R → ∃ s', f s' = q ∧ s'.val ∈ m.trans.getD (s.val, a) ∅

abbrev CNFA.Sim (m : CNFA A) (A : NFA A S) := CNFA.Sim' m A ⊤

def NFA.closed_set (M : NFA α σ) (S : Set σ) := M.start ⊆ S ∧ ∀ a, M.stepSet S a ⊆ S

def sim_closed_set (m : CNFA A) (A : NFA A S) (R : Set S) (hcl: A.closed_set R) :
    m.Sim' A R → m.Sim A :=
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

@[simp]
lemma wf_newState (m : CNFA A) (hwf : m.WF) :
    m.newState.2.WF := by
  constructor <;> intros <;> apply Nat.lt_add_one_of_lt <;> simp_all [CNFA.newState, CNFA.WF]
  apply hwf.trans_tgt_lt <;> assumption

@[simp]
lemma wf_addInitial (m : CNFA A) (hwf : m.WF) (hin : s ∈ m.states) :
    (m.addInitial s).WF := by
  constructor <;> intros <;> simp_all [CNFA.addInitial, CNFA.WF]
  { casesm* _ ∨ _ <;> subst_eqs <;> simp_all }
  { apply hwf.trans_tgt_lt <;> assumption }

@[simp]
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

variable (A : Type) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable {S : Type} [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]
variable (stateSpace : Finset S)

abbrev inSS : Type := { sa : S // sa ∈ stateSpace }

private structure worklist.St where
  m : CNFA A
  map : Std.HashMap (inSS stateSpace) State := ∅
  worklist : Array (inSS stateSpace) := ∅
  worklist_nodup : worklist.toList.Nodup
  worklist_incl : ∀ sa ∈ worklist, sa ∈ map

attribute [aesop 10% unsafe] worklist.St.worklist_nodup worklist.St.worklist_incl
attribute [simp] worklist.St.worklist_nodup worklist.St.worklist_incl

private def worklist.St.meas (st : worklist.St A stateSpace) : ℕ :=
  Finset.card $ stateSpace.attach.filter fun x => x ∉ st.map.keys ∨ x ∈ st.worklist.toList


theorem List.perm_subset_iff_right {l1 l2 : List α} (hperm : l1.Perm l2) (l : List α) :
  l ⊆ l1 ↔ l ⊆ l2 := by
  constructor
  { intros hincl x hin; apply List.Perm.mem_iff (a := x) at hperm ; apply hperm.mp; apply hincl; assumption }
  { intros hincl x hin; apply List.Perm.mem_iff (a := x) at hperm ; apply hperm.mpr; apply hincl; assumption }

open List in
private theorem list_perm_trick (x y a b c : List α) :
    y ~ b ++ x → x ~ a ++ c → y ~ a ++ b ++ c := by
  intros h1 h2
  have hi : b ++ x ~ b ++ (a ++ c) := by apply Perm.append_left; assumption
  have := perm_append_comm_assoc b a c
  have := h1.trans (hi.trans this)
  aesop

private def worklist.St.addOrCreateState (st : worklist.St A stateSpace) (final? : Bool) (sa : inSS stateSpace) : State × worklist.St A stateSpace :=
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
      simp [worklist, map]; intros sa' hsa' hin; apply Array.mem_push at hin; rcases hin with hin | heq
      { apply st.worklist_incl at hin; aesop }
      { aesop }
    let st' := { st with m, map, worklist, worklist_nodup, worklist_incl }
    (s, st')

omit [BEq S] [LawfulBEq S] in
theorem addOrCreateState_grow (st : worklist.St A stateSpace) (b : Bool) (sa : inSS stateSpace) :
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

private def processOneElem (final : S → Bool) (s : State) (st : worklist.St A stateSpace) : A × inSS stateSpace → worklist.St A stateSpace :=
  fun (a', sa') =>
    let (s', st') := st.addOrCreateState _ _ (final sa') sa'
    let m := st'.m.addTrans a' s s'
    { st' with m }

omit [BEq S] [LawfulBEq S] in
theorem processOneElem_grow (st : worklist.St A stateSpace) (final : S → Bool) (a : A) (sa' : inSS stateSpace) (s : State) :
      let st' := processOneElem _ _ final s st (a, sa')
      ∃ sas, List.Perm st'.map.keys (sas ++ st.map.keys) ∧ st'.worklist.toList = st.worklist.toList ++ sas := by
  simp [processOneElem]
  have h := addOrCreateState_grow _ _ st (final sa') sa'
  rcases heq : (worklist.St.addOrCreateState A stateSpace st (final ↑sa') sa') with ⟨x, st'⟩
  simp [heq] at h
  rcases h with ⟨sas, h1, h2⟩
  use sas

def worklist.initState (inits : Array $ inSS stateSpace) (hinits : inits.toList.Nodup) : worklist.St A stateSpace :=
  let m := CNFA.empty (A := A)
  let mapm := inits.foldl (init := (Std.HashMap.empty, m)) fun (map, m) sa =>
    let (s, m) := m.newState
    let m := m.addInitial s
    (map.insert sa s, m)
  let map := mapm.1
  let m := mapm.2
  let worklist_incl : ∀ sa ∈ inits, sa ∈ map := by
    let mot (n : ℕ) (mapm : Std.HashMap (inSS stateSpace) State × CNFA A) : Prop :=
      ∀ sa, ∀ k < n, inits[k]? = some sa → sa ∈ mapm.1
    suffices hccl : mot inits.size mapm by
      simp_all [mot]; intros sa hsa hin
      apply Array.getElem_of_mem at hin; rcases hin with ⟨k, hk, heq⟩
      apply hccl _ _ _ hk (by simp_all [Array.getElem?_eq_getElem])
    apply Array.foldl_induction; simp [mot]
    intros i map ih; simp [mot] at ih ⊢
    intros sa hsa k hk hsome
    apply Nat.lt_add_one_iff_lt_or_eq.mp at hk; rcases hk with hk | rfl
    { right; apply ih _ _ _ hk hsome }
    { left; simp_all [Array.getElem?_eq_getElem]  }
  { m, map, worklist := inits, worklist_nodup := hinits, worklist_incl }

def worklistRunAux (final : S → Bool) (f : inSS stateSpace → Array (A × inSS stateSpace)) (inits : Array $ inSS stateSpace) (hinits : inits.toList.Nodup) : CNFA A :=
  let st0 := worklist.initState _ _ inits hinits
  go st0
where go (st0 : worklist.St A stateSpace) : CNFA A :=
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
          let wl' := processOneElem A stateSpace final s st asa
          rcases ih wl' with ⟨sas', h1', h2'⟩; clear ih
          rcases processOneElem_grow _ _ st final asa.1 asa.2 s with ⟨sas, h1, h2⟩
          use (sas ++ sas')
          constructor
          { simp [wl'] at h1'; apply list_perm_trick <;> assumption }
          { simp [wl', h2] at h2'; aesop }
      have hincl : ∀ k, k ∈ st1.map → k ∈ st2.map := by
        intros k; rcases hgrow with ⟨sas, hkeys, -⟩;
        have := @(List.perm_subset_iff_right hkeys st1.map.keys).mpr (by aesop) k; aesop
      have : st1.meas < st0.meas := by
        rcases heq' : sa? with ⟨⟩ | ⟨sa, hsa⟩
        { aesop }
        apply Finset.card_lt_card
        simp [worklist.St.meas, Finset.ssubset_iff, Finset.subset_iff]
        use sa, hsa
        simp [sa?] at heq'
        constructor
        { constructor
          { apply Array.back?_mem at heq'; apply st0.worklist_incl; assumption }
          { apply Array.not_elem_back_pop at heq' <;> simp_all [Array.pop, wl] } }
        constructor
        { right; apply Array.back?_mem at heq'; apply Array.Mem.val; assumption}
        rintro sa hsa hh; rcases hh with hnin | hin
        { simp [hnin] }
        right
        apply List.mem_of_mem_dropLast; assumption
      have : st2.meas ≤ st1.meas := by
        apply Finset.card_le_card
        simp [worklist.St.meas, Finset.subset_iff]
        intros sa' hsa' h
        rcases h with hnin | hin
        { left; simp [st1] at hincl; intros hc; apply hnin; apply hincl; assumption }
        by_cases hnew : ⟨sa', hsa'⟩ ∈ st0.map
        all_goals try (left; trivial)
        right
        simp [st1] at hgrow
        rcases hgrow with ⟨sas, hkeys2, hwl2⟩
        simp [hwl2] at hin
        have hnin : ⟨sa', hsa'⟩ ∉ sas := by
          intros hc
          have hdisj : st0.map.keys.Disjoint sas := by
            have : (sas ++ st0.map.keys).Nodup := by
              apply List.Perm.nodup
              assumption
              apply st2.map.keys_nodup
            simp [List.nodup_append_comm, List.disjoint_of_nodup_append, this]
          aesop
        rcases hin <;> trivial
      have : st2.meas < st0.meas := by omega
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  termination_by st0.meas

def worklistRun (final : S → Bool) (f : S → Array (A × S)) (inits : Array S) (hinits : inits.toList.Nodup)
    (hinits_in : ∀ sa ∈ inits, sa ∈ stateSpace) (hf : ∀ s ∈ stateSpace, f s |>.all fun (_, s') => s' ∈ stateSpace) : CNFA A :=
  let f' := fun ⟨s, hs⟩ => (f s).attach.map fun ⟨⟨a, s'⟩, hin⟩ =>
     (a, ⟨s', Array.all_eq_true_iff_forall_mem.mp (hf s hs) _ hin |> of_decide_eq_true⟩)
  let inits' : Array (inSS stateSpace) := inits.attach.map fun ⟨sa, hsa⟩ => ⟨sa, hinits_in sa hsa⟩
  have hinits' : inits'.toList.Nodup := by
    simp [inits']; apply List.Nodup.map
    · rintro ⟨_, _⟩ ⟨_, _⟩ h; simp_all
    · simp_all [List.attachWith_nodup]
  worklistRunAux _ _ final f' inits' hinits'


-- List.Nodup.map

-- Correctness of the algorithm

variable (final : S → Bool) (f : inSS stateSpace → Array (A × inSS stateSpace)) (init : inSS stateSpace)
variable (A : NFA A σ)
variable (corr : S → σ)
variable (hinit : corr init ∈ A.start)

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
