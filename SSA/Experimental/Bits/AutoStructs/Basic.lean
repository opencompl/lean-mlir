/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashSet
import Std.Data.HashMap
import Std.Data.HashMap.Lemmas
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
structure NFA (A : Type 0) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A] where
  stateMax : State
  initials : Std.HashSet State
  finals : Std.HashSet State
  trans : Std.HashMap (State × A) (Std.HashSet State)
deriving Repr

section basics

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def NFA.empty : NFA A := {
  stateMax := 0
  initials := ∅
  finals := ∅
  trans := ∅
}

def NFA.newState (m : NFA A) : State × NFA A :=
  let old := m.stateMax
  let m := { m with stateMax := old + 1 }
  (old, m)

def NFA.addTrans (m : NFA A) (a : A) (s s' : State) : NFA A :=
  let ns := m.trans.getD (s, a) ∅
  let ns := ns.insert s'
  { m with trans :=  m.trans.insert (s, a) ns }

def NFA.addManyTrans (m : NFA A) (a : List A) (s s' : State) : NFA A :=
  a.foldl (init := m) fun m a => m.addTrans a s s'

def NFA.addInitial (m : NFA A) (s : State) : NFA A :=
  { m with initials := m.initials.insert s }

def NFA.addFinal (m : NFA A) (s : State) : NFA A :=
  { m with finals := m.finals.insert s }

def NFA.transSet (m : NFA A) (ss : Std.HashSet State) (a : A) : Std.HashSet State :=
  ss.fold (init := ∅) fun ss' s =>
    ss'.insertMany $ m.trans.getD (s, a) ∅

instance NFA_Inhabited : Inhabited (NFA A) where
  default := NFA.empty

end basics

-- A generic function to define automata constructions using worklist algorithms
section worklist

variable (A : Type) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable {S : Type} [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]
variable (stateSpace : Finset S)

abbrev inSS : Type := { sa : S // sa ∈ stateSpace }

private structure worklist.St where
  m : NFA A
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

def worklist.initState (init : inSS stateSpace) : worklist.St A stateSpace :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let map : Std.HashMap _ _ := {(init, s)}
  let worklist := Array.singleton init
  { m, map, worklist, worklist_nodup := by simp [worklist], worklist_incl := by simp [map, worklist] }

def worklistRunAux (final : S → Bool) (f : S → Array (A × inSS stateSpace)) (init : inSS stateSpace) : NFA A :=
  let st0 := worklist.initState _ _ init
  go st0
where go (st0 : worklist.St A stateSpace) : NFA A :=
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
          { simp [wl'] at h2'; rw [h2] at h2'; aesop }
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
          { apply Array.not_elem_back_pop at heq'; simp [Array.pop] at heq'; assumption; exact st0.worklist_nodup } }
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
