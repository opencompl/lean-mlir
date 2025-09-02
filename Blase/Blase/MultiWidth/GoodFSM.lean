/-
This file builds the FSMs whose
verification implies the correctness of the
multi-width bitstream semantics.
-/
import Blase.Fast.FiniteStateMachine
import Blase.Vars
import Blase.MultiWidth.Defs
import Blase.KInduction.KInduction
import Lean

namespace MultiWidth


-- build an FSM whose output is unary, and is 1 in the beginning, and becomes 0
-- forever after.
-- TODO: I am pretty sure we can just do this with binary encodings as well?
def mkWidthFSM (wcard : Nat) (tcard : Nat) (w : Nondep.WidthExpr) :
    (NatFSM wcard tcard w) :=
  match w with
  | .var wnat =>
    if h : wnat < wcard then
      { toFsm :=
        -- composeUnaryAux FSM.scanAnd (FSM.var' (StateSpace.widthVar ⟨w.toNat, h⟩))
        (FSM.var' (StateSpace.widthVar ⟨wnat, h⟩))
      }
    else
      { toFsm := FSM.zero' } -- default, should not be used.
  | .min v w =>
      { toFsm :=
        (mkWidthFSM wcard tcard v).toFsm &&& (mkWidthFSM wcard tcard w).toFsm
      }
  | .max v w =>
        { toFsm :=
        (mkWidthFSM wcard tcard v).toFsm ||| (mkWidthFSM wcard tcard w).toFsm
      }
  | .addK v k =>
    { toFsm :=
        composeUnaryAux (FSM.repeatN true k)  (mkWidthFSM wcard tcard v).toFsm
    }

def IsGoodNatFSM_mkWidthFSM {wcard : Nat} (tcard : Nat) (w : WidthExpr wcard) :
    HNatFSMToBitstream (mkWidthFSM wcard tcard (.ofDep w)) where
  heq := by
    intros wenv fsmEnv henv
    induction w
    case var v =>
      simp [mkWidthFSM]
      have ⟨henv⟩ := henv
      rw [henv]
    case min v w hv hw =>
      simp [mkWidthFSM]
      rw [hv, hw]
      ext i
      simp
    case max v w hv hw =>
      simp [mkWidthFSM]
      rw [hv, hw]
      ext i
      simp
    case addK v k hv =>
      simp [mkWidthFSM]
      rw [hv]
      ext i
      simp
      omega

/--
Build an FSM taking inputs 'x' and 'w'.
Produce the bit 'x[i]' as long as 'w = 1'.
Once 'w = 0', produce the last value 'x[`last index where w = 1`]
Otherwise, return if we have found a '1' so far.
-/
def fsmMsbAux : FSM Bool where
  -- when w = 1, store into 'x'.
  α := Unit
  initCarry := fun () => false
  outputCirc :=
    let s : Circuit (Unit ⊕ (Bool)) := Circuit.var (positive := true) (.inl ())
    let x : Circuit (Unit ⊕ (Bool)) := Circuit.var (positive := true) (.inr false)
    let w : Circuit (Unit ⊕ (Bool))  := Circuit.var (positive := true) (.inr true)
    Circuit.ite w -- if still inside width
    x -- then update state bit to be 'x'.
    s -- else return 's'.
  nextStateCirc := fun () =>
    let s : Circuit (Unit ⊕ (Bool)) := Circuit.var (positive := true) (.inl ())
    let x : Circuit (Unit ⊕ (Bool)) := Circuit.var (positive := true) (.inr false)
    let w : Circuit (Unit ⊕ (Bool)) := Circuit.var (positive := true) (.inr true)
    -- as long as the width is not exceeded, store into the width.
    Circuit.ite w -- if w
      x -- then x
      s  -- else s

/--
the MSB finite state machine
returns the 'msb' upto the current width.
-/
def fsmMsb (x w : FSM α) : FSM α :=
  composeBinaryAux' (FSM.latchImmediate false) (qfalse := x) (qtrue := w)

@[simp]
theorem eval_fsmMsb_eq {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (w : WidthExpr wcard)
    (x : Term tctx w)
    (xfsm : TermFSM wcard tcard (.ofDep x))
    (hxfsm : HTermFSMToBitStream xfsm)
    (wfsm : NatFSM wcard tcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmMsb xfsm.toFsm wfsm.toFsm).eval fsmEnv = (fun i =>
      BitStream.ofBitVecZextMsb (x.toBV tenv) (min i (w.toNat wenv))) := by
  simp [fsmMsb]
  have wfsmEval := hwfsm.heq (henv := htenv.toHWidthEnv)
  have tfsmEval := hxfsm.heq (henv := htenv)
  ext i
  rcases i with rfl | i
  · simp
    intros hxFsmEq
    simp [tfsmEval]
  · simp
    rw [tfsmEval, wfsmEval]
    simp
    induction i
    case zero =>
      simp
      by_cases hw : 1 ≤ w.toNat wenv
      · simp [hw]
      · simp at hw
        simp [hw]
    case succ i hi =>
      simp
      by_cases hxiSucc : (Term.toBV tenv x).getLsbD (i + 1) = true
      · simp [hxiSucc]
        by_cases hiwLe : i + 1 + 1  ≤ w.toNat wenv
        · simp [hiwLe]
          simp [hxiSucc]
        · simp [hiwLe]
          simp at hiwLe
          have hiwLt := BitVec.lt_of_getLsbD hxiSucc
          omega
      · simp at hxiSucc
        simp [hxiSucc]
        rw [hi]
        clear hi
        generalize hbv : (Term.toBV tenv x) = bv
        rw [hbv] at hxiSucc
        by_cases hiSucc : i + 1 ≤ w.toNat wenv
        · simp [hiSucc]
          by_cases hiSuccSucc : i + 1 + 1 ≤ w.toNat wenv
          · simp [hiSuccSucc]
            rw [hxiSucc]
          · simp at hiSuccSucc
            have hwEq : w.toNat wenv = i + 1 := by omega
            simp [hwEq]
        · simp at hiSucc
          simp [show ¬ i + 1 + 1 ≤ w.toNat wenv by omega]
          simp [show min (i + 1) (w.toNat wenv) = w.toNat wenv by omega]
          simp [show min (i + 1 + 1) (w.toNat wenv) = w.toNat wenv by omega]


-- | Found a cuter expression for 'getLsbD_signExtend'.
theorem getLsbD_signExtend_eq {wold : Nat} (x : BitVec wold) {wnew : Nat} :
  (x.signExtend wnew).getLsbD i =
    (x.getLsbD (min i (wold - 1)) && decide (i < wnew))
      := by
  simp [BitVec.getLsbD_signExtend]
  rw [BitVec.msb_eq_getLsbD_last]
  by_cases hnew : i < wnew
  · simp [hnew]
    by_cases hi : i < wold
    · simp [hi]
      simp [show min i (wold - 1) = i by omega]
    · simp [hi]
      simp [show min i (wold - 1) = wold - 1 by omega]
  · simp [hnew]

def fsmSext (x wold wnew : FSM α) : FSM α :=
  (fsmMsb x wold) &&& wnew

def fsmUnaryMax (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.or a b

@[simp]
theorem eval_fsmUnaryMax_eq_decide
  (a : NatFSM wcard tcard (.ofDep v))
  (b : NatFSM wcard tcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
  ((fsmUnaryMax a.toFsm b.toFsm).eval fsmEnv) i =
    (i ≤ (max (v.toNat wenv) (w.toNat wenv))) := by
  simp only [fsmUnaryMax, composeBinaryAux'_eval, eq_iff_iff]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp

def fsmUnaryMin (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.and a b

/-- compute the 'min' of two FSMs. -/
@[simp]
theorem eval_fsmUnaryMin_eq_decide
  (a : NatFSM wcard tcard (.ofDep v))
  (b : NatFSM wcard tcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
  ((fsmUnaryMin a.toFsm b.toFsm).eval fsmEnv) i =
    (i ≤ (min (v.toNat wenv) (w.toNat wenv))) := by
  simp only [fsmUnaryMin, composeBinaryAux'_eval, _root_.FSM.eval_and, cond_true, cond_false,
    BitStream.and_eq, Bool.and_eq_true, le_inf_iff, eq_iff_iff]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp

/-- increment a unary number by a known constant 'k'. -/
def fsmUnaryIncrK (k : Nat) (fsm : FSM α) : FSM α :=
  match k with
  | 0 => fsm
  | k + 1 => composeUnaryAux (FSM.ls true) (fsmUnaryIncrK k fsm)

theorem eval_fsmUnaryIncrK_eq_decide
  (a : NatFSM wcard tcard (.ofDep v))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) :
  ((fsmUnaryIncrK k a.toFsm).eval fsmEnv) = fun i =>
  decide (i ≤ (v.toNat wenv) + k) := by
  induction k
  case zero =>
    simp [fsmUnaryIncrK]
    rw [ha.heq (henv := henv)]
  case succ k ih =>
    simp [fsmUnaryIncrK]
    rw [ih]
    ext i
    rcases i with rfl | i
    · simp only [BitStream.concat_zero, zero_le, decide_true]
    · simp only [BitStream.concat_succ, decide_eq_decide]
      omega

-- when we compute 'a - b', if the borrow bit is zero,
-- then we know that 'a' is greater than or equal to 'b'.
-- if the borrow bit is one, then we know that 'a' is less than 'b'.
-- a ≤ b ↔ b[i] = 0 → a[i] = 0
-- if b = 1, we are done.
-- Otherwise, if b=0,then a=0

-- alternatively, a[i] = 1 → b[i] = 1.
-- if a is high, then b must be high for it to be ≤.
def fsmUnaryUle (a : FSM arity) (b : FSM arity) : FSM arity :=
 composeUnaryAux FSM.scanAnd (b ||| ~~~ a)

theorem eval_fsmUnaryUle_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryUle a.toFsm b.toFsm).eval fsmEnv) i =
    decide (min i (v.toNat wenv) ≤ min i (w.toNat wenv)) := by
  simp [fsmUnaryUle]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp [BitStream.scanAnd_eq_decide]
  by_cases hiv : i ≤ v.toNat wenv
  case pos =>
    by_cases hiw : i ≤ w.toNat wenv
    case pos =>
      simp [hiw]
      intros j
      omega
    case neg =>
      simp [hiw]
      by_cases hvw : v.toNat wenv ≤ w.toNat wenv
      case pos =>
        simp [hvw]
        intros j
        omega
      case neg =>
        simp [hvw]
        exists i
        omega
  case neg =>
    by_cases hiw : i ≤ w.toNat wenv
    case pos =>
      simp [hiw]
      omega
    case neg =>
      simp [hiw]
      by_cases hvw : v.toNat wenv ≤ w.toNat wenv
      case pos =>
        simp [hvw]
        omega
      case neg =>
        simp [hvw]
        exists (v.toNat wenv)
        omega

@[simp]
theorem eval_fsmUnaryUle_eq_lt_or_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryUle a.toFsm b.toFsm).eval fsmEnv) i =
    decide (i ≤ min (v.toNat wenv) (w.toNat wenv) ∨ (v.toNat wenv) ≤ (w.toNat wenv)) := by
  rw [eval_fsmUnaryUle_eq_decide (wenv := wenv) (henv := henv) (ha := ha) (hb := hb)]
  simp
  by_cases hiv : i ≤ v.toNat wenv
  · simp [hiv]
  · simp [hiv]
    omega
/--
info: 'MultiWidth.eval_fsmUnaryUle_eq_decide' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms eval_fsmUnaryUle_eq_decide

-- returns 1 if a is equal to b.
def fsmEqUnaryUpto (a : FSM arity) (b : FSM arity) : FSM arity :=
  composeUnaryAux FSM.scanAnd (composeBinaryAux' FSM.nxor a b)

@[simp]
private theorem min_eq_of_not_le {a b : Nat} (hab : ¬ a ≤ b) : min a b = b := by
  omega

@[simp]
private theorem min_eq_of_not_le' {a b : Nat} (hab : ¬ a ≤ b) : min b a = b := by
  omega

@[simp]
theorem eval_FsmEqUpto_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmEqUnaryUpto a.toFsm b.toFsm).eval fsmEnv) i =
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  simp [fsmEqUnaryUpto]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp [BitStream.scanAnd_eq_decide]
  constructor
  · intros hi
    -- | think about what the heck this is saying.
    by_cases hiv : v.toNat wenv ≤ i
    · have hiv' := hi (v.toNat wenv) hiv
      have := hiv'.mp (by simp)
      simp [hiv]
      by_cases hiw : w.toNat wenv ≤ i
      · simp [hiw]
        have hiw' := hi (w.toNat wenv) hiw
        have := hiw'.mpr (by simp)
        omega
      · simp [hiw]
        have hiv' := hi i (by simp) |>.mpr (by omega)
        omega
    · simp [hiv]
      apply hi .. |>.mp <;> omega
  · intros hivw j hj
    omega

@[simp]
theorem eval_FsmEqUpto_eq_decide'
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmEqUnaryUpto a.toFsm b.toFsm).eval fsmEnv) = fun i =>
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  ext i
  rw [eval_FsmEqUpto_eq_decide (henv := henv) (ha := ha) (hb := hb)]

private theorem decide_eq_eq_decide_iff_decide {P Q : Prop}
  [Decidable P] [Decidable Q] :
  (decide P = decide Q) = decide (P ↔ Q) := by
  simp

private theorem not_decide_eq_decide_lnot {P : Prop}
  [Decidable P] :
    (!(decide P)) = (decide (¬ P)) := by simp

private theorem decide_and_decide_eq_decide {P Q : Prop}
  [Decidable P] [Decidable Q] :
  (decide P && decide Q) = decide (P ∧ Q) := by
  simp

private theorem decide_or_decide_eq_decide {P Q : Prop}
  [Decidable P] [Decidable Q] :
  (decide P || decide Q) = decide (P ∨ Q) := by
  simp

/-- returns 1 if a is not equal to b. -/
def fsmUnaryNeqUpto (a b : FSM arity) : FSM arity :=
  composeUnaryAux FSM.scanOr (a ^^^ b)

theorem neq_of_min_neq_min {i v w : Nat} (hivw : ¬ min i v = min i w ) :
  (v ≠ w) := by
  by_cases hiv : i < v
  · simp [hiv] at hivw ⊢
    omega
  · simp at hiv; simp [hiv] at hivw
    by_cases hiw : i < w
    · simp [hiw] at hivw
      omega
    · simp at hiw; simp [hiw] at hivw
      omega

@[simp]
theorem eval_fsmUnaryNeqUpto_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryNeqUpto a.toFsm b.toFsm).eval fsmEnv) i =
    (decide (min i (v.toNat wenv) ≠ min i (w.toNat wenv))) := by
  simp [fsmUnaryNeqUpto]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp [BitStream.scanOr_eq_decide]
  rw [not_decide_eq_decide_lnot]
  rw [decide_eq_eq_decide_iff_decide]
  rw [decide_eq_true_iff]
  constructor
  · intros hi
    obtain ⟨j, hj₁, hj₂⟩ := hi
    by_cases hiv : v.toNat wenv < i
    · simp only [not_le, hiv, min_eq_of_not_le]
      omega
    · simp only [not_lt] at hiv
      simp only [hiv, inf_of_le_left, left_eq_inf, not_le]
      omega
  · intros hivw
    simp only [not_iff, not_le]
    by_cases hiv : i < (v.toNat wenv)
    · simp only [not_le, hiv, min_eq_of_not_le', left_eq_inf] at hivw ⊢
      exists i
      omega
    · simp only [not_lt] at hiv; simp [hiv] at hivw
      by_cases hiw : i < (w.toNat wenv)
      · simp only [not_le, hiw, min_eq_of_not_le'] at hivw
        have hiv' : (v.toNat wenv) ≤ i := by omega
        exists i
        omega
      · simp only [not_lt] at hiw; simp [hiw] at hivw
        by_cases hvw : v.toNat wenv < w.toNat wenv
        · exists (w.toNat wenv)
          simp only [le_refl, iff_true]
          omega
        · simp only [not_lt] at hvw
          exists (v.toNat wenv)
          omega

def fsmUltUnary (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.and (fsmUnaryUle a b) (fsmUnaryNeqUpto a b)

theorem eval_fsmUltUnary_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUltUnary a.toFsm b.toFsm).eval fsmEnv) i =
   (decide (min i (v.toNat wenv) < min i (w.toNat wenv))) := by
  simp [fsmUltUnary]
  rw [eval_fsmUnaryUle_eq_lt_or_decide (wenv := wenv) (henv := henv) (ha := ha) (hb := hb)]
  rw [eval_fsmUnaryNeqUpto_eq_decide (wenv := wenv) (henv := henv) (ha := ha) (hb := hb)]
  simp
  generalize v.toNat wenv = v'
  generalize w.toNat wenv = w'
  simp only [not_decide_eq_decide_lnot,
    decide_and_decide_eq_decide,
    decide_or_decide_eq_decide, decide_eq_decide]
  omega

private theorem BitVec.getLsbD_zeroExtend_eq_getLsbD (x : BitVec wold) (wnew : Nat) :
    (x.zeroExtend wnew).getLsbD i = ((x.getLsbD i) ∧ (i ≤ wnew - 1) ∧ (wnew ≠ 0)) := by
  simp [and_comm]; try omega

/-- this creates an FSM that returns whether 'a ≤ i' -/
def fsmUnaryIndexUle (a : NatFSM wcard tcard (.ofDep v)) :
    FSM (StateSpace wcard tcard) :=
  a.toFsm

@[simp]
theorem fsmIndexUle_eval_eq
    (a : NatFSM wcard tcard (.ofDep v))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) :
    (fsmUnaryIndexUle a).eval fsmEnv i =
    decide (i ≤ v.toNat wenv) := by
  rw [fsmUnaryIndexUle]
  rw [ha.heq (henv := henv)]

