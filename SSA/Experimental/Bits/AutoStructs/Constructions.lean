import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Finset.Powerset
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.NFA'

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

def CNFA.addSink (m : CNFA n) : CNFA n := ⟨m.m.addSink, sorry⟩

lemma addSink_spec (m : CNFA n) (M : NFA' n) :
    m.Sim M →
    m.addSink.Sim M.complete :=
  sorry

def RawCNFA.flipFinals (m : RawCNFA A) : RawCNFA A :=
  let oldFinals := m.finals
  let newFinals := (List.range m.stateMax).foldl (init := ∅) fun fins s =>
    if oldFinals.contains s then fins else fins.insert s
  { m with finals := newFinals }

def CNFA.flipFinals (m : CNFA n) : CNFA n := ⟨m.m.flipFinals, by sorry⟩

end sink

section product

variable {A : Type} [BEq A] [LawfulBEq A] [Hashable A] [DecidableEq A] [FinEnum A]

omit [LawfulBEq A] in
lemma RawCNFA.WF.intitials_states (m : RawCNFA A) (hwf : m.WF) : ∀ s ∈ m.initials, s ∈ m.states := by
  simp_all [RawCNFA.states, hwf]

def product (final? : Bool → Bool → Bool) (m1 m2 : CNFA n) : CNFA n :=
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


def CNFA.inter (m1 m2 : CNFA n) : CNFA n := product (fun b1 b2 => b1 && b2) m1 m2
def CNFA.union (m1 m2 : CNFA n) : CNFA n :=
  -- FIXME add a sink state to each automata, or modify product
  product (fun b1 b2 => b1 || b2) m1.addSink m2.addSink

noncomputable def to_prop (f : Bool → Bool → Bool) (p1 p2 : Prop) : Prop :=
  f (@Decidable.decide p1 (Classical.propDecidable _)) (@Decidable.decide p2 (Classical.propDecidable _))

def CNFA.product_spec (final? : Bool → Bool → Bool) (m1 m2 : CNFA n)
  {M1 : NFA' n} {M2 : NFA' n} :
    m1.Sim M1 →
    m2.Sim M2 →
    (product final? m1 m2).Sim (NFA'.product (to_prop final?) M1 M2) := by
  sorry

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

def CNFA.determinize (m : CNFA n) : CNFA n :=
  worklistRun (BitVec m.m.stateMax)
    (fun ss => ss.any fun n b => b == true && n ∈ m.m.finals)
    #[BitVec.ofFn (fun n => n ∈ m.m.initials)]
    (by apply List.nodup_singleton)
    fun (ss : BitVec m.m.stateMax) =>
        (FinEnum.toList (BitVec n)).foldl (init := Array.empty) fun ts a =>
          let ss' := m.m.transSetBV ss a
          ts.push (a, ss')

def NFA'.determinize_spec_nonemp (m : CNFA n)  [Nonempty m.m.states]
  {M : NFA' n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  sorry

def NFA'.determinize_spec_emp (m : CNFA n) (hemp : m.m.stateMax = 0)
  {M : NFA' n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  sorry

def NFA'.determinize_spec (m : CNFA n)
  {M : NFA' n} (hsim : m.Sim M) :
    m.determinize.Sim M.determinize := by
  rcases heq : m.m.stateMax
  · apply NFA'.determinize_spec_emp <;> simp_all
  · have _ : Nonempty m.m.states := by use 0; simp_all [RawCNFA.states]
    apply NFA'.determinize_spec_nonemp; simp_all

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
