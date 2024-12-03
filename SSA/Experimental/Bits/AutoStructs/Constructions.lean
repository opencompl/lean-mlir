import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Finset.Powerset
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.NFA'
import SSA.Experimental.Bits.AutoStructs.Worklist

section sink

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def RawCNFA.addSink (m : RawCNFA A) : RawCNFA A := m.createSink.2
-- def RawCNFA.addSink (m : RawCNFA A) : RawCNFA A :=
  -- let res := (List.range m.stateMax).foldl (init := (none, m)) fun (sink?, m) s =>
  --   (FinEnum.toList (α := A)).foldl (init := (sink?, m)) fun (sink?, m) a =>
  --     let stuck := if let some trans := m.trans.get? (s, a) then trans.isEmpty else true
  --     if !stuck then (sink?, m) else
  --       let (sink, m) := match sink? with
  --                       | some s => (s, m)
  --                       | none => m.createSink
  --       (some sink, m.addTrans a s sink)
  -- res.2

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

lemma RawCNFA.flipFinal_wf {m : RawCNFA A} (hwf : m.WF) : m.flipFinals.WF := by
  simp [flipFinals]
  constructor <;> simp_all

  let motive (fs : Std.HashSet State) := ∀ s ∈ fs, s ∈ m.states
  suffices h : motive $ List.foldl (fun fins s => if m.finals.contains s = true then fins else fins.insert s) ∅ (List.range m.stateMax) by
    exact h
  apply List.foldlRecOn
  · simp [motive]
  · simp [motive]
    rintro _ _ _ _ _ hif
    split_ifs at hif <;> simp_all
    rcases hif <;> simp_all [states]
  · intros; apply hwf.trans_tgt_lt <;> assumption

def CNFA.flipFinals (m : CNFA n) : CNFA n := ⟨m.m.flipFinals, m.m.flipFinal_wf m.wf⟩

end sink

section product

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def product (final? : Bool → Bool → Bool) (m1 m2 : CNFA n) : CNFA n :=
  worklistRun (m1.m.states × m2.m.states) final inits (by sorry /- looks annoying -/) f
