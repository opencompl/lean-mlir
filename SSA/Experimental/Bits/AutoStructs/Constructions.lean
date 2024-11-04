import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.FinEnum
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum
import Batteries.Data.Fin.Basic

section sink

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

def NFA.addSink (m : NFA A) : NFA A :=
  let (sink, m) := m.newState
  -- let m := m.addInitial sink -- TODO(leo) is that right?
  (List.range m.stateMax).foldl (init := m) fun m s =>
    (FinEnum.toList (α := A)).foldl (init := m) fun m a =>
      let stuck := if let some trans := m.trans.get? (s, a) then trans.isEmpty else true
      if stuck then m.addTrans a s sink else m

def NFA.flipFinals (m : NFA A) : NFA A :=
  let oldFinals := m.finals
  let newFinals := (List.range m.stateMax).foldl (init := ∅) fun fins s =>
    if oldFinals.contains s then fins else fins.insert s
  { m with finals := newFinals }

end sink

section product

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

private structure product.State where
  m : NFA A
  map : Std.HashMap (_root_.State × _root_.State) _root_.State := ∅
  worklist : Array (_root_.State × _root_.State) := ∅

private def product.State.measure (st : product.State (A := A)) (m1 m2 : NFA A) :=
  ((Multiset.range m1.stateMax).product (Multiset.range m2.stateMax)).sub
    ((Multiset.ofList st.map.keys).sub (Multiset.ofList st.worklist.toList))

def product (final? : Bool → Bool → Bool) (m1 m2 : NFA A) : NFA A :=
  let map : Std.HashMap (State × State) State := ∅
  let worklist : Array (State × State) := ∅
  let st : product.State (A := A) := { m := NFA.empty }
  let st := init st
  go st
