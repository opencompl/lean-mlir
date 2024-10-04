/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.FinEnum
import Mathlib.Tactic.FinCases
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.FiniteStateMachine

open AutoStructs

section fsm

abbrev Alphabet (arity: Type) [FinEnum arity] := BitVec (FinEnum.card arity + 1)

variable {arity : Type} [FinEnum arity]

private structure fsm.State (carryLen : Nat) where
  m : NFA $ Alphabet (arity := arity) -- TODO: ugly all over...
  map : Std.HashMap (BitVec carryLen) State := ∅
  worklist : Array (BitVec carryLen) := ∅

def finFunToBitVec (c : carry → Bool) [FinEnum carry] : BitVec (FinEnum.card carry) :=
  ((FinEnum.toList carry).enum.map (fun (i, x) => c x |> Bool.toNat * 2^i)).foldl (init := 0) Nat.add |> BitVec.ofNat _

def bitVecToFinFun [FinEnum ar] (bv : BitVec $ FinEnum.card ar) : ar → Bool := fun c => bv[FinEnum.equiv.toFun c]

/--
Transforms an `FSM` of arity `k` to an `NFA` of arity `k+1`.
This correponds to transforming a function with `k` inputs and
one output to a `k+1`-ary relation. By convention, the output
is the MSB of the alphabet.
-/
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


/- A bunch of NFAs that implement the relations we care about -/
section nfas_relations

