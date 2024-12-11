/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Std.Data.HashSet
import Std.Data.HashMap
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.FinEnum
import Mathlib.Data.Vector.Basic
import Mathlib.Data.Vector.Defs
import Mathlib.Tactic.FinCases
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.Constructions
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FinEnum
import SSA.Experimental.Bits.AutoStructs.FiniteStateMachine
import SSA.Experimental.Bits.AutoStructs.NFA'

open AutoStructs
open Mathlib

@[simp] theorem Language.mem_setOf_eq {x : List α} {p : List α → Prop} :
    @Membership.mem (List α) (Language α) instMembershipListLanguage {y | p y} x = p x := by
  rfl

@[simp] theorem Language.trivial : x ∈ (⊤ : Language α) := by trivial

def NFA.sa (_ : NFA α σ) := σ → Language α

structure NFA.correct (M : NFA α σ) (ζ : M.sa) (L : Language α) where
  cond1 : ∀ w, (w ∈ L ↔ ∃ q ∈ M.accept, w ∈ ζ q)
  cond2 : ∀ w q, q ∈ M.eval w ↔ w ∈ ζ q

lemma NFA.correct_spec {M : NFA α σ} {ζ : M.sa} {L : Language α} :
    M.correct ζ L → M.accepts = L := by
  rintro ⟨h1, h2⟩
  simp [accepts]; ext w
  simp_all

abbrev BVRel := ∀ ⦃w⦄, BitVec w → BitVec w → Prop
abbrev BVNRel n := ∀ ⦃w⦄, Mathlib.Vector (BitVec w) n → Prop

def NFA'.sa (M : NFA' n) := M.σ → BVNRel n
def NFA'.sa2 (M : NFA' 2) := M.σ → BVRel

def langRel (R : BVNRel n) : Set (BitVecs n) :=
  { bvs | R bvs.bvs }

def langRel2 (R : BVRel) : Set (BitVecs 2) :=
  { bvs | R (bvs.bvs.get 0) (bvs.bvs.get 1) }

@[simp]
lemma in_enc : x ∈ enc '' S ↔ dec x ∈ S := by
  simp; constructor
  · simp; rintro y hS rfl; simp_all
  · rintro hS; use dec x; simp_all

@[simp]
lemma Mathlib.Vector.ofFn_0 {f : Fin 0 → α} : ofFn f = .nil := by
  simp [ofFn]

@[simp]
lemma BitVec.ofFn_0 {f : Fin 0 → Bool} : ofFn f = .nil := by
  apply eq_nil

