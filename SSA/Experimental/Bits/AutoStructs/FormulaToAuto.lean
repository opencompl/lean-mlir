/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Batteries.Data.Fin.Basic
import Batteries.Data.Fin.Lemmas
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Experimental.Bits.AutoStructs.Constructions
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FiniteStateMachine

import Mathlib.Tactic.FinCases

set_option grind.warning false

open Mathlib

@[simp] theorem Language.mem_setOf_eq {x : List α} {p : List α → Prop} :
    @Membership.mem (List α) (Language α) Language.instMembershipList {y | p y} x = p x := rfl

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
abbrev BVNRel n := ∀ ⦃w⦄, List.Vector (BitVec w) n → Prop

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
lemma List.Vector.ofFn_0 {f : Fin 0 → α} : ofFn f = .nil := by
  simp [ofFn]

@[simp]
lemma BitVec.ofFn_0 {f : Fin 0 → Bool} : ofFn f = .nil := by
  apply eq_nil

@[simp]
lemma dec_snoc_in_langRel {n} {R : BVNRel n} {w : BitVecs' n} {a : BitVec n} :
    dec (w ++ [a]) ∈ langRel R ↔
      R (List.Vector.ofFn fun k => .cons (a.getLsbD k) ((dec w).bvs.get k)) := by
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
    have h : ∀ i, i < w + w' → (x1 ++ y1).getLsbD i = (x2 ++ y2).getLsbD i := by simp [heq]
    constructor
    · apply eq_of_getLsbD_eq; intros i hi
      specialize h (i + w') (by omega)
      simp [getLsbD_append] at h
      assumption
    · apply eq_of_getLsbD_eq; intros i hi
      specialize h i (by omega)
      simp [getLsbD_append] at h
      simp_all
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
  cond1 : ∀ ⦃w⦄ (bvn : List.Vector (BitVec w) n), (L bvn ↔ ∃ q ∈ M.M.accept, ζ q bvn)
  cond2 q : q ∈ M.M.start ↔ ζ q (List.Vector.replicate n .nil)
  cond3 q a {w} (bvn : List.Vector (BitVec w) n) : q ∈ M.M.stepSet { q | ζ q bvn } a ↔
              ζ q (List.Vector.ofFn fun k => BitVec.cons (a.getLsbD k) (bvn.get k))

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
  intros w; induction w using List.reverseRecOn
  case nil =>
    intros q; simp only [NFA.eval_nil]; rw [in_enc]; simp [h2, langRel]
  case append_singleton w a ih =>
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
  suffices hc : M.correct (fun q w (bvn : List.Vector (BitVec w) 2) => ζ q (bvn.get 0) (bvn.get 1))
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

def finFunToBitVec [fe : FinEnum carry] (c : carry → Bool) : BitVec (FinEnum.card carry) :=
  BitVec.ofFn fun i => c (fe.equiv.invFun i)

def bitVecToFinFun [FinEnum ar] (bv : BitVec $ FinEnum.card ar) : ar → Bool :=
  fun c => bv[FinEnum.equiv.toFun c]

@[simp]
lemma bitVecToFinFun_rinv (c : carry → Bool) [FinEnum carry]:
    bitVecToFinFun (finFunToBitVec c) = c := by
  ext x; simp [bitVecToFinFun, finFunToBitVec]

@[simp]
lemma bitVecToFinFun_linv [FinEnum ar] (bv : BitVec $ FinEnum.card ar) :
    finFunToBitVec (bitVecToFinFun bv) = bv := by
  ext i hi; simp [bitVecToFinFun, finFunToBitVec, hi]

@[simp]
lemma bitVecToFinFun_inj [FinEnum ar] : Function.Injective (bitVecToFinFun (ar := ar)) := by
  let g := finFunToBitVec (carry := ar)
  apply Function.LeftInverse.injective (g := g)
  apply bitVecToFinFun_linv

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
abbrev inFSMRel (p : FSM arity) {w} (bvn : List.Vector (BitVec w) _) :=
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
    have heq : a[FinEnum.card arity] = a.msb := by
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
        ext i hi
        simp [BitVec.getElem_cons]
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
            omega
          · ext ar; simp [BitVec.getElem_cons]; rfl
        next hne =>
          have hlt : i < w := by omega
          rcases hsa with ⟨hsa, -⟩; simp [inFSMRel] at hsa
          simp [hsa, FSM.evalBV]
          apply FSM.eval_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          simp [BitVec.getLsbD_cons]
          omega
      · rw [hq]
        rcases hsa with ⟨-, rfl⟩
        simp [FSM.carryBV, FSM.carry]; congr
        · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          rw [ite_cond_eq_true]
          on_goal 2 => simp; omega
          simp [BitVec.getLsbD_cons]
          omega
        · unfold bitVecToFinFun; simp [BitVec.getElem_cons]; rfl
    · rintro hsa; simp [NFA.stepSet]
      use p.carryBV (fun ar => bvn.get (FinEnum.equiv.toFun ar))
      rcases hsa with ⟨hrel, hcar⟩
      constructor
      · constructor
        on_goal 2 => rfl
        simp [inFSMRel] at *
        ext i hi
        rw [BitVec.eq_of_getElem_eq_iff] at hrel
        specialize hrel i (by omega)
        simp only [BitVec.getElem_cons, show ¬i = w by omega, ↓reduceDIte] at hrel
        rw [hrel]
        simp only [FSM.evalBV]
        repeat rw [BitVec.ofFn_getElem _ (by omega)]
        apply FSM.eval_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
        rw [ite_cond_eq_true]
        on_goal 2 => simp; omega
        rw [ite_cond_eq_true]
        simp [BitVec.getLsbD_cons]
        simp at hk; omega
        simp at hk ⊢; omega
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
          · unfold bitVecToFinFun; simp [BitVec.getElem_cons]; rfl
        · unfold inFSMRel at hrel
          rw [BitVec.eq_of_getLsbD_eq_iff] at hrel
          specialize hrel (Fin.last w)
          simp [BitVec.getElem_cons, heq] at hrel
          rw [hrel]; simp [FSM.evalBV, FSM.eval, FSM.carryBV]; congr
          · apply FSM.carry_eq_up_to; rintro ar k hk; simp [BitStream.ofBitVec]
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            rw [ite_cond_eq_true]
            on_goal 2 => simp; omega
            simp [BitVec.getLsbD_cons]
            omega
          · unfold bitVecToFinFun; simp [BitVec.getElem_cons]; rfl

def _root_.NFA'.ofFSM  (p : FSM arity) : NFA' (FinEnum.card arity + 1) :=
  _root_.NFA'.ofFSM' p -- |>.reduce

open BitStream in
lemma evalFinStream_evalFin {t : Term} {k : Nat} (hlt : k < w) (vars : Fin t.arity → BitVec w) :
    EqualUpTo w (t.evalFin (fun ar => BitStream.ofBitVec (vars ar))) (ofBitVec $ t.evalFinBV vars) := by
  induction t <;> simp
  case var => rfl
  case zero => unfold BitStream.ofBitVec; rintro _ _; simp
  case negOne =>
    unfold BitStream.ofBitVec; rintro _ _; simp [BitVec.neg_one_eq_allOnes]; left; assumption
  case one =>
    unfold BitStream.ofBitVec; rintro k hk; simp
    cases k <;> simp_all
  case ofNat =>
    intros i hi
    simp_all only [ofNat, ofBitVec, BitVec.getLsbD_eq_getElem, ite_true]
    -- TODO: should there be a BitVec.getElem_ofNat ?
    rw [←BitVec.getLsbD_eq_getElem]
    rw [BitVec.getLsbD_ofNat]
    simp_all
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
  case shiftL t k ih =>
    intros i hi
    have hik : i - k < w := by omega
    specialize ih vars (i-k) hik
    simp_all [ofBitVec]

@[simp]
lemma FSM.eval_bv (bvn : List.Vector (BitVec w) (t.arity + 1)) :
  ((FSM.ofTerm t).evalBV fun ar => bvn.get ar.castSucc) =
    (t.evalFinBV fun ar => bvn.get ar.castSucc) := by
  simp only [FSM.evalBV]; ext k hk
  simp only [FSM.ofTerm, hk, BitVec.ofFn_getElem]
  rw [←(termEvalEqFSM t).good, evalFinStream_evalFin hk _ _ hk]
  simp_all

@[simp]
lemma NFA'.ofFSM_spec (t : Term) :
    (ofFSM (FSM.ofTerm t)).accepts = t.language := by
  simp [ofFSM, correct_spec (ofFSM_correct (FSM.ofTerm t)), langRel, Term.language]
  ext bvs; simp; tauto

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
    f
  where
    @[inline]
    f carry :=
      (FinEnum.toList (BitVec (FinEnum.card arity))).foldl (init := #[]) fun ts a =>
        process carry ts a
    @[inline]
    process carry ts a :=
        let eval x := (p.nextBitCirc x).eval (Sum.elim (bitVecToFinFun carry) (bitVecToFinFun a))
        let res : Bool := eval none
        let carry' : BitVec (FinEnum.card p.α) := finFunToBitVec (fun c => eval (some c))
        ts.push (a.cons res, carry')

@[simp]
lemma CNFA.ofFSM.f_spec {p : FSM arity} {s s' : BitVec (FinEnum.card p.α)} :
    (a, s') ∈ f p s ↔ bitVecToFinFun s' ∈ (NFA.ofFSM p).step (bitVecToFinFun s) a := by
  let motive (as : List (BitVec (FinEnum.card arity))) := ∀ (acc : Array _) a s',
    ((a, s') ∈ as.foldl (init := acc) (process p s))
      ↔ (a, s') ∈ acc ∨ (a.setWidth (FinEnum.card arity) ∈ as) ∧
          bitVecToFinFun s' ∈ (NFA.ofFSM p).step (bitVecToFinFun s) a
  suffices h : motive (FinEnum.toList (BitVec (FinEnum.card arity))) by
    specialize h #[]
    simp [motive] at h
    rw [←h]
    rfl
  generalize FinEnum.toList (BitVec (FinEnum.card arity)) = qs
  induction qs
  case nil => simp [motive]
  case cons a as ih =>
    rintro acc b s'
    simp only [List.foldl_cons]; rw [ih]
    simp [process]
    constructor
    · rintro ((hacc | ⟨rfl, rfl⟩) | ⟨hin₁, hin₂⟩)
      · exact .inl hacc
      · right; simp [NFA.ofFSM]; constructor <;> rfl
      · right; simp_all only [or_true, and_self, motive]
    · rintro (hacc | ⟨(rfl | hold), hst⟩)
      · tauto
      · simp [NFA.ofFSM] at hst; left; right
        rcases hst with ⟨hs', hb⟩
        constructor
        · rw [←BitVec.cons_msb_setWidth b]
          simp_all only [BitVec.setWidth_cons, BitVec.cons_inj, and_true]; rfl
        · apply_fun bitVecToFinFun <;> simp only [hs', bitVecToFinFun_rinv, bitVecToFinFun_inj]
          rfl
      · tauto

lemma CNFA.ofFSM_spec (p : FSM arity) :
    (CNFA.ofFSM p).Sim (NFA'.ofFSM p) := by
  apply bisim_comp
  · apply worklistRun_spec
  use (λ s q ↦ q = bitVecToFinFun s)
  simp [nfa', nfa, NFA'.ofFSM, NFA'.ofFSM', NFA.ofFSM]
  constructor
  · simp
  · constructor <;> simp
  · aesop
  · rintro q₁ q₂ a q₂' rfl hst
    use (finFunToBitVec q₂')
    simpa [hst]

lemma CNFA.ofFSM_bv_language :
    (CNFA.ofFSM (FSM.ofTerm t)).bv_recognizes t.language := by
  rw [bv_recognizes_equiv]
  use NFA'.ofFSM (FSM.ofTerm t), ofFSM_spec (FSM.ofTerm t)
  exact NFA'.ofFSM_spec t

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
  ⟨RawCNFA.autEq, by simp [RawCNFA.autEq]; aesop⟩

def NFA.autEq : NFA (BitVec 2) Unit :=
  { start := ⊤, accept := ⊤, step _ a := { _s' | if a = 0 ∨ a = 3 then true else false }}

def NFA'.autEq : NFA' 2 :=
  ⟨Unit, NFA.autEq⟩

instance : Fintype (NFA'.autEq).σ := by simp [NFA'.autEq]; infer_instance
instance : DecidableEq (NFA'.autEq).σ := by simp [NFA'.autEq]; infer_instance
instance : DecidableNFA (NFA'.autEq).M := by
  simp [NFA'.autEq, NFA.autEq]; constructor <;> infer_instance
instance : DecidableNFA' (NFA'.autEq) where

def NFA'.eqRel : BVRel := fun _ x y => x = y

lemma NFA'.autEq_correct : autEq.correct2 (fun _ => eqRel) eqRel := by
  constructor <;> simp [autEq, NFA.autEq, eqRel]
  rintro ⟨⟩ ⟨a⟩ w bv1 bv2
  fin_cases a <;> simp [NFA.stepSet]

@[simp] lemma CNFA.autEq_stateMax : autEq.m.stateMax = 1 := by rfl
@[simp]
lemma CNFA.autEq_states : s ∈ autEq.m.states ↔ s = 0 := by
  simp [RawCNFA.states]

def autEq_equiv : CNFA.autEq.m.states ≃ NFA'.autEq.σ where
  toFun := fun ⟨s, hs⟩ =>
    match s with
    | _ => ()
  invFun q :=
    match q with
    | () => ⟨0, by simp⟩
  left_inv := by rintro ⟨x, hx⟩; symm; simp at hx; simp [hx]
  right_inv := by rintro ⟨⟩; simp

lemma CNFA.autEq_spec : autEq.Sim NFA'.autEq := by
  apply simulFun_sim autEq_equiv; constructor <;> native_decide +revert

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
  let mf := m.addTrans 1#2 slt sgt
  match cmp with
  | .lt => mf.addFinal slt
  | .le => (mf.addFinal slt).addFinal seq
  | .gt => mf.addFinal sgt
  | .ge => (mf.addFinal sgt).addFinal seq

-- TODO: make it faster with a custom tactic?
set_option maxHeartbeats 1000000 in
lemma RawCNFA.autoUnsignedCmp_wf {cmp} : autUnsignedCmp cmp |>.WF := by
  unfold autUnsignedCmp; aesop

def CNFA.autUnsignedCmp (cmp: RelationOrdering) : CNFA 2 :=
  ⟨RawCNFA.autUnsignedCmp cmp, RawCNFA.autoUnsignedCmp_wf⟩

@[simp]
lemma CNFA.autUnsignedCmp_stateMax cmp : (autUnsignedCmp cmp).m.stateMax = 3 := by
  rcases cmp <;> rfl

@[simp]
lemma CNFA.autUnsignedCmp_states cmp : s ∈ (autUnsignedCmp cmp).m.states ↔  s < 3 := by
  simp [RawCNFA.states]

inductive NFA.unsignedCmpState : Type where
| eq | gt | lt
deriving Fintype, DecidableEq

def NFA.unsignedCmpStep (q : NFA.unsignedCmpState) (a : BitVec 2) : List NFA.unsignedCmpState :=
  match q, a with
  | .eq, 0 => [ .eq ] | .eq, 3 => [ .eq ] | .eq, 1 => [ .gt ] | .eq, 2 => [ .lt ]
  | .gt, 0 => [ .gt ] | .gt, 1 => [ .gt ] | .gt, 3 => [ .gt ] | .gt, 2 => [ .lt ]
  | .lt, 0 => [ .lt ] | .lt, 1 => [ .gt ] | .lt, 2 => [ .lt ] | .lt, 3 => [ .lt ]

def NFA.autUnsignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) unsignedCmpState where
  step s a := { s' | s' ∈ unsignedCmpStep s a }
  start := {s | s = .eq }
  accept := { s | s ∈ match cmp with | .lt => [unsignedCmpState.lt] | .le => [.lt, .eq] | .gt => [.gt] | .ge => [.gt, .eq] }

def NFA'.autUnsignedCmp (cmp: RelationOrdering) : NFA' 2 :=
  ⟨_, NFA.autUnsignedCmp cmp⟩

@[simp] lemma NFA'.autUnsignedCmp_σ (cmp : RelationOrdering) : (NFA'.autUnsignedCmp cmp).σ = NFA.unsignedCmpState := by rcases cmp <;> rfl

instance {cmp} : Fintype (NFA'.autUnsignedCmp cmp).σ := by simp; infer_instance
instance {cmp} : DecidableEq (NFA'.autUnsignedCmp cmp).σ := by simp; infer_instance
instance {cmp} : DecidableNFA (NFA'.autUnsignedCmp cmp).M := by
  simp only [NFA'.autUnsignedCmp, NFA.autUnsignedCmp]; constructor <;> infer_instance
instance {cmp} : DecidableNFA' (NFA'.autUnsignedCmp cmp) where

def RelationOrdering.urel (cmp : RelationOrdering) : BVRel :=
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
  repeat rw [←Nat.two_pow_add_eq_or_of_lt] <;> try assumption
  cases b1 <;> cases b2 <;> simp <;> omega

@[simp]
lemma ucmp_tricho : (bv1 >ᵤ bv2) = false → (bv2 >ᵤ bv1) = false → bv1 = bv2 := by
  simp [BitVec.ule, BitVec.ult, BitVec.toNat_eq]
  apply Nat.le_antisymm

set_option maxHeartbeats 1000000 in
lemma NFA'.autUnsignedCmp_correct cmp : autUnsignedCmp cmp |>.correct2 autUnsignedCmpSA cmp.urel := by
  let getState {w} (bv1 bv2 : BitVec w) : NFA.unsignedCmpState :=
    if bv1 >ᵤ bv2 then .gt else if bv2 >ᵤ bv1 then .lt else .eq
  constructor <;> simp [NFA.autUnsignedCmp, autUnsignedCmp, autUnsignedCmpSA, RelationOrdering.urel]
  · rintro _ _ _; cases cmp <;> simp [BitVec.ule_iff_ult_or_eq]; tauto
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
  let (m, sltfin, sgtfin, seq) := m
  match cmp with
  | .lt => m.addFinal sltfin
  | .le => (m.addFinal sltfin).addFinal seq
  | .gt => m.addFinal sgtfin
  | .ge => (m.addFinal sgtfin).addFinal seq
where
  @[inline]
  m :=
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
    (m.addTrans 1#2 slt sgt, sltfin, sgtfin, seq)

-- TODO: make it faster with a custom tactic?
set_option maxHeartbeats 1000000 in
@[simp]
lemma RawCNFA.autSignedCmp_m_wf : autSignedCmp.m.1 |>.WF := by
  unfold autSignedCmp.m; aesop

-- TODO: make it faster with a custom tactic?
lemma RawCNFA.autSignedCmp_wf {cmp} : autSignedCmp cmp |>.WF := by
  unfold autSignedCmp; simp
  have _ : autSignedCmp.m.2.1 ∈ autSignedCmp.m.1.states := by unfold autSignedCmp.m; aesop
  have _ : autSignedCmp.m.2.2.1 ∈ autSignedCmp.m.1.states := by unfold autSignedCmp.m; aesop
  have _ : autSignedCmp.m.2.2.2 ∈ autSignedCmp.m.1.states := by unfold autSignedCmp.m; aesop
  aesop

def CNFA.autSignedCmp (cmp: RelationOrdering) : CNFA 2 :=
  ⟨RawCNFA.autSignedCmp cmp, RawCNFA.autSignedCmp_wf⟩

@[simp]
lemma CNFA.SignedCmp_stateMax cmp : (autSignedCmp cmp).m.stateMax = 5 := by
  rcases cmp <;> rfl

@[simp]
lemma CNFA.SignedCmp_states cmp : s ∈ (autSignedCmp cmp).m.states ↔  s < 5 := by
  simp [RawCNFA.states]

inductive NFA.signedCmpState : Type where
| eq | gt | lt | ltfin | gtfin
deriving DecidableEq, Fintype

def NFA.signedCmpStep (q : NFA.signedCmpState) (a : BitVec 2) : List NFA.signedCmpState :=
  match q, a with
  | .eq, 0 => [ .eq ] | .eq, 3 => [.eq] | .eq, 1 => [.gt, .ltfin] | .eq, 2 => [ .lt, .gtfin ]
  | .gt, 0 => [ .gt, .gtfin ] | .gt, 1 => [ .gt, .ltfin ] | .gt, 3 => [ .gt, .gtfin ] | .gt, 2 => [ .lt, .gtfin ]
  | .lt, 0 => [ .lt, .ltfin ] | .lt, 1 => [ .gt, .ltfin ] | .lt, 2 => [ .lt, .gtfin ] | .lt, 3 => [ .lt, .ltfin ]
  | .gtfin, _ => ∅
  | .ltfin, _ => ∅

def NFA.autSignedCmp (cmp: RelationOrdering) : NFA (BitVec 2) signedCmpState where
  step s a := { s' | s' ∈ signedCmpStep s a }
  start := { s | s = signedCmpState.eq }
  accept := { s | s ∈ match cmp with | .lt => [NFA.signedCmpState.ltfin] | .le => [.ltfin, .eq] | .gt => [.gtfin] | .ge => [.gtfin, .eq] }

def NFA'.autSignedCmp (cmp: RelationOrdering) : NFA' 2 :=
  ⟨_, NFA.autSignedCmp cmp⟩

@[simp] lemma NFA'.autSignedCmp_σ (cmp : RelationOrdering) : (NFA'.autSignedCmp cmp).σ = NFA.signedCmpState := by rcases cmp <;> rfl

instance {cmp} : Fintype (NFA'.autSignedCmp cmp).σ := by simp; infer_instance
instance {cmp} : DecidableEq (NFA'.autSignedCmp cmp).σ := by simp; infer_instance
instance {cmp} : DecidableNFA (NFA'.autSignedCmp cmp).M := by
  simp only [NFA'.autSignedCmp, NFA.autSignedCmp]; constructor <;> infer_instance
instance {cmp} : DecidableNFA' (NFA'.autSignedCmp cmp) where

def RelationOrdering.srel (cmp : RelationOrdering) : BVRel :=
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

private lemma BitVec.sle_iff_slt_or_eq {w : ℕ} (bv1 bv2 : BitVec w):
    (bv2 ≥ₛ bv1) = true ↔ (bv2 >ₛ bv1) = true ∨ bv1 = bv2 := by
  simp [BitVec.sle, BitVec.slt, le_iff_lt_or_eq, BitVec.toInt_inj]

theorem Nat.add_lt_is_or {a} (a_lt : a < 2^i) :
    2^i + a = 2^i ||| a := by
  have _ := Nat.two_pow_add_eq_or_of_lt a_lt 1
  simp_all

@[simp]
lemma BitVec.cons_sgt_iff {w} {bv1 bv2 : BitVec w} :
    (BitVec.cons b1 bv1 >ₛ BitVec.cons b2 bv2) ↔
      (if b1 = b2 then bv1 >ᵤ bv2 else b2) := by
  simp [BitVec.slt, BitVec.toInt_eq_msb_cond]
  have hbv1 := bv1.isLt
  have hbv2 := bv2.isLt
  have h₁ : bv1.toNat - bv2.toNat < 2 ^ w := by omega
  have h₂ : 2 ^ (w + 1) - 2 ^ w = 2 ^ w := by simp [Nat.two_pow_succ]
  have h₃ (x : Nat) : (2 : ℤ) ^ x = (2 ^ x : ℕ) := by simp_all only [Nat.cast_pow, Nat.cast_ofNat]
  have := h₃ w
  have := h₃ (w + 1)
  cases b1 <;> cases b2 <;> simp [BitVec.ult, Nat.shiftLeft_eq] <;>
    repeat rw [←Nat.add_lt_is_or (by assumption)] <;> simp [Nat.two_pow_succ]
  · omega
  · omega
  · rw [←Nat.add_lt_is_or hbv1, ←Nat.add_lt_is_or hbv2]
    apply Nat.add_lt_add_iff_left

set_option maxHeartbeats 1000000 in
lemma NFA'.autSignedCmp_correct cmp : autSignedCmp cmp |>.correct2 autSignedCmpSA cmp.srel := by
  let getState {w} (bv1 bv2 : BitVec w) : NFA.signedCmpState :=
    if bv1 >ᵤ bv2 then .gt else if bv2 >ᵤ bv1 then .lt else .eq
  constructor <;> simp [NFA.autSignedCmp, autSignedCmp, autSignedCmpSA, RelationOrdering.srel]
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

def unsigned_equiv cmp : (CNFA.autUnsignedCmp cmp).m.states ≃ (NFA'.autUnsignedCmp cmp).σ where
  toFun := fun ⟨s, hs⟩ =>
    match s with
    | 0 => .eq
    | 1 => .gt
    | _ => .lt
  invFun q :=
    match q with
    | .eq => ⟨0, by simp⟩
    | .gt => ⟨1, by simp⟩
    | .lt => ⟨2, by simp⟩
  left_inv := by
    simp; rintro ⟨x, hx⟩
    rcases x with _ | _ | _ | n
    · rfl
    · rfl
    · rfl
    · simp at hx; simp [State] at *; omega
  right_inv := by simp; rintro x; rcases x <;> rfl

lemma CNFA.autUnsignedCmp_spec {cmp} : (CNFA.autUnsignedCmp cmp).Sim (NFA'.autUnsignedCmp cmp) := by
  apply simulFun_sim (unsigned_equiv cmp)
  constructor <;> native_decide +revert

def signed_equiv cmp : (CNFA.autSignedCmp cmp).m.states ≃ (NFA'.autSignedCmp cmp).σ where
  toFun := fun ⟨s, hs⟩ =>
    match s with
    | 0 => .eq
    | 1 => .gt
    | 2 => .lt
    | 3 => .gtfin
    | _ => .ltfin
  invFun q :=
    match q with
    | .eq => ⟨0, by simp⟩
    | .gt => ⟨1, by simp⟩
    | .lt => ⟨2, by simp⟩
    | .gtfin => ⟨3, by simp⟩
    | .ltfin => ⟨4, by simp⟩
  left_inv := by
    simp; rintro ⟨x, hx⟩
    rcases x with _ | _ | _ | _ | _ | n
    · rfl
    · rfl
    · rfl
    · rfl
    · rfl
    · simp at hx; simp [State] at *; omega
  right_inv := by simp; rintro x; rcases x <;> rfl

lemma CNFA.autSignedCmp_spec {cmp} : (CNFA.autSignedCmp cmp).Sim (NFA'.autSignedCmp cmp) := by
  apply simulFun_sim (signed_equiv cmp)
  constructor <;> native_decide +revert

def RawCNFA.autMsbSet : RawCNFA (BitVec 1) :=
  let m := RawCNFA.empty
  let (si, m) := m.newState
  let (sf, m) := m.newState
  let m := m.addInitial si
  let m := m.addFinal sf
  let m := m.addTrans 1 si sf
  let m := m.addManyTrans [0, 1] si si
  m

lemma RawCNFA.autMsbSet_wf : autMsbSet.WF := by
  unfold autMsbSet; aesop

@[inline]
def CNFA.autMsbSet : CNFA 1 :=
  ⟨RawCNFA.autMsbSet, RawCNFA.autMsbSet_wf⟩

inductive NFA.msbState : Type where
| i | f
deriving DecidableEq, Fintype

def NFA.msbStep (q : NFA.msbState) (a : BitVec 1) : List NFA.msbState :=
  match q, a with
  | .i, 0 => [.i]
  | .i, 1 => [.i, .f]
  | _, _ => []

def NFA.autMsbSet : NFA (BitVec 1) msbState where
  step s a := { s' | s' ∈ msbStep s a }
  start := {.i}
  accept := {.f}

def NFA'.autMsbSet : NFA' 1 := ⟨_, NFA.autMsbSet⟩

instance : Fintype (NFA'.autMsbSet).σ := by simp [NFA'.autMsbSet]; infer_instance
instance : DecidableEq (NFA'.autMsbSet).σ := by simp [NFA'.autMsbSet]; infer_instance
instance : DecidableNFA (NFA'.autMsbSet).M := by
  simp [NFA'.autMsbSet, NFA.autMsbSet]; constructor <;> infer_instance
instance : DecidableNFA' (NFA'.autMsbSet) where

def NFA.msbLang : Language (BitVec 1) := { bvs  | bvs.getLast? = some 1 }

def NFA.msbSA (q : msbState) : Language (BitVec 1) :=
  match q with
  | .i => ⊤
  | .f => msbLang

def NFA.msbCorrect : NFA.autMsbSet.correct msbSA msbLang := by
  constructor
  · simp [NFA.autMsbSet, msbSA]
  · intros w; induction w using List.reverseRecOn
    case nil =>
      simp [NFA.autMsbSet, msbSA, msbLang]; intros q; cases q <;> simp
    case append_singleton w a ih =>
      have h : NFA.autMsbSet.eval w = { q | w ∈ msbSA q } := by ext; simp [ih]
      simp [h]; rintro (_ | _)
      · simp [NFA.autMsbSet, msbSA, msbLang, stepSet, msbStep]
        use .i; simp; fin_cases a <;> simp [instFinEnumBitVec_sSA]
      · simp [NFA.autMsbSet, msbSA, msbLang, stepSet, msbStep]; constructor
        · intro ⟨q, hq⟩; fin_cases a <;> simp [instFinEnumBitVec_sSA] at *
          cases q <;> simp_all
        · rintro rfl; use .i; simp

@[simp]
lemma autMsb_states : s ∈ CNFA.autMsbSet.m.states ↔ s < 2 := by
  simp [RawCNFA.states]; rfl

def autMsb_equiv : CNFA.autMsbSet.m.states ≃ NFA'.autMsbSet.σ where
  toFun := fun ⟨s, hs⟩ =>
    match s with
    | 0 => .i
    | 1 => .f
    | _ => .i
  invFun q :=
    match q with
    | .i => ⟨0, by simp⟩
    | .f => ⟨1, by simp⟩
  left_inv := by simp; rintro x; fin_cases x <;> rfl
  right_inv := by simp; rintro x; rcases x <;> rfl

lemma CNFA.autMsbSet_spec : CNFA.autMsbSet.Sim NFA'.autMsbSet := by
  apply simulFun_sim autMsb_equiv
  constructor <;> native_decide +revert

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
    rw [BitVec.ofFn_getLsbD (by omega)]
    simp
    rw [List.getLast?_eq_getElem?] at hl
    rw [List.getElem?_eq_getElem (by omega)] at hl
    injection hl
    simp_all only [BitVec.getElem_one, zero_lt_one, decide_true, Bool.and_self]
  · intros h; use enc bvs
    simp only [dec_enc', and_true]
    simp [enc]
    have hw : bvs.w ≠ 0 := by
      rcases bvs with ⟨w, bvs⟩; rintro rfl
      simp_all [BitVec.eq_nil (bvs.head)]
    use ⟨bvs.w - 1, by omega⟩
    simp; rw [List.getLast?_eq_getElem?]
    simp; constructor
    · rw [List.getElem?_eq_getElem (by simp; omega)]; simp
    · ext i hi; rw [BitVec.ofFn_getElem _ (by omega)]
      rw [BitVec.msb_eq_getLsbD_last] at h
      simp [←BitVec.getLsbD_eq_getElem]
      obtain rfl : i = 0 := by omega
      simp_all

lemma CNFA.autMsbSet_bv_language : autMsbSet.bv_recognizes langMsb := by
  rw [bv_recognizes_equiv]
  use NFA'.autMsbSet, autMsbSet_spec
  exact autMsbSet_accepts

def WidthPredicate.final? (wp : WidthPredicate) (n : Nat) (s : State) : Bool :=
  decide (wp.sat s n)

def RawCNFA.autWidth (wp : WidthPredicate) (n : Nat) : RawCNFA (BitVec 0) :=
  let m := (n+2).iterate f empty
  let m := m.addInitial 0
  m.addTrans (BitVec.zero 0) (n + 1) (n + 1)
where
  f m :=
    let (s, m) := m.newState
    let m := if wp.final? n s then m.addFinal s else m
    if s > 0 then m.addTrans (BitVec.zero 0) (s-1) s else m

set_option maxHeartbeats 1_000_000 in
lemma RawCNFA.autWidth_spec {wp : WidthPredicate} :
  let m := RawCNFA.autWidth wp n
  m.WF ∧ m.stateMax = n+2 ∧
  (∀ s, s ∈ m.states → (s ∈ m.initials ↔ s = 0) ∧ (s ∈ m.finals ↔ wp.final? n s)) ∧
  (∀ s s', s ∈ m.states → s' ∈ m.states → (s' ∈ m.tr s 0 ↔ if s = n+1 then s = s' else s' = s + 1))
  := by
    unfold autWidth
    lift_lets
    generalize h : n = k
    nth_rw 1 [←h]
    rintro m
    let motive (m : RawCNFA (BitVec 0)) k := m.WF ∧ (∀ i, i ∈ m.states ↔ i < k) ∧
      (∀ s, (s ∉ m.initials) ∧ (s ∈ m.finals ↔ (s ∈ m.states ∧ wp.final? n s))) ∧
      (∀ s s', (s' ∈ m.tr s 0 ↔ (s ∈ m.states ∧ s' ∈ m.states ∧ s' = s + 1)))
    have hsucc m k : motive m k → motive (autWidth.f wp n m) (k + 1) := by
      simp only [motive, autWidth.f]
      rintro ⟨hwf, hsts, hin, htrs⟩
      have hk : k = m.stateMax := by
        simp [states] at hsts; symm
        apply eq_of_forall_lt_iff (hsts ·)
      split_ands
      · split_ifs <;> try simp_all
        · apply wf_addTrans <;> simp_all
      · rintro i; split
        · split <;> simp_all <;> unfold State at * <;> omega
        · split <;> simp_all
      · rintro s
        simp only [newState_eq, gt_iff_lt, BitVec.zero_eq, motive]
        split <;> split <;> simp <;> grind
      · rintro s s'
        unfold State at *
        split <;> split <;> simp_all [State] <;> omega

    suffices h: motive m (k + 2) by
      simp only [motive]
      rcases h with ⟨hwf, hsts, hin, htrs⟩
      split_ands
      · simp_all
      · simp only [BitVec.zero_eq, addTrans_stateMax, addInitial_stateMax, motive]
        simp only [states, Finset.mem_range, motive] at hsts
        apply eq_of_forall_lt_iff (hsts ·)
      · rintro s hs; simp_all; grind
      · rintro s s' hs hs'; simp_all
        unfold State at *
        split <;> omega
    clear h
    unfold m
    generalize h : k+2 = z
    clear m h k
    induction z
    case zero =>
      simp [motive]
    case succ k ih =>
      obtain heq : k + 1 = 1 + k := by omega
      nth_rw 1 [heq, Function.iterate_add]
      simp
      apply hsucc
      apply ih

lemma RawCNFA.autWidth_wf {wp : WidthPredicate} : RawCNFA.autWidth wp n |>.WF := autWidth_spec.1

def CNFA.autWidth (wp : WidthPredicate) (n : Nat) : CNFA 0 :=
  ⟨RawCNFA.autWidth wp n, RawCNFA.autWidth_wf⟩

def NFA.autWidth (wp : WidthPredicate) (n : Nat) : NFA (BitVec 0) (Fin (n+2)) where
  start := { 0 }
  accept := { s | wp.final? n s }
  step s₁ _ := { s₂ | if s₁ = Fin.last (n+1) then s₁ = s₂ else s₂ = s₁ + 1 }

def NFA'.autWidth (wp : WidthPredicate) (n : Nat) : NFA' 0 := ⟨_, NFA.autWidth wp n⟩

def NFA.autWidthLang (wp : WidthPredicate) (n : Nat) : Language (BitVec 0) := { bvs  | wp.final? n bvs.length }

def NFA.autWidthSA (n : Nat) (q : Fin (n+2)) : Language (BitVec 0) :=
  if q = Fin.last (n+1) then { w | w.length > n } else { w | w.length = q }

@[simp]
lemma Fin.clamp_eq_bound : Fin.clamp m n = Fin.last n ↔ n ≤ m := by
  simp [Fin.ext_iff]

@[simp]
lemma Fin.clamp_neq_bound : Fin.clamp m n ≠ Fin.last n ↔ m < n := by
  simp [not_iff_not]

-- TODO: refactor, remove non-terminal simps
def NFA.autWidth_correct : (autWidth wp n).correct (autWidthSA n) (autWidthLang wp n) := by
  constructor
  · simp [autWidth, autWidthSA, autWidthLang]
    rintro w; constructor
    · rintro h; use (Fin.clamp w.length (n+1))
      simp_all only [Fin.coe_clamp, Fin.clamp_eq_bound]
      constructor
      · cases wp <;> simp_all [WidthPredicate.final?]; omega
      · split
        · simp only [Language.mem_setOf_eq]
          omega
        · simp only [Language.mem_setOf_eq, left_eq_inf]
          omega
    · rintro ⟨q, hfin, hlen⟩
      split at hlen <;> simp_all
      cases wp <;> simp_all [WidthPredicate.final?] <;> omega

  · intros w; induction w using List.reverseRecOn
    case nil =>
      simp only [autWidth, Set.setOf_eq_eq_singleton, eval_nil, Set.mem_singleton_iff, autWidthSA,
      gt_iff_lt]
      rintro q; constructor
      · rintro rfl; split <;> simp_all; exact rfl
      · split <;> simp_all [Fin.eq_of_val_eq]
        rintro h; exact (Fin.eq_of_val_eq h).symm
    case append_singleton w a ih =>
      rintro q; simp only [eval_append_singleton, stepSet, ih, Set.mem_iUnion, exists_prop]
      simp only [autWidthSA, gt_iff_lt, autWidth, Set.setOf_eq_eq_singleton, Set.mem_singleton_iff]
      constructor
      · rintro ⟨q', hq, heq⟩
        simp only [Set.mem_setOf_eq] at heq
        split_ifs at heq with hcond
        · subst heq hcond
          simp_all only [Fin.val_last, ite_true, Language.mem_setOf_eq, List.length_append,
            List.length_cons, List.length_nil, zero_add]
          omega
        · subst heq; simp_all
          apply Fin.val_lt_last at hcond
          split_ifs with hcond' <;> simp_all
          · suffices _ : n = q' by simp_all
            rw [Fin.ext_iff] at hcond'
            rw [Fin.val_add_one_of_lt hcond] at hcond'
            simp_all
          · exact (Fin.val_add_one_of_lt hcond).symm
      · rintro h; rcases q with ⟨q, hq⟩; split_ifs at h with hcond
        · simp at h
          by_cases hlen: w.length = n
          · use ⟨n, by omega⟩; simp [←hcond]
            have : n ≠ q := by rintro rfl; rw [Fin.ext_iff] at hcond; simp_all
            simp_all
            ext; simp
            have hlt : n < Fin.last (n+1) := by
              by_contra!; simp at this
            rw [Fin.val_add_one_of_lt hlt]
          · use ⟨q, hq⟩; simp_all
            omega
        · simp at h
          use q - 1
          have hneq : (q : Fin (n+2)) - 1 ≠ Fin.last (n + 1) := by
            rintro habs
            rw [Fin.ext_iff] at habs
            simp_all only [Fin.val_last]
            rw [Fin.sub_val_of_le] at habs
            · rw [←h] at habs
              simp_all
              rw [Nat.mod_eq_of_lt hq] at habs
              omega
            · rw [←h]
              simp_all only
              have : q ≥ 1 := by omega
              simpa [Fin.le_def, Nat.mod_eq_of_lt hq]
          simp [hneq]
          nth_rw 1 [←h]
          simp
          constructor
          · exact (Nat.mod_eq_of_lt (by omega)).symm
          · ext; simp; exact (Nat.mod_eq_of_lt (by omega)).symm

@[simp]
def NFA.autWidth_spec : (autWidth wp n).accepts = { bv | wp.sat bv.length n } := by
   simp [autWidthLang, correct_spec autWidth_correct, WidthPredicate.final?]

@[simp]
def NFA'.autWidth_spec : (autWidth wp n).accepts = { bv | wp.sat bv.w n } := by
  simp [accepts, accepts', autWidth]
  cases wp <;> ext bv <;> simp <;>
    · constructor
      · rintro ⟨x, hpred, rfl⟩; simpa
      · rintro hpred; use (enc bv); simpa

@[simp]
lemma CNFA.autWidth_stateMax : (autWidth wp n).m.stateMax = n + 2 := RawCNFA.autWidth_spec.2.1

@[simp]
lemma CNFA.autWidth_states: s ∈ (autWidth wp n).m.states ↔ s < n+2 := by
  simp [RawCNFA.states]

lemma CNFA.autWidth_initials : s ∈ (autWidth wp n).m.initials ↔ s = 0 := by
  have h := (@RawCNFA.autWidth_spec n wp).2.2.1
  by_cases hs : s ∈ (autWidth wp n).m.states
  · exact (h _ hs).1
  · constructor
    · rintro _; simp_all
    · rintro _; simp_all

lemma CNFA.autWidth_finals (hn : s < n + 2) : s ∈ (autWidth wp n).m.finals ↔ wp.final? n s := by
  have h := (@RawCNFA.autWidth_spec n wp).2.2.1
  exact (h _ (autWidth_states.mpr hn)).2

lemma CNFA.autWidth_tr (hs : s < n + 2) (hs' : s' < n + 2) : s' ∈ (autWidth wp n).m.tr s 0 ↔ if s = n+1 then s = s' else s' = s + 1 := by
  have h := (@RawCNFA.autWidth_spec n wp).2.2.2
  exact (h _ _ (autWidth_states.mpr hs) (autWidth_states.mpr hs'))

def autWidth_equiv : (CNFA.autWidth wp n).m.states ≃ (NFA'.autWidth wp n).σ where
  toFun := fun ⟨s, hs⟩ =>
    Fin.mk s (by simp_all)
  invFun q := ⟨q.val, by simp_all⟩
  left_inv := by rintro _; simp
  right_inv := by rintro _; simp

lemma CNFA.autWidth_spec : autWidth wp n |>.Sim (NFA'.autWidth wp n) := by
  apply simulFun_sim autWidth_equiv; simp [autWidth_equiv]; constructor
  · rintro q; simp_all [NFA'.autWidth, NFA.autWidth]; apply autWidth_finals (q.isLt)
  · rintro q; simp_all [NFA'.autWidth, NFA.autWidth]; rw [autWidth_initials]; exact
    eq_iff_eq_of_cmp_eq_cmp rfl
  · rintro a q q'; fin_cases a; simp_all [NFA'.autWidth, NFA.autWidth, instFinEnumBitVec_sSA];
    have h := @autWidth_tr q.val n q'.val wp q.isLt q'.isLt
    unfold State at *
    simp_all
    rcases q with ⟨q, hq⟩
    rcases q' with ⟨q', hq'⟩
    simp [Fin.last]
    split
    · rfl
    · rw [Fin.add_def]
      simp only [Fin.val_one, Fin.mk.injEq]
      rw [Nat.mod_eq_of_lt (by omega)]

lemma CNFA.autWidth_bv_language :
    (autWidth wp n).bv_recognizes { bv | wp.sat bv.w n }  := by
  rw [bv_recognizes_equiv]
  use NFA'.autWidth wp n, autWidth_spec
  exact NFA'.autWidth_spec

end nfas_relations

def Relation.autOfRelation : Relation → CNFA 2
| .eq => CNFA.autEq
| .signed ord => CNFA.autSignedCmp ord
| .unsigned ord => CNFA.autUnsignedCmp ord

def Relation.absAutOfRelation (rel : Relation) : NFA' 2 :=
  match rel with
  | .eq => NFA'.autEq
  | .unsigned cmp => NFA'.autUnsignedCmp cmp
  | .signed cmp => NFA'.autSignedCmp cmp

lemma autOfRelation_spec (r : Relation) :
  r.autOfRelation.Sim r.absAutOfRelation := by
  simp [Relation.autOfRelation, Relation.absAutOfRelation]
  rcases r
  · exact CNFA.autEq_spec
  · exact CNFA.autSignedCmp_spec
  · exact CNFA.autUnsignedCmp_spec

@[simp]
lemma autOfRelation_accepts (r : Relation) :
    r.absAutOfRelation.accepts = r.language := by
  simp [Relation.absAutOfRelation]
  rcases r with ⟨⟩ | ⟨cmp⟩ | ⟨cmp⟩ <;> simp
  · rw [NFA'.correct2_spec NFA'.autEq_correct]
    simp [langRel2, NFA'.eqRel, evalRelation]
  · rw [NFA'.correct2_spec (NFA'.autSignedCmp_correct cmp)]
    simp [langRel2, evalRelation, RelationOrdering.srel]
    cases cmp <;> simp
  · rw [NFA'.correct2_spec (NFA'.autUnsignedCmp_correct cmp)]
    simp [langRel2, evalRelation, RelationOrdering.urel]
    cases cmp <;> simp

lemma CNFA.autOfRelation_bv_language (r : Relation) :
    (r.autOfRelation).bv_recognizes r.language := by
  rw [bv_recognizes_equiv]
  use r.absAutOfRelation, autOfRelation_spec r
  exact autOfRelation_accepts r

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

lemma unopNfa_accepts (op : Unop) (M : NFA' n) :
    (unopAbsNfa op M).accepts = M.acceptsᶜ := by
  simp [unopAbsNfa]

lemma unopNfa_bv_language (op : Unop) :
    m.bv_recognizes L → (unopNfa op m).bv_recognizes Lᶜ := by
  repeat rw [CNFA.bv_recognizes_equiv]
  rintro ⟨M, hsim, rfl⟩
  use (unopAbsNfa op M), unopNfa_spec op m M hsim
  exact unopNfa_accepts op M

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

lemma binopNfa_bv_language (op : Binop) {m₁ m₂ : CNFA n}  :
    m₁.bv_recognizes L₁ → m₂.bv_recognizes L₂ →
    (binopNfa op m₁ m₂).bv_recognizes (langBinop op L₁ L₂) := by
  repeat rw [CNFA.bv_recognizes_equiv]
  rintro ⟨M₁, hsim₁, rfl⟩ ⟨M₂, hsim₂, rfl⟩
  use (binopAbsNfa op M₁ M₂)
  constructor
  · rcases op <;> simp_all [binopNfa, binopAbsNfa]
    · exact CNFA.inter_spec m₁ m₂ hsim₁ hsim₂
    · exact CNFA.union_spec m₁ m₂ hsim₁ hsim₂
    · apply CNFA.union_spec
      · exact CNFA.neg_spec m₁ hsim₁
      · assumption
    · apply CNFA.inter_spec
      · apply CNFA.union_spec
        · apply CNFA.neg_spec _ hsim₁
        · assumption
      · apply CNFA.union_spec
        · apply CNFA.neg_spec _ hsim₂
        · assumption
  · rcases op <;> simp_all [binopNfa, binopAbsNfa, langBinop]

def liftOp n : Fin (n + 1) → Fin (n + 3) :=
  fun k =>
    if k = n then Fin.last (n+2) else k.castLE (by omega)

@[simp]
def liftOp_unchanged (k : Fin n) : liftOp n k.castSucc = k.castLE (by simp) := by
  simp only [liftOp, Fin.coe_eq_castSucc, Fin.natCast_eq_last, Fin.castLE_castSucc,
    ite_eq_right_iff]
  rcases k with ⟨k, hk⟩
  simp only [Fin.castSucc_mk, Fin.last, Fin.mk.injEq, Fin.castLE_mk]; omega

def liftUnop n : Fin (n + 1) → Fin (n + 2) :=
  fun k =>
    if k = n then Fin.last (n+1) else k.castLE (by omega)

@[simp]
def liftUnop_unchanged (k : Fin n) : liftUnop n k = k.castLE (by simp) := by
  simp only [liftUnop, Fin.coe_eq_castSucc, Fin.natCast_eq_last, Fin.castLE_castSucc,
    ite_eq_right_iff]
  rcases k with ⟨k, hk⟩
  simp only [Fin.castSucc_mk, Fin.last, Fin.mk.injEq, Fin.castLE_mk]; omega

@[simp]
def liftUnop_unchanged' (k : Fin n) : liftUnop n k.castSucc = k.castLE (by simp) := by
  simp only [liftUnop, Fin.coe_eq_castSucc, Fin.natCast_eq_last, Fin.castLE_castSucc,
    ite_eq_right_iff]
  rcases k with ⟨k, hk⟩
  simp only [Fin.castSucc_mk, Fin.last, Fin.mk.injEq, Fin.castLE_mk]; omega

inductive TermBinop where
| and | or | xor | add | sub

def TermBinop.subst (op : TermBinop) (t₁ t₂ : Term) : Term :=
  match op with
  | .and => .and t₁ t₂
  | .or => .or t₁ t₂
  | .xor => .xor t₁ t₂
  | .add => .add t₁ t₂
  | .sub => .sub t₁ t₂

lemma TermBinop.subst_arity {op : TermBinop} : (op.subst t₁ t₂).arity = t₁.arity ⊔ t₂.arity := by
  rcases op <;> rfl

lemma TermBinop.subst_arity' {op : TermBinop} : (op.subst t₁ t₂).arity + 1= t₁.arity ⊔ t₂.arity + 1 := by
  rcases op <;> rfl

def TermBinop.openTerm (op : TermBinop) : Term := op.subst (.var 0) (.var 1)

@[simp]
def TermBinop.openTerm_arity (op : TermBinop) : op.openTerm.arity + 1 = 3 := by rcases op <;> rfl

def TermBinop.termGadget (t : TermBinop) : CNFA 3 :=
  match t with
  | .and => FSM.ofTerm (.and (.var 0) (.var 1)) |> CNFA.ofFSM
  | .or => FSM.ofTerm (.or (.var 0) (.var 1)) |> CNFA.ofFSM
  | .xor => FSM.ofTerm (.xor (.var 0) (.var 1)) |> CNFA.ofFSM
  | .add => FSM.ofTerm (.add (.var 0) (.var 1)) |> CNFA.ofFSM
  | .sub => FSM.ofTerm (.sub (.var 0) (.var 1)) |> CNFA.ofFSM

def autOfTermBinop (op : TermBinop) (m₁ : CNFA (n + 1)) (m₂ : CNFA (m + 1)) : CNFA ((n ⊔ m) + 1 ) :=
  let mop : CNFA 3 := op.termGadget
  let f₁ := liftMaxSuccSucc1 n m
  let m1' := m₁.lift f₁
  let f₂ := liftMaxSuccSucc2 n m
  let m2' := m₂.lift f₂
  let mop := mop.lift $ liftLast3 (max (FinEnum.card (Fin n)) (FinEnum.card (Fin m)))
  let m := CNFA.inter m1' m2' |> CNFA.inter mop
  let mfinal := m.proj (liftOp _)
  mfinal.minimize


@[simp]
lemma Set.mem_cast (A : W → Type) (P : A w → Prop) (h : w = w') (x : A w') :
  x ∈ h ▸ setOf P ↔
  P (h ▸ x) := by
  cases h
  simp

@[simp]
lemma BitVecs.cast_eq  (x : BitVecs n) (h : n = n') : h ▸ x = x.cast h := by
  cases h
  rfl

@[simp]
lemma List.Vector.cast_get {bvs : List.Vector (BitVec w) n} {h : n = n'} :
    (h ▸ bvs).get i = bvs.get (i.cast h.symm) := by
  cases h
  rfl

-- Upstream?
@[simp]
lemma Fin.castLE_toNat (x : Fin n) : (x.castLE h).val = x.val := by rfl

lemma Fin.natAdd_zero' [h : NeZero m] : Fin.natAdd (m := m) n 0 = n := by
  ext
  simp
  rw [Nat.mod_eq_of_lt]
  have := h.ne
  omega

@[simp]
lemma Fin.castSucc_neq_last (x : Fin n) : x.castSucc ≠ Fin.last n := by
  rintro h
  rcases x with ⟨x, hx⟩
  simp only [castSucc_mk, Fin.ext_iff, val_last] at h
  omega

def swapLastTwoBlock (x : Fin (n + 3)) : Fin (n + 3) :=
  if x = Fin.last (n+2) then n
  else if x = n+1 then Fin.last (n + 2)
  else if x = n then n + 1
  else x

@[simp] lemma swapLastTwoBlock_n {n : Nat} : swapLastTwoBlock (n := n) n = n + 1 := by
  simp [swapLastTwoBlock]
  rintro h
  rw [Fin.ext_iff] at h
  simp at h
  rw [Nat.mod_eq_of_lt (by omega)] at h
  omega

@[simp] lemma swapLastTwoBlock_Sn {n : Nat} : swapLastTwoBlock (n := n) (n+1) = Fin.last _ := by
   simp [swapLastTwoBlock, Fin.last, Fin.add_def, Nat.mod_eq_of_lt]

@[simp] lemma swapLastTwoBlock_SSn {n : Nat} : swapLastTwoBlock (Fin.last (n+2)) = n := by
   simp [swapLastTwoBlock]

@[simp] lemma swapLastTwoBlock_cast {n : Nat} {x : Fin m} (h : m ≤ n) : swapLastTwoBlock (n := n) (x.castLE (by omega)) = x := by
   rcases x with ⟨x, hx⟩
   simp [swapLastTwoBlock]
   split_ifs
   · simp_all [Fin.last, Fin.castLE]; omega
   · simp_all [Fin.last, Fin.castLE, Fin.ext_iff, Fin.add_def, Nat.mod_eq_of_lt]; omega
   · simp_all [Fin.last, Fin.ext_iff, Nat.mod_eq_of_lt]; omega
   · simp_all [Fin.last, Fin.ext_iff]; rw [Nat.mod_eq_of_lt (by omega)] at *

@[simp] lemma swapLastTwoBlock_cast' {n : Nat} {x : Fin (m + 1)} (h : m ≤ n) (hne : x ≠ Fin.last _) :
    swapLastTwoBlock (n := n) (x.castLE (by omega)) = x := by
  rcases x with ⟨x, hx⟩
  simp [swapLastTwoBlock]
  split_ifs
  · simp_all [Fin.last, Fin.castLE]; omega
  · simp_all [Fin.last, Fin.castLE, Fin.ext_iff, Fin.add_def, Nat.mod_eq_of_lt]; omega
  · simp_all [Fin.last, Fin.ext_iff, Nat.mod_eq_of_lt]; omega
  · simp_all [Fin.last, Fin.ext_iff]; rw [Nat.mod_eq_of_lt (by omega)] at *

set_option maxHeartbeats 1000000 in
lemma TermBinop.alt_lang {t₁ t₂ : Term} (op : TermBinop) :
  (op.subst_arity' ▸ (op.subst t₁ t₂).language) =
    let lop : Set (BitVecs 3) := op.openTerm_arity ▸ op.openTerm.language
    let lop' : Set (BitVecs ((t₁.arity ⊔ t₂.arity) + 3)) := lop.lift (liftLast3 (max t₁.arity t₂.arity))
    let l₁ := t₁.language.lift (liftMaxSuccSucc1 t₁.arity t₂.arity)
    let l₂ := t₂.language.lift (liftMaxSuccSucc2 t₁.arity t₂.arity)
    let l := l₁ ∩ l₂ ∩ lop'
    l.proj (liftOp _)
    := by
  simp [Term.language]
  ext bvs
  simp
  constructor
  · rintro heq
    let bvs' := bvs.bvs.append
                  (t₁.evalFinBV (λ n ↦ bvs.bvs.get n) ::ᵥ t₂.evalFinBV (λ n ↦ bvs.bvs.get n) ::ᵥ List.Vector.nil)
                |>.transport swapLastTwoBlock
    use ⟨_, bvs'⟩
    simp [bvs']
    split_ands
    · rw [liftMaxSuccSucc1]; simp
      conv =>
        enter [1, 2, n]
        rw [List.Vector.append_get_lt (by rcases n with ⟨n, hn⟩; simp_all; rw [Nat.mod_eq_of_lt (by omega)]; omega)]
        rfl

      rw [List.Vector.append_get_ge]
      on_goal 2 => apply Nat.le_of_eq; simp [Fin.add_def]; rw [Nat.mod_eq_of_lt (by omega)]

      generalize_proofs h₁ h₂ h₃ h₄
      have heq h : Fin.subNat (t₁.arity ⊔ t₂.arity + 1) (Fin.cast h₄ (↑(t₁.arity ⊔ t₂.arity) + 1)) h = 0 := by
         ext; simp [Fin.add_def]; rw [Nat.mod_eq_of_lt (by omega)]; omega
      simp [heq]
      congr; ext1 i; congr 1
      rcases i with ⟨i, hi⟩; simp [Fin.castLT]; ext; simp; repeat rw [Nat.mod_eq_of_lt (by omega)]
    · rw [liftMaxSuccSucc2]; simp
      conv =>
        enter [1, 2, n]
        rw [List.Vector.append_get_lt (by rcases n with ⟨n, hn⟩; simp_all; rw [Nat.mod_eq_of_lt (by omega)]; omega)]
        rfl
      generalize_proofs h₁ h₂ h₃ h₄
      have heq h : Fin.subNat (t₁.arity ⊔ t₂.arity + 1) (Fin.last (2 + t₁.arity ⊔ t₂.arity)) h = 1 := by
         ext; simp [Fin.add_def]; omega
      simp [heq]
      congr; ext1 i; congr 1
      rcases i with ⟨i, hi⟩; simp [Fin.castLT]; ext; simp; repeat rw [Nat.mod_eq_of_lt (by omega)]
    · rw [BitVecs.cast_eq] at *
      simp [BitVecs.cast] at *
      rw [liftLast3]
      simp
      rw [List.Vector.append_get_lt (by simp; rw [Nat.mod_eq_of_lt (by omega)]; omega)]
      convert heq using 1
      have h n : n + 1 < n + 3 := by omega
      have h' n m k : n < m → n < (k ⊔ m) + 1 := by omega
      · cases op <;>
        · simp [openTerm, subst, liftLast3]; congr
          · rw [List.Vector.append_get_ge]
            · simp [Fin.subNat, Fin.add_def]; simp [Nat.mod_eq_of_lt, h]; congr! with ⟨n, hn⟩; ext; simp; omega
            · rw [Fin.add_def]; simp; rw [Nat.mod_eq_of_lt (by omega)]
          · have heq h : (Fin.subNat (t₁.arity ⊔ t₂.arity + 1) (Fin.last (2 + t₁.arity ⊔ t₂.arity)) h) = 1 := by
              simp [Fin.subNat]; omega
            simp [heq, List.Vector.get]; congr; ext1 ⟨i, hi⟩; simp; simp [Nat.mod_eq_of_lt (h' _ _ t₁.arity hi)]
      · congr!; simp [Fin.castLT, Fin.last]; omega
    · ext1
      · simp
      next i =>
        simp [bvs', List.Vector.append_get_ge, liftOp]
        split_ifs with h
        · subst h
          simp
          rw [List.Vector.append_get_lt]
          on_goal 2 =>
            simp +arith
            repeat (rw [Nat.mod_eq_of_lt (by omega)])
            omega
          congr; ext; simp +arith
          omega
        · simp [h]
          rw [List.Vector.append_get_lt (by rcases i; simp_all [Fin.last]; rw [Nat.mod_eq_of_lt (by omega)]; omega)]
          rcases i with ⟨i, hi⟩; congr!; simp_all; omega
  · rintro ⟨bvs', ⟨⟨⟨heq₁, heq₂⟩, heq₃⟩, heq₄⟩⟩
    rw [BitVecs.cast_eq] at *
    simp [BitVecs.cast] at *
    rw [←heq₄]
    conv_rhs =>
      simp
      simp [liftOp]
      rfl
    simp [liftMaxSuccSucc1, liftMaxSuccSucc2] at heq₁ heq₂
    rw [liftLast3] at heq₃
    convert heq₃ using 1
    have h₁ : (t₁.evalFinBV fun i => bvs'.bvs.get (liftOp (t₁.arity ⊔ t₂.arity) (Fin.castLE (by omega) i).castSucc)) =
                  bvs'.bvs.get (liftLast3 (t₁.arity ⊔ t₂.arity) 0) := by
      simp only [liftOp_unchanged, Fin.castLE_castLE, liftLast3]; convert heq₁ using 1
    have h₂ : (t₂.evalFinBV fun i => bvs'.bvs.get (liftOp (t₁.arity ⊔ t₂.arity) (Fin.castLE (by omega) i).castSucc)) =
                  bvs'.bvs.get (liftLast3 (t₁.arity ⊔ t₂.arity) 1) := by
      simp only [liftOp_unchanged, Fin.castLE_castLE, liftLast3]; convert heq₂
    rcases op with _ | _ | _ <;>
    . simp [subst, openTerm] at *; congr


inductive TermUnop where
| neg | not | shiftL (k : Nat)

def TermUnop.openTerm (op : TermUnop) : Term :=
  match op with
  | .neg => .neg (.var 0)
  | .not => .not (.var 0)
  | .shiftL k => .shiftL (.var 0) k

def TermUnop.openTerm_arity (op : TermUnop) : op.openTerm.arity = 1 := by rcases op <;> rfl

@[simp]
def TermUnop.openTerm_arity' (op : TermUnop) : op.openTerm.arity + 1 = 2 := by rcases op <;> rfl

def TermUnop.subst (op : TermUnop) (t : Term) : Term :=
  match op with
  | .neg => .neg t
  | .not => .not t
  | .shiftL k => .shiftL t k

@[simp]
lemma TermUnop.subst_arity {op : TermUnop} : (op.subst t).arity = t.arity := by
  rcases op <;> rfl

@[simp]
lemma TermUnop.subst_arity' {op : TermUnop} : (op.subst t).arity + 1 = t.arity + 1 := by simp

lemma autOfTermBinop_bv_language op {t₁ t₂ : Term} (m₁ : CNFA (t₁.arity + 1)) (m₂ : CNFA (t₂.arity + 1)) :
    m₁.bv_recognizes t₁.language →
    m₂.bv_recognizes t₂.language →
    (autOfTermBinop op m₁ m₂ |>.bv_recognizes (op.subst_arity' ▸ (op.subst t₁ t₂).language)) := by
  rintro hrec₁ hrec₂
  simp [autOfTermBinop]
  rw [TermBinop.alt_lang]
  simp
  apply CNFA.minimize_bv_language
  apply CNFA.proj_bv_language
  ac_nf
  apply CNFA.inter_bv_language
  · apply CNFA.lift_bv_language
    rcases op <;> simp [TermBinop.termGadget, TermBinop.openTerm] <;> apply CNFA.ofFSM_bv_language
  · apply CNFA.inter_bv_language
    · apply CNFA.lift_bv_language; assumption
    · apply CNFA.lift_bv_language; assumption

def TermUnop.termGadget (t : TermUnop) : CNFA 2 :=
  match t with
  | .neg => FSM.ofTerm (.neg (.var 0)) |> CNFA.ofFSM
  | .not => FSM.ofTerm (.not (.var 0)) |> CNFA.ofFSM
  | .shiftL k => FSM.ofTerm (.shiftL (.var 0) k) |> CNFA.ofFSM

def autOfTermUnop (op : TermUnop) (m : CNFA (n + 1)) : CNFA (n + 1) :=
  let mop : CNFA 2 := op.termGadget
  let mop : CNFA (n + 2) := mop.lift (λ i ↦ i.natAdd n)
  let m : CNFA (n + 2) := m.lift (λ i ↦ i.castLE (by omega))
  let m := CNFA.inter m mop
  let mfinal := m.proj (liftUnop n)
  mfinal.minimize

def nfaOfTerm (t : Term) : CNFA (t.arity + 1) :=
  match t with
  | .var n => FSM.ofTerm (.var n) |> CNFA.ofFSM
  | .zero => FSM.ofTerm .zero |> CNFA.ofFSM
  | .negOne => FSM.ofTerm .negOne |> CNFA.ofFSM
  | .one => FSM.ofTerm .one |> CNFA.ofFSM
  | .ofNat n => FSM.ofTerm (.ofNat n) |> CNFA.ofFSM
  | .and t₁ t₂ => autOfTermBinop .and (nfaOfTerm t₁) (nfaOfTerm t₂)
  | .or t₁ t₂ => autOfTermBinop .or (nfaOfTerm t₁) (nfaOfTerm t₂)
  | .xor t₁ t₂ => autOfTermBinop .xor (nfaOfTerm t₁) (nfaOfTerm t₂)
  | .add t₁ t₂ => autOfTermBinop .add (nfaOfTerm t₁) (nfaOfTerm t₂)
  | .sub t₁ t₂ => autOfTermBinop .sub (nfaOfTerm t₁) (nfaOfTerm t₂)
  | .neg t => autOfTermUnop .neg (nfaOfTerm t)
  | .not t => autOfTermUnop .not (nfaOfTerm t)
  | .shiftL t k => autOfTermUnop (.shiftL k) (nfaOfTerm t)

def swapLastTwo (x : Fin (n + 2)) : Fin (n + 2) :=
  if x = Fin.last (n + 1) then n else if x = n then Fin.last (n + 1) else x

@[simp]
lemma swapLastTwo_same (x : Fin n) : swapLastTwo (n := n) (x.castLE (by omega)) = x.castLE (by omega) := by
  simp [swapLastTwo]
  split_ifs with h h' <;> simp_all +arith
  · rcases x with ⟨x, hx⟩
    simp_all [Fin.ext_iff, Fin.add_def]
    omega
  · rcases x with ⟨x, hx⟩
    simp_all [Fin.ext_iff, Fin.add_def]
    rw [h'] at hx
    rw [Nat.mod_eq_of_lt (by omega)] at hx
    simp at hx

@[simp]
lemma swapLastTwo_same' (x : Fin (n + 1)) (h : x ≠ Fin.last n) : swapLastTwo (n := n) (x.castLE (by omega)) = x.castLE (by omega) := by
  simp [swapLastTwo]
  split_ifs with h h' <;> simp_all +arith
  · rcases x with ⟨x, hx⟩
    simp_all [Fin.ext_iff, Fin.add_def]
    omega
  · rcases x with ⟨x, hx⟩
    simp_all [Fin.ext_iff, Fin.add_def]
    omega

@[simp]
lemma swapLastTwo_eq1 : swapLastTwo (n := n) (Fin.natAdd n 1) = n := by
  have : Fin.natAdd (m := 2) n 1 = Fin.last (n + 1) := by ext; simp
  simp [swapLastTwo, this]

@[simp]
lemma swapLastTwo_eq1' : swapLastTwo (n := n) (Fin.last (n + 1)) = n := by
  simp [swapLastTwo]

@[simp]
lemma swapLastTwo_eq2 : swapLastTwo (n := n) n = Fin.last (n+1) := by
  simp [swapLastTwo]

lemma TermUnop.alt_lang {t : Term} (op : TermUnop) :
  (op.subst_arity' ▸ (op.subst t).language) =
    let lop : Set (BitVecs 2) := op.openTerm_arity' ▸ op.openTerm.language
    let lop' : Set (BitVecs (t.arity + 2)) := lop.lift (λ i ↦ i.natAdd t.arity)
    let lt : Set (BitVecs (t.arity + 2)) := t.language.lift (λ i ↦ i.castLE (by omega))
    let l := lt ∩ lop'
    l.proj (liftUnop t.arity)
    := by
  simp [Term.language]
  ext bvs
  simp

  generalize_proofs h₁ h₂ h₃ h₄ h₅
  constructor
  · rintro heq
    let bvs' := bvs.bvs.append (t.evalFinBV (λ n ↦ bvs.bvs.get n) ::ᵥ List.Vector.nil) |>.transport swapLastTwo
    use ⟨_, bvs'⟩
    split_ands
    · simp [bvs']
      have heq : (swapLastTwo (Fin.castLE h₃ (Fin.last t.arity))) = Fin.last (t.arity + 1) := by
        simp [swapLastTwo]
        split_ifs with h₁ h₂
        · exfalso; rw [Fin.ext_iff] at h₁
          simp [Fin.add_def] at h₁
        · rfl
        · exfalso; apply h₂; ext; simp; exact Eq.symm (Nat.mod_eq_of_lt h₃)
      rw [heq]
      rw [List.Vector.append_get_ge]
      on_goal 2 => simp [Fin.add_def]
      simp
      congr
      ext1 x
      rw [List.Vector.append_get_lt]
      on_goal 2 => simp +arith
      congr!
    · rw [BitVecs.cast_eq] at heq ⊢
      unfold BitVecs.cast
      simp
      simp [BitVecs.cast] at heq
      have hget : bvs'.get (Fin.natAdd t.arity 1) = bvs.bvs.get t.arity := by
        simp [bvs']
        rw [List.Vector.append_get_lt]
        on_goal 2 => simp +arith; exact Nat.mod_le t.arity (t.arity + 2)
        · congr
          ext
          simp +arith
      rw [hget]
      convert heq using 1
      · have hbvs' : bvs'.get t.arity = t.evalFinBV fun n => bvs.bvs.get n := by
          simp [bvs', Fin.add]
        simp [openTerm]
        rcases op <;> simp [hbvs', Fin.natAdd_zero'] <;> rfl
      · congr!;  ext; simp
    · ext1
      · simp
      next i =>
        simp [bvs', List.Vector.append_get_ge, liftUnop]
        split_ifs with h
        · subst h
          simp
          rw [List.Vector.append_get_lt]
          on_goal 2 => simp +arith; exact Nat.mod_le t.arity (t.arity + 2)
          congr
          ext; simp +arith
        · simp [h]
          congr!
  · rintro ⟨bvs', ⟨⟨heq₁, heq₂⟩, heq₃⟩⟩
    rw [BitVecs.cast_eq] at *
    simp [BitVecs.cast] at *
    rw [←heq₃]
    conv_rhs =>
      simp only [BitVecs.transport_getElem]
      simp [liftUnop]
      rw [ite_cond_eq_true]
      rfl
      tactic => simp only [eq_iff_iff, iff_true]; ext1; simp
    convert heq₂ using 1
    rcases op with _ | _ | _ <;>
    . simp [subst, openTerm] at *; congr

lemma autOfTermUnop_bv_language op {t : Term} (m : CNFA (t.arity + 1)) :
    m.bv_recognizes t.language →
    (autOfTermUnop op m |>.bv_recognizes (op.subst_arity' ▸ (op.subst t).language)) := by
  rintro hrec
  rw [TermUnop.alt_lang]
  simp only [autOfTermUnop]
  simp
  apply CNFA.minimize_bv_language
  apply CNFA.proj_bv_language
  apply CNFA.inter_bv_language
  · apply CNFA.lift_bv_language; assumption
  · apply CNFA.lift_bv_language
    simp [TermUnop.openTerm, TermUnop.termGadget]
    rcases op <;> apply CNFA.ofFSM_bv_language

lemma nfaOfTerm_bv_language (t : Term) :
    nfaOfTerm t |>.bv_recognizes t.language := by
  induction t
  case var x =>
    simp only [nfaOfTerm]
    exact CNFA.ofFSM_bv_language
  case zero =>
    simp only [nfaOfTerm]
    exact CNFA.ofFSM_bv_language
  case one =>
    simp only [nfaOfTerm]
    exact CNFA.ofFSM_bv_language
  case negOne =>
    simp only [nfaOfTerm]
    exact CNFA.ofFSM_bv_language
  case ofNat k =>
    simp only [nfaOfTerm]
    exact CNFA.ofFSM_bv_language
  case neg t ih =>
    simp only [nfaOfTerm]
    apply autOfTermUnop_bv_language; assumption
  case not t ih =>
    simp only [nfaOfTerm]
    apply autOfTermUnop_bv_language; assumption
  case shiftL k t ih =>
    simp only [nfaOfTerm]
    apply autOfTermUnop_bv_language; assumption
  case and t₁ t₂ ih₁ ih₂ =>
    simp only [nfaOfTerm]
    apply autOfTermBinop_bv_language <;> assumption
  case or t₁ t₂ ih₁ ih₂ =>
    simp only [nfaOfTerm]
    apply autOfTermBinop_bv_language <;> assumption
  case xor t₁ t₂ ih₁ ih₂ =>
    simp only [nfaOfTerm]
    apply autOfTermBinop_bv_language <;> assumption
  case add t₁ t₂ ih₁ ih₂ =>
    simp only [nfaOfTerm]
    apply autOfTermBinop_bv_language <;> assumption
  case sub t₁ t₂ ih₁ ih₂ =>
    simp only [nfaOfTerm]
    apply autOfTermBinop_bv_language <;> assumption

def nfaOfFormula (φ : Formula) : CNFA φ.arity :=
  match φ with
  | .width wp n => CNFA.autWidth wp n
  | .atom rel t1 t2 =>
    let m1 := nfaOfTerm t1
    let m2 := nfaOfTerm t2
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

attribute [aesop unsafe 80%] CNFA.inter_bv_language CNFA.union_bv_language CNFA.lift_bv_language CNFA.proj_bv_language

theorem nfaOfFormula_bv_language φ :
    (nfaOfFormula φ).bv_recognizes φ.language := by
  induction φ
  case width rel n =>
    simp only [nfaOfFormula]
    apply CNFA.autWidth_bv_language
  case atom rel t1 t2 =>
    simp only [nfaOfFormula, Formula.language]
    apply CNFA.proj_bv_language
    ac_nf
    apply CNFA.inter_bv_language
    · apply CNFA.lift_bv_language
      exact CNFA.autOfRelation_bv_language rel
    · apply CNFA.inter_bv_language
      · apply CNFA.lift_bv_language
        exact nfaOfTerm_bv_language t1
      · apply CNFA.lift_bv_language
        exact nfaOfTerm_bv_language t2
  case msbSet t =>
    simp only [nfaOfFormula, Formula.language]
    apply CNFA.proj_bv_language
    apply CNFA.inter_bv_language
    · exact CNFA.ofFSM_bv_language
    · apply CNFA.lift_bv_language
      apply CNFA.autMsbSet_bv_language
  case unop op φ ih =>
    simp only [nfaOfFormula, Formula.language]
    exact unopNfa_bv_language op ih
  case binop op φ₁ φ2 ih₁ ih₂ =>
    simp only [nfaOfFormula, Formula.language, ih₁, ih₂]
    apply binopNfa_bv_language op
    · apply CNFA.lift_bv_language; assumption
    · apply CNFA.lift_bv_language; assumption

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

theorem decision_procedure_is_correct {w} (φ : Formula) (env : Nat → BitVec w) :
    formulaIsUniversal φ → φ.sat' env := by
  unfold formulaIsUniversal; simp
  rintro h
  have hl := nfaOfFormula_bv_language φ
  have := CNFA.isUniversal_bv_language hl h
  rw [formula_language] at this
  rw [←sat_impl_sat']
  have hx := env_to_bvs φ (fun k => env k.val)
  extract_lets bvs at hx
  have hin : bvs ∈ (⊤ : Set _) := by simp
  rw [←this] at hin
  simp +zetaDelta [Set.instMembership, Set.Mem] at hin
  assumption

@[simp]
lemma formula_predicate_term_match {t : Term} :
    t.denote w vars = t.evalNat (vars[·]!) := by
  induction t <;> simp_all [Term.denote, Term.evalNat]

lemma formula_predicate_match {p : Predicate} :
    p.denote w vars ↔ (formula_of_predicate p).sat' (vars[·]!) := by
  induction p
  case binary pred t₁ t₂ =>
    cases pred <;> simp only [Predicate.denote, formula_predicate_term_match,
      List.getElem!_eq_getElem?_getD, formula_of_predicate, Formula.sat', evalRelation]
  case width rel w' =>
     cases rel <;> simp [Predicate.denote, Formula.sat', formula_of_predicate, evalRelation]
  case land p₁ p₂ ih₁ ih₂ =>
    simp_all [Predicate.denote, Formula.sat', formula_of_predicate, evalRelation]
  case lor p₁ p₂ ih₁ ih₂ =>
    simp_all [Predicate.denote, Formula.sat', formula_of_predicate, evalRelation]

theorem Formula.denote_of_isUniversal {p : Predicate}
    (heval : formulaIsUniversal (formula_of_predicate p)) :
    ∀ (w : Nat) (vars : List (BitVec w)), p.denote w vars := by
  rintro w vars
  apply decision_procedure_is_correct _ (λ n ↦ vars[n]!) at heval
  simp_all [formula_predicate_match]

-- -- For testing the comparison operators.
-- def nfaOfCompareConstants (signed : Bool) {w : Nat} (a b : BitVec w) : RawCNFA (BitVec 0) :=
--   let m1 := RawCNFA.ofConst a
--   let m2 := RawCNFA.ofConst b
--   let f1 : Fin 1 → Fin 2 := fun 0 => 0
--   let m1' := m1.lift f1
--   let f2 : Fin 1 → Fin 2 := fun 0 => 1
--   let m2' := m2.lift f2
--   let meq := if signed then RawCNFA.autSignedCmp .lt else RawCNFA.autUnsignedCmp .lt
--   let m := m1'.inter m2' |> RawCNFA.inter meq
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
