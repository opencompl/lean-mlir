import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Finset.Powerset
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.GoodNFA

section sink

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]


def CNFA.addSink (m : CNFA A) : CNFA A := m.createSink.2
-- def CNFA.addSink (m : CNFA A) : CNFA A :=
  -- let res := (List.range m.stateMax).foldl (init := (none, m)) fun (sink?, m) s =>
  --   (FinEnum.toList (α := A)).foldl (init := (sink?, m)) fun (sink?, m) a =>
  --     let stuck := if let some trans := m.trans.get? (s, a) then trans.isEmpty else true
  --     if !stuck then (sink?, m) else
  --       let (sink, m) := match sink? with
  --                       | some s => (s, m)
  --                       | none => m.createSink
  --       (some sink, m.addTrans a s sink)
  -- res.2

def GoodCNFA.addSink (m : GoodCNFA n) : GoodCNFA n := ⟨m.m.addSink, sorry⟩

lemma addSink_spec (m : GoodCNFA n) (M : GoodNFA n) :
    m.Sim M →
    m.addSink.Sim M.complete :=
  sorry

def CNFA.flipFinals (m : CNFA A) : CNFA A :=
  let oldFinals := m.finals
  let newFinals := (List.range m.stateMax).foldl (init := ∅) fun fins s =>
    if oldFinals.contains s then fins else fins.insert s
  { m with finals := newFinals }

def GoodCNFA.flipFinals (m : GoodCNFA n) : GoodCNFA n := ⟨m.m.flipFinals, by sorry⟩

end sink

section product

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

omit [LawfulBEq A] in
lemma CNFA.WF.intitials_states (m : CNFA A) (hwf : m.WF) : ∀ s ∈ m.initials, s ∈ m.states := by
  simp_all [CNFA.states, hwf]

def product (final? : Bool → Bool → Bool) (m1 m2 : GoodCNFA n) : GoodCNFA n :=
  worklistRun (m1.m.states × m2.m.states) final inits (by sorry /- looks annoying -/) f