@[simp]
lemma dec_snoc_in_langRel {n} {R : BVNRel n} {w : BitVecs' n} {a : BitVec n} :
    dec (w ++ [a]) ∈ langRel R ↔
      R (Mathlib.Vector.ofFn fun k => .cons (a.getLsbD k) ((dec w).bvs.get k)) := by
  simp [langRel]

@[simp]
lemma dec_snoc_in_langRel2 :
    dec (w ++ [a]) ∈ langRel2 R ↔ R (.cons (a.getLsbD 0) ((dec w).bvs.get 0))
                                   (.cons (a.getLsbD 1) ((dec w).bvs.get 1)) := by
  simp [langRel2]

-- move
@[simp]
theorem BitVec.cast_inj (h : w = w') {x y : BitVec w} : BitVec.cast h x = BitVec.cast h y ↔ x = y := by
  rcases h; simp

-- move
@[simp]
lemma Fin.cast_val {a : Fin n} (h : n = m) : (h ▸ a).val = a.val := by
  rcases h; simp

-- move
@[simp]
theorem BitVec.append_inj {x1 x2 : BitVec w} {y1 y2 : BitVec w'} :
    x1 ++ y1 = x2 ++ y2 ↔ x1 = x2 ∧ y1 = y2 := by
  constructor
  · rintro heq
    have h : ∀ (i : Fin (w + w')), (x1 ++ y1).getLsbD i = (x2 ++ y2).getLsbD i := by simp [heq]
    constructor
    · apply eq_of_getLsbD_eq; intros i
      sorry
      -- specialize h (i.addNat w')
      -- simp [getLsbD_append] at h
      -- assumption
    · sorry
      -- apply eq_of_getLsbD_eq; intros i
      -- specialize h (Nat.add_comm _ _ ▸ (i.castAdd w))
      -- simp [getLsbD_append] at h
      -- assumption
  · rintro ⟨rfl, rfl⟩; rfl

@[simp]
lemma BitVec.cons_inj : cons b1 bv1 = cons b2 bv2 ↔ (b1 = b2) ∧ bv1 = bv2 := by
  simp [cons]

@[simp] lemma BitVec.lk30 : (3#2 : BitVec 2)[0] = true := by rfl
@[simp] lemma BitVec.lk31 : (3#2 : BitVec 2)[1] = true := by rfl
@[simp] lemma BitVec.lk20 : (2#2 : BitVec 2)[0] = false := by rfl
@[simp] lemma BitVec.lk21 : (2#2 : BitVec 2)[1] = true := by rfl
@[simp] lemma BitVec.lk10 : (1#2 : BitVec 2)[0] = true := by rfl
@[simp] lemma BitVec.lk11 : (1#2 : BitVec 2)[1] = false := by rfl
@[simp] lemma BitVec.lk00 : (0#2 : BitVec 2)[0] = false := by rfl
@[simp] lemma BitVec.lk01 : (0#2 : BitVec 2)[1] = false := by rfl

structure NFA'.correct (M : NFA' n) (ζ : M.sa) (L : BVNRel n) where
  cond1 : ∀ ⦃w⦄ (bvn : Mathlib.Vector (BitVec w) n), (L bvn ↔ ∃ q ∈ M.M.accept, ζ q bvn)
  cond2 q : q ∈ M.M.start ↔ ζ q (Vector.replicate n .nil)
  cond3 q a {w} (bvn : Mathlib.Vector (BitVec w) n) : q ∈ M.M.stepSet { q | ζ q bvn } a ↔
              ζ q (Mathlib.Vector.ofFn fun k => BitVec.cons (a.getLsbD k) (bvn.get k))

structure NFA'.correct2 (M : NFA' 2) (ζ : M.sa2) (L : BVRel) where
  cond1 : ∀ (bv1 bv2 : BitVec w), (L bv1 bv2 ↔ ∃ q ∈ M.M.accept, ζ q bv1 bv2)
  cond2 q : q ∈ M.M.start ↔ ζ q .nil .nil
  cond3 q a w (bv1 bv2 : BitVec w) : q ∈ M.M.stepSet { q | ζ q bv1 bv2 } a ↔
              ζ q (BitVec.cons (a.getLsbD 0) bv1) (BitVec.cons (a.getLsbD 1) bv2)

lemma NFA'.correct_spec {M : NFA' n} {ζ : M.sa} {L : BVNRel n} :
    M.correct ζ L → M.accepts = langRel L := by
  rintro ⟨h1, h2, h3⟩
  simp [accepts, accepts']
  have heq : dec '' (enc '' langRel L) = langRel L := by simp
  rw [←heq]
  congr!
  suffices h : M.M.correct (fun q => enc '' langRel (ζ q)) (enc '' langRel L) by
    apply NFA.correct_spec h
  constructor
  · intros w; rw [in_enc]; simp [langRel, h1]; simp_rw [@in_enc _ _ w]; rfl
  intros w; induction w using List.list_reverse_induction
  case base =>
    intros q; simp only [NFA.eval_nil]; rw [in_enc]; simp [h2, langRel]
  case ind w a ih =>
    rintro q
    simp only [NFA.eval_append_singleton]
    rw [in_enc]
    have h : M.M.eval w = { q | w ∈ enc '' langRel (ζ q) } := by
      ext; rw [ih]; dsimp; rfl
    rw [dec_snoc_in_langRel]
    rw [h]; simp_rw [in_enc]
    simp [langRel, h3]

lemma NFA'.correct2_spec {M : NFA' 2} {ζ : M.sa2} {L : BVRel} :
    M.correct2 ζ L → M.accepts = langRel2 L := by
  rintro ⟨h1, h2, h3⟩
  suffices hc : M.correct (fun q w (bvn : Mathlib.Vector (BitVec w) 2) => ζ q (bvn.get 0) (bvn.get 1))
                      (fun w bvn => L (bvn.get 0) (bvn.get 1)) by
    rw [M.correct_spec hc]
    simp [langRel2, langRel]
  constructor
  · simp_all
  · intros q; simp_all; rfl
  · simp_all

section fsm

abbrev Alphabet (arity: Type) [FinEnum arity] := BitVec (FinEnum.card arity + 1)

variable {arity : Type} [FinEnum arity]

def finFunToBitVec (c : carry → Bool) [FinEnum carry] : BitVec (FinEnum.card carry) :=
  ((FinEnum.toList carry).enum.map (fun (i, x) => c x |> Bool.toNat * 2^i)).foldl (init := 0) Nat.add |> BitVec.ofNat _

def bitVecToFinFun [FinEnum ar] (bv : BitVec $ FinEnum.card ar) : ar → Bool :=
  fun c => bv[FinEnum.equiv.toFun c]

def NFA.ofFSM (p : FSM arity) : NFA (Alphabet arity) (p.α → Bool) where
  start := { q | q = p.initCarry }
  accept := ⊤
  step s a := {s' |
    let (s'', b) := p.nextBit s (bitVecToFinFun (a.truncate $ FinEnum.card arity))
    s' = s'' ∧ a.msb = b }

def _root_.NFA'.ofFSM'  (p : FSM arity) : NFA' (FinEnum.card arity + 1) where
  σ := p.α → Bool
  M := NFA.ofFSM p

@[simp]
abbrev inFSMRel (p : FSM arity) {w} (bvn : Mathlib.Vector (BitVec w) _) :=
  bvn.get (Fin.last (FinEnum.card arity)) = p.evalBV (fun ar => bvn.get (FinEnum.equiv.toFun ar))

def NFA'.ofFSM_sa (p : FSM arity) : (NFA'.ofFSM' p).sa := fun q _ bvn =>
    inFSMRel p bvn ∧ q = p.carryBV (fun ar => bvn.get (FinEnum.equiv.toFun ar))

-- TODO: improve this proof
def NFA'.ofFSM_correct (p : FSM arity) :
    (NFA'.ofFSM' p).correct (ofFSM_sa p) (fun _ bvn => inFSMRel p bvn) := by
  constructor
  · simp [inFSMRel, NFA.ofFSM, ofFSM', ofFSM_sa]
  · simp [inFSMRel, NFA.ofFSM, ofFSM', ofFSM_sa]; intros q; constructor
    · rintro rfl; constructor
      · apply Subsingleton.allEq
      · simp [FSM.carryBV]
    · rintro ⟨-, rfl⟩; simp [FSM.carryBV]
  · simp [inFSMRel, ofFSM']; intros q a w bvn
    have heq : a.getLsbD (FinEnum.card arity) = a.msb := by
      simp [BitVec.msb_eq_getLsbD_last]
    constructor
    · simp [NFA.stepSet]
      rintro x hsa hst
      simp [NFA.ofFSM] at hst
      rcases hst with ⟨hq, hmsb⟩
      simp [ofFSM_sa]; constructor
      · simp [FSM.evalBV]
        rw [heq, hmsb]
        unfold bitVecToFinFun
        simp
        ext i
        simp [BitVec.getLsbD_cons]
        split
        next hi =>
          rw [hi]
          simp [FSM.eval]
          congr
          rcases hsa with ⟨-, rfl⟩
          simp [FSM.carryBV]
          · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            simp [BitVec.getLsbD_cons]
            rw [ite_cond_eq_false]
            simp; omega
          · ext ar; simp [BitVec.getLsbD_cons]
        next hne =>
          sorry
          -- rcases i with ⟨i, hi⟩
          -- simp at hne ⊢
          -- have hlt : i < w := by omega
          -- rcases hsa with ⟨hsa, -⟩; simp [inFSMRel] at hsa
          -- simp [hsa, FSM.evalBV]
          -- rw [BitVec.ofFn_getLsbD' _ _ hlt]
          -- simp
          -- apply FSM.eval_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
          -- rw [ite_cond_eq_true]
          -- on_goal 2 => simp; omega
          -- rw [ite_cond_eq_true]
          -- on_goal 2 => simp; omega
          -- simp [BitVec.getLsbD_cons]
          -- rw [ite_cond_eq_false]
          -- simp; omega
      · rw [hq]
        rcases hsa with ⟨-, rfl⟩
        simp [FSM.carryBV, FSM.carry]; congr
        · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          simp [BitVec.getLsbD_cons]
          rw [ite_cond_eq_false]
          simp; omega
        · unfold bitVecToFinFun; simp [BitVec.getLsbD_cons]
    · rintro hsa; simp [NFA.stepSet]
      use p.carryBV (fun ar => bvn.get (FinEnum.equiv.toFun ar))
      rcases hsa with ⟨hrel, hcar⟩
      constructor
      · constructor
        sorry
        sorry
        -- on_goal 2 => rfl
        -- simp [inFSMRel] at *
        -- ext ⟨i, hi⟩
        -- simp
        -- rw [BitVec.eq_of_getLsbD_eq_iff] at hrel
        -- specialize hrel ⟨i, by omega⟩
        -- simp [BitVec.getLsbD_cons] at hrel
        -- rw [ite_cond_eq_false] at hrel
        -- on_goal 2 => simp; omega
        -- rw [hrel]
        -- simp [FSM.evalBV]
        -- repeat rw [BitVec.ofFn_getLsbD' _ _ (by omega)]
        -- simp
        -- apply FSM.eval_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
        -- rw [ite_cond_eq_true]
        -- on_goal 2 => simp; omega
        -- rw [ite_cond_eq_true]
        -- on_goal 2 => simp; omega
        -- simp [BitVec.getLsbD_cons]
        -- omega
      · rw [hcar]; simp [NFA.ofFSM]
        constructor
        · simp [FSM.carryBV, FSM.carry]; congr
          · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            simp [BitVec.getLsbD_cons]
            omega
          · unfold bitVecToFinFun; simp [BitVec.getLsbD_cons]
        · unfold inFSMRel at hrel
          rw [BitVec.eq_of_getLsbD_eq_iff] at hrel
          specialize hrel (Fin.last w)
          simp [BitVec.getLsbD_cons, heq] at hrel
          rw [hrel]; simp [FSM.evalBV, FSM.eval, FSM.carryBV]; congr
          · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            simp [BitVec.getLsbD_cons]
            omega
          · unfold bitVecToFinFun; simp [BitVec.getLsbD_cons]

def _root_.NFA'.ofFSM  (p : FSM arity) : NFA' (FinEnum.card arity + 1) :=
  _root_.NFA'.ofFSM' p |>.reduce

open BitStream in
lemma evalFinStream_evalFin {t : Term} {k : Nat} (hlt : k < w) (vars : Fin t.arity → BitVec w) :
    EqualUpTo w (t.evalFinStream (fun ar => BitStream.ofBitVec (vars ar))) (ofBitVec $ t.evalFin vars) := by
  induction t <;> simp
  case var => rfl
  case zero => unfold BitStream.ofBitVec; rintro _ _; simp
  case negOne =>
    unfold BitStream.ofBitVec; rintro _ _; simp [BitVec.negOne_eq_allOnes]; left; assumption
  case one =>
    unfold BitStream.ofBitVec; rintro k hk; simp
    cases k <;> simp_all
  case and => apply BitStream.and_congr <;> simp_all
  case or => apply BitStream.or_congr <;> simp_all
  case xor => apply BitStream.xor_congr <;> simp_all
  case not =>
    rcases w with ⟨⟩ | ⟨w⟩
    · intros _ _; omega
    · simp; apply BitStream.not_congr; simp_all
  case add =>
    symm; transitivity; apply ofBitVec_add
    symm; apply BitStream.add_congr <;> simp_all
  case sub =>
    symm; transitivity; apply ofBitVec_sub
    symm; apply BitStream.sub_congr <;> simp_all
  case neg =>
    symm; transitivity; apply ofBitVec_neg
    symm; apply BitStream.neg_congr; simp_all

-- @[simp]
-- lemma FSM.eval_bv (bvn : Mathlib.Vector (BitVec w) (t.arity + 1)) :
--   ((FSM.ofTerm t).evalBV fun ar => bvn.get ar.castSucc) =
--     (t.evalFin fun ar => bvn.get ar.castSucc) := by
--   simp [FSM.evalBV]; ext ⟨k, hk⟩
--   simp [BitVec.ofFn_getLsbD' _ _ hk, FSM.ofTerm]
--   rw [←(termEvalEqFSM t).good, evalFinStream_evalFin hk _ _ hk]
--   simp only [ite_eq_left_iff, not_lt]
--   intros _; omega

-- @[simp]
-- lemma NFA'.ofFSM_spec (t : Term) :
--     (ofFSM (FSM.ofTerm t)).accepts = t.language := by
--   simp [ofFSM, correct_spec (ofFSM_correct (FSM.ofTerm t)), langRel, Term.language]
--   ext bvs; simp; tauto

/--
Transforms an `FSM` of arity `k` to an `RawCNFA` of arity `k+1`.
This correponds to transforming a function with `k` inputs and
one output to a `k+1`-ary relation. By convention, the output
is the MSB of the alphabet.
-/
def CNFA.ofFSM (p : FSM arity) : CNFA (FinEnum.card arity + 1) :=
  worklistRun (BitVec (FinEnum.card p.α))
    (fun _ => true)
    #[finFunToBitVec p.initCarry]
    (by apply List.nodup_singleton)
    fun carry =>
      (FinEnum.toList (BitVec (FinEnum.card arity))).foldl (init := #[]) fun ts a =>
        let eval x := (p.nextBitCirc x).eval (Sum.elim (bitVecToFinFun carry) (bitVecToFinFun a))
        let res : Bool := eval none
        let carry' : BitVec (FinEnum.card p.α) := finFunToBitVec (fun c => eval (some c))
        ts.push (a.cons res, carry')

lemma CNFA.ofFSM_spec (p : FSM arity) :
    (CNFA.ofFSM p).Sim (NFA'.ofFSM p) := by
  sorry

end fsm
/- A bunch of RawCNFAs that implement the relations we care about -/
section nfas_relations

def RawCNFA.ofConst {w} (bv : BitVec w) : RawCNFA (BitVec 1) :=
  let m := RawCNFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let (s', m) := (List.range w).foldl (init := (s, m)) fun (s, m) i =>
    let b := bv[i]?.getD false
    let (s', m) := m.newState
    let m := m.addTrans (BitVec.ofBool b) s s'
    (s', m)
  m.addFinal s'

def RawCNFA.autEq : RawCNFA (BitVec 2) :=
  let m := RawCNFA.empty
  let (s, m) := m.newState
  let m := m.addInitial s
  let m := m.addFinal s
  let m := m.addTrans 0 s s
  let m := m.addTrans 3 s s
  m

def CNFA.autEq : CNFA 2 :=
  ⟨RawCNFA.autEq, by simp [RawCNFA.autEq]; sorry⟩

def NFA.autEq : NFA (BitVec 2) Unit :=
  { start := ⊤, accept := ⊤, step := fun () a => if a = 0 ∨ a = 3 then ⊤ else ⊥ }

def NFA'.autEq : NFA' 2 :=
  ⟨Unit, { start := ⊤, accept := ⊤, step := fun () a => if a = 0 ∨ a = 3 then ⊤ else ⊥ }⟩

def NFA'.eqRel : BVRel := fun _ x y => x = y

lemma NFA'.autEq_correct : autEq.correct2 (fun _ => eqRel) eqRel := by
  constructor <;> simp [autEq, eqRel]
  rintro ⟨⟩ ⟨a⟩ w bv1 bv2
  fin_cases a <;> simp [NFA.stepSet]

-- Automata recognizing unsigned comparisons

def RawCNFA.autUnsignedCmp (cmp: RelationOrdering) : RawCNFA (BitVec 2) :=
  let m := RawCNFA.empty
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

def CNFA.autUnsignedCmp (cmp: RelationOrdering) : CNFA 2 :=
  ⟨RawCNFA.autUnsignedCmp cmp, by sorry⟩

inductive NFA.unsignedCmpState : Type where
| eq | gt | lt

def NFA.unsignedCmpStep (q : NFA.unsignedCmpState) (a : BitVec 2) : Set NFA.unsignedCmpState :=
  match q, a with
  | .eq, 0 => { .eq } | .eq, 3 => { .eq } | .eq, 1 => { .gt } | .eq, 2 => { .lt }
  | .gt, 0 => { .gt } | .gt, 1 => { .gt } | .gt, 3 => { .gt } | .gt, 2 => { .lt }
  | .lt, 0 => { .lt } | .lt, 1 => { .gt } | .lt, 2 => { .lt } | .lt, 3 => { .lt }

def NFA.autUnsignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) unsignedCmpState where
  step := unsignedCmpStep
  start := {.eq}
  accept := match cmp with | .lt => {.lt} | .le => {.lt, .eq} | .gt => {.gt} | .ge => {.gt, .eq}

def NFA'.autUnsignedCmp (cmp: RelationOrdering) : NFA' 2 :=
  ⟨_, NFA.autUnsignedCmp cmp⟩

def AutoStructs.RelationOrdering.urel (cmp : RelationOrdering) : BVRel :=
  match cmp with
  | .lt => fun _ bv1 bv2 => bv1 <ᵤ bv2
  | .le => fun _ bv1 bv2 => bv1 ≤ᵤ bv2
  | .gt => fun _ bv1 bv2 => bv1 >ᵤ bv2
  | .ge => fun _ bv1 bv2 => bv1 ≥ᵤ bv2

def NFA'.autUnsignedCmpSA (q : NFA.unsignedCmpState) : BVRel :=
  match q with
  | .eq => fun _ bv1 bv2 => bv1 = bv2
  | .lt => fun _ bv1 bv2 => bv1 <ᵤ bv2
  | .gt => fun _ bv1 bv2 => bv1 >ᵤ bv2

lemma BitVec.ule_iff_ult_or_eq {w : ℕ} (bv1 bv2 : BitVec w):
    (bv2 ≥ᵤ bv1) = true ↔ (bv2 >ᵤ bv1) = true ∨ bv1 = bv2 := by
  simp [BitVec.ule, BitVec.ult, le_iff_lt_or_eq, BitVec.toNat_eq]

@[simp]
lemma BitVec.cons_ugt_iff {w} {bv1 bv2 : BitVec w} :
    (BitVec.cons b1 bv1 >ᵤ BitVec.cons b2 bv2) ↔ (if b1 = b2 then bv1 >ᵤ bv2 else b1) := by
  simp [BitVec.ult, Nat.shiftLeft_eq]
  rw [Nat.mul_comm]
  nth_rw 2 [Nat.mul_comm]
  have _ := bv1.isLt
  have _ := bv2.isLt
  repeat rw [←Nat.mul_add_lt_is_or] <;> try assumption
  cases b1 <;> cases b2 <;> simp <;> omega

@[simp]
lemma ucmp_tricho : (bv1 >ᵤ bv2) = false → (bv2 >ᵤ bv1) = false → bv1 = bv2 := by
  simp [BitVec.ule, BitVec.ult, BitVec.toNat_eq]
  apply Nat.le_antisymm

lemma NFA'.autUnsignedCmp_correct cmp : autUnsignedCmp cmp |>.correct2 autUnsignedCmpSA cmp.urel := by
  let getState {w} (bv1 bv2 : BitVec w) : NFA.unsignedCmpState :=
    if bv1 >ᵤ bv2 then .gt else if bv2 >ᵤ bv1 then .lt else .eq
  constructor <;> simp [NFA.autUnsignedCmp, autUnsignedCmp, autUnsignedCmpSA, AutoStructs.RelationOrdering.urel]
  · cases cmp <;> simp [BitVec.ule_iff_ult_or_eq]; tauto
  · rintro (_ | _ | _) <;> simp
  · rintro (_ | _ | _) a w bv1 bv2 <;> simp [NFA.stepSet, NFA.unsignedCmpStep]
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.unsignedCmpStep, instFinEnumBitVec_sSA]
      · rintro ⟨_, _⟩; use .eq; simp; fin_cases a <;> simp [instFinEnumBitVec_sSA] at * <;> tauto
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.unsignedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [instFinEnumBitVec_sSA] at *
        · use .gt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .gt; simp_all
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.unsignedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [instFinEnumBitVec_sSA] at *
        · use .lt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .lt; simp_all

-- Automata recognizing signed comparisons

def RawCNFA.autSignedCmp (cmp: RelationOrdering) : RawCNFA (BitVec 2) :=
  let m := RawCNFA.empty
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

def CNFA.autSignedCmp (cmp: RelationOrdering) : CNFA 2 :=
  ⟨RawCNFA.autSignedCmp cmp, by sorry⟩

inductive NFA.signedCmpState : Type where
| eq | gt | lt | ltfin | gtfin

def NFA.signedCmpStep (q : NFA.signedCmpState) (a : BitVec 2) : Set NFA.signedCmpState :=
  match q, a with
  | .eq, 0 => { .eq } | .eq, 3 => { .eq } | .eq, 1 => { .gt, .ltfin } | .eq, 2 => { .lt, .gtfin }
  | .gt, 0 => { .gt, .gtfin } | .gt, 1 => { .gt, .ltfin } | .gt, 3 => { .gt, .gtfin } | .gt, 2 => { .lt, .gtfin }
  | .lt, 0 => { .lt, .ltfin } | .lt, 1 => { .gt, .ltfin } | .lt, 2 => { .lt, .gtfin } | .lt, 3 => { .lt, .ltfin }
  | .gtfin, _ => ∅
  | .ltfin, _ => ∅

def NFA.autSignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) signedCmpState where
  step := signedCmpStep
  start := {.eq}
  accept := match cmp with | .lt => {.ltfin} | .le => {.ltfin, .eq} | .gt => {.gtfin} | .ge => {.gtfin, .eq}

def NFA'.autSignedCmp (cmp: RelationOrdering) : NFA' 2 :=
  ⟨_, NFA.autSignedCmp cmp⟩

def AutoStructs.RelationOrdering.srel (cmp : RelationOrdering) : BVRel :=
  match cmp with
  | .lt => fun _ bv1 bv2 => bv1 <ₛ bv2
  | .le => fun _ bv1 bv2 => bv1 ≤ₛ bv2
  | .gt => fun _ bv1 bv2 => bv1 >ₛ bv2
  | .ge => fun _ bv1 bv2 => bv1 ≥ₛ bv2

def NFA'.autSignedCmpSA (q : NFA.signedCmpState) : BVRel :=
  match q with
  | .eq => fun _ bv1 bv2 => bv1 = bv2
  | .lt => fun _ bv1 bv2 => bv1 <ᵤ bv2
  | .gt => fun _ bv1 bv2 => bv1 >ᵤ bv2
  | .ltfin => fun _ bv1 bv2 => bv1 <ₛ bv2
  | .gtfin => fun _ bv1 bv2 => bv1 >ₛ bv2

-- TODO: why is it BitVec.toInt_inj but its BitVec.toNat_eq?

lemma BitVec.sle_iff_slt_or_eq {w : ℕ} (bv1 bv2 : BitVec w):
    (bv2 ≥ₛ bv1) = true ↔ (bv2 >ₛ bv1) = true ∨ bv1 = bv2 := by
  simp [BitVec.sle, BitVec.slt, le_iff_lt_or_eq, BitVec.toInt_inj]

theorem Nat.add_lt_is_or {a} (a_lt : a < 2^i) :
    2^i + a = 2^i ||| a := by
  have _ := Nat.mul_add_lt_is_or a_lt 1
  simp_all

@[simp]
lemma BitVec.cons_sgt_iff {w} {bv1 bv2 : BitVec w} :
    (BitVec.cons b1 bv1 >ₛ BitVec.cons b2 bv2) ↔
      (if b1 = b2 then bv1 >ᵤ bv2 else b2) := by
  simp [BitVec.slt, BitVec.toInt_eq_msb_cond]
  have hbv1 := bv1.isLt
  have hbv2 := bv2.isLt
  cases b1 <;> cases b2 <;> simp [BitVec.ult, Nat.shiftLeft_eq] <;>
    repeat rw [←Nat.add_lt_is_or (by assumption)] <;> simp [Nat.two_pow_succ]
  · linarith [Nat.two_pow_succ w] -- why do I need to use `two_pow_succ` twice?
  · linarith [Nat.two_pow_succ w]
  · rw [←Nat.add_lt_is_or hbv1, ←Nat.add_lt_is_or hbv2]
    apply Nat.add_lt_add_iff_left

set_option maxHeartbeats 1000000 in
lemma NFA'.autSignedCmp_correct cmp : autSignedCmp cmp |>.correct2 autSignedCmpSA cmp.srel := by
  let getState {w} (bv1 bv2 : BitVec w) : NFA.signedCmpState :=
    if bv1 >ᵤ bv2 then .gt else if bv2 >ᵤ bv1 then .lt else .eq
  constructor <;> simp [NFA.autSignedCmp, autSignedCmp, autSignedCmpSA, AutoStructs.RelationOrdering.srel]
  · cases cmp <;> simp [BitVec.sle_iff_slt_or_eq]; tauto
  · rintro (_ | _ | _) <;> simp
  · rintro (_ | _ | _) a w bv1 bv2 <;> simp [NFA.stepSet, NFA.unsignedCmpStep]
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.signedCmpStep, instFinEnumBitVec_sSA]
      · rintro ⟨_, _⟩; use .eq; simp; fin_cases a <;> simp [instFinEnumBitVec_sSA] at * <;> tauto
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.signedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [NFA.signedCmpStep, instFinEnumBitVec_sSA] at *
        · use .gt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .gt; simp_all
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.signedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [NFA.signedCmpStep, instFinEnumBitVec_sSA] at *
        · use .lt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .lt; simp_all
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.signedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [NFA.signedCmpStep, instFinEnumBitVec_sSA] at *
        · use .lt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .lt; simp_all
    · constructor
      · rintro ⟨i, hi⟩; cases i <;> fin_cases a <;> simp_all [NFA.signedCmpStep, instFinEnumBitVec_sSA]
      · rintro _; fin_cases a <;> simp [NFA.signedCmpStep, instFinEnumBitVec_sSA] at *
        · use .gt; simp_all
        · use (getState bv1 bv2); simp [getState]; split_ifs <;> simp_all; apply ucmp_tricho <;> assumption
        · use .gt; simp_all

def RawCNFA.autMsbSet' : RawCNFA (BitVec 1) :=
  let m := RawCNFA.empty
  let (si, m) := m.newState
  let (sf, m) := m.newState
  let m := m.addInitial si
  let m := m.addFinal sf
  let m := m.addTrans 1 si sf
  let m := m.addManyTrans [0, 1] si si
  m

def CNFA.autMsbSet : CNFA 1 :=
  ⟨RawCNFA.autMsbSet', by sorry⟩

inductive NFA.msbState : Type where
| i | f

def NFA.msbStep (q : NFA.msbState) (a : BitVec 1) : Set NFA.msbState :=
  match q, a with
  | .i, 0 => {.i}
  | .i, 1 => {.i, .f}
  | _, _ => ∅

def NFA.msb : NFA (BitVec 1) msbState where
  step := msbStep
  start := {.i}
  accept := {.f}

def NFA'.autMsbSet : NFA' 1 := ⟨_, NFA.msb⟩

def NFA.msbLang : Language (BitVec 1) := { bvs  | bvs.getLast? = some 1 }

def NFA.msbSA (q : msbState) : Language (BitVec 1) :=
  match q with
  | .i => ⊤
  | .f => msbLang

-- TODO: rewrite with the n-ary `correct` predicate!
def NFA.msbCorrect : msb.correct msbSA msbLang := by
  constructor
  · simp [msb, msbSA]
  · intros w; induction w using List.list_reverse_induction
    case base =>
      simp [msb, msbSA, msbLang]; intros q; cases q <;> simp
    case ind w a ih =>
      have h : msb.eval w = { q | w ∈ msbSA q } := by ext; simp [ih]
      simp [h]; rintro (_ | _)
      · simp [msb, msbSA, msbLang, stepSet, msbStep]
        use .i; simp; fin_cases a <;> simp [instFinEnumBitVec_sSA]
      · simp [msb, msbSA, msbLang, stepSet, msbStep]; constructor
        · intro ⟨q, hq⟩; fin_cases a <;> simp [instFinEnumBitVec_sSA] at *
          cases q <;> simp_all
        · rintro rfl; use .i; simp

lemma CNFA.autMsbSet_spec : CNFA.autMsbSet.Sim NFA'.autMsbSet := by
  sorry

@[simp]
lemma autMsbSet_accepts : NFA'.autMsbSet.accepts = langMsb := by
  simp [NFA'.accepts, NFA'.accepts', NFA'.autMsbSet]
  rw [NFA.correct_spec NFA.msbCorrect, NFA.msbLang]
  ext bvs; simp only [BitVec.ofNat_eq_ofNat, Set.mem_image, Set.mem_setOf_eq]
  constructor
  · rintro ⟨bvs', hl, heq⟩
    have _ : bvs'.length ≠ 0 := by cases bvs'; tauto; simp
    rw [←heq]
    simp [dec]
    rw [BitVec.msb_eq_getLsbD_last]
    rw [BitVec.ofFn_getLsbD' _ _ (by omega)]
    simp
    rw [List.getLast?_eq_getElem?] at hl
    rw [List.getElem?_eq_getElem (by omega)] at hl
    injection hl
    simp_all only [BitVec.getLsbD_one, zero_lt_one, decide_true, Bool.and_self]
  · intros h; use enc bvs
    simp only [dec_enc', and_true]
    simp [enc]
    have hw : bvs.w ≠ 0 := by
      rcases bvs with ⟨w, bvs⟩; rintro rfl
      simp_all [BitVec.eq_nil (bvs.head)]
    use ⟨bvs.w - 1, by omega⟩
    simp; rw [List.getLast?_eq_getElem?]
    simp; constructor
    · sorry--rw [List.getElem?_eq_getElem (by simp; omega)]; simp
    · ext; rw [BitVec.ofFn_getLsbD' _ _ (by omega)]
      sorry
      -- rw [BitVec.msb_eq_getLsbD_last] at h
      -- simp [←BitVec.getLsbD_eq_getElem]
      -- exact h

end nfas_relations

def AutoStructs.Relation.autOfRelation : Relation → CNFA 2
| .eq => CNFA.autEq
| .signed ord => CNFA.autSignedCmp ord
| .unsigned ord => CNFA.autUnsignedCmp ord

def AutoStructs.Relation.absAutOfRelation (rel : Relation) : NFA' 2 :=
  match rel with
  | .eq => NFA'.autEq
  | .unsigned cmp => NFA'.autUnsignedCmp cmp
  | .signed cmp => NFA'.autSignedCmp cmp

lemma autOfRelation_spec (r : AutoStructs.Relation) :
  r.autOfRelation.Sim r.absAutOfRelation := by
  sorry

@[simp]
lemma autOfRelation_accepts (r : AutoStructs.Relation) :
    r.absAutOfRelation.accepts = r.language := by
  simp [AutoStructs.Relation.absAutOfRelation]
  rcases r with ⟨⟩ | ⟨cmp⟩ | ⟨cmp⟩ <;> simp
  · rw [NFA'.correct2_spec NFA'.autEq_correct]
    simp [langRel2, NFA'.eqRel, evalRelation]
  · rw [NFA'.correct2_spec (NFA'.autSignedCmp_correct cmp)]
    simp [langRel2, evalRelation, RelationOrdering.srel]
    cases cmp <;> simp
  · rw [NFA'.correct2_spec (NFA'.autUnsignedCmp_correct cmp)]
    simp [langRel2, evalRelation, RelationOrdering.urel]
    cases cmp <;> simp

def unopNfa (op : Unop) (m : CNFA n) : CNFA n :=
  match op with
  | .neg => m.neg

def unopAbsNfa (op : Unop) (M : NFA' n) : NFA' n :=
  match op with
  | .neg => M.neg

lemma unopNfa_spec (op : Unop) (m : CNFA n) (M : NFA' n) :
    m.Sim M → (unopNfa op m).Sim (unopAbsNfa op M) := by
  rcases op with ⟨⟩
  intros hsim
  apply CNFA.neg_spec; assumption

def binopNfa (op : Binop) (m1 m2 : CNFA n) : CNFA n :=
  match op with
  | .and => m1.inter m2
  | .or => m1.union m2
  | .impl => m1.neg.union m2
  | .equiv => (m1.neg.union m2).inter (m2.neg.union m1)

def binopAbsNfa (op : Binop) (M1 M2: NFA' n) : NFA' n :=
  match op with
  | .and => M1.inter M2
  | .or => M1.union M2
  | .impl => M1.neg.union M2
  | .equiv => (M1.neg.union M2).inter (M2.neg.union M1)

def nfaOfFormula (φ : Formula) : CNFA φ.arity :=
  match φ with
  | .atom rel t1 t2 =>
    let m1 := FSM.ofTerm t1 |> CNFA.ofFSM
    let m2 := FSM.ofTerm t2 |> CNFA.ofFSM
    let f1 := liftMaxSucc1 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m1' := m1.lift f1
    let f2 := liftMaxSucc2 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m2' := m2.lift f2
    let meq := rel.autOfRelation.lift $ liftLast2 (max (FinEnum.card (Fin t1.arity)) (FinEnum.card (Fin t2.arity)))
    let m := CNFA.inter m1' m2' |> CNFA.inter meq
    let mfinal := m.proj (liftExcept2 _)
    mfinal
  | .msbSet t =>
    let m := (termEvalEqFSM t).toFSM |> CNFA.ofFSM
    let mMsb := CNFA.autMsbSet.lift $ fun _ => Fin.last t.arity
    let res := m.inter mMsb
    res.proj $ fun n => n.castLE (by simp [Formula.arity, FinEnum.card])
  | .unop op φ => unopNfa op (nfaOfFormula φ)
  | .binop op φ1 φ2 =>
    let m1 := (nfaOfFormula φ1).lift $ liftMax1 φ1.arity φ2.arity
    let m2 := (nfaOfFormula φ2).lift $ liftMax2 φ1.arity φ2.arity
    binopNfa op m1 m2

def absNfaOfFormula (φ : Formula) : NFA' φ.arity :=
  match φ with
  | .atom rel t1 t2 =>
    let m1 := FSM.ofTerm t1 |> NFA'.ofFSM
    let m2 := FSM.ofTerm t2 |> NFA'.ofFSM
    let f1 := liftMaxSucc1 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m1' := m1.lift f1
    let f2 := liftMaxSucc2 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity)
    let m2' := m2.lift f2
    let meq := rel.absAutOfRelation.lift $ liftLast2 (max (FinEnum.card (Fin t1.arity)) (FinEnum.card (Fin t2.arity)))
    let m := NFA'.inter m1' m2' |> NFA'.inter meq
    let mfinal := m.proj (liftExcept2 _)
    mfinal
  | .msbSet t =>
    let m := (termEvalEqFSM t).toFSM |> NFA'.ofFSM
    let mMsb := NFA'.autMsbSet.lift $ fun _ => Fin.last t.arity
    let res := m.inter mMsb
    res.proj $ fun n => n.castLE (by simp [Formula.arity, FinEnum.card])
  | .unop op φ => unopAbsNfa op (absNfaOfFormula φ)
  | .binop op φ1 φ2 =>
    let m1 := (absNfaOfFormula φ1).lift $ liftMax1 φ1.arity φ2.arity
    let m2 := (absNfaOfFormula φ2).lift $ liftMax2 φ1.arity φ2.arity
    binopAbsNfa op m1 m2

lemma nfaOfFormula_spec φ : (nfaOfFormula φ).Sim (absNfaOfFormula φ) := by
  induction φ <;> unfold nfaOfFormula absNfaOfFormula <;> simp
  case atom rel t1 t2 =>
    apply CNFA.proj_spec
    apply CNFA.inter_spec
    apply CNFA.lift_spec; apply autOfRelation_spec
    apply CNFA.inter_spec
    apply CNFA.lift_spec; apply CNFA.ofFSM_spec
    apply CNFA.lift_spec; apply CNFA.ofFSM_spec
  case msbSet t =>
    apply CNFA.proj_spec
    apply CNFA.inter_spec
    · apply CNFA.ofFSM_spec
    · apply CNFA.lift_spec
      apply CNFA.autMsbSet_spec
  case unop op φ ih =>
    rcases op; simp [unopNfa, unopAbsNfa]
    apply CNFA.neg_spec
    assumption
  case binop op φ1 φ2 ih1 ih2 =>
    rcases op; simp [binopNfa, binopAbsNfa]
    · apply CNFA.inter_spec
      apply CNFA.lift_spec; assumption
      apply CNFA.lift_spec; assumption
    · apply CNFA.union_spec
      apply CNFA.lift_spec; assumption
      apply CNFA.lift_spec; assumption
    · apply CNFA.union_spec
      · apply CNFA.neg_spec
        apply CNFA.lift_spec; assumption
      · apply CNFA.lift_spec; assumption
    · apply CNFA.inter_spec <;>
      · apply CNFA.union_spec
        · apply CNFA.neg_spec
          apply CNFA.lift_spec; assumption
        · apply CNFA.lift_spec; assumption

-- lemma absNfaToFomrmula_spec (φ : Formula) :
--     (absNfaOfFormula φ).accepts = φ.language := by
--   induction φ
--   case atom rel t1 t2 =>
--     simp [absNfaOfFormula, binopAbsNfa]; ac_nf
--   case msbSet t =>
--     simp [absNfaOfFormula]
--   case unop op φ ih =>
--     simp [absNfaOfFormula, unopAbsNfa, ih]
--   case binop op φ1 φ2 ih1 ih2 =>
--     rcases op <;> simp [absNfaOfFormula, binopAbsNfa, langBinop, ih1, ih2]

/--
The theorem stating that the automaton generated from the formula φ recognizes
exactly the solution of φ.
-/
-- theorem absNfaToFomrmula_spec' (φ : Formula) :
--     (absNfaOfFormula φ).accepts = { (bvs : BitVecs φ.arity) | φ.sat (fun k => bvs.bvs.get k) = true } := by
--   simp [absNfaToFomrmula_spec, formula_language]

-- /--
-- info: 'absNfaToFomrmula_spec'' depends on axioms: [propext, Classical.choice, Quot.sound]
-- -/
-- #guard_msgs in #print axioms absNfaToFomrmula_spec'

/-
Note: it is important to define this function and not inline it, otherwise
each call to the tactic will compile a new function, which takes ~350ms on
my machine.
 -/
def formulaIsUniversal (f : Formula) : Bool :=
  let m := nfaOfFormula f
  m.isUniversal

-- theorem decision_procedure_is_correct {w} (φ : Formula) (env : Nat → BitVec w) :
--     formulaIsUniversal φ → φ.sat' env := by
--   unfold formulaIsUniversal; simp
--   intros h; apply CNFA.isUniversal_spec (nfaOfFormula_spec φ) at h
--   rw [absNfaToFomrmula_spec, formula_language] at h
--   rw [←sat_impl_sat']
--   have hx := env_to_bvs φ (fun k => env k.val)
--   extract_lets bvs at hx
--   suffices hin : bvs ∈ (⊤ : Set _) by
--     rw [←h] at hin
--     simp [Set.instMembership, Set.Mem] at hin; assumption
--   simp

-- -- For testing the comparison operators.
-- def nfaOfCompareConstants (signed : Bool) {w : Nat} (a b : BitVec w) : RawCNFA (BitVec 0) :=
--   let m1 := RawCNFA.ofConst a
--   let m2 := RawCNFA.ofConst b
--   let f1 : Fin 1 → Fin 2 := fun 0 => 0
--   let m1' := m1.lift f1
--   let f2 : Fin 1 → Fin 2 := fun 0 => 1
--   let m2' := m2.lift f2
--   let meq := if signed then RawCNFA.autSignedCmp .lt else RawCNFA.autUnsignedCmp .lt
--   let m := RawCNFA.inter m1' m2' |> RawCNFA.inter meq
--   let mfinal := m.proj (liftExcecpt2 _)
--   mfinal

-- /- This case is a bit weird because we have on the one hand an
--    automaton with a singleton alphabet, denoting a singleton set.
--    Hence the correpondance between a word and the unique bitvector in
--    `BitVec 0` is not super clear... This is why we check for non-emptiness
--    rather than universality. This shoud be clarified.
-- -/
-- def testLeq (signed : Bool) (w : Nat) : Option (BitVec w × BitVec w) :=
--   (List.range (2^w)).findSome? fun n =>
--     (List.range (2^w)).findSome? fun m =>
--       let bv := BitVec.ofNat w n
--       let bv' := BitVec.ofNat w m
--       if (if signed then bv <ₛ bv' else bv <ᵤ bv') ==
--         (nfaOfCompareConstants signed bv bv' |> RawCNFA.isNotEmpty)
--       then none else some (bv, bv')
-- /-- info: true -/
-- #guard_msgs in #eval! (testLeq true 4 == none)

-- def nfaOfMsb {w : Nat} (a : BitVec w) : RawCNFA (BitVec 0) :=
--   let m := RawCNFA.ofConst a
--   let meq := RawCNFA.autMsbSet
--   let m := m |> RawCNFA.inter meq
--   let mfinal := m.proj $ fun _ => 0
--   mfinal

-- def testMsb (w : Nat) : Bool :=
--   (List.range (2^w)).all fun n =>
--     let bv := BitVec.ofNat w n
--     (bv.msb == true) == (nfaOfMsb bv |> RawCNFA.isNotEmpty)
-- /-- info: true -/
-- #guard_msgs in #eval! testMsb 8

-- -- -x = ~~~ (x - 1)
-- def ex_formula_neg_eq_neg_not_one : Formula :=
--   open Term in
--   let x := var 0
--   Formula.atom .eq (neg x) (not $ sub x 1)

-- /-- info: true -/
-- #guard_msgs in #eval! nfaOfFormula ex_formula_neg_eq_neg_not_one |> RawCNFA.isUniversal

-- -- x &&& ~~~ y = x - (x &&& y)
-- def ex_formula_and_not_eq_sub_add : Formula :=
--   open Term in
--   let x := var 0
--   let y := var 1
--   Formula.atom .eq (and x (not y)) (sub x (and x y))
-- /-- info: true -/
-- #guard_msgs in #eval! nfaOfFormula ex_formula_and_not_eq_sub_add |> RawCNFA.isUniversal

-- /- x &&& y ≤ᵤ ~~~(x ^^^ y) -/
-- def ex_formula_and_ule_not_xor : Formula :=
--   open Term in
--   let x := var 0
--   let y := var 1
--   .atom (.unsigned .le) (.and x y) (.not (.xor x y))

-- /-- info: true -/
-- #guard_msgs in #eval! nfaOfFormula ex_formula_and_ule_not_xor |> RawCNFA.isUniversal

-- -- Only true for `w > 0`!
-- -- x = 0 ↔ (~~~ (x ||| -x)).msb
-- def ex_formula_eq_zero_iff_not_or_sub : Formula :=
--   open Term in
--   let x := var 0
--   .binop .equiv
--     (.atom .eq x .zero)
--     (.msbSet (.not (.or x (.neg x))))

-- /-- info: true -/
-- #guard_msgs in #eval! nfaOfFormula ex_formula_eq_zero_iff_not_or_sub |> RawCNFA.isUniversal'

-- -- (x <ₛ 0) ↔ x.msb := by
-- def ex_formula_lst_iff : Formula :=
--   open Term in
--   let x := var 0
--   .binop .equiv
--     (.atom (.signed .lt) x .zero)
--     (.msbSet x)

-- /-- info: true -/
-- #guard_msgs in #eval! nfaOfFormula ex_formula_lst_iff |> RawCNFA.isUniversal