def fsmZext (nFsm wnewfsm : FSM (StateSpace wcard tcard))
    : FSM (StateSpace wcard tcard) :=
  nFsm &&& (wnewfsm)


/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmZext_eval_eq
    (wnewFsm : NatFSM wcard tcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term tctx w)
    (tFsm : TermFSM wcard tcard (.ofDep t))
    (ht : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmZext tFsm.toFsm wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZextMsb ((Term.zext t wnew).toBV tenv))) i := by
  ext i
  rw [fsmZext]
  simp only [FSM.eval_and', BitStream.and_eq, BitStream.ofBitVecZextMsb_eq_concat_ofBitVecZext]
  rw [ht.heq (henv := htenv)]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]
  simp
  rcases i with rfl | i
  · simp
  · simp
    by_cases hi : i < wnew.toNat wenv
    · simp [hi]
      intros hval
      omega
    · simp [hi]
      omega

/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmSext_eval_eq
    (woldFsm : NatFSM wcard tcard (.ofDep wold))
    (wnewFsm : NatFSM wcard tcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    (hwold : HNatFSMToBitstream woldFsm)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term tctx wold)
    (tFsm : TermFSM wcard tcard (.ofDep t))
    (htfsm : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmSext tFsm.toFsm woldFsm.toFsm  wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZextMsb ((Term.sext t wnew).toBV tenv))) i := by
  ext i
  rw [fsmSext]
  simp only [FSM.eval_and', BitStream.and_eq,
    BitStream.ofBitVecZextMsb_eq_concat_ofBitVecZext]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]
  rw [eval_fsmMsb_eq
        (xfsm := tFsm) (wfsm := woldFsm) (htenv := htenv)
        (hxfsm := htfsm) (hwfsm := hwold)]
  simp
  by_cases hwold : i ≤ wold.toNat wenv
  · simp [hwold]
    by_cases hwnew : i ≤ wnew.toNat wenv
    · simp [hwnew]
      rcases i with rfl | i
      · simp
      · simp [BitVec.getLsbD_signExtend]
        simp [show i < wnew.toNat wenv by omega]
        omega
    · simp [hwnew]
      rcases i with rfl | i
      · simp
      · simp [BitVec.getLsbD_signExtend]
        omega
  · simp [hwold]
    by_cases hwnew : i ≤ wnew.toNat wenv
    · simp [hwnew]
      -- TODO: needs fsmMsbAux.
      rcases i with rfl | i
      · simp
        omega
      · simp
        simp at hwold
        rw [getLsbD_signExtend_eq]
        simp [show min i (wold.toNat wenv - 1) = wold.toNat wenv - 1 by omega]
        simp [show i < wnew.toNat wenv by omega]
        have hwold : wold.toNat wenv = 0 ∨ 0 < wold.toNat wenv := by
          omega
        rcases hwold with hwold | hwold
        · simp [hwold]
        · simp [hwold]
    · simp [hwnew]
      rcases i with rfl | w
      · simp
      · simp
        rw [BitVec.getLsbD_signExtend]
        simp; omega