where final (ss : m1.m.states × m2.m.states) := final? (ss.1 ∈ m1.m.finals) (ss.2 ∈ m2.m.finals)
      inits :=
       let a := Array.mkEmpty <| m1.m.initials.size * m2.m.initials.size
       m1.m.initials.attachWith _ @m1.wf.initials_lt |>.fold (init := a) fun is s1 =>
         m2.m.initials.attachWith _ @m2.wf.initials_lt |>.fold (init := is) fun is s2 =>
           is.push (s1, s2)
      f (ss : m1.m.states × m2.m.states) :=
        let (s1, s2) := ss
        (FinEnum.toList (α := BitVec n)).foldl (init := Array.empty) fun as a =>
          let s1trans := m1.m.trans.getD (s1, a) ∅
          let s2trans := m2.m.trans.getD (s2, a) ∅
          s1trans.attachWith _ (m1.wf.trans_tgt_lt' s1 a) |>.fold (init := as) fun as s1' =>
            s2trans.attachWith _ (m2.wf.trans_tgt_lt' s2 a) |>.fold (init := as) fun as s2' =>
              as.push (a, (s1', s2'))


noncomputable def to_prop (f : Bool → Bool → Bool) (p1 p2 : Prop) : Prop :=
  f (@Decidable.decide p1 (Classical.propDecidable _)) (@Decidable.decide p2 (Classical.propDecidable _))

lemma product.inits_spec :
    (s₁, s₂) ∈ inits m1 m2 ↔ s₁.val ∈ m1.m.initials ∧ s₂.val ∈ m2.m.initials := by
  sorry

lemma product.f_spec :
    (a, (s₁', s₂')) ∈ f m1 m2 (s₁, s₂) ↔ s₁'.val ∈ m1.m.tr s₁ a ∧ s₂'.val ∈ m2.m.tr s₂ a := by
  sorry

lemma product.sim {m1 m2 : CNFA n}:
    m1.Sim M1 → m2.Sim M2 →
    (nfa (inits m1 m2) (final final? m1 m2) (f m1 m2)).Bisim (M1.M.product (to_prop final?) M2.M) := by
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
  rintro h₁ h₂
  apply bisim_comp
  · apply worklistRun_spec
  · apply product.sim h₁ h₂

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
  simp [any]; rfl

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

private def bv_to_set {m : CNFA n} (bv : BitVec m.m.stateMax) : Set State :=
  { s | bv.getLsbD s }

lemma transSetBV_spec {m : CNFA n} {ss : BitVec m.m.stateMax} :
    s' ∈ bv_to_set (m.m.transSetBV ss a) ↔
      ∃ s ∈ bv_to_set ss, s' ∈ m.m.tr s a :=
  by sorry

lemma CNFA.determinize.f_spec {m : CNFA n} {a : BitVec n} {sa sa' : BitVec m.m.stateMax} :
    (a, sa') ∈ (f m sa) ↔ (∀ {s'}, s' ∈ bv_to_set sa' ↔ ∃ s ∈ bv_to_set sa, s' ∈ m.m.tr s a) := by
  sorry

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
  sorry

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

-- TODO: this relies on the fact that all states are reachable!
-- We should add this to the simulation predicate I think
def CNFA.isEmpty (m : CNFA n) : Bool := m.m.finals.isEmpty

def CNFA.isUniversal (m : CNFA n) : Bool := m.neg.isEmpty

theorem CNFA.isUniversal_spec {m : CNFA n} {M : NFA' n} :
    m.Sim M → m.isUniversal → M.accepts = ⊤ := by
  sorry

/-- Recognizes the empty word -/
def RawCNFA.emptyWord : RawCNFA A :=
  let m := RawCNFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  m

def CNFA.emptyWord : CNFA n := ⟨RawCNFA.emptyWord, by sorry⟩

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
def RawCNFA.lift (m1: RawCNFA (BitVec n1)) (f : Fin n1 → Fin n2) : RawCNFA (BitVec n2) :=
  let m2 : RawCNFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  (List.range m2.stateMax).foldl (init := m2) fun m2 s =>
    (FinEnum.toList (BitVec n2)).foldl (init := m2) fun m2 (bv : BitVec n2) =>
      let newtrans := m1.trans.getD (s, bv.transport f) ∅
      let oldtrans := m2.trans.getD (s, bv) ∅
      let trans := newtrans.union oldtrans
      if trans.isEmpty then m2 else { m2 with trans := m2.trans.insert (s, bv) trans }

def CNFA.lift (m: CNFA n1) (f : Fin n1 → Fin n2) : CNFA n2 :=
  ⟨m.m.lift f, by sorry⟩

def CNFA.lift_spec (m : CNFA n1) (f : Fin n1 → Fin n2) {M : NFA' n1} :
    m.Sim M → (m.lift f |>.Sim (M.lift f)) := by
  sorry

-- Morally, n1 >= n2
def RawCNFA.proj (m1: RawCNFA (BitVec n1)) (f : Fin n2 → Fin n1) : RawCNFA (BitVec n2) :=
  let m2 : RawCNFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  m1.trans.keys.foldl (init := m2) fun m2 (s, bv) =>
    let trans := m1.trans.getD (s, bv) ∅
    let bv' := bv.transport f
    let oldtrans := m2.trans.getD (s, bv') ∅
    { m2 with trans := m2.trans.insert (s, bv') (trans.union oldtrans) }

def CNFA.proj (m: CNFA n2) (f : Fin n1 → Fin n2) : CNFA n1 :=
  ⟨m.m.proj f, by sorry⟩

def CNFA.proj_spec (m : CNFA n2) (f : Fin n1 → Fin n2) {M : NFA' n2} :
    m.Sim M → (m.proj f |>.Sim (M.proj f)) := by
  sorry

end lift_proj