where init (st : product.State (A := A)) : product.State (A := A) :=
       m1.initials.fold (init := st) fun st s1 =>
         m2.initials.fold (init := st) fun st s2 =>
           let (s, m) := st.m.newState
           let m := m.addInitial s
           let map := st.map.insert (s1, s2) s
           let worklist := st.worklist.push (s1, s2)
           {m, map, worklist}
      go (st0 : product.State (A := A)) : NFA A := Id.run do
        if hne : st0.worklist.size == 0 then
          return st0.m
        else
        let some (s1, s2) := st0.worklist.get? (st0.worklist.size - 1) | return st0.m
        let st := { st0 with worklist := st0.worklist.pop }
        let some s := st.map.get? (s1, s2) | return NFA.empty
        let st := if final? (m1.finals.contains s1) (m2.finals.contains s2) then
                    { st with m := st.m.addFinal s }
                  else
                    st
        let st := (FinEnum.toList (α := A)).foldl (init := st) fun st a =>
          if let some s1trans := m1.trans.get? (s1, a) then
            if let some s2trans := m2.trans.get? (s2, a) then
              s1trans.fold (init := st) fun st s1' =>
                s2trans.fold (init := st) fun st s2' =>
                  if let some s' := st.map.get? (s1', s2') then
                    let m := st.m.addTrans a s s'
                    { st with m }
                  else
                    let (s', m) := st.m.newState
                    let worklist := st.worklist.push (s1', s2')
                    let map := st.map.insert (s1', s2') s'
                    let m := m.addTrans a s s'
                    { m, map, worklist }
            else
              st
          else
            st
        go st
        termination_by st0.measure m1 m2
        decreasing_by {
          sorry
        }



def NFA.inter (m1 m2 : NFA A) : NFA A := product (fun b1 b2 => b1 && b2) m1 m2
def NFA.union (m1 m2 : NFA A) : NFA A :=
  -- FIXME add a sink state to each automata, or modify product
  product (fun b1 b2 => b1 || b2) m1.addSink m2.addSink

end product

def HashSet.inter [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Std.HashSet A :=
  m1.fold (init := Std.HashSet.empty) fun mi x => if m2.contains x then mi.insert x else mi

def Std.HashSet.isDisjoint [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  (HashSet.inter m1 m2).isEmpty

def HashSet.areIncluded [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  m1.all (fun x => m2.contains x)

section determinization

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

instance hashableHashSet [Hashable A] : Hashable (Std.HashSet A) where
  hash s := s.fold (init := 0) fun h x => mixHash h (hash x)

private structure NFA.determinize.St where
  map : Std.HashMap (Std.HashSet State) State
  worklist : List (Std.HashSet State)
  m : NFA A

open NFA.determinize in
def NFA.determinize (mi : NFA A) : NFA A :=
  let m : NFA A := NFA.empty
  let (si, m) := m.newState
  let m := m.addInitial si
  let map : Std.HashMap _ _ := { (mi.initials, si) }
  let st : St := { map, worklist := [mi.initials], m}
  go st
where go (st : St) : NFA A := Id.run do
  if let some (ss, worklist) := st.worklist.next? then
    let st := { st with worklist }
    let some s := st.map[ss]? | return NFA.empty
    let m := if !ss.isDisjoint mi.finals then st.m.addFinal s else st.m
    let st := (FinEnum.toList A).foldl (init := { st with m }) fun st a =>
      let ss' := mi.transSet ss a
      let (s', st) := if let some s' := st.map[ss']? then (s', st) else
        let (s', m) := st.m.newState
        let map := st.map.insert ss' s'
        let worklist := ss' :: st.worklist
        (s', { map, worklist, m })
      { st with m := st.m.addTrans a s s'}
    go st
  else
    st.m
  decreasing_by sorry

def NFA.neg (m : NFA A) : NFA A := m.determinize.flipFinals

end determinization

section equality

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

private structure isIncluded.State where
  visited : List (_root_.State × Std.HashSet _root_.State) := ∅ -- TODO: slow
  worklist : List (_root_.State × Std.HashSet _root_.State) := ∅

-- TODO: this function is not correct yet...
/-- Returns true when `L(m1) ⊆ L(m2)` -/
def NFA.isIncluded (m1 m2 : NFA A) : Bool :=
  let st := { visited := [], worklist := m1.initials.fold (init := []) fun res s1 => (s1, m2.initials) :: res }
  go st
where go (st : isIncluded.State) : Bool :=
  if let some ((s1, ss1), worklist) := st.worklist.next? then
    let st := { st with worklist }
    if m1.initials.contains s1 ∧ ss1.isDisjoint m2.finals then
      false
    else
      let st := { st with visited := (s1, ss1) :: st.visited }
      let st := (FinEnum.toList (α := A)).foldl (init := st) fun st a =>
        let ss2 := m2.transSet ss1 a
        (m1.trans.getD (s1, a) ∅).fold (init := st) fun st s2 =>
          if st.worklist.any (fun (s'', ss'') => s'' = s2 && HashSet.areIncluded ss'' ss2) ||
            st.visited.any (fun (s'', ss'') => s'' = s2 && HashSet.areIncluded ss'' ss2) then
            st
          else
            { st with worklist := (s2, ss2)::st.worklist }
      go st
  else
    true
  decreasing_by sorry

end equality

section universality

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

private structure isUniversal.State where
  visited : Std.HashSet (Std.HashSet _root_.State) := ∅
  worklist : Array (Std.HashSet _root_.State) := ∅

/-- Returns true when `L(m) = A*` -/
def NFA.isUniversal (m : NFA A) : Bool :=
  let st := { visited := ∅, worklist := Array.singleton m.initials}
  go st
where go (st : isUniversal.State) : Bool :=
  match heq : st.worklist.back? with
  | none => true
  | some ss =>
    let worklist := st.worklist.pop
    let st := { st with worklist }
    if ss.isDisjoint m.finals then
      false
    else
      let st := { st with visited := st.visited.insert ss }
      let st := (FinEnum.toList (α := A)).foldl (init := st) fun st a =>
        let ss' := m.transSet ss a
        if st.worklist.any (fun ss'' => HashSet.areIncluded ss'' ss') ||
           st.visited.any (fun ss'' => HashSet.areIncluded ss'' ss') then
           st
        else
           { st with worklist := st.worklist.push ss' }
      go st
  decreasing_by sorry

/-- Recognizes the empty word -/
def NFA.emptyWord : NFA A :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  m

/-- Returns true when `L(m) ∪ {ε} = A*`. This is useful because the
    bitvector of with width zero has strange properties.
 -/
def NFA.isUniversal' (m : NFA A) : Bool :=
  m.union NFA.emptyWord |> NFA.isUniversal

-- TODO: this relies on the fact that all states are reachable!
def NFA.isEmpty (m : NFA A) : Bool := m.finals.isEmpty
def NFA.isNotEmpty (m : NFA A) : Bool := !m.finals.isEmpty

end universality

instance: Hashable (BitVec n) where
  hash x := Hashable.hash x.toFin

section lift_proj

-- Defined as bv'[i] = bv[f i]
def transport (f : Fin n2 → Fin n1) (bv : BitVec n1) : BitVec n2 :=
  (Fin.list n2).foldl (init := BitVec.zero n2) fun bv' (i : Fin _) => bv' ||| (BitVec.twoPow n2 i * bv[f i].toNat)

variable {n : Nat}

-- Morally, n2 >= n1
def NFA.lift (m1: NFA (BitVec n1)) (f : Fin n1 → Fin n2) : NFA (BitVec n2) :=
  let m2 : NFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  (List.range m2.stateMax).foldl (init := m2) fun m2 s =>
    (FinEnum.toList (BitVec n2)).foldl (init := m2) fun m2 (bv : BitVec n2) =>
      let newtrans := m1.trans.getD (s, transport f bv) ∅
      let oldtrans := m2.trans.getD (s, bv) ∅
      let trans := newtrans.union oldtrans
      if trans.isEmpty then m2 else { m2 with trans := m2.trans.insert (s, bv) trans }

-- Morally, n1 >= n2
def NFA.proj (m1: NFA (BitVec n1)) (f : Fin n2 → Fin n1) : NFA (BitVec n2) :=
  let m2 : NFA (BitVec n2) := { m1 with trans := Std.HashMap.empty }
  m1.trans.keys.foldl (init := m2) fun m2 (s, bv) =>
    let trans := m1.trans.getD (s, bv) ∅
    let bv' := transport f bv
    let oldtrans := m2.trans.getD (s, bv') ∅
    { m2 with trans := m2.trans.insert (s, bv') (trans.union oldtrans) }

end lift_proj