/-- info: 'MultiWidth.fsmSext_eval_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fsmSext_eval_eq

/-- Create a finite state machine that masks the zero bit.
It produces the stream '0111....'.  -/
def mkMaskZeroFSM {α : Type} : FSM α :=
  composeUnaryAux (FSM.ls false) (FSM.negOne) |>.map Fin.elim0

@[simp]
theorem eval_mkMaskZeroFsm_eq_decide (env : α → BitStream):
  mkMaskZeroFSM.eval env i =
    decide (0 < i) := by
  simp [mkMaskZeroFSM]
  rcases i with rfl | i <;> simp

def mkTermFSM (wcard tcard : Nat) (t : Nondep.Term) :
    (TermFSM wcard tcard t) :=
  match t with
  | .var v _w =>
    if h : v < tcard then
      {
      -- toFsm := composeUnaryAux FSM.scanAnd (FSM.var' (StateSpace.termVar ⟨v, h⟩))
      toFsm := (FSM.var' (StateSpace.termVar ⟨v, h⟩))
      }
    else
      { toFsm := FSM.zero.map Fin.elim0 } -- default, should not be ued.
  | .add w a b =>
    let fsmW := mkWidthFSM wcard tcard w
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    { toFsm :=
      composeBinaryAux' FSM.and
        fsmW.toFsm
        (composeBinaryAux' FSM.add fsmA.toFsm fsmB.toFsm)
    }
  | .zext a wnew =>
      -- let wold := a.width
      let afsm := mkTermFSM wcard tcard a
      -- let woldFsm := mkWidthFSM wcard tcard wold
      let wnewFsm := mkWidthFSM wcard tcard wnew
      { toFsm := fsmZext afsm.toFsm wnewFsm.toFsm }
  | .sext a v =>
    let wold := a.width
    let afsm := mkTermFSM wcard tcard a
    let woldFsm := mkWidthFSM wcard tcard wold
    let vFsm := mkWidthFSM wcard tcard v
    { toFsm := fsmSext afsm.toFsm woldFsm.toFsm vFsm.toFsm }
  | .band _w a b =>
      let aFsm := mkTermFSM wcard tcard a
      let bFsm := mkTermFSM wcard tcard b
      { toFsm :=
            (composeBinaryAux' FSM.and aFsm.toFsm bFsm.toFsm) }
  | .bor _w a b =>
    let aFsm := mkTermFSM wcard tcard a
    let bFsm := mkTermFSM wcard tcard b
    { toFsm :=
          (composeBinaryAux' FSM.or aFsm.toFsm bFsm.toFsm) }
  | .bxor _w a b =>
    let aFsm := mkTermFSM wcard tcard a
    let bFsm := mkTermFSM wcard tcard b
    { toFsm :=
          (composeBinaryAux' FSM.xor aFsm.toFsm bFsm.toFsm) }
  | .bnot w a =>
    let aFsm := mkTermFSM wcard tcard a
    let wFsm := mkWidthFSM wcard tcard w
    { toFsm :=
      composeBinaryAux' FSM.and wFsm.toFsm
        (composeBinaryAux' FSM.and (mkMaskZeroFSM.map Fin.elim0)
          (composeUnaryAux FSM.not aFsm.toFsm)) }

/-- if we concatenate, then the bitstreams remain equal. -/
@[simp]
theorem BitStream.EqualUpTo_of_concat_EqualUpTo_concat
  (x y : BitStream) (n : Nat) :
  BitStream.EqualUpTo (n + 1) (.concat b x) (.concat b y) ↔
  BitStream.EqualUpTo n x y := by
  simp [BitStream.EqualUpTo]
  constructor
  · intros h i hi
    specialize h (i + 1) (by omega)
    simp at h
    exact h
  · intros h i hi
    rcases i with rfl | i
    · simp
    · simp
      apply h
      omega

/-- masking with a unary bitstream produces equal results
if the bitstreams are equal upto a given width. -/
theorem BitStream.ofNatUnary_and_eq_ofNatUnary_and_of_EqualUpTo_succ (n : Nat)
  {x y : BitStream} (hxy : BitStream.EqualUpTo (n + 1) x y) :
  (BitStream.ofNatUnary n) &&& x =
  (BitStream.ofNatUnary n) &&& y := by
  ext i
  simp
  specialize hxy i
  by_cases hi : i ≤ n
  · simp [hi]
    apply hxy (by omega)
  · simp [hi]

/-- Zero extend a finite bitvector 'x' to the infinite stream of 'x.msb' -/
theorem ofBitVecZextMsb_eq_ofNatUnary_and_ofBitVecZextMsb {w} (x : BitVec w) :
  (BitStream.ofBitVecZextMsb x) =
  (BitStream.ofNatUnary w) &&& (BitStream.ofBitVecZextMsb x) := by
  ext i
  simp
  rcases i with rfl | i
  · simp
  · simp
    intros hi
    have := BitVec.lt_of_getLsbD hi
    omega


-- theorem BitVec.ult_iff_borrow (a b : BitVec w) : a.borrow b
--    ((t₁.borrow t₂)).concat true ↔ a < b:
--     evalUlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
--     (Term.denote w a vars < Term.denote w b vars) := by
--   simp [evalUlt, BitVec.lt_eq_decide_ult, BitVec.ult_eq_not_carry]
--   rcases w with rfl | w
--   · simp [BitVec.of_length_zero]
--   · simp
--     simp [BitStream.borrow, BitStream.subAux_eq_BitVec_carry (w := w + 1)]



def IsGoodTermFSM_mkTermFSM (wcard tcard : Nat) {tctx : Term.Ctx wcard tcard}
    {wold : WidthExpr wcard}
    (t : Term tctx wold) :
    (HTermFSMToBitStream (mkTermFSM wcard tcard (.ofDep t))) := by
  induction t
  case var v =>
    constructor
    intros wenv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    simp only [Nondep.Term.ofDep_var, mkTermFSM,
      Fin.is_lt, ↓reduceDIte, Fin.eta, FSM.eval_var', htenv_term,
      BitStream.ofBitVecZextMsb_eq_concat_ofBitVecZext, Term.toBV_var]
  case add v p q hp hq =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp only [Nondep.Term.ofDep, mkTermFSM, composeBinaryAux'_eval, FSM.eval_add, cond_true,
      cond_false]
    rw [hp.heq (henv := htenv)]
    rw [hq.heq (henv := htenv)]
    rw [Term.toBV_add] -- TODO: why does this just not rewrite?
    simp
    have hwgood := IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) v
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    rcases i with rfl | i
    · simp
    · simp
      by_cases hi : i < v.toNat wenv
      · simp [show i + 1 ≤ v.toNat wenv by omega]
        rw [BitStream.concat_false_add_concat_false_eq_add]
        simp only [BitStream.concat_succ]
        -- | TODO: find clean lemmas here.
        rw [BitStream.EqualUpTo_ofBitVecZext_add]
        omega
      · simp [show ¬ i + 1 ≤ v.toNat wenv by omega]
        apply BitVec.getLsbD_of_ge
        omega
  case zext w' a wnew ha  =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    let hwnew := IsGoodNatFSM_mkWidthFSM tcard wnew
    rw [fsmZext_eval_eq (htenv := htenv) (wnew := wnew) (ht := ha) (hwnew := hwnew)]
    simp
  case sext wold a wnew ha =>
    constructor
    intros wenv tenv fsmEnv htenv
    let hwold := IsGoodNatFSM_mkWidthFSM tcard wold
    let hwnew := IsGoodNatFSM_mkWidthFSM tcard wnew
    simp [Nondep.Term.ofDep, mkTermFSM]
    -- | TODO: why does this not unify?
    rw [MultiWidth.Nondep.Term.width_ofDep_eq_ofDep]
    rw [fsmSext_eval_eq (htenv := htenv) (tenv := tenv)
      (wold := wold) (wnew := wnew) (t := a) (htfsm := ha)
      (hwnew := hwnew) (hwold := hwold)]
    simp
  case band _w a b ha hb =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv)]
    rw [hb.heq (henv := htenv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bor _w a b ha hb =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv)]
    rw [hb.heq (henv := htenv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bxor _w a b ha hb =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv)]
    rw [hb.heq (henv := htenv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bnot w a ha =>
    let hw := IsGoodNatFSM_mkWidthFSM tcard w
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv)]
    rw [hw.heq (henv := htenv.toHWidthEnv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i
    · simp
    · simp
      by_cases hi : i < w.toNat wenv
      · simp [hi]
        omega
      · simp [hi]
        omega

def fsmTermEq {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard a)
  (bfsm : TermFSM wcard tcard b)
  -- (ha : IsGoodTermFSM afsm)
  -- (hb : IsGoodTermFSM bfsm)
  : FSM (StateSpace wcard tcard) :=
    composeUnaryAux FSM.scanAnd
    (composeBinaryAux' FSM.nxor afsm.toFsm  bfsm.toFsm)


-- | TODO: refactor the whole thing, to not need a separation between 'output' and 'state.
/-- fsm for carry, where initial carry bit is given statically.

TODO: create different
-/
def fsmCarry (width0Val : Bool) (initialCarryVal : Bool): FSM Bool :=
  let outputCirc :=
    let atState0 := Circuit.var true (Sum.inl false)
    let carry := Circuit.var true (Sum.inl true)
    let a := Circuit.var true (Sum.inr true)
    let b := Circuit.var true (Sum.inr false)
    -- if we are zero, then the output is 'false'.
    Circuit.ite atState0
      (Circuit.ofBool width0Val)
      ((a &&& b) ||| (a &&& carry) ||| (b &&& carry))
  let nextStateCirc :=
    let atState0 := Circuit.var true (Sum.inl false)
    let carry := Circuit.var true (Sum.inl true)
    let a := Circuit.var true (Sum.inr true)
    let b := Circuit.var true (Sum.inr false)
    -- if we are zero, then the output is 'false'.
    Circuit.ite atState0
      (carry)
      ((a &&& b) ||| (a &&& carry) ||| (b &&& carry))

  { α := Bool,
    -- bit at 'false' tells us if we are at the zero state.
    -- bit at 'true' tells us the carry value.
    initCarry := fun stateIx =>
      match stateIx with
      | false => true -- we are at the state zero.
      | true => initialCarryVal, -- our carry is the init carry.
    outputCirc := outputCirc
    nextStateCirc := fun stateIx =>
      match stateIx with
      | false => Circuit.fals -- from state 1 onwards, this is just "false"
      | true => nextStateCirc
  }

@[simp]
theorem initCarry_fsmCarry : (fsmCarry width0Val initCarry).initCarry =
  fun isZeroOrCarry =>
      match isZeroOrCarry with
      | false => true -- we are at the state zero.
      | true => initCarry := by
  simp [fsmCarry]; grind

@[simp]
theorem snd_nextBit_fsmCarry {state : Bool → Bool} {env : Bool → Bool} :
    ((fsmCarry width0Val initCarry).nextBit state env).2 =
      if (state false)
      then width0Val
      else Bool.atLeastTwo (env true) (env false) (state true) := by
  simp [fsmCarry, FSM.nextBit, Lean.Elab.WF.paramLet, FSM.nextBit]
  by_cases hs : state false
  · simp [hs]
    by_cases hw : width0Val <;> simp [hw]
  · simp [hs]

@[simp]
theorem fst_nextBit_fsmCarry_eq_atLeastTwo {state : Bool → Bool} {env : Bool → Bool} :
    ((fsmCarry width0Val initCarry).nextBit state env).1 = fun stateIx =>
    match stateIx with
    | false => false
    | true =>
      if (state false)
      then (state true)
      else Bool.atLeastTwo (env true) (env false) (state true) := by
  simp [fsmCarry, Lean.Elab.WF.paramLet, FSM.nextBit]
  ext bit
  rcases bit with rfl | rfl
  · simp
  · simp
    -- by_cases hs : state false
    -- · simp [hs]
    --   by_cases hw : width0Val <;> simp [hw]
    -- · simp [hs]

-- def unConcat (f : FSM arity) : FSM arity where
--   α := f.α
--   initCarry := fun s =>
--     (f.nextStateCirc s).eval
--      (Sum.elim (fun t => (f.initCarry t)) (fun _ => false))
--   nextStateCirc := f.nextStateCirc
--   outputCirc := f.outputCirc

-- theorem eval_unConcat (f : FSM arity) (b : Bool) {env : arity → BitStream}
--   (hf : ∀ (env₁ env₂ : f.α ⊕ arity → Bool), f.outputCirc.eval env₁ = f.outputCirc.eval env₂) :
--   (unConcat (composeUnaryAux (FSM.ls b) f)).eval env i = f.eval env i := by
--   induction i
--   case zero =>
--     simp [unConcat]
--     simp [FSM.eval, FSM.nextBit]
--     simp [composeUnaryAux, FSM.compose]
--     simp [FSM.ls]
--     simp [Circuit.eval_bind]
--     simp [Circuit.eval_map]
--     congr 1
--     ext i
--     rcases i with i | i
--     · simp
--     · simp
--       let env' : arity → BitStream := fun a i => false
--       rw [show false = env' i 0 by rfl]


/--
The carry state of the borrow bit.
TODO: rewrite with 'induction' to be a clean proof script.
-/
@[simp] theorem carry_fsmCarry (initCarry : Bool)
    (x : Bool → BitStream) : ∀ (n : ℕ),
    FSM.carry (fsmCarry width0Val initCarry) x (n + 1) =
    fun stateIx =>
      match stateIx with
      | false => false
      | true =>
        match n with
        | 0 => initCarry
        | n + 1 => BitStream.carry initCarry ((x true).tail) ((x false).tail) n := by
  intros n
  induction n
  case zero =>
    ext stateIx
    rcases stateIx with rfl | rfl
    · simp [fsmCarry, FSM.carry, FSM.nextBit]
    · simp [fsmCarry, FSM.carry, FSM.nextBit]
      -- by_cases hw : width0Val <;> simp [hw]
  case succ n ih =>
    ext stateIx
    rw [FSM.carry]
    simp only [ih]
    clear ih
    simp [FSM.nextBit, fsmCarry]
    rcases stateIx with rfl | rfl
    · simp
    · simp
      induction n
      case zero =>
        simp [BitStream.carry_zero, Bool.atLeastTwo]
        -- sorry
      case succ n ih =>
        simp [BitStream.carry_succ, Bool.atLeastTwo]
        -- sorry

@[simp] lemma eval_fsmCarry (x : Bool → BitStream) :
    (fsmCarry width0Val initCarry).eval x =
    (BitStream.concat width0Val <|
      BitStream.carry initCarry (x true).tail (x false).tail) := by
  ext i
  rcases i with rfl | i
  · simp [fsmCarry, FSM.eval, FSM.nextBit]
    rcases width0Val with rfl | rfl <;> simp
  · induction i
    case zero =>
      simp [FSM.eval]
    case succ i ih =>
      rw [FSM.eval]
      simp only [carry_fsmCarry]
      simp

-- /-- an FSM for carry, that takes in the init carry after one step. -/
-- def fsmCarryDelayed (initialCarryVal : Bool) : FSM Bool :=
--   composeUnaryAux (FSM.ls false) (fsmCarry initialCarryVal)

/--
The 'carry' FSM evaluates to the value of the carry bit.
-/
theorem eval_fsmCarry_eq {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term tctx w)
    (b : Term tctx w)
    (afsm : TermFSM wcard tcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((composeBinaryAux' (fsmCarry width0Val initCarry)
      afsm.toFsm
      bfsm.toFsm)).eval fsmEnv i =
      match i with
      | 0 => width0Val
      | i + 1 => BitVec.carry (i + 1) (a.toBV tenv) (b.toBV tenv) initCarry
           := by
  rcases i with rfl | i
  · simp
  · induction i
    · case zero =>
      simp
      rw [BitVec.carry_succ]
      simp
      rw [hafsm.heq (henv := henv)]
      simp
      rw [hbfsm.heq (henv := henv)]
      simp
    · case succ i ih =>
      simp only [] at ih ⊢
      simp
      rw [BitVec.carry_succ]
      rw [← ih]
      simp
      rw [hafsm.heq (henv := henv)]
      simp
      rw [hbfsm.heq (henv := henv)]
      simp



def fsmCarry' (initialCarryVal : Bool): FSM Bool :=
  let outputCirc :=
    let carry := Circuit.var true (Sum.inl ())
    let a := Circuit.var true (Sum.inr true)
    let b := Circuit.var true (Sum.inr false)
    -- if we are zero, then the output is 'false'.
    ((a &&& b) ||| (a &&& carry) ||| (b &&& carry))
  { α := Unit,
    -- bit at 'false' tells us if we are at the zero state.
    -- bit at 'true' tells us the carry value.
    initCarry := fun () => initialCarryVal, -- our carry is the init carry.
    outputCirc := outputCirc,
    nextStateCirc := fun () => outputCirc
  }


@[simp]
theorem initCarry_fsmCarry' : (fsmCarry' initCarry).initCarry =
    fun _ => initCarry := by
  simp [fsmCarry']

@[simp]
theorem snd_nextBit_fsmCarry' {state : Unit → Bool} {env : Bool → Bool} :
    ((fsmCarry' initCarry).nextBit state env).2 =
      Bool.atLeastTwo (env true) (env false) (state ()) := by
  simp [fsmCarry', FSM.nextBit, Lean.Elab.WF.paramLet, FSM.nextBit]

@[simp]
theorem fst_nextBit_fsmCarry'_eq_atLeastTwo {state : Unit → Bool} {env : Bool → Bool} :
    ((fsmCarry' initCarry).nextBit state env).1 =
      fun () => Bool.atLeastTwo (env true) (env false) (state ()) := by
  simp [fsmCarry', Lean.Elab.WF.paramLet, FSM.nextBit]

/--
The carry state of the borrow bit.
TODO: rewrite with 'induction' to be a clean proof script.
-/
@[simp] theorem carry_fsmCarry' (initCarry : Bool)
    (x : Bool → BitStream) : ∀ (n : ℕ),
    FSM.carry (fsmCarry' initCarry) x (n + 1) =
      fun () =>
        BitStream.carry initCarry ((x true)) ((x false)) n := by
  intros n
  induction n
  case zero =>
    ext stateIx
    simp [fsmCarry', FSM.carry, FSM.nextBit]
      -- by_cases hw : width0Val <;> simp [hw]
  case succ n ih =>
    ext stateIx
    rw [FSM.carry]
    simp only [ih]
    clear ih
    simp [FSM.nextBit, fsmCarry']

@[simp] lemma eval_fsmCarry' (x : Bool → BitStream) :
    (fsmCarry' initCarry).eval x =
      (BitStream.carry initCarry (x true) (x false)) := by
  ext i
  rcases i with rfl | i
  · simp [fsmCarry', FSM.eval, FSM.nextBit]
  · induction i
    case zero =>
      simp [FSM.eval]
    case succ i ih =>
      rw [FSM.eval]
      simp only [carry_fsmCarry']
      simp

def fsmCarry'' (initialCarryVal : Bool): FSM Bool :=
  let outputCirc :=
    let carry := Circuit.var true (Sum.inl ())
    let a := Circuit.var true (Sum.inr true)
    let b := Circuit.var true (Sum.inr false)
    -- if we are zero, then the output is 'false'.
    ((a &&& b) ||| (a &&& carry) ||| (b &&& carry))
  { α := Unit,
    -- bit at 'false' tells us if we are at the zero state.
    -- bit at 'true' tells us the carry value.
    initCarry := fun () => initialCarryVal, -- our carry is the init carry.
    outputCirc := Circuit.var true (Sum.inl ()) ,
    nextStateCirc := fun () => outputCirc
  }


@[simp]
theorem initCarry_fsmCarry'' : (fsmCarry'' initCarry).initCarry =
    fun _ => initCarry := by
  simp [fsmCarry'']

@[simp]
theorem snd_nextBit_fsmCarry'' {state : Unit → Bool} {env : Bool → Bool} :
    ((fsmCarry'' initCarry).nextBit state env).2 =
      (state ()) := by
  simp [fsmCarry'', FSM.nextBit, Lean.Elab.WF.paramLet, FSM.nextBit]

@[simp]
theorem fst_nextBit_fsmCarry''_eq_atLeastTwo {state : Unit → Bool} {env : Bool → Bool} :
    ((fsmCarry' initCarry).nextBit state env).1 =
      fun () => Bool.atLeastTwo (env true) (env false) (state ()) := by
  simp [fsmCarry', Lean.Elab.WF.paramLet, FSM.nextBit]

/--
The carry state of the borrow bit.
TODO: rewrite with 'induction' to be a clean proof script.
-/
@[simp] theorem carry_fsmCarry'' (initCarry : Bool)
    (x : Bool → BitStream) : ∀ (n : ℕ),
    FSM.carry (fsmCarry'' initCarry) x n =
      fun () =>
        BitStream.carry' initCarry ((x true)) ((x false)) n := by
  intros n
  induction n
  case zero =>
    ext stateIx
    simp [fsmCarry'', FSM.carry]
      -- by_cases hw : width0Val <;> simp [hw]
  case succ n ih =>
    ext stateIx
    rw [FSM.carry]
    simp only [ih]
    clear ih
    simp [FSM.nextBit, fsmCarry'']

@[simp] lemma eval_fsmCarry'' (x : Bool → BitStream) :
    (fsmCarry'' initCarry).eval x =
      (BitStream.carry' initCarry (x true) (x false)) := by
  ext i
  induction i
  case zero =>
    simp [FSM.eval]
  case succ i ih =>
    simp [FSM.eval]

def fsmTermUlt {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard a)
  (bfsm : TermFSM wcard tcard b)
  : FSM (StateSpace wcard tcard) :=
    let streamFsm := composeUnaryAux (FSM.ls true) (fsmCarry'' true)
    (~~~ (composeBinaryAux' streamFsm  afsm.toFsm (~~~ bfsm.toFsm)))

/--
info: BitVec.ult_eq_not_carry {w : ℕ} (x y : BitVec w) :
  x.ult y = !BitVec.carry w x (~~~y) true
-/
#guard_msgs (whitespace := lax) in #check BitVec.ult_eq_not_carry


/--
The 'carry' FSM evaluates to the value of the carry bit.
-/
theorem eval_fsmTermUlt_eq_carry {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term tctx w)
    (b : Term tctx w)
    (afsm : TermFSM wcard tcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermUlt
      afsm
      bfsm)).eval fsmEnv i =
      !(BitVec.carry i (a.toBV tenv) (~~~ b.toBV tenv) true)
           := by
    simp [fsmTermUlt]
    rcases i with rfl | i
    · simp
    · simp
      rw [BitStream.carry'_eq_carry
        (x' := BitVec.shiftLeftZeroExtend (Term.toBV tenv a) 1)
        (y' := ~~~ (BitVec.shiftLeftZeroExtend ((Term.toBV tenv b)) 1))]
      sorry
      · intros i
        rw [hafsm.heq (henv := henv)]
        simp
        rcases i with rfl | i
        · simp
        · simp
      · intros i
        rw [hbfsm.heq (henv := henv)]
        simp
        rcases i with rfl | i
        · simp
        · simp
          sorry

-- fSM that returns 1 ifthe predicate is true, and 0 otherwise -/
def mkPredicateFSMAux (wcard tcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard p) :=
  match p with
  | .binRel .eq _w a b =>
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    { toFsm := fsmTermEq fsmA fsmB }
  | .binRel .ult w a b =>
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    let fsmW := mkWidthFSM wcard tcard w
    { toFsm := ~~~ fsmW.toFsm ||| fsmTermUlt fsmA fsmB }
  | .or p q  =>
    let fsmP :=  mkPredicateFSMAux wcard tcard p
    let fsmQ :=  mkPredicateFSMAux wcard tcard q
    let fsmP := composeUnaryAux FSM.scanAnd fsmP.toFsm
    let fsmQ := composeUnaryAux FSM.scanAnd fsmQ.toFsm
    { toFsm := (fsmP ||| fsmQ) }
  | .and p q =>
    let fsmP := mkPredicateFSMAux wcard tcard p
    let fsmQ := mkPredicateFSMAux wcard tcard q
    { toFsm := (fsmP.toFsm &&& fsmQ.toFsm) }


theorem foo (f g : α → β) (h : f ≠ g) : ∃ x, f x ≠ g x := by
  exact Function.ne_iff.mp h

def isGoodPredicateFSM_mkPredicateFSMAux {wcard tcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx) :
    HPredFSMToBitStream (mkPredicateFSMAux wcard tcard (.ofDep p)) := by
  induction p
  case binRel rel w a b =>
    rcases rel with rfl | rfl
    case eq =>
      -- | TODO: extract proof.
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      -- fsmTermEqProof starts here.
      simp [fsmTermEq]
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard b
      rw [ha.heq (henv := henv)]
      rw [hb.heq (henv := henv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp
        rw [h]
        rw [BitStream.scanAnd_eq_decide]
        simp
      · intros h
        apply BitVec.eq_of_getLsbD_eq
        intros i hi
        have := congrFun h (i + 1)
        simp at this
        simp [this]
    case ult =>
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hw := IsGoodNatFSM_mkWidthFSM tcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard b
      simp [fsmTermUlt]
      rw [hw.heq (henv := henv.toHWidthEnv)]
      -- rw [ha.heq (henv := henv)]
      -- rw [hb.heq (henv := henv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp only [BitStream.or_eq, BitStream.not_eq, BitStream.eval_ofNatUnary,
          BitStream.negOne_eq, Bool.or_eq_true, Bool.not_eq_eq_eq_not, Bool.not_true,
          decide_eq_false_iff_not, not_le]
        by_cases hw : w.toNat wenv < N
        · simp [hw]
        · simp [hw]
          rcases N with rfl | N
          · simp
          · simp
            sorry
      · intros h
        simp at h
        rw [← BitVec.ult_iff_lt]
        rw [BitVec.ult_eq_not_carry]
        simp
        -- have := BitVec.ult_eq_not_carry
        --   (w := w.toNat wenv)
        --   (x := Term.toBV tenv a)
        --   (y := Term.toBV tenv b)
        -- have := congrArg Bool.not this
        -- rw [Bool.not_not] at this
        -- rw [← this]
        -- simp
        have := congrFun h ((w.toNat wenv) + 1)
        simp at this
        -- rw [BitStream.carry_eq_carry]
        sorry
  case or p q hp hq =>
    constructor
    intros wenv tenv fsmEnv henv
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    simp [Predicate.toProp]
    rw [hp.heq (henv := henv)]
    rw [hq.heq (henv := henv)]
    constructor
    · intros h
      ext i
      simp only [BitStream.or_eq, BitStream.negOne_eq, Bool.or_eq_true]
      rcases h with h | h
      · left
        rw [BitStream.scanAnd_eq_decide]
        simp
        intros j hj
        have := congrFun h j
        simp at this
        simp [this]
      · right
        rw [BitStream.scanAnd_eq_decide]
        simp
        intros j hj
        have := congrFun h j
        simp at this
        simp [this]
    · intros h
      by_contra h'
      simp at h'
      obtain ⟨h1, h2⟩ := h'
      have h1 := Function.ne_iff.mp h1
      have h2 := Function.ne_iff.mp h2
      obtain ⟨i1, h1⟩ := h1
      simp at h1
      obtain ⟨i2, h2⟩ := h2
      simp at h2
      have := congrFun h (max i1 i2)
      simp at this
      rcases this with this | this
      · rw [BitStream.scanAnd_eq_decide] at this
        simp at this
        specialize this i1 (by omega)
        simp [this] at h1
      · rw [BitStream.scanAnd_eq_decide] at this
        simp at this
        specialize this i2 (by omega)
        simp [this] at h2
  case and p q hp hq =>
    constructor
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    intros wenv tenv fsmEnv htenv
    simp [Predicate.toProp]
    rw [hp.heq (henv := htenv)]
    rw [hq.heq (henv := htenv)]
    constructor
    · intros h
      obtain ⟨hpfsm, hqfsm⟩ := h
      simp [hpfsm, hqfsm]
      ext i; simp
    · intros h
      constructor
      · ext i
        have := congrFun h i
        simp at this
        simp [this]
      · ext i
        have := congrFun h i
        simp at this
        simp [this]

/-- Negate the FSM so we can decide if zeroes. -/
def mkPredicateFSMNondep (wcard tcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard p) :=
    let fsm := mkPredicateFSMAux wcard tcard p
    { toFsm := ~~~ fsm.toFsm }

def mkPredicateFSMDep {wcard tcard : Nat} {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx) : PredicateFSM wcard tcard (.ofDep p) :=
  mkPredicateFSMNondep wcard tcard (.ofDep p)

section BitStream2BV

variable
  {tctx : Term.Ctx wcard tcard}
    (p : Predicate tctx)

end BitStream2BV

-- | TODO: rename these namespaces.
open ReflectVerif BvDecide Std Tactic BVDecide Frontend in
/-- If the FSM passes the safety and induction certificates,
then the predicate is satisfied.
-/
theorem Predicate.toProp_of_KInductionCircuits
    {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    (p : MultiWidth.Predicate tctx)
    (pNondep : Nondep.Predicate)
    (_hpNondep : pNondep = (.ofDep p))
    (fsm : PredicateFSM wcard tcard pNondep)
    (_hfsm : fsm = mkPredicateFSMNondep wcard tcard pNondep)
    (n : Nat)
    (circs : KInductionCircuits fsm.toFsm n)
    (hCircs : circs.IsLawful)
    (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
    (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
    (wenv : WidthExpr.Env wcard)
    (tenv : tctx.Env wenv) :
    p.toProp tenv := by
  have hGoodPredicateFSM := isGoodPredicateFSM_mkPredicateFSMAux p
  rw [hGoodPredicateFSM.heq (tenv := tenv)
    (fsmEnv := HTermEnv.mkFsmEnvOfTenv tenv)]
  · subst _hpNondep _hfsm
    simp [mkPredicateFSMNondep] at circs
    apply ReflectVerif.BvDecide.KInductionCircuits.eval_eq_negOne_of_mkIndHypCycleBreaking_eval_eq_false_of_mkSafetyCircuit_eval_eq_false'
      (circs := circs) (hCircs := hCircs) (envBitstream := (HTermEnv.mkFsmEnvOfTenv tenv))
      (hSafety := Circuit.eval_eq_false_of_verifyCircuit hs)
      (hIndHyp := Circuit.eval_eq_false_of_verifyCircuit hind)
  · simp

/--
info: 'MultiWidth.Predicate.toProp_of_KInductionCircuits' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms Predicate.toProp_of_KInductionCircuits

end MultiWidth
