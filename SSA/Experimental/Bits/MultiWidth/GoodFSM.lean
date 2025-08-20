/-
This file builds the FSMs whose
verification implies the correctness of the
multi-width bitstream semantics.
-/
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars
import SSA.Experimental.Bits.MultiWidth.Defs
import SSA.Experimental.Bits.KInduction.KInduction
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
  | _ => { toFsm := FSM.zero' }

axiom AxIsGoodNatFsm {P : Prop}: P

def IsGoodNatFSM_mkWidthFSM {wcard : Nat} (tcard : Nat) (w : WidthExpr wcard) :
    HNatFSMToBitstream (mkWidthFSM wcard tcard (.ofDep w)) where
  heq := by
    intros wenv fsmEnv henv
    induction w
    case var v =>
      simp [mkWidthFSM]
      have ⟨henv⟩ := henv
      rw [henv]
    case min v w => exact AxIsGoodNatFsm
    case max v w => exact AxIsGoodNatFsm
    case addK v k => exact AxIsGoodNatFsm


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
  | .add a b =>
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    { toFsm := (composeBinaryAux' FSM.add fsmA.toFsm fsmB.toFsm) }
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

axiom AxAdd {P : Prop} : P

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
    simp only [BitStream.ofBitVecZextMsb_eq_concat_ofBitVecZext]
    -- -- TODO: fill this up
    -- rw [← BitStream.add_eq]
    -- rw [BitStream.add]
    exact AxAdd
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

def fsmTermEq {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard a)
  (bfsm : TermFSM wcard tcard b)
  -- (ha : IsGoodTermFSM afsm)
  -- (hb : IsGoodTermFSM bfsm)
  : FSM (StateSpace wcard tcard) :=
    composeUnaryAux FSM.scanAnd
    (composeBinaryAux' FSM.nxor afsm.toFsm  bfsm.toFsm)


-- fSM that returns 1 ifthe predicate is true, and 0 otherwise -/
def mkPredicateFSMAux (wcard tcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard p) :=
  match p with
  | .binRel .eq a b =>
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    { toFsm := fsmTermEq fsmA fsmB }
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
  case binRel w rel a b =>
    rcases rel
    case eq =>
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
info: 'MultiWidth.Predicate.toProp_of_KInductionCircuits' depends on axioms: [propext,
 Classical.choice,
 MultiWidth.AxAdd,
 MultiWidth.AxIsGoodNatFsm,
 Quot.sound]
-/
#guard_msgs in #print axioms Predicate.toProp_of_KInductionCircuits

end MultiWidth