def NFA.ofConst {w} (bv : BitVec w) : NFA (BitVec 1) :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let (s', m) := (List.range w).foldl (init := (s, m)) fun (s, m) i =>
    let b := bv[i]?.getD false
    let (s', m) := m.newState
    let m := m.addTrans (BitVec.ofBool b) s s'
    (s', m)
  m.addFinal s'

def NFA.autEq : NFA (BitVec 2) :=
  let m := NFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  let m := m.addTrans 0 s s
  let m := m.addTrans 3 s s
  m

def NFA.autSignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) :=
  let m := NFA.empty
  let (seq, m) := m.newState
  let (sgt, m) := m.newState
  let (slt, m) := m.newState
  let (sgtfin, m) := m.newState
  let (sltfin, m) := m.newState
  let m := m.addInitial seq
  let m := m.addManyTrans [0#2, 3#2] seq seq
  let m := m.addTrans 1#2 seq sgt
  let m := m.addTrans 2#2 seq slt
  let m := m.addTrans 1#2 seq sltfin
  let m := m.addTrans 2#2 seq sgtfin
  let m := m.addManyTrans [0#2, 1#2, 3#2] sgt sgt
  let m := m.addManyTrans [0#2, 2#2, 3#2] sgt sgtfin
  let m := m.addTrans 1#2 sgt sltfin
  let m := m.addTrans 2#2 sgt slt
  let m := m.addManyTrans [0#2, 2#2, 3#2] slt slt
  let m := m.addManyTrans [0#2, 1#2, 3#2] slt sltfin
  let m := m.addTrans 2#2 slt sgtfin
  let m := m.addTrans 1#2 slt sgt
  match cmp with
  | .lt => m.addFinal sltfin
  | .le => (m.addFinal sltfin).addFinal seq
  | .gt => m.addFinal sgtfin
  | .ge => (m.addFinal sgtfin).addFinal seq

def NFA.autUnsignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) :=
  let m := NFA.empty
  let (seq, m) := m.newState
  let (sgt, m) := m.newState
  let (slt, m) := m.newState
  let m := m.addInitial seq
  let m := m.addManyTrans [0#2, 3#2] seq seq
  let m := m.addTrans 1#2 seq sgt
  let m := m.addTrans 2#2 seq slt
  let m := m.addManyTrans [0#2, 1#2, 3#2] sgt sgt
  let m := m.addTrans 2#2 sgt slt
  let m := m.addManyTrans [0#2, 2#2, 3#2] slt slt
  let m := m.addTrans 1#2 slt sgt
  match cmp with
  | .lt => m.addFinal slt
  | .le => (m.addFinal slt).addFinal seq
  | .gt => m.addFinal sgt
  | .ge => (m.addFinal sgt).addFinal seq

def NFA.autMsbSet : NFA (BitVec 1) :=
  let m := NFA.empty
  let (si, m) := m.newState
  let (sf, m) := m.newState
  let m := m.addInitial si
  let m := m.addFinal sf
  let m := m.addTrans 1 si sf
  let m := m.addManyTrans [0, 1] si si
  m.determinize

end nfas_relations

-- A bunch of maps from `Fin n` to `Fin m` that we use to
-- lift and project variables when we interpret formulas
def liftMaxSucc1 (n m : Nat) : Fin (n + 1) → Fin (max n m + 2) :=
  fun k => if _ : k = n then Fin.last (max n m) else k.castLE (by omega)
def liftMaxSucc2 (n m : Nat) : Fin (m + 1) → Fin (max n m + 2) :=
  fun k => if _ : k = m then Fin.last (max n m + 1) else k.castLE (by omega)
def liftLast2 n : Fin 2 → Fin (n + 2)
| 0 => n
| 1 => n + 1
def liftExcecpt2 n : Fin n → Fin (n + 2) :=
  fun k => Fin.castLE (by omega) k
def liftMax1 (n m : Nat) : Fin n → Fin (max n m) :=
  fun k => k.castLE (by omega)
def liftMax2 (n m : Nat) : Fin m → Fin (max n m) :=
  fun k => k.castLE (by omega)

-- TODO(leo): style? upstream?
@[simp]
lemma finEnumCardFin n : FinEnum.card (Fin n) = n := by
  rw [FinEnum.card, FinEnum.fin, FinEnum.ofList, FinEnum.ofNodupList]
  simp only
  rw [List.Nodup.dedup]
  · simp
  · apply List.nodup_finRange

def AutoStructs.Relation.autOfRelation : Relation → NFA (BitVec 2)
| .eq => NFA.autEq
| .signed ord => NFA.autSignedCmp ord
| .unsigned ord => NFA.autUnsignedCmp ord

def unopNfa {A} [BEq A] [FinEnum A] [Hashable A]
  (op : Unop) (m : NFA A) : NFA A :=
  match op with
  | .neg => m.neg

-- TODO(leo) : why is the typchecking so slow?
def binopNfa {A} [BEq A] [FinEnum A] [Hashable A]
  (op : Binop) (m1 : NFA A) (m2 : NFA A) : NFA A :=
  match op with
  | .and => m1.inter m2
  | .or => m1.union m2
  | .impl => m1.neg.union m2
  | .equiv => (m1.neg.union m2).inter (m2.neg.union m1)

-- TODO(leo) : why is it so slow? 40 seconds on my machine
-- the slow part is the compilation apparently
def nfaOfFormula (φ : Formula) : NFA (BitVec φ.arity) :=
  match φ with
  | .atom rel t1 t2 =>
    let m1 := (termEvalEqFSM t1).toFSM |> NFA.ofFSM
    let m2 := (termEvalEqFSM t2).toFSM |> NFA.ofFSM
    let f1 := liftMaxSucc1 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m1' := m1.lift f1
    let f2 := liftMaxSucc2 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m2' := m2.lift f2
    let meq := rel.autOfRelation.lift $ liftLast2 (max (FinEnum.card (Fin t1.arity)) (FinEnum.card (Fin t2.arity)))
    let m := NFA.inter m1' m2' |> NFA.inter meq
    let mfinal := m.proj (liftExcecpt2 _)
    have h : (Formula.atom .eq t1 t2).arity = max (FinEnum.card (Fin t1.arity)) (FinEnum.card (Fin t2.arity)) := by simp [FinEnum.card]
    h ▸ mfinal
  | .msbSet t =>
    let m := (termEvalEqFSM t).toFSM |> NFA.ofFSM
    let mMsb := NFA.autMsbSet.lift $ fun _ => Fin.last t.arity
    have h : t.arity + 1 = FinEnum.card (Fin t.arity) + 1 := by
      simp [FinEnum.card]
    let m : NFA (BitVec (t.arity + 1)) := h.symm ▸ m
    let res := m.inter mMsb
    res.proj $ fun n => n.castLE (by rw [Formula.arity]; omega)
  | .unop op φ => unopNfa op (nfaOfFormula φ)
  | .binop op φ1 φ2 =>
    let m1 := (nfaOfFormula φ1).lift $ liftMax1 φ1.arity φ2.arity
    let m2 := (nfaOfFormula φ2).lift $ liftMax2 φ1.arity φ2.arity
    binopNfa op m1 m2

-- This is wrong, this is (hopefuly) true only for `w > 0`
axiom decision_procedure_is_correct {w} (φ : Formula) (env : Nat → BitVec w) :
  nfaOfFormula φ |>.isUniversal' → φ.sat' env

-- For testing the comparison operators.
def nfaOfCompareConstants (signed : Bool) {w : Nat} (a b : BitVec w) : NFA (BitVec 0) :=
  let m1 := NFA.ofConst a
  let m2 := NFA.ofConst b
  let f1 : Fin 1 → Fin 2 := fun 0 => 0
  let m1' := m1.lift f1
  let f2 : Fin 1 → Fin 2 := fun 0 => 1
  let m2' := m2.lift f2
  let meq := if signed then NFA.autSignedCmp .lt else NFA.autUnsignedCmp .lt
  let m := NFA.inter m1' m2' |> NFA.inter meq
  let mfinal := m.proj (liftExcecpt2 _)
  mfinal

/- This case is a bit weird because we have on the one hand an
   automaton with a singleton alphabet, denoting a singleton set.
   Hence the correpondance between a word and the unique bitvector in
   `BitVec 0` is not super clear... This is why we check for non-emptiness
   rather than universality. This shoud be clarified.
-/
def testLeq (signed : Bool) (w : Nat) : Option (BitVec w × BitVec w) :=
  (List.range (2^w)).findSome? fun n =>
    (List.range (2^w)).findSome? fun m =>
      let bv := BitVec.ofNat w n
      let bv' := BitVec.ofNat w m
      if (if signed then bv <ₛ bv' else bv <ᵤ bv') ==
        (nfaOfCompareConstants signed bv bv' |> NFA.isNotEmpty)
      then none else some (bv, bv')
/-- info: true -/
#guard_msgs in #eval! (testLeq true 4 == none)

def nfaOfMsb {w : Nat} (a : BitVec w) : NFA (BitVec 0) :=
  let m := NFA.ofConst a
  let meq := NFA.autMsbSet
  let m := m |> NFA.inter meq
  let mfinal := m.proj $ fun _ => 0
  mfinal

def testMsb (w : Nat) : Bool :=
  (List.range (2^w)).all fun n =>
    let bv := BitVec.ofNat w n
    (bv.msb == true) == (nfaOfMsb bv |> NFA.isNotEmpty)
/-- info: true -/
#guard_msgs in #eval! testMsb 8

-- -x = ~~~ (x - 1)
def ex_formula_neg_eq_neg_not_one : Formula :=
  open Term in
  let x := var 0
  Formula.atom .eq (neg x) (not $ sub x 1)

/-- info: true -/
#guard_msgs in #eval! nfaOfFormula ex_formula_neg_eq_neg_not_one |> NFA.isUniversal

-- x &&& ~~~ y = x - (x &&& y)
def ex_formula_and_not_eq_sub_add : Formula :=
  open Term in
  let x := var 0
  let y := var 1
  Formula.atom .eq (and x (not y)) (sub x (and x y))
/-- info: true -/
#guard_msgs in #eval! nfaOfFormula ex_formula_and_not_eq_sub_add |> NFA.isUniversal

/- x &&& y ≤ᵤ ~~~(x ^^^ y) -/
def ex_formula_and_ule_not_xor : Formula :=
  open Term in
  let x := var 0
  let y := var 1
  .atom (.unsigned .le) (.and x y) (.not (.xor x y))

/-- info: true -/
#guard_msgs in #eval! nfaOfFormula ex_formula_and_ule_not_xor |> NFA.isUniversal

-- Only true for `w > 0`!
-- x = 0 ↔ (~~~ (x ||| -x)).msb
def ex_formula_eq_zero_iff_not_or_sub : Formula :=
  open Term in
  let x := var 0
  .binop .equiv
    (.atom .eq x .zero)
    (.msbSet (.not (.or x (.neg x))))

/-- info: true -/
#guard_msgs in #eval! nfaOfFormula ex_formula_eq_zero_iff_not_or_sub |> NFA.isUniversal'

-- (x <ₛ 0) ↔ x.msb := by
def ex_formula_lst_iff : Formula :=
  open Term in
  let x := var 0
  .binop .equiv
    (.atom (.signed .lt) x .zero)
    (.msbSet x)

/-- info: true -/
#guard_msgs in #eval! nfaOfFormula ex_formula_lst_iff |> NFA.isUniversal