where final (ss : m1.m.states × m2.m.states) := final? (m1.m.finals.contains ss.1) (m2.m.finals.contains ss.2)
      inits :=
       let a := Array.mkEmpty <| m1.m.initials.size * m2.m.initials.size
       m1.m.initials.attachWith _ m1.wf.intitials_states |>.fold (init := a) fun is s1 =>
         m2.m.initials.attachWith _ m2.wf.intitials_states |>.fold (init := is) fun is s2 =>
           is.push (s1, s2)
      f (ss : m1.m.states × m2.m.states) :=
        let (s1, s2) := ss
        (FinEnum.toList (α := BitVec n)).foldl (init := Array.empty) fun as a =>
          let s1trans := m1.m.trans.getD (s1, a) ∅
          let s2trans := m2.m.trans.getD (s2, a) ∅
          s1trans.attachWith _ (m1.wf.trans_tgt_lt' s1 a) |>.fold (init := as) fun as s1' =>
            s2trans.attachWith _ (m2.wf.trans_tgt_lt' s2 a) |>.fold (init := as) fun as s2' =>
              as.push (a, (s1', s2'))


def GoodCNFA.inter (m1 m2 : GoodCNFA n) : GoodCNFA n := product (fun b1 b2 => b1 && b2) m1 m2
def GoodCNFA.union (m1 m2 : GoodCNFA n) : GoodCNFA n :=
  -- FIXME add a sink state to each automata, or modify product
  product (fun b1 b2 => b1 || b2) m1.addSink m2.addSink

noncomputable def to_prop (f : Bool → Bool → Bool) (p1 p2 : Prop) : Prop :=
  f (@Decidable.decide p1 (Classical.propDecidable _)) (@Decidable.decide p2 (Classical.propDecidable _))

def GoodCNFA.product_spec (final? : Bool → Bool → Bool) (m1 m2 : GoodCNFA n)
  {M1 : GoodNFA n} {M2 : GoodNFA n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (product final? m1 m2).Sim (GoodNFA.product (to_prop final?) M1 M2) := by
  rintro ⟨f1, hsim1⟩ ⟨f2, hsim2⟩
  apply worklistRun_spec (m1.m.states × m2.m.states)
    (corr := fun (s1, s2) => (f1 s1, f2 s2))
  · rintro ⟨s1, s2⟩ ⟨s1', s2'⟩; simp; rintro heqs
    injection heqs with h1 h2
    apply hsim1.injective at h1; apply hsim2.injective at h2; simp_all
  · rintro ⟨s1, s2⟩
    simp [product.final, GoodNFA.product, NFA.product, to_prop, Set.instMembership, Set.Mem]; congr
    · rw [←Bool.coe_iff_coe, ←Std.HashSet.mem_iff_contains]; simp; apply hsim1.accept
    · rw [←Bool.coe_iff_coe, ←Std.HashSet.mem_iff_contains]; simp; apply hsim2.accept
  · rintro ⟨s1, s2⟩ ⟨q1, q2⟩ a hin
    simp [NFA.product] at hin
    obtain ⟨hst1, hst2⟩ := hin
    obtain ⟨s1', hf1, htr1⟩ := hsim1.trans_match₁ s1 a q1 hst1 (by simp) (by simp)
    obtain ⟨s2', hf2, htr2⟩ := hsim2.trans_match₁ s2 a q2 hst2 (by simp) (by simp)
    use ⟨s1', s2'⟩; simp_all [product.f]
    sorry
  · rintro ⟨s1, s2⟩ a ⟨s1', s2'⟩ hinf
    dsimp only [GoodNFA.product, NFA.product]
    simp [to_prop, Set.instMembership, Set.Mem]
    suffices h : s1'.val ∈ m1.m.trans.getD (s1, a) ∅ ∧ s2'.val ∈ m2.m.trans.getD (s2, a) ∅ by
      rcases h with ⟨h1, h2⟩
      obtain ⟨h1, hin1⟩ := hsim1.trans_match₂ _ _ _ h1
      obtain ⟨h2, hin2⟩ := hsim2.trans_match₂ _ _ _ h2
      aesop
    sorry

def GoodCNFA.inter_spec (m1 m2 : GoodCNFA n)
  {M1 : GoodNFA n} {M2 : GoodNFA n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (m1.inter m2).Sim (M1.inter M2) := by
  intros h1 h2
  simp [GoodNFA.inter_eq, GoodCNFA.inter]
  have heq : And = to_prop (fun x y => x && y) := by
    ext x y; simp [to_prop]
  simp [heq]
  apply product_spec <;> assumption

def GoodCNFA.union_spec (m1 m2 : GoodCNFA n)
  {M1 : GoodNFA n} {M2 : GoodNFA n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (m1.union m2).Sim (M1.union M2) := by
  intros h1 h2
  simp [GoodNFA.union_eq, GoodCNFA.union]
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

def GoodCNFA.determinize (m : GoodCNFA n) : GoodCNFA n :=
  worklistRun (BitVec m.m.stateMax)
    (fun ss => ss.any fun n b => b == true && n ∈ m.m.finals)
    #[BitVec.ofFn (fun n => n ∈ m.m.initials)]
    (by apply List.nodup_singleton)
    fun (ss : BitVec m.m.stateMax) =>
        (FinEnum.toList (BitVec n)).foldl (init := Array.empty) fun ts a =>
          let ss' := m.m.transSetBV ss a
          ts.push (a, ss')

def GoodNFA.determinize_spec_nonemp (m : GoodCNFA n)  [Nonempty m.m.states]
  {M : GoodNFA n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  rcases hsim with ⟨fsim, hsim⟩
  unfold GoodCNFA.determinize
  apply worklistRun_spec (BitVec m.m.stateMax)
    (corr := λ ss q => let i := Function.invFun fsim q; ss[i.val] == true)
    (M := M.determinize)
  · intros ss1 ss2; simp; intros heq; ext i
    rw [funext_iff] at heq
    specialize heq (fsim ⟨i.val, by simp [CNFA.states]⟩)
    rw [Function.leftInverse_invFun hsim.injective] at heq
    simp at heq; exact heq
  · sorry
  · sorry
  · sorry

def GoodNFA.determinize_spec_emp (m : GoodCNFA n) (hemp : m.m.stateMax = 0)
  {M : GoodNFA n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  rcases hsim with ⟨fsim, hsim⟩
  unfold GoodCNFA.determinize
  apply worklistRun_spec (BitVec m.m.stateMax)
    (corr := λ ss _ => True)
    (M := M.determinize)
  · rw [hemp]; intros ss1 ss2 _; apply BitVec.eq_of_getMsbD_eq; simp
  · rw [hemp]; rintro ⟨⟨x⟩⟩
    obtain rfl : x = 0 := by omega
    simp [BitVec.any, GoodNFA.determinize, NFA.toDFA]
    intros q _ ha
    sorry -- need to prove that f is surjective?
  · sorry
  · sorry

def GoodNFA.determinize_spec (m : GoodCNFA n)
  {M : GoodNFA n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  rcases heq : m.m.stateMax
  · apply GoodNFA.determinize_spec_emp <;> simp_all
  · have _ : Nonempty m.m.states := by use 0; simp_all [CNFA.states]
    apply GoodNFA.determinize_spec_nonemp; simp_all

def GoodCNFA.neg (m : GoodCNFA n) : GoodCNFA n := m.determinize.flipFinals

def GoodCNFA.neg_spec (m : GoodCNFA n)  {M : GoodNFA n} (hsim : m.Sim M) :
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
-- def CNFA.isIncluded (m1 m2 : CNFA A) : Bool :=
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
def GoodCNFA.isEmpty (m : GoodCNFA n) : Bool := m.m.finals.isEmpty

def GoodCNFA.isUniversal (m : GoodCNFA n) : Bool := m.neg.isEmpty

theorem GoodCNFA.isUniversal_spec {m : GoodCNFA n} {M : GoodNFA n} :
    m.Sim M → m.isUniversal → M.accepts = ⊤ := by
  sorry

/-- Recognizes the empty word -/
def CNFA.emptyWord : CNFA A :=
  let m := CNFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  m

def GoodCNFA.emptyWord : GoodCNFA n := ⟨CNFA.emptyWord, by sorry⟩

/-- Returns true when `L(m) ∪ {ε} = A*`. This is useful because the
    bitvector of with width zero has strange properties.
 -/
def GoodCNFA.isUniversal' (m : GoodCNFA n) : Bool :=
  m.union GoodCNFA.emptyWord |> GoodCNFA.isUniversal

-- TODO: this relies on the fact that all states are reachable!
-- should derive from the fact that all states of M are reachable.
def CNFA.isNotEmpty (m : CNFA A) : Bool := !m.finals.isEmpty

end emptiness

section lift_proj

variable {n : Nat}

-- Morally, n2 >= n1
def CNFA.lift (m1: CNFA (BitVec n1)) (f : Fin n1 → Fin n2) : CNFA (BitVec n2) :=
  let m2 : CNFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  (List.range m2.stateMax).foldl (init := m2) fun m2 s =>
    (FinEnum.toList (BitVec n2)).foldl (init := m2) fun m2 (bv : BitVec n2) =>
      let newtrans := m1.trans.getD (s, bv.transport f) ∅
      let oldtrans := m2.trans.getD (s, bv) ∅
      let trans := newtrans.union oldtrans
      if trans.isEmpty then m2 else { m2 with trans := m2.trans.insert (s, bv) trans }

def GoodCNFA.lift (m: GoodCNFA n1) (f : Fin n1 → Fin n2) : GoodCNFA n2 :=
  ⟨m.m.lift f, by sorry⟩

def GoodCNFA.lift_spec (m : GoodCNFA n1) (f : Fin n1 → Fin n2) {M : GoodNFA n1} :
    m.Sim M → (m.lift f |>.Sim (M.lift f)) := by
  sorry

-- Morally, n1 >= n2
def CNFA.proj (m1: CNFA (BitVec n1)) (f : Fin n2 → Fin n1) : CNFA (BitVec n2) :=
  let m2 : CNFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  m1.trans.keys.foldl (init := m2) fun m2 (s, bv) =>
    let trans := m1.trans.getD (s, bv) ∅
    let bv' := bv.transport f
    let oldtrans := m2.trans.getD (s, bv') ∅
    { m2 with trans := m2.trans.insert (s, bv') (trans.union oldtrans) }

def GoodCNFA.proj (m: GoodCNFA n2) (f : Fin n1 → Fin n2) : GoodCNFA n1 :=
  ⟨m.m.proj f, by sorry⟩

def GoodCNFA.proj_spec (m : GoodCNFA n2) (f : Fin n1 → Fin n2) {M : GoodNFA n2} :
    m.Sim M → (m.proj f |>.Sim (M.proj f)) := by
  sorry

end lift_proj
