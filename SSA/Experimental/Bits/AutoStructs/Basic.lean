/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.FinEnum
import Mathlib.Tactic.FinCases
import SSA.Experimental.Bits.Fast.FiniteStateMachine

abbrev State := Nat

-- where to add the wellformedness conditions? a typeclass?
-- possible improvements for performance:
-- 1. change the representation, eg. transitions as
--       Array (Array (A × State))
-- as in LASH, or with BDD as in MONA
-- 2. Use the interleaving technique to reduce the number of transitions:
-- instead of having the alphabet `BitVec n`, it's simply `Bool` and the
-- representation of (a00, a01, .., a0k)(a10, a11, .., a1k)...(an0, an1, .., ank)
-- is (a00 a10 ... an0 a01 a11 ... an1 ...... ank)

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
        let some (s1, s2) := st0.worklist.get? (st0.worklist.size - 1) | return st0.m
        let st := { st0 with worklist := st0.worklist.pop }
        -- let _ : product.State.measure st m1 m2 < st0.measure m1 m2 := by simp
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
        decreasing_by
          simp [sizeOf]
          sorry

def NFA.inter (m1 m2 : NFA A) : NFA A := product (fun b1 b2 => b1 && b2) m1 m2
def NFA.union (m1 m2 : NFA A) : NFA A :=
  -- FIXME add a sink state to each automata, or modify product
  product (fun b1 b2 => b1 || b2) m1.addSink m2.addSink

end product

