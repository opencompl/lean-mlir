/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashSet
import Std.Data.HashMap
import Std.Data.HashMap.Lemmas
import Mathlib.Data.FinEnum
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.List.Infix
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.FinEnum

abbrev State := Nat

-- where to add the wellformedness conditions? a typeclass?
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

/- Question:
why does `Decidable (s ∈ l)` require `LawfulBEq` if `l` is a list and `DecidableEq` if `l` is an array?
-/

variable (A : Type) [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]
variable {S : Type} [BEq S] [LawfulBEq S] [Hashable S] [DecidableEq S]
variable (stateSpace : Finset S)

abbrev inSS : Type := { sa : S // sa ∈ stateSpace }

private structure worklist.St where
  m : NFA A
  map : Std.HashMap (inSS stateSpace) State := ∅
  worklist : Array { sa : inSS stateSpace // sa ∈ map.keys} := ∅
  worklist_nodup : worklist.toList.Nodup

private def worklist.St.meas (st : worklist.St A stateSpace) : ℕ :=
  Finset.card $ stateSpace.attach.filter fun x => x ∉ st.map.keys ∨ x ∈ st.worklist.toList.map fun x => x.val

private def worklist.St.addOrCreateState (st : worklist.St A stateSpace) (final? : Bool) (sa : S) : State × worklist.St A stateSpace := sorry

theorem List.dropLast_nodup (l : List X) : l.Nodup → l.dropLast.Nodup := by
  have hsl := List.dropLast_sublist l
  apply List.Nodup.sublist; trivial

theorem List.dropLasnodup (l : List X) : l.Nodup → l.dropLast.Nodup := by
  have hsl := List.dropLast_sublist l
  apply List.Nodup.sublist; trivial

@[simp]
theorem Array.not_elem_back_pop (a : Array X) (x : X) : a.toList.Nodup → a.back? = some x → x ∉ a.pop := by sorry

@[simp]
theorem Array.not_elem_back_pop_list (a : Array X) (x : X) : a.toList.Nodup → a.back? = some x → x ∉ a.toList.dropLast := by sorry

@[simp]
theorem Array.back_mem (a : Array X) (x : X) : a.back? = some x → x ∈ a := by sorry

def worklist.initState (init : inSS stateSpace) : worklist.St A stateSpace :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let map : Std.HashMap _ _ := {(init, s)}
  let init' : { sa : inSS stateSpace // sa ∈ map.keys } := ⟨init, by sorry /- TODO: should be trivial -/⟩
  let worklist := Array.singleton init'
  { m, map, worklist, worklist_nodup := by simp [worklist] }

def worklistRunAux (final : S → Bool) (f : S → Array (A × {sa : S | sa ∈ stateSpace })) (init : inSS stateSpace) : NFA A :=
  let st0 := worklist.initState _ _ init
  go st0
where go (st0 : worklist.St A stateSpace) : NFA A :=
  if hemp : st0.worklist.isEmpty then st0.m else
  let sa? := st0.worklist.back?
  have h1 : match sa? with
   | none => True
   | some _ => { st0 with worklist := st0.worklist.pop,  worklist_nodup := by apply List.dropLast_nodup; exact st0.worklist_nodup }.meas < st0.meas := by
    have hrem : sa? = st0.worklist.back? := by simp
    rcases sa? with ⟨⟩ | ⟨⟨sa, hsa1⟩, hsa2⟩ <;> simp
    apply Finset.card_lt_card
    simp [worklist.St.meas, Finset.ssubset_iff, Finset.subset_iff]
    use sa
    use hsa1
    constructor
    { constructor; assumption; symm at hrem; apply Array.not_elem_back_pop_list at hrem; intros hc; simp at hrem
      rw [← List.map_dropLast] at hc
      apply List.exists_of_mem_map at hc
      rcases hc with ⟨⟨⟨sa', hsa''⟩, hsa'⟩, hc, heq⟩
      simp at heq
      subst heq
      aesop
      exact st0.worklist_nodup }
    constructor
    { right; use hsa2; symm at hrem; apply Array.back_mem at hrem; apply Array.Mem.val; trivial }
    rintro sa' hsa' hh; rcases hh with hnin | hin
    { left; trivial }
    right
    rw [← List.map_dropLast] at hin
    apply List.exists_of_mem_map at hin
    rcases hin with ⟨⟨⟨sa', hsa''⟩, hsa'⟩, hc, heq⟩
    simp at heq
    rcases heq
    use hsa'
    apply List.mem_of_mem_dropLast
    trivial

  match sa? with
  | some sa =>
    let wl := st0.worklist.pop
    let st1 := { st0 with worklist := wl, worklist_nodup := by simp [wl]; apply List.dropLast_nodup; exact st0.worklist_nodup }
    if let some s := st1.map.get? sa then
      let a := f sa
      let st2 := a.foldl (init := st1) fun st (a', sa') =>
        let (s', st') := st.addOrCreateState _ _ (final sa') sa'
        have : st'.meas ≤ st.meas := by sorry -- should follow from the aux function's properties
        let m := st'.m.addTrans a' s s'
        { st' with m }
      have hincl : st1.map.keys ⊆ st2.map.keys := by sorry
      have : st1.meas < st0.meas := by simp at h1; simp [st1]; assumption
      have : st2.meas ≤ st1.meas := by
        apply Finset.card_le_card
        simp [worklist.St.meas, Finset.subset_iff]
        intros sa' hsa' h -- we need to know that map.keys is ever growing too
        rcases h with hnin | ⟨hsa'', hin⟩
        { left; simp [st1] at hincl; intros hc; apply hnin; apply hincl; assumption }
        by_cases hnew : ⟨sa', hsa'⟩ ∈ st0.map.keys
        all_goals try (left; trivial)
        right; use hnew
        sorry
      have : st2.meas < st0.meas := by omega
      go st2
    else
      st0.m -- never happens
  | none => st0.m -- never happens
  termination_by st0.meas

end worklist

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
  map : Std.HashMap (State × State) State := ∅
  worklist : Array (State × State) := ∅

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
        -- for termination, we need to know that worklist ⊆ map.keys ⊆ [0..max1] × [0..max2]
        -- or something like this
        decreasing_by {
          sorry
          -- apply List.foldl_lt (fun st : product.State => sizeOf (st.measure m1 m2))
          -- · simp
          --   cases (final? (m1.finals.contains s1) (m2.finals.contains s2))
          --   { simp [product.State.measure, sizeOf]
          --     apply Multiset.sizeOf_subset
          --     { sorry }
          --     { intros contra
          --       congr contra

          --      }
          --    }
          --   { sorry }
          -- · sorry
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

section universality

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

private structure isUniversal.State where
  visited : List (Std.HashSet State) := ∅ -- TODO: slow
  worklist : List (Std.HashSet State) := ∅

/-- Returns true when `L(m) = A*` -/
def NFA.isUniversal (m : NFA A) : Bool :=
  let st := { visited := [], worklist := [m.initials]}
  go st
where go (st : isUniversal.State) : Bool :=
  if let some (ss, worklist) := st.worklist.next? then
    let st := { st with worklist }
    if ss.isDisjoint m.finals then
      false
    else
      let st := { st with visited := ss :: st.visited }
      let st := (FinEnum.toList (α := A)).foldl (init := st) fun st a =>
        let ss' := m.transSet ss a
        if st.worklist.any (fun ss'' => HashSet.areIncluded ss'' ss') ||
           st.visited.any (fun ss'' => HashSet.areIncluded ss'' ss') then
           st
        else
           { st with worklist := ss'::st.worklist}
      go st
  else
    true
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

/-
  TODOs:
  1. to detect overflow (eg `AdditionNoOverflows?` in `HackersDelight.lean`), abs, ...
  2. clarify what happens with automata over the alphabet `BitVec 0`...
  3. for abs, do we have to eschew FSMs?
  ...
  n. Maybe we can deal with some shifts and powers of 2 if they are of the form `k` or `w - k`.

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
