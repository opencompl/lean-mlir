import SSA.Experimental.Bits.AutoStructs.Basic
import Mathlib.Tactic.LiftLets

section nfa

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable {S : Type} [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

variable (inits : Array S) (final : S → Bool) (f : S → Array (A × S))

def nfa : NFA A S where
  start := { sa | sa ∈ inits }
  accept := { sa | final sa }
  step sa a := { sa' | (a, sa') ∈ f sa }

end nfa

section nfa'

variable {S : Type} [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

variable (inits : Array S) (final : S → Bool) (f : S → Array (BitVec n × S))

def nfa' : NFA' n :=
  { σ := _, M := nfa inits final f }

end nfa'

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
      apply st.worklist_incl at hc;
      apply Std.HashMap.get?_none_not_mem at heq; contradiction
    have worklist_incl : ∀ sa ∈ worklist, sa ∈ map := by
      simp [worklist, map]; intros sa' hin; rcases hin with hin | heq
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
  simp [Std.HashMap.getElem?_insert, *]
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
          { apply Array.mem_of_back? at heq'; apply st0.worklist_incl; assumption }
          { apply Array.not_elem_back_pop at heq' <;> simp_all +zetaDelta [Array.pop, wl] } }
        constructor
        { right; apply Array.mem_of_back? at heq'; assumption }
        rintro sa hh; rcases hh with hnin | hin
        { simp +zetaDelta [hnin] }
        right
        exact Array.mem_of_mem_pop st0.worklist sa hin
      have : st2.meas ≤ st1.meas := by
        apply Finset.card_le_card
        simp +zetaDelta [worklist.St.meas, Finset.subset_iff]
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
          { simp_all [Std.HashMap.mem_keys]; apply hnew }
          { apply hc }
        rcases hin with ⟨hin⟩; simp_all +zetaDelta
      have : st2.meas < st0.meas := by omega
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  termination_by st0.meas

def worklist.St.visited (st : worklist.St A S) : Set S := { s : S | s ∈ st.map ∧ s ∉ st.worklist }

structure StInv (m : RawCNFA A) (map : Std.HashMap S State) where
  wf : m.WF
  map_states : ∀ (sa : S) s, map[sa]? = some s → s ∈ m.states
  map_surj : ∀ s : m.states, ∃ (sa : S), map[sa]? = some s.val
  map_inj : ∀ {s} {sa sa' : S}, map[sa]? = some s → map[sa']? = some s → sa = sa'

attribute [simp] StInv.wf StInv.map_states StInv.map_surj

def worklistRun_init_post (inits : Array S) (final : S → Bool)
    (map : Std.HashMap S State) (m : RawCNFA A) :=
  (forall sa, sa ∈ map ↔ sa ∈ inits) ∧
  m.trans = ∅ ∧
  ∀ sa s, map[sa]? = some s → (s ∈ m.initials) ∧ (s ∈ m.finals ↔ final sa)

set_option maxHeartbeats 1000000 in
omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma worklistRun'_init_wf inits hinits final? :
    let st := worklist.initState A S inits hinits final?
    (StInv A S st.m st.map ∧ worklistRun_init_post A S inits final? st.map st.m) := by
  unfold worklist.initState
  lift_lets
  intros m0 mapm
  let motive := λ (k : Nat) (x : Std.HashMap S State × RawCNFA A) =>
                  (StInv A S x.2 x.1 ∧ worklistRun_init_post _ _ (inits.take k) final? x.1 x.2)
  suffices _ : motive (inits.size) mapm by
    simp_all [motive]
  apply Array.foldl_induction
  · simp [motive, worklistRun_init_post, m0, RawCNFA.states, StInv]; constructor
    · constructor <;> simp
    · simp [RawCNFA.empty]
  · rintro i ⟨map, m⟩ ⟨⟨hwf, hst, hsurj, hinj⟩, hmi, htr, hif⟩
    simp -zeta
    lift_lets
    intros m1 m2
    have hm1 : m1.WF := by
      simp [m1]
      apply wf_addInitial
      · apply wf_newState; assumption
      · simp
    have hm2 : m2.WF := by
      simp [m2]; split
      · apply wf_addFinal; assumption; simp [m1]
      · assumption
    have hst' : ∀ (sa : S) s, map[sa]? = some s → s ∈ m1.states := by
      intros sa s hmap; simp [m1]; left
      apply hst _ _ hmap
    have hst' : ∀ (sa : S) s, map[sa]? = some s → s ∈ m2.states := by
      intros sa s hmap; simp [m2]; split <;> apply hst' _ _ hmap
    have hnew : ∀ sa, sa ∈ map → inits[i] ≠ sa := by
      rintro sa hin rfl; simp_all
      rw [Array.mem_take_iff_getElem?] at hin
      rcases hin with ⟨k, hki, hk⟩
      simp only [←Array.getElem?_eq_getElem i.isLt] at hk
      apply Array.nodup_iff_getElem?_ne_getElem?.mp hinits at hk; trivial; assumption; exact i.isLt
    have hsts : m2.states = m.states ∪ {m.stateMax} := by
      simp [m2, m1]; split; simp; rw [states_addInitial]; simp
    simp [motive]; constructor; constructor
    · assumption
    · intros sa s hmap
      rw [Std.HashMap.getElem?_insert] at hmap
      split at hmap
      · simp_all
      · apply hst' _ _ hmap
    · rw [hsts]; simp; rintro s hin
      by_cases heq : s = m.stateMax
      · use inits[i]; rw [heq]
        exact Std.HashMap.getElem?_insert_self
      · have hin : s ∈ m.states := by simp_all
        obtain ⟨sa, hsa⟩ := hsurj ⟨_, hin⟩; use sa
        specialize hst sa s hsa
        rw [Std.HashMap.getElem?_insert]; split_ifs with hcond
        · simp only [beq_iff_eq, motive, m1, m2, m0] at hcond
          specialize hnew sa (Std.HashMap.mem_of_getElem? hsa) hcond
          contradiction
        · assumption
    · rintro s sa sa' hsa hsa'
      have hs : s ∈ m.states ∪ {m.stateMax} := by
        rw [Std.HashMap.getElem?_insert] at hsa
        split_ifs at hsa
        · simp at hsa; simp [hsa]
        · apply hst at hsa; simp [hsa]
      simp [hsts] at hs; rcases hs with hs | rfl
      · have _ : m.stateMax ≠ s := by
          rintro rfl; simp [RawCNFA.states] at hs
        rw [Std.HashMap.getElem?_insert] at hsa hsa'
        split at hsa <;> split at hsa' <;> try simp at hsa hsa' <;> try contradiction
        simp only [Subtype.forall] at hinj
        apply hinj hsa hsa'
      · rw [Std.HashMap.getElem?_insert] at hsa hsa'
        have himp : ∀ (sa : S), map[sa]? ≠ some m.stateMax := by
          rintro sa hc; apply hst at hc; simp [RawCNFA.states] at hc
        split at hsa <;> split at hsa' <;> try simp at hsa hsa'
        · simp_all
        · exfalso; apply himp; assumption
        · exfalso; apply himp; assumption
        · exfalso; apply himp; assumption
    split_ands
    · rintro s; simp [Array.mem_take_get_succ, ←hmi]
    · simp [m2, m1, RawCNFA.addInitial, RawCNFA.addFinal, RawCNFA.newState]
      split <;> simp [htr] <;> assumption
    · rintro sa s hmap
      rw [Std.HashMap.getElem?_insert] at hmap; split at hmap
      next heq =>
        simp at hmap heq; subst_vars
        simp [m2, m1]; constructor
        · split <;> simp [RawCNFA.addFinal, RawCNFA.addInitial]
        · split <;> simp [RawCNFA.addFinal, RawCNFA.addInitial, RawCNFA.newState]; assumption
          suffices _ : m.stateMax ∉ m.finals by simp_all
          rintro hc; apply hwf.finals_lt at hc; simp at hc
      next hneq =>
        specialize hif _ _ hmap
        simp [m2, m1]; constructor
        · split <;> simp [RawCNFA.addFinal, RawCNFA.addInitial, RawCNFA.newState, hif]
        · split <;> simp [RawCNFA.addFinal, RawCNFA.addInitial, RawCNFA.newState, hif]
          rintro rfl; exfalso; apply hst at hmap; simp [RawCNFA.states] at hmap

set_option maxHeartbeats 1000000 in
lemma worklistRun'_go_wf :
    (st.m.WF ∧ (∀ (sa : S) s, st.map[sa]? = some s → s ∈ st.m.states)) →
    (worklistRun'.go A S final f st).WF := by
  rintro h
  induction st using worklistRun'.go.induct _ _ final f
  case case1 st hemp =>
    unfold worklistRun'.go; simp_all
  case case3 st hemp sa? sa hsa wl st' hmap =>
    unfold worklistRun'.go sa? at *
    split; simp_all
    simp [hsa]
    have heq := Option.eq_none_iff_forall_not_mem.mpr hmap
    simp_all
    split <;> simp_all +zetaDelta
  case case4 sa? _ =>
    unfold worklistRun'.go sa? at *
    simp; simp_all
  case case2 st hnemp sa? sa heq wl' st1 s hs as st2 _ _ _ _ _ ih => -- inductive case, prove the invariant is maintained
    rcases h with ⟨hwf, hst⟩
    unfold worklistRun'.go
    split; simp_all
    simp
    unfold sa? at heq
    rw [heq]; simp
    unfold st1 at hs; simp at hs; rw [hs]; simp
    apply ih
    unfold st2
    let motive := (λ (_ : Nat) (st : worklist.St A S) =>
      st.m.WF ∧ s ∈ st.m.states ∧ ∀ (sa : S) s, st.map[sa]? = some s → s ∈ st.m.states)
    suffices hccl : motive as.size (Array.foldl (processOneElem A S final s) st1 as) by
      rcases hccl with ⟨hwf, hst', _⟩; constructor <;> assumption
    apply Array.foldl_induction motive
    · simp_all +zetaDelta [motive]; constructor
      · apply hst _ _ hs
      · apply hst
    . simp [motive]; intros i st hwf hsin hst
      simp only [processOneElem, worklist.St.addOrCreateState]
      split
      · split_ands
        · apply wf_addTrans
          · assumption
          · assumption
          · apply hst <;> assumption
        · exact hsin
        · exact hst
      · split_ands
        · split
          · apply wf_addTrans
            · simp; apply wf_addFinal
              · apply wf_newState st.m (by assumption)
              · apply mem_states_newState_self
            · simp only [states_addFinal, states_newState, Finset.mem_union, Finset.mem_singleton]; left; assumption
            · simp
          · apply wf_addTrans
            · simp; apply wf_newState; assumption
            · simp; left; assumption
            · simp
        · split <;> simp_all
        · simp; intros sa s hmap
          rw [Std.HashMap.getElem?_insert] at hmap
          split
          · simp; split at hmap
            · simp_all
            · left; apply hst _ _ hmap
          · simp_all; split at hmap
            · simp_all
            · left; apply hst _ _ hmap

lemma worklistRun'_wf :
    (worklistRun' A S final inits hinits f).WF := by
  unfold worklistRun'
  simp
  apply worklistRun'_go_wf
  obtain ⟨hi, hv⟩ := worklistRun'_init_wf A S inits hinits final
  exact ⟨hi.wf, hi.map_states⟩

def worklistRun (final : S → Bool) (inits : Array S)
    (hinits : inits.toList.Nodup) (f : S → Array (BitVec n × S)) : CNFA n :=
  ⟨worklistRun' _ S final inits hinits f, worklistRun'_wf (BitVec n) S⟩

end worklist

section worklist_correct

-- Correctness of the algorithm
variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable {S : Type} [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

variable (inits : Array S) (final : S → Bool) (f : S → Array (A × S))

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma addOrCreateElem_visited final? (st : worklist.St A S) sa :
    st.addOrCreateState _ _ final? sa |>.2.visited = st.visited := by
  simp [worklist.St.visited, worklist.St.addOrCreateState]
  ext sa'
  split; simp
  simp; constructor <;> simp
  · rintro ⟨rfl | h⟩ hnin heq?
    · simp at heq?
    · constructor; assumption; simp [hnin]
  · rintro hin hnin; constructor
    · right; assumption
    · constructor; assumption; rintro rfl
      suffices _ : sa' ∉ st.map by simp_all
      apply Std.HashMap.get?_none_not_mem; assumption

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_visited (st : worklist.St A S) :
    let st' := processOneElem _ _  final s st (a, sa')
    st'.visited = st.visited := by
  intros st'
  rw [←addOrCreateElem_visited (final sa') st sa']
  simp [st', processOneElem, worklist.St.visited]

def worklist.St.rel (st : worklist.St A S) : Rel State S := λ s sa ↦
  st.map[sa]? = some s

def worklist.St.D (st : worklist.St A S) : Set S := st.visited

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
lemma processOneElem_states (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
  (processOneElem A S final s st (a, sa)).m.states =
    if sa ∉ st.map then st.m.newState.2.states else st.m.states := by
  simp [processOneElem, worklist.St.addOrCreateState]
  split
  next s' heq =>
    dsimp
    have _ := Std.HashMap.mem_of_getElem? heq
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
    split <;> simp_all only []
    split <;> simp_all
  next heq =>
    dsimp; split <;> (rw [Std.HashMap.getElem?_insert]; split <;> simp_all [-getElem?_eq_none_iff])

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_new_map (st : worklist.St A S) (final : S → Bool) (a : A) (sa : S) (s : State) :
  (processOneElem A S final s st (a, sa)).map[sa]? =
    match st.map[sa]? with
    | some s => some s
    | none => some st.m.stateMax := by
  simp [processOneElem_map]

omit [LawfulBEq A] [Fintype S] [DecidableEq S] in
@[simp]
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
    have _ := Std.HashMap.mem_of_getElem? heq
    split_ifs <;> simp_all
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
        (processOneElem A S final s st (a, sa)).m.tr s' b =
        (st.m.tr s a |>.insert ssa)
    else
      (processOneElem A S final s st (a, sa)).m.tr s' b = st.m.tr s' b := by
  simp [processOneElem, worklist.St.addOrCreateState, RawCNFA.tr]
  split
  next _ =>
    casesm _ ∧ _; subst_eqs
    dsimp
    split
    next s'' heq =>
      use s''; constructor; assumption
      have _ := Std.HashMap.mem_of_getElem? heq
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
lemma processOneElem_trans_preserve (st : worklist.St A S) (final : S → Bool) (a b : A) (sa : S) (s s1 s2 : State) :
    s2 ∈ st.m.tr s1 b →
    s2 ∈ (processOneElem A S final s st (a, sa)).m.tr s1 b := by
  have h := processOneElem_trans st final a b sa s s1
  split_ifs at h
  · obtain ⟨_, _, h2⟩ := h
    simp_all
  · simp_all

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_rel {s₁ s₂ : State} :
    (processOneElem A S final s₁ st (a, sa)).rel s₂ sa' ↔
      (st.rel s₂ sa' ∨ (s₂ = st.m.stateMax ∧ sa' = sa ∧ st.map[sa']? = none)) := by
  simp only [worklist.St.rel]
  rw [processOneElem_map]
  constructor
  · split
    next s heq => simp only [Option.some.injEq]; rintro ⟨rfl, _⟩; tauto
    next hnone =>
      simp only [Option.ite_none_right_eq_some, Option.some.injEq, and_imp]
      rintro rfl _; right; tauto
  · rintro (heq | ⟨rfl, rfl, heq⟩) <;> simp [*]

omit [LawfulBEq A] [Fintype S] [LawfulBEq S] [DecidableEq S] in
lemma rel_in_states {st : worklist.St A S} (hinv : StInv A S st.m st.map) :
    st.rel s sa → s ∈ st.m.states := by
  rintro h1
  apply hinv.map_states <;> assumption

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_rel_preserve :
    st.rel s₂ sa' →
    (processOneElem A S final s₁ st (a, sa)).rel s₂ sa' := by
  rw [processOneElem_rel]; tauto

omit [LawfulBEq A] [Fintype S] in
lemma processOneElem_rel_preserve_olds :
    (processOneElem A S final s₁ st (a, sa)).rel s₂ sa' →
    s₂ ∈ st.m.states → st.rel s₂ sa' := by
  rw [processOneElem_rel]
  rintro (h | ⟨rfl, rfl, heq⟩) hs; exact h
  simp at hs

abbrev worklist.St.sim {st : worklist.St A S} (T : Set (S × A × S)) :=
  st.m.Simul (nfa inits final f) st.rel st.D T

def processOneElem_mot (s : State) (sa : S) (n : ℕ) (st : worklist.St A S) : Prop :=
  st.map[sa]? = some s ∧
  sa ∈ st.visited ∧
  StInv A S st.m st.map ∧
  st.sim inits final f  {(sa1, a, sa') | sa1 = sa ∧ ∃ k ≥ n, (f sa)[k]? = some (a, sa') }

def processOneElem_inv {st : worklist.St A S} (s : State) (sa : S) (k : ℕ) :
    ∀ a sa', (f sa)[k]? = some (a, sa') →
    processOneElem_mot inits final f s sa k st →
    let st' := processOneElem A S final s st (a, sa')
    StInv A S st'.m st'.map := by
  rintro a sa' hf ⟨hmap, hvisited, inv, hsim⟩; simp only
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
        simp_all only [ge_iff_le, Prod.mk.eta, beq_iff_eq, ite_eq_right_iff, Option.some.injEq]
        rintro rfl; simp_all }
      { use sa'; simp_all } } }
  { rintro s' sa1 sa2
    rw [processOneElem_map]
    rw [processOneElem_map]
    split <;> split
    · rintro heq1 heq2; subst_eqs
      have hs'' : s' ∈ st.m.states := by apply hmem s' sa1 (by assumption)
      apply inv.map_inj <;> assumption
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

omit [Fintype S] in
lemma processOneElem_spec {st : worklist.St A S} (s : State) (sa : S) (k : ℕ) :
    ∀ a sa', (f sa)[k]? = some (a, sa') →
    processOneElem_mot inits final f s sa k st →
    processOneElem_mot inits final f s sa (k+1) (processOneElem A S final s st (a, sa')) := by
  intro a sa' hf ⟨hmap, hvisited, inv, hsim⟩
  have hmem : ∀ s (sa : S), st.map[sa]? = some s → s ∈ st.m.states := by intros; apply inv.map_states; assumption
  have hwf : st.m.WF := by apply inv.wf
  have inv' := processOneElem_inv inits final f s sa k a sa' hf ⟨hmap, hvisited, inv, hsim⟩
  unfold processOneElem_mot
  constructor
  (rw [processOneElem_preserves_map]; assumption)
  constructor
  (rw [processOneElem_visited]; exact hvisited)
  use inv'; constructor
  { rw [processOneElem_finals]
    rintro s' q hR
    have hs' : s ∈ st.m.states := by apply hmem <;> assumption
    rw [processOneElem_rel] at hR
    rcases hR with hR | ⟨rfl, rfl, heq⟩
    · have heq := rel_in_states inv hR
      split_ifs with hcond
      · have hneq : st.m.stateMax ≠ s' := by rintro rfl; simp [RawCNFA.states] at heq
        simp [hneq]
        apply hsim.accept; assumption
      · apply hsim.accept; assumption
    · split_ifs with h
      · rcases h with ⟨_, hfin⟩
        simp [nfa, hfin]
      · simp [nfa]
        suffices hnin : q ∉ st.map by
          push_neg at h; specialize h hnin; simp_all
          rintro hc; apply hwf.finals_lt at hc; simp at hc
        exact Std.HashMap.getElem?_none_not_mem heq }
  { rintro s₁ hs₁; rw [processOneElem_initials] at hs₁
    obtain ⟨q, hq, hR⟩ := hsim.initial₁ hs₁
    use q, hq, processOneElem_rel_preserve final hR }
  { intros q hq; obtain ⟨s, hs, hR⟩ := hsim.initial₂ hq
    simp only [processOneElem_initials]
    use s, hs, (by exact processOneElem_rel_preserve final hR) }
  { rintro s₁ s₂ b q₁ hR htr
    have h := processOneElem_trans st final a b sa' s s₁
    split_ifs at h with hcond
    on_goal 2 => {
      rw [h] at htr
      apply processOneElem_rel_preserve_olds at hR
      specialize hR (RawCNFA.WF.trans_src_lt'' hwf htr)
      obtain ⟨q₂, hst, hrel⟩ := hsim.trans_match₁ hR htr
      use q₂; simp only [hst, true_and]
      exact processOneElem_rel_preserve final hrel }
    rcases hcond with ⟨rfl, rfl⟩
    rcases h with ⟨sₙ, hmap', htr'⟩
    rw [htr'] at htr; clear htr'
    simp only [Std.HashSet.mem_insert, beq_iff_eq] at htr
    rcases htr with rfl | htr
    on_goal 2 =>
      have hold := RawCNFA.WF.trans_src_lt'' hwf htr
      obtain ⟨q₂, hst, hrel⟩ := hsim.trans_match₁
        (by apply processOneElem_rel_preserve_olds final hR hold) htr
      use q₂, hst, processOneElem_rel_preserve final hrel
    use sa'; constructor
    · suffices heq : q₁ = sa by
        subst heq; apply Array.mem_of_getElem? hf
      apply processOneElem_preserves_map at hmap
      unfold worklist.St.rel at hR
      apply inv'.map_inj hR hmap
    · exact hmap' }
  { rintro s₁ b q₁ q₂ hR hs hD hnT
    simp only [ge_iff_le, Prod.mk.eta, Set.mem_setOf_eq, not_and, not_exists] at hnT
    have h := processOneElem_trans st final a b sa' s s₁
    split_ifs at h with hcond
    on_goal 2 =>
      have hR' : st.rel s₁ q₁ := by
        rw [processOneElem_rel] at hR; rcases hR with hR' | ⟨_, _, hnone⟩; exact hR'
        unfold worklist.St.D at hD; rw [processOneElem_visited] at hD
        rcases hD with ⟨hnin, -⟩
        apply Std.HashMap.getElem?_none_not_mem at hnone
        contradiction
      obtain ⟨s₂, hs', hR⟩ := hsim.trans_match₂ hR' hs
        (by simp_all [worklist.St.D, processOneElem_visited])
        (by simp; rintro rfl i hi hc
            by_cases heq: k = i
            · subst heq; apply hcond; constructor
              · simp [hc] at hf; simp [hf]
              · rw [hR'] at hmap; simp at hmap; exact hmap.symm
            · apply hnT rfl _ (by omega) hc)
      use s₂; simp only [h, hs', true_and]
      apply processOneElem_rel_preserve; assumption
    rcases hcond with ⟨rfl, rfl⟩
    rcases h with ⟨sₙ, hmap', htr'⟩
    obtain rfl : sa = q₁ := by
      apply processOneElem_preserves_map at hmap
      apply inv'.map_inj hmap hR
    simp only [htr', Std.HashSet.mem_insert, beq_iff_eq]
    by_cases heq : sa' = q₂
    · subst heq; use sₙ; simp only [true_or, true_and]; exact hmap'
    · have hold := hmem _ _ hmap
      apply processOneElem_rel_preserve_olds at hR
      obtain ⟨s₂, hs', hR⟩ := hsim.trans_match₂ (hR hold) hs
        (by simp_all [worklist.St.D, processOneElem_visited])
        (by simp; rintro i hi hc
            have _ : i ≠ k := by rintro rfl; simp_all
            apply hnT rfl i (by omega) hc)
      use s₂; simp only [hs', or_true, true_and]
      apply processOneElem_rel_preserve; assumption }

def worklistGo_spec {st : worklist.St A S} (inv : StInv A S st.m st.map) :
    st.sim inits final f ∅ →
    (worklistRun'.go A S final f st |>.Sim $ nfa inits final f) := by
  induction st using worklistRun'.go.induct _ _ final f with
  | case4 st hnemp sa? hsa? =>
    -- trivial case that's impossible
      simp only [Array.back?, Array.getElem?_eq_none_iff, sa?] at hsa?
      have : st.worklist.size = 0 := by omega
      simp_all only [Array.isEmpty, decide_true, not_true_eq_false]
  | case3 st hnemp sa? sa hsa? wl' st' hc =>
    have h : sa ∈ st.map := by
      apply st.worklist_incl
      simp_all [sa?, Array.mem_of_back?]
    apply Std.HashMap.getElem?_eq_some_getD (fallback := 0) at h
    simp [st'] at hc
    exfalso; apply (hc _); exact h
  | case1 st hemp =>
    -- exit case, prove that the invariant + empty worklist implies the postcondition
    have : st.worklist = #[] := by
      simp only [Array.isEmpty] at hemp; apply Array.eq_empty_of_size_eq_zero; simp_all only [decide_eq_true_eq]
    intros hsim; unfold worklistRun'.go; simp_all
    apply sim_full_cod st.m (nfa inits final f) st.D ∅ st.rel (by simp_all) hsim
    unfold worklist.St.rel worklist.St.D worklist.St.visited; simp [this]
    ext q; constructor
    · rintro ⟨s, hs⟩; exact Std.HashMap.mem_of_getElem? hs
    · rintro hin; exact Std.HashMap.mem_iff_getElem?.mp hin
  | case2 st hnemp sa? sa heq wl' st1 s hs as st2 _ _ _ _ _ ih =>
    -- inductive case, prove the invariant is maintained
    intros hsim; unfold worklistRun'.go; simp_all [sa?]
    split
    next sa' hsome =>
      have _ : sa' = sa := by simp_all
      subst_eqs
      split
      next _ s' hmap =>
        have _ : s' = s := by simp_all +zetaDelta
        subst_eqs
        rw [heq] at hsome; subst_eqs
        suffices hccl : processOneElem_mot inits final f s sa (f sa).size (Array.foldl (processOneElem A S final s) st1 (f sa)) by
          obtain ⟨_, _, inv', hsim'⟩ := hccl
          have hemp : {(sa1, a, sa') | sa1 = sa ∧ ∃ k, (f sa).size ≤ k ∧ (f sa)[k]? = some (a, sa')} = ∅ := by
            ext sa'; simp_all; rintro rfl k hge hsome
            suffices hccl : (f sa'.1)[k]? = none by simp_all
            apply Array.getElem?_size_le; assumption
          simp_all +zetaDelta only [ge_iff_le, st2]
        apply Array.foldl_induction
        { simp only [st1, wl']
          unfold processOneElem_mot
          have inv' : StInv A S st1.m st1.map := by
            constructor
            { simp [st1]; exact inv.wf }
            { simp [st1]; apply inv.map_states }
            { simp only [st1]; intros a; obtain ⟨sa, hsa⟩ := inv.map_surj a; use sa }
            { simp only [st1]; exact inv.map_inj }
          constructor; assumption
          constructor
          { simp [worklist.St.visited]; simp_all; exact Std.HashMap.mem_of_getElem? hmap }
          use inv'; constructor
          { apply @hsim.accept }
          { apply @hsim.initial₁ }
          { apply @hsim.initial₂ }
          { apply @hsim.trans_match₁ }
          { rintro s1 a sa₁ sa₂ hR hst hD hnT
            simp only
            by_cases hnew? : sa₁ = sa
            · exfalso; apply hnT; subst hnew?
              simp [Array.mem_iff_getElem?.mp hst]
            · obtain ⟨s₂, htr, hR⟩ := hsim.trans_match₂ hR hst (by
                rcases hD with ⟨hmap, hwl⟩
                use hmap
                rw [Array.mem_pop_iff]; simp [hwl, heq]
                rintro rfl; apply hnew? rfl)
                (by simp)
              use s₂, htr
              simp [worklist.St.rel]; exact hR }}
        { intros k st; apply processOneElem_spec; simp }
      next hnone =>
        have hnin : sa ∉ st.map := by
          intros hin
          suffices ex : ∃ s, st.map[sa]? = some s by simp_all
          simp_all +zetaDelta
        exfalso; apply hnin; apply st.worklist_incl; exact Array.mem_of_back? hsome
    next hnone =>
      simp only [Array.back?, Array.getElem?_eq_none_iff] at *
      have : st.worklist.size = 0 := by omega
      simp_all

def worklistRun'_spec :
    (worklistRun' A S final inits hinits f |>.Sim $ nfa inits final f) := by
  unfold worklistRun'
  simp
  obtain ⟨inv, hmi, hts, hif⟩ := worklistRun'_init_wf A S inits hinits final
  have hvis : (worklist.initState A S inits hinits final).visited = ∅ := by
    simp [worklist.St.visited]; simp_all; simp [worklist.initState]
  apply worklistGo_spec <;> try assumption
  constructor
  · rintro s q hR
    obtain ⟨sa, hsa⟩ := inv.map_surj ⟨s, by exact inv.map_states _ s hR⟩
    rw [(hif _ _ hsa).2, nfa]
    simp only [Set.mem_setOf_eq, Bool.coe_iff_coe]; congr
    apply inv.map_inj hsa hR
  · rintro s hi
    obtain ⟨sa, hsa⟩ := inv.map_surj ⟨s, by apply inv.wf.initials_lt hi⟩
    simp [nfa]
    use sa
    constructor
    · rw [←hmi]; exact Std.HashMap.mem_of_getElem? hsa
    · exact hsa
  · rintro q hs
    simp only [nfa, Set.mem_setOf_eq] at hs
    rw [←hmi, Std.HashMap.mem_iff_getElem?] at hs
    obtain ⟨s, hR⟩ := hs
    use s
    constructor
    · exact hif _ _ hR |>.1
    · exact hR
  · simp [RawCNFA.tr, hts]
  · simp [worklist.St.D, hvis]

end worklist_correct

section worklist_good

variable {S : Type} [Fintype S] [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]

variable (inits : Array S) (final : S → Bool) (f : S → Array (BitVec n × S))

def worklistRun_spec : (worklistRun S final inits hinits f |>.Sim $ nfa' inits final f) :=
  worklistRun'_spec inits final f

end worklist_good