def HashSet.inter [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Std.HashSet A :=
  m1.fold (init := Std.HashSet.empty) fun mi x => if m2.contains x then mi.insert x else mi

def HashSet.areDisjoint [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  (HashSet.inter m1 m2).isEmpty

def HashSet.areIncluded [BEq A] [Hashable A] (m1 m2 : Std.HashSet A) : Bool :=
  m1.all (fun x => m2.contains x)

section universality

variable {A : Type} [BEq A] [Hashable A] [DecidableEq A] [FinEnum A]

private structure isUniversal.State where
  visited : List (Std.HashSet State) := ∅ -- TODO: slow
  worklist : List (Std.HashSet State) := ∅

def NFA.isUniversal (m : NFA A) : Bool :=
  let st := { visited := [], worklist := [m.initials]}
  go st
where go (st : isUniversal.State) : Bool :=
  if let some (ss, worklist) := st.worklist.next? then
    let st := { st with worklist }
    if HashSet.areDisjoint ss m.finals then
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

def NFA.isUniversal' (n : Nat) (m : NFA A) : Bool :=
  let st := { visited := [], worklist := [m.initials]}
  go n st
where go n (st : isUniversal.State) : Bool :=
  if n == 0 then false else
  if let some (ss, worklist) := st.worklist.next? then
    dbg_trace "msg with {reprStr ss}::{reprStr worklist}";
    if HashSet.areDisjoint ss m.finals then
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
      go (n-1) st
  else
    true
  decreasing_by sorry

end universality

instance: FinEnum (BitVec w) where
  card := 2^w
  equiv := {
    toFun := fun x => x.toFin
    invFun := fun x => BitVec.ofFin x
    left_inv := by intros bv; simp
    right_inv := by intros n; simp
  }

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

section fsm

variable {arity : Type} [FinEnum arity]

abbrev Alphabet := BitVec (FinEnum.card arity + 1)

private structure fsm.State (carryLen : Nat) where
  m : NFA $ Alphabet (arity := arity) -- TODO: ugly all over...
  map : Std.HashMap (BitVec carryLen) State := ∅
  worklist : Array (BitVec carryLen) := ∅

def finFunToBitVec (c : carry → Bool) [FinEnum carry] : BitVec (FinEnum.card carry) :=
  ((FinEnum.toList carry).enum.map (fun (i, x) => c x |> Bool.toNat * 2^i)).foldl (init := 0) Nat.add |> BitVec.ofNat _

def bitVecToFinFun [FinEnum ar] (bv : BitVec $ FinEnum.card ar) : ar → Bool := fun c => bv[FinEnum.equiv.toFun c]

partial
def NFA.ofFSM (p : FSM arity) [FinEnum p.α] : NFA (Alphabet (arity := arity)) :=
  let m := NFA.empty
  let (s, m) := m.newState
  let initState := finFunToBitVec p.initCarry
  let m := m.addInitial s
  let map := Std.HashMap.empty.insert initState s
  let worklist := Array.singleton initState
  let st : fsm.State (arity := arity) (FinEnum.card p.α) := { m, map, worklist }
  go st
where go (st : fsm.State (arity := arity) (FinEnum.card p.α)) : NFA _ := Id.run do
  let some carry := st.worklist.get? (st.worklist.size - 1) | return st.m
  let some s := st.map.get? carry | return NFA.empty
  let m := st.m.addFinal s
  let st := { st with m, worklist := st.worklist.pop }
  let st := (FinEnum.toList (BitVec (FinEnum.card arity))).foldl (init := st) fun st a =>
    let eval x := (p.nextBitCirc x).eval (Sum.elim (bitVecToFinFun carry) (bitVecToFinFun a))
    let res : Bool := eval none
    let carry' : BitVec (FinEnum.card p.α) := finFunToBitVec (fun c => eval (some c))

    let (s', st) := if let some s' := st.map.get? carry' then (s', st) else
      let (s', m) := st.m.newState
      let map := st.map.insert carry' s'
      let worklist := st.worklist.push carry'
      (s', {m, map, worklist})

    let m := st.m.addTrans (a.cons res) s s'
    { st with m }
  go st

end fsm

instance : FinEnum Bool where
  card := 2
  equiv := { toFun := fun x => if x then 0 else 1, invFun := fun (x : Fin 2 ) => if x == 0 then false else true,
             left_inv := by sorry, right_inv := by sorry }

instance : FinEnum Unit where
  card := 1
  equiv := { toFun := fun _ => 0, invFun := fun (_ : Fin 1) => (), left_inv := by sorry, right_inv := by sorry }


instance : FinEnum FSM.xor.α where
  card := 0
  equiv := {
    toFun := fun x => Empty.elim x
    invFun := fun (x : Fin 0) => Fin.elim0 x
    left_inv := by intros _; simp; sorry
    right_inv := by sorry }

instance : FinEnum FSM.and.α where
  card := 0
  equiv := {
    toFun := fun x => Empty.elim x
    invFun := fun (x : Fin 0) => Fin.elim0 x
    left_inv := by intros _; simp; sorry
    right_inv := by sorry }

def Rxor : NFA (BitVec 3) := NFA.ofFSM FSM.xor
def Rand : NFA (BitVec 3) := NFA.ofFSM FSM.and

def test : Fintype (Fin 3) := inferInstance

def swap_1_2 (n : Fin 3) : Fin 3 :=
  match n with
  | 0 => 1
  | 1 => 0
  | 2 => 2

def Rxy : NFA (BitVec 3) := Rxor
-- TODO: this creates garbage transitions to nowhere...
def Ryx : NFA (BitVec 3) := Rxor.lift swap_1_2
def Ryx' : NFA (BitVec 3) := Rxor.proj swap_1_2

def add4th (n : Fin 3) : Fin 4 :=
  match n with
  | 0 => 0
  | 1 => 1
  | 2 => 2

def add3rd (n : Fin 3) : Fin 4 :=
  match n with
  | 0 => 0
  | 1 => 1
  | 2 => 3

def Rxy4 : NFA (BitVec 4) := Rxy.lift add4th
#eval! Rxy4
def Ryx4 : NFA (BitVec 4) := Ryx'.lift add3rd
#eval! Ryx4

def Req : NFA (BitVec 2) :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  let m := m.addTrans 0 s s
  let m := m.addTrans 3 s s
  m

def add12 (n : Fin 2) : Fin 4 :=
  match n with
  | 0 => 2
  | 1 => 3

def add23 (n : Fin 2) : Fin 4 :=
  match n with
  | 0 => 0
  | 1 => 1

def Req4 : NFA (BitVec 4) := Req.lift add12

def Rhyp : NFA (BitVec 4) := Rxy4.inter Ryx4

def Rtest : NFA (BitVec 1) :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  let m := m.addTrans 0 s s
  let m := m.addTrans 1 s s
  m

/-- info: true -/
#guard_msgs in #eval! Rtest.isUniversal

def notRhyp := Rhyp.addSink.flipFinals

def form := notRhyp.union Req4

-- def wholeform := (notRhyp.union Req4).proj add23
def wholeform := (Rhyp.inter Req4).proj add23

-- corresponds to the formula with two free variables x and y:
--    ∃ a b, XOR(x, y) = a ∧ XOR (y, x) = b ∧ a = b
-- which corresponds to x XOR y = y XOR x in a relational style

/-- info: { stateMax := 1,
  initials := Std.HashSet.ofList [0],
  finals := Std.HashSet.ofList [0],
  trans := Std.HashMap.ofList [((0, 0x3#2), Std.HashSet.ofList [0]),
            ((0, 0x2#2), Std.HashSet.ofList [0]),
            ((0, 0x0#2), Std.HashSet.ofList [0]),
            ((0, 0x1#2), Std.HashSet.ofList [0])] }
-/
#guard_msgs in #eval! wholeform

-- this checks that the formula is universally true, for all x and y
/-- info: true -/
#guard_msgs in #eval! wholeform.isUniversal
