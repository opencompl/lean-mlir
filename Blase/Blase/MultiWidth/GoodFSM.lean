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



-- build an FSM whose output is unary, and is 1 in the beginning, and becomes 0
-- forever after.
-- TODO: I am pretty sure we can just do this with binary encodings as well?
def mkWidthFSM (wcard : Nat) (tcard : Nat) (pcard : Nat) (w : Nondep.WidthExpr) :
    (NatFSM wcard tcard pcard w) :=
  match w with
  | .const nat => {
      toFsm := (FSM.trueUptoExcluding nat).map Fin.elim0
    }
  | .var wnat =>
    if h : wnat < wcard then
      { toFsm :=
        composeUnaryAux FSM.scanAnd (FSM.var' (StateSpace.widthVar ⟨wnat, h⟩))
        -- (FSM.var' (StateSpace.widthVar ⟨wnat, h⟩))
      }
    else
      { toFsm := FSM.zero' } -- default, should not be used.
  | .min v w =>
      { toFsm :=
        (mkWidthFSM wcard tcard pcard v).toFsm &&& (mkWidthFSM wcard tcard pcard w).toFsm
      }
  | .max v w =>
        { toFsm :=
        (mkWidthFSM wcard tcard pcard v).toFsm ||| (mkWidthFSM wcard tcard pcard w).toFsm
      }
  | .addK v k =>
    { toFsm :=
        composeUnaryAux (FSM.repeatN true k)  (mkWidthFSM wcard tcard pcard v).toFsm
    }

def IsGoodNatFSM_mkWidthFSM {wcard : Nat} (tcard : Nat) (pcard : Nat) (w : WidthExpr wcard) :
    HNatFSMToBitstream (mkWidthFSM wcard tcard pcard (.ofDep w)) where
  heq := by
    intros wenv fsmEnv henv
    induction w
    case const n =>
      simp [mkWidthFSM, FSM.eval_trueUptoExcluding]
    case var v =>
      simp [mkWidthFSM]
      have ⟨henv⟩ := henv
      rw [henv]
      ext i
      rw [BitStream.scanAnd_eq_decide]
      simp
      constructor
      · intros hi
        apply hi
        omega
      · intros hi
        intros j hj
        omega
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
      simp only [decide_or_decide_eq_decide, decide_eq_decide]
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
  composeBinaryAux'
    (FSM.latchImmediate false)
    (qfalse := x)
    (qtrue := w)

@[simp]
theorem eval_fsmMsb_eq {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (w : WidthExpr wcard)
    (x : Term tctx w)
    (xfsm : TermFSM wcard tcard pcard (.ofDep x))
    (hxfsm : HTermFSMToBitStream xfsm)
    (wfsm : NatFSM wcard tcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmMsb xfsm.toFsmZext wfsm.toFsm).eval fsmEnv = (fun i =>
      BitStream.ofBitVecZext (x.toBV tenv) (min i (w.toNat wenv - 1))) := by
  simp [fsmMsb]
  have wfsmEval := hwfsm.heq (henv := htenv.toHWidthEnv)
  have tfsmEval := hxfsm.heq (henv := htenv)
  ext i
  rcases i with rfl | i
  case zero =>
    simp [wfsmEval]
    by_cases hw : 0 < w.toNat wenv
    · simp [hw]
      simp [tfsmEval]
      rfl
    · simp at hw
      simp [hw]
  case succ =>
    simp
    simp [wfsmEval]
    simp [tfsmEval]
    by_cases hi : i + 1 < w.toNat wenv
    · simp [hi]
      congr; omega
    · simp [hi]
      simp at hi
      simp [show min (i + 1) (w.toNat wenv - 1) = w.toNat wenv - 1 by omega]
      induction i
      case neg.zero =>
        simp
        by_cases hw : 0 < w.toNat wenv
        · simp [hw]
          simp [show w.toNat wenv = 1 by omega]
        · simp [hw]
          simp at hw
          simp [hw]
      case neg.succ i ih =>
        simp
        by_cases hw : i + 1 < w.toNat wenv
        · simp [hw]
          congr
          omega
        · simp [hw]
          rw [ih]
          omega

theorem eval_fsmMsb_eq_BitStream_ofBitVecSext {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (w : WidthExpr wcard)
    (x : Term tctx w)
    (xfsm : TermFSM wcard tcard pcard (.ofDep x))
    (hxfsm : HTermFSMToBitStream xfsm)
    (wfsm : NatFSM wcard tcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmMsb xfsm.toFsmZext wfsm.toFsm).eval fsmEnv =
      BitStream.ofBitVecSext (x.toBV tenv) := by
  rw [eval_fsmMsb_eq (wfsm := wfsm) (hwfsm := hwfsm) (hxfsm := hxfsm)
    (tenv := tenv) (htenv := htenv)]
  ext i
  simp [BitStream.ofBitVecSext]
  by_cases hi : i < w.toNat wenv
  · simp [hi]
    congr
    omega
  · simp [hi, BitVec.msb_eq_getLsbD_last]
    congr
    omega

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
  (a : NatFSM wcard tcard pcard (.ofDep v))
  (b : NatFSM wcard tcard pcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard pcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
  ((fsmUnaryMax a.toFsm b.toFsm).eval fsmEnv) i =
    (i < (max (v.toNat wenv) (w.toNat wenv))) := by
  simp only [fsmUnaryMax, composeBinaryAux'_eval, eq_iff_iff]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp

def fsmUnaryMin (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.and a b

/-- compute the 'min' of two FSMs. -/
@[simp]
theorem eval_fsmUnaryMin_eq_decide
  (a : NatFSM wcard tcard pcard (.ofDep v))
  (b : NatFSM wcard tcard pcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard pcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
  ((fsmUnaryMin a.toFsm b.toFsm).eval fsmEnv) i =
    (i < (min (v.toNat wenv) (w.toNat wenv))) := by
  simp only [fsmUnaryMin, composeBinaryAux'_eval, _root_.FSM.eval_and, cond_true, cond_false,
    BitStream.and_eq, Bool.and_eq_true, eq_iff_iff]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  simp

/-- increment a unary number by a known constant 'k'. -/
def fsmUnaryIncrK (k : Nat) (fsm : FSM α) : FSM α :=
  match k with
  | 0 => fsm
  | k + 1 => composeUnaryAux (FSM.ls true) (fsmUnaryIncrK k fsm)

theorem eval_fsmUnaryIncrK_eq_decide
  (a : NatFSM wcard tcard pcard (.ofDep v))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard pcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : HNatFSMToBitstream a) :
  ((fsmUnaryIncrK k a.toFsm).eval fsmEnv) = fun i =>
  decide (i < (v.toNat wenv) + k) := by
  induction k
  case zero =>
    simp [fsmUnaryIncrK]
    rw [ha.heq (henv := henv)]
  case succ k ih =>
    simp [fsmUnaryIncrK]
    rw [ih]
    ext i
    rcases i with rfl | i
    · simp
    · simp only [BitStream.concat_succ, decide_eq_decide]
      omega


@[simp]
private theorem min_eq_of_not_le {a b : Nat} (hab : ¬ a ≤ b) : min a b = b := by
  omega

@[simp]
private theorem min_eq_of_not_le' {a b : Nat} (hab : ¬ a ≤ b) : min b a = b := by
  omega

/-- this creates an FSM that returns whether 'a ≤ i' -/
def NatFSM.fsmUnaryIndexUle (a : NatFSM wcard tcard pcard v) :
    FSM (StateSpace wcard tcard pcard) :=
  composeUnaryAux (FSM.ls true) a.toFsm

@[simp]
theorem HNatFSMToBitstream.fsmIndexUle_eval_eq
    (a : NatFSM wcard tcard pcard (.ofDep v))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) :
    (NatFSM.fsmUnaryIndexUle a).eval fsmEnv = fun i =>
    decide (i ≤ v.toNat wenv) := by
  ext i
  rw [NatFSM.fsmUnaryIndexUle]
  rcases i with rfl | i
  · simp
  · simp [ha.heq (henv := henv)]
    omega


-- when we compute 'a - b', if the borrow bit is zero,
-- then we know that 'a' is greater than or equal to 'b'.
-- if the borrow bit is one, then we know that 'a' is less than 'b'.
-- a ≤ b ↔ b[i] = 0 → a[i] = 0
-- if b = 1, we are done.
-- Otherwise, if b=0,then a=0

-- alternatively, a[i] = 1 → b[i] = 1.
-- if a is high, then b must be high for it to be ≤.
def fsmUnaryUle (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard pcard) :=
 composeUnaryAux FSM.scanAnd (b.fsmUnaryIndexUle ||| ~~~ a.fsmUnaryIndexUle)

theorem eval_fsmUnaryUle_eq_decide
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryUle a b).eval fsmEnv) i =
    decide (min i (v.toNat wenv) ≤ min i (w.toNat wenv)) := by
  simp [fsmUnaryUle]
  rw [ha.fsmIndexUle_eval_eq (henv := henv)]
  rw [hb.fsmIndexUle_eval_eq (henv := henv)]
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
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryUle a b).eval fsmEnv) i =
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
def fsmEqUnaryUpto (a : NatFSM wcard tcard pcard (.ofDep v))
  (b : NatFSM wcard tcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard pcard) :=
  composeUnaryAux FSM.scanAnd (composeBinaryAux' FSM.nxor
    a.fsmUnaryIndexUle
    b.fsmUnaryIndexUle)


@[simp]
theorem eval_FsmEqUpto_eq_decide
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmEqUnaryUpto a b).eval fsmEnv) i =
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  simp [fsmEqUnaryUpto]
  simp [BitStream.scanAnd_eq_decide]
  rw [ha.fsmIndexUle_eval_eq (henv := henv)]
  rw [hb.fsmIndexUle_eval_eq (henv := henv)]
  simp
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
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmEqUnaryUpto a b).eval fsmEnv) = fun i =>
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  ext i
  rw [eval_FsmEqUpto_eq_decide (henv := henv) (ha := ha) (hb := hb)]

/-- returns 1 if a is not equal to b. -/
def fsmUnaryNeqUpto (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard pcard) :=
  composeUnaryAux FSM.scanOr (a.fsmUnaryIndexUle ^^^ b.fsmUnaryIndexUle)

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
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUnaryNeqUpto a b).eval fsmEnv) i =
    (decide (min i (v.toNat wenv) ≠ min i (w.toNat wenv))) := by
  simp [fsmUnaryNeqUpto]
  rw [ha.fsmIndexUle_eval_eq (henv := henv)]
  rw [hb.fsmIndexUle_eval_eq (henv := henv)]
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

def fsmUltUnary
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard pcard) :=
  composeBinaryAux' FSM.and (fsmUnaryUle a b) (fsmUnaryNeqUpto a b)

theorem eval_fsmUltUnary_eq_decide
    (a : NatFSM wcard tcard pcard (.ofDep v))
    (b : NatFSM wcard tcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmUltUnary a b).eval fsmEnv) i =
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


def fsmZext (nFsm wnewfsm : FSM (StateSpace wcard tcard pcard))
    : FSM (StateSpace wcard tcard pcard) :=
  (nFsm) &&& (wnewfsm)


/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmZext_eval_eq
    (wnewFsm : NatFSM wcard tcard pcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term tctx w)
    (tFsm : TermFSM wcard tcard pcard (.ofDep t))
    (ht : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmZext tFsm.toFsmZext wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZext ((Term.zext t wnew).toBV tenv))) i := by
  ext i
  rw [fsmZext]
  simp only [FSM.eval_and', BitStream.and_eq]
  simp
  rw [ht.heq (henv := htenv)]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]
  -- rw [hwnew.fsmIndexUle_eval_eq (henv := htenv.toHWidthEnv)]
  simp
  by_cases hi : i < wnew.toNat wenv <;> simp [hi]

/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmSext_eval_eq
    (woldFsm : NatFSM wcard tcard pcard (.ofDep wold))
    (wnewFsm : NatFSM wcard tcard pcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard pcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    (hwold : HNatFSMToBitstream woldFsm)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term tctx wold)
    (tFsm : TermFSM wcard tcard pcard (.ofDep t))
    (htfsm : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmSext tFsm.toFsmZext woldFsm.toFsm  wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZext ((Term.sext t wnew).toBV tenv))) i := by
  ext i
  rw [fsmSext]
  simp [FSM.eval_and', BitStream.and_eq]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]
  rw [eval_fsmMsb_eq
        (xfsm := tFsm) (wfsm := woldFsm) (htenv := htenv)
        (hxfsm := htfsm) (hwfsm := hwold)]
  simp
  by_cases hwold : i < wold.toNat wenv
  · simp [hwold]
    by_cases hwnew : i < wnew.toNat wenv
    · simp [hwnew]
      simp [BitVec.getElem_signExtend]
      simp [hwold]
      congr; omega
    · simp [hwnew]
      simp [BitVec.getLsbD_signExtend]
      omega
  · by_cases hwnew : i < wnew.toNat wenv
    · simp [hwnew]
      simp at hwold
      rw [BitVec.getElem_signExtend]
      simp [show min i (wold.toNat wenv - 1) = wold.toNat wenv - 1 by omega]
      simp [show ¬ i < wold.toNat wenv by omega]
      rw [BitVec.msb_eq_getLsbD_last]
    · simp [hwnew]
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

def mkTermFSM (wcard tcard pcard : Nat) (t : Nondep.Term) :
    (TermFSM wcard tcard pcard t) :=
  match t with
  | .ofNat w n =>
    let fsmW  := (mkWidthFSM wcard tcard pcard w)
    let fsmN : FSM (StateSpace wcard tcard pcard) := (FSM.ofNat n).map Fin.elim0
    {
      toFsmZext := fsmW.toFsm &&& fsmN,
      width := fsmW
    }
  | .var v w =>
    let wfsm := mkWidthFSM wcard tcard pcard w
    if h : v < tcard then
      let varFsm : FSM (StateSpace wcard tcard pcard) :=
       (FSM.var' (StateSpace.termVar ⟨v, h⟩))
      {
        toFsmZext := varFsm &&& wfsm.toFsm,
        width := wfsm
      }
    else
      -- default, should not be ued.
      { toFsmZext := FSM.zero.map Fin.elim0, width := mkWidthFSM wcard tcard pcard w }
  | .add w a b =>
    let fsmW := mkWidthFSM wcard tcard pcard w
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    { toFsmZext :=
      composeBinaryAux' FSM.and
        fsmW.toFsm
        (composeBinaryAux' FSM.add fsmA.toFsmZext fsmB.toFsmZext),
      width := fsmW
    }
  | .zext a wnew =>
      -- let wold := a.width
      let afsm := mkTermFSM wcard tcard pcard a
      -- let woldFsm := mkWidthFSM wcard tcard wold
      let wnewFsm := mkWidthFSM wcard tcard pcard wnew
      { toFsmZext := fsmZext afsm.toFsmZext wnewFsm.toFsm, width := wnewFsm }
  | .sext a v =>
    let wold := a.width
    let afsm := mkTermFSM wcard tcard pcard a
    let woldFsm := mkWidthFSM wcard tcard pcard wold
    let vFsm := mkWidthFSM wcard tcard pcard v
    { toFsmZext := fsmSext afsm.toFsmZext woldFsm.toFsm vFsm.toFsm, width := vFsm }
  | .band w a b =>
      let aFsm := mkTermFSM wcard tcard pcard a
      let bFsm := mkTermFSM wcard tcard pcard b
      {
        toFsmZext :=
            (composeBinaryAux' FSM.and aFsm.toFsmZext bFsm.toFsmZext),
        width := mkWidthFSM wcard tcard pcard w

      }
  | .bor w a b =>
    let aFsm := mkTermFSM wcard tcard pcard a
    let bFsm := mkTermFSM wcard tcard pcard b
    {   toFsmZext := (composeBinaryAux' FSM.or aFsm.toFsmZext bFsm.toFsmZext) ,
        width := mkWidthFSM wcard tcard pcard w
    }
  | .bxor w a b =>
    let aFsm := mkTermFSM wcard tcard pcard a
    let bFsm := mkTermFSM wcard tcard pcard b
    { toFsmZext := (composeBinaryAux' FSM.xor aFsm.toFsmZext bFsm.toFsmZext),
      width := mkWidthFSM wcard tcard pcard w
    }
  | .bnot w a =>
    let aFsm := mkTermFSM wcard tcard pcard a
    let wFsm := mkWidthFSM wcard tcard pcard w
    { toFsmZext :=
          composeBinaryAux' FSM.and wFsm.toFsm
            (composeUnaryAux FSM.not aFsm.toFsmZext),
      width := wFsm
    }

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
  {x y : BitStream} (hxy : BitStream.EqualUpTo n x y) :
  (BitStream.ofNatUnary n) &&& x =
  (BitStream.ofNatUnary n) &&& y := by
  ext i
  simp
  specialize hxy i
  by_cases hi : i < n
  · simp [hi]
    apply hxy (by omega)
  · simp [hi]

/-- Zero extend a finite bitvector 'x' to the infinite stream of 'x.msb' -/
theorem ofBitVecZextMsb_eq_ofNatUnary_and_ofBitVecZextMsb {w} (x : BitVec w) :
  (BitStream.ofBitVecZext x) =
  (BitStream.ofNatUnary w) &&& (BitStream.ofBitVecZext x) := by
  ext i
  simp
  intros hi
  have := BitVec.lt_of_getLsbD hi
  omega


def IsGoodTermFSM_mkTermFSM (wcard tcard pcard : Nat) {tctx : Term.Ctx wcard tcard}
    {wold : WidthExpr wcard}
    (t : Term tctx wold) :
    (HTermFSMToBitStream (mkTermFSM wcard tcard pcard (.ofDep t))) := by
  induction t
  case ofNat w n =>
    constructor
    intros wenv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    have hwgood := IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (pcard := pcard) w
    simp [mkTermFSM, Nondep.Term.ofDep]
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    by_cases hi : i < w.toNat wenv
    · simp [hi]
      rw [BitVec.getElem_eq_testBit_toNat]
      simp
      omega
    · simp [hi]
      apply BitVec.getLsbD_of_ge
      omega
  case var v =>
    constructor
    intros wenv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    have hwgood := IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (pcard := pcard) (tctx v)
    simp [Nondep.Term.ofDep_var, mkTermFSM, htenv_term]
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i 
    simp
    intros hi
    have := BitVec.lt_of_getLsbD hi
    omega
  case add v p q hp hq =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp only [Nondep.Term.ofDep, mkTermFSM, composeBinaryAux'_eval, FSM.eval_add, cond_true,
      cond_false]
    rw [hp.heq (henv := htenv)]
    rw [hq.heq (henv := htenv)]
    rw [Term.toBV_add] -- TODO: why does this just not rewrite?
    simp
    have hwgood := IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (pcard := pcard) v
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    by_cases hi : i < v.toNat wenv
    · simp [hi]
      rw [BitStream.EqualUpTo_ofBitVecZext_add]
      · rfl
      · exact hi
    · simp [hi]
      apply BitVec.getLsbD_of_ge
      omega
  case zext w' a wnew ha  =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    let hwnew := IsGoodNatFSM_mkWidthFSM tcard (pcard := pcard) wnew
    rw [fsmZext_eval_eq (htenv := htenv) (wnew := wnew) (ht := ha) (hwnew := hwnew)]
    simp
    ext i
    simp
  case sext wold a wnew ha =>
    constructor
    intros wenv tenv fsmEnv htenv
    let hwold := IsGoodNatFSM_mkWidthFSM tcard (pcard := pcard) wold
    let hwnew := IsGoodNatFSM_mkWidthFSM tcard (pcard := pcard) wnew
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
    let hw := IsGoodNatFSM_mkWidthFSM tcard (pcard := pcard) w
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv)]
    ext i
    simp [Term.toBV]
    rw [hw.heq (henv := htenv.toHWidthEnv)]

def fsmTermEq {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  -- (ha : IsGoodTermFSM afsm)
  -- (hb : IsGoodTermFSM bfsm)
  : FSM (StateSpace wcard tcard pcard) :=
    composeUnaryAux FSM.scanAnd
    (composeBinaryAux' FSM.nxor afsm.toFsmZext  bfsm.toFsmZext)

/--
FSM for not equals. Two terms are not equal if they fail to match
at any index.
-/
def fsmTermNe {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  : FSM (StateSpace wcard tcard pcard) :=
    composeUnaryAux FSM.scanOr
    (composeBinaryAux' FSM.xor afsm.toFsmZext  bfsm.toFsmZext)




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
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  : FSM (StateSpace wcard tcard pcard) :=
    -- let streamFsm := composeUnaryAux (FSM.ls true) (fsmCarry'' true)
    let streamFsm := (fsmCarry'' true)
    (~~~ (composeBinaryAux' streamFsm  afsm.toFsmZext (~~~ bfsm.toFsmZext)))

/--
info: BitVec.ult_eq_not_carry {w : ℕ} (x y : BitVec w) :
  x.ult y = !BitVec.carry w x (~~~y) true
-/
#guard_msgs (whitespace := lax) in #check BitVec.ult_eq_not_carry


theorem eval_fsmTermUlt_eq_decide_lt {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term tctx w)
    (b : Term tctx w)
    (afsm : TermFSM wcard tcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermUlt
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV tenv).setWidth i) < ((b.toBV tenv).setWidth i)) := by
  have := BitVec.ult_eq_not_carry
    ((a.toBV tenv).setWidth i)
    ((b.toBV tenv).setWidth i)
  simp [← BitVec.ult_iff_lt]
  rw [this]
  clear this
  simp [fsmTermUlt]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.setWidth i (Term.toBV tenv a))
      (y' := ~~~ BitVec.setWidth i (Term.toBV tenv b))]
  · intros j
    simp
    intros hj
    simp [hj]
    rw [hafsm.heq (henv := henv)]
  · intros j
    simp
    intros hj
    simp [hj]
    rw [hbfsm.heq (henv := henv)]

/--
info: 'MultiWidth.eval_fsmTermUlt_eq_decide_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms eval_fsmTermUlt_eq_decide_lt

def fsmTermUle {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  : FSM (StateSpace wcard tcard pcard) :=
    -- let streamFsm := composeUnaryAux (FSM.ls true) (fsmCarry'' true)
    let streamFsm := (fsmCarry'' true)
    ((composeBinaryAux' streamFsm  bfsm.toFsmZext (~~~ afsm.toFsmZext)))

/--
info: BitVec.ult_eq_not_carry {w : ℕ} (x y : BitVec w) :
  x.ult y = !BitVec.carry w x (~~~y) true
-/
#guard_msgs (whitespace := lax) in #check BitVec.ult_eq_not_carry


theorem eval_fsmTermUle_eq_decide_le {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term tctx w)
    (b : Term tctx w)
    (afsm : TermFSM wcard tcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermUle
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV tenv).setWidth i) ≤ ((b.toBV tenv).setWidth i)) := by
  have := BitVec.ule_eq_carry
    ((a.toBV tenv).setWidth i)
    ((b.toBV tenv).setWidth i)
  simp [← BitVec.ule_iff_le]
  rw [this]
  clear this
  simp [fsmTermUle]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.setWidth i (Term.toBV tenv b))
      (y' := ~~~ BitVec.setWidth i (Term.toBV tenv a))]
  · intros j
    simp
    intros hj
    simp [hj]
    rw [hbfsm.heq (henv := henv)]
  · intros j
    simp
    intros hj
    simp [hj]
    rw [hafsm.heq (henv := henv)]

/-- info: BitVec.ule_eq_carry {w : ℕ} (x y : BitVec w) :
    x.ule y = BitVec.carry w y (~~~x) true -/
#guard_msgs (whitespace := lax) in #check BitVec.ule_eq_carry

def fsmMsbEq (a : FSM α) (b : FSM α) : FSM α :=
  composeUnaryAux (FSM.ls false) <|
    composeBinaryAux' FSM.xor a b



def fsmTermSlt
  {wcard tcard : Nat}
  {w : Nondep.WidthExpr}
  {a b : Nondep.Term}
  (wfsm : NatFSM wcard tcard pcard w)
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  : FSM (StateSpace wcard tcard pcard) :=
    let afsm := afsm.toFsmZext
    let bfsm := bfsm.toFsmZext
    let afsm := fsmMsb afsm wfsm.toFsm
    let bfsm := fsmMsb bfsm wfsm.toFsm
    let carryFsm :=
      (~~~ (composeBinaryAux' (fsmCarry'' true)  afsm (~~~ bfsm)))
    let xorFsm := fsmMsbEq afsm bfsm
    let val := xorFsm ^^^ carryFsm
    val
/--
info: BitVec.slt_eq_not_carry {w : ℕ} {x y : BitVec w} :
  x.slt y = (x.msb == y.msb ^^ BitVec.carry w x (~~~y) true)
-/
#guard_msgs (whitespace := lax) in #check BitVec.slt_eq_not_carry

private theorem BitVec.signExtend_sle_signExtend_of_sle {x y : BitVec w}
    {N : Nat} (hN : w ≤ N)
    (h : x.sle y) : (x.signExtend N).sle (y.signExtend N) := by
  rw [BitVec.sle_eq_decide] at ⊢ h
  simp at h ⊢
  simp [BitVec.toInt_signExtend]
  simp [show min N w = w by omega]
  assumption


private theorem BitVec.signExtend_slt_signExtend_of_slt {x y : BitVec w}
    {N : Nat} (hN : w ≤ N)
    (h : x.slt y) : (x.signExtend N).slt (y.signExtend N) := by
  rw [BitVec.slt_eq_decide] at ⊢ h
  simp at h ⊢
  simp [BitVec.toInt_signExtend]
  simp [show min N w = w by omega]
  assumption

theorem eval_fsmTermSlt_eq_decide_slt {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term tctx w)
    (b : Term tctx w)
    (wfsm : NatFSM wcard tcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (afsm : TermFSM wcard tcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermSlt
      wfsm
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV tenv).signExtend i).slt
          ((b.toBV tenv).signExtend i)) := by
  simp [fsmTermSlt]
  have := BitVec.slt_eq_not_carry
    (x := (a.toBV tenv).signExtend i)
    (y := (b.toBV tenv).signExtend i)
  rw [this]
  clear this
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
        (tenv := tenv) (htenv := henv)]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
    (tenv := tenv) (htenv := henv)]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.signExtend i (Term.toBV tenv a))
      (y' := ~~~ BitVec.signExtend i (Term.toBV tenv b))]
  -- simp [fsmMsbEq]
  · rcases i with rfl | i
    · simp
      simp [BitVec.of_length_zero]
      simp [fsmMsbEq]
    · simp [fsmMsbEq]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
            (tenv := tenv) (htenv := henv)]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
        (tenv := tenv) (htenv := henv)]
      simp [BitStream.ofBitVecSext]
      by_cases hi : i < w.toNat wenv
      · simp [BitVec.msb_eq_getLsbD_last, BitVec.getElem_signExtend]
        simp [hi]
        grind [Bool]
      · simp [BitVec.msb_eq_getLsbD_last, BitVec.getElem_signExtend]
        simp [hi]
        grind [Bool]
  · intros j
    intros hj
    simp [hj]
    simp [BitVec.getElem_signExtend]
    simp [BitStream.ofBitVecSext]
    by_cases hw : j < w.toNat wenv
    · simp [hw]
    · simp [hw]
  · intros j
    simp
    intros hj
    simp [hj]
    simp [BitVec.getElem_signExtend]
    simp [BitStream.ofBitVecSext]
    by_cases hw : j < w.toNat wenv
    · simp [hw]
    · simp [hw]

/--
info: BitVec.sle_eq_carry {w : ℕ} {x y : BitVec w} :
    x.sle y = !(x.msb == y.msb ^^ BitVec.carry w y (~~~x) true)
-/
#guard_msgs (whitespace := lax) in #check BitVec.sle_eq_carry

def fsmTermSle
  {wcard tcard : Nat}
  {w : Nondep.WidthExpr}
  {a b : Nondep.Term}
  (wfsm : NatFSM wcard tcard pcard w)
  (afsm : TermFSM wcard tcard pcard a)
  (bfsm : TermFSM wcard tcard pcard b)
  : FSM (StateSpace wcard tcard pcard) :=
    let afsm := afsm.toFsmZext
    let bfsm := bfsm.toFsmZext
    let afsm := fsmMsb afsm wfsm.toFsm
    let bfsm := fsmMsb bfsm wfsm.toFsm
    let carryFsm :=
      ((composeBinaryAux' (fsmCarry'' true)  bfsm (~~~ afsm)))
    let xorFsm := fsmMsbEq afsm bfsm
    ~~~ ((~~~ xorFsm) ^^^ carryFsm)

theorem eval_fsmTermSle_eq_decide_sle {wcard tcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (wfsm : NatFSM wcard tcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (a : Term tctx w)
    (b : Term tctx w)
    (afsm : TermFSM wcard tcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermSle
      wfsm
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV tenv).signExtend i).sle
       ((b.toBV tenv).signExtend i)) := by
  have := BitVec.sle_eq_carry
    (x := (a.toBV tenv).signExtend i)
    (y := (b.toBV tenv).signExtend i)
  rw [this]
  clear this
  simp [fsmTermSle]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
        (tenv := tenv) (htenv := henv)]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
    (tenv := tenv) (htenv := henv)]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.signExtend i (Term.toBV tenv b))
      (y' := ~~~ BitVec.signExtend i (Term.toBV tenv a))]
  simp [fsmMsbEq]
  · rcases i with rfl | i
    · simp
      simp [BitVec.of_length_zero]
    · simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
            (tenv := tenv) (htenv := henv)]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
        (tenv := tenv) (htenv := henv)]
      simp [BitStream.ofBitVecSext]
      by_cases hi : i < w.toNat wenv
      · simp [BitVec.msb_eq_getLsbD_last, BitVec.getElem_signExtend]
        simp [hi]
        grind [Bool]
      · simp [BitVec.msb_eq_getLsbD_last, BitVec.getElem_signExtend]
        simp [hi]
        grind [Bool]
  · intros j
    intros hj
    simp [hj]
    simp [BitVec.getElem_signExtend]
    simp [BitStream.ofBitVecSext]
    by_cases hw : j < w.toNat wenv
    · simp [hw]
    · simp [hw]
  · intros j
    simp
    intros hj
    simp [hj]
    simp [BitVec.getElem_signExtend]
    simp [BitStream.ofBitVecSext]
    by_cases hw : j < w.toNat wenv
    · simp [hw]
    · simp [hw]

/--
info: 'MultiWidth.eval_fsmTermSle_eq_decide_sle' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms eval_fsmTermSle_eq_decide_sle

-- fSM that returns 1 ifthe predicate is true, and 0 otherwise -/
def mkPredicateFSMAux (wcard tcard pcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard pcard p) :=
  match p with
  | .var x => 
    if hx : x < pcard then
      { toFsm := FSM.var' (StateSpace.predVar ⟨x, hx⟩) }
    else 
      { toFsm := FSM.zero' } -- default, should not be used.
  | .binRel .eq w a b =>
    let fsmW := mkWidthFSM wcard tcard pcard w
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    { toFsm := ~~~ fsmW.toFsm ||| fsmTermEq fsmA fsmB }
  | .binRel .ne w a b =>
    let fsmW := mkWidthFSM wcard tcard pcard w
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    { toFsm := fsmW.toFsm ||| fsmTermNe fsmA fsmB }
  | .binRel .ult w a b =>
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    let fsmW := mkWidthFSM wcard tcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermUlt fsmA fsmB)
    }
  | .binRel .ule w a b =>
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    let fsmW := mkWidthFSM wcard tcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermUle fsmA fsmB)
    }
  | .binRel .slt w a b =>
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    let fsmW := mkWidthFSM wcard tcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermSlt fsmW fsmA fsmB)
    }
  | .binRel .sle w a b =>
    let fsmA := mkTermFSM wcard tcard pcard a
    let fsmB := mkTermFSM wcard tcard pcard b
    let fsmW := mkWidthFSM wcard tcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermSle fsmW fsmA fsmB)
    }
  | .or p q  =>
    let fsmP :=  mkPredicateFSMAux wcard tcard pcard p
    let fsmQ :=  mkPredicateFSMAux wcard tcard pcard q
    let fsmP := composeUnaryAux FSM.scanAnd fsmP.toFsm
    let fsmQ := composeUnaryAux FSM.scanAnd fsmQ.toFsm
    { toFsm := (fsmP ||| fsmQ) }
  | .and p q =>
    let fsmP := mkPredicateFSMAux wcard tcard pcard p
    let fsmQ := mkPredicateFSMAux wcard tcard pcard q
    { toFsm := (fsmP.toFsm &&& fsmQ.toFsm) }


theorem foo (f g : α → β) (h : f ≠ g) : ∃ x, f x ≠ g x := by
  exact Function.ne_iff.mp h

/-- if 'x < y', then also 'x.setWidth N < y.setWidthN'. -/
private theorem BitVec.setWidth_lt_setWidth_of_lt {x y : BitVec w}
  {N : Nat} (hN : w ≤ N)
    (h : x < y) : x.setWidth N < y.setWidth N := by
  have hlt := BitVec.lt_def |>.mp h
  rw [BitVec.lt_def]
  simp
  have : 2^w ≤ 2^N := by
    apply Nat.pow_le_pow_right (by omega) (by omega)
  rw [Nat.mod_eq_of_lt (by omega)]
  rw [Nat.mod_eq_of_lt (by omega)]
  assumption

/-- if 'x ≤ y', then also 'x.setWidth N ≤ y.setWidthN'. -/
private theorem BitVec.setWidth_le_setWidth_of_le {x y : BitVec w}
  {N : Nat} (hN : w ≤ N)
    (h : x ≤ y) : x.setWidth N ≤  y.setWidth N := by
  have hlt := BitVec.le_def |>.mp h
  rw [BitVec.le_def]
  simp
  have : 2^w ≤ 2^N := by
    apply Nat.pow_le_pow_right (by omega) (by omega)
  rw [Nat.mod_eq_of_lt (by omega)]
  rw [Nat.mod_eq_of_lt (by omega)]
  assumption

def isGoodPredicateFSM_mkPredicateFSMAux {wcard tcard pcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx pcard) :
    HPredFSMToBitStream (mkPredicateFSMAux wcard tcard pcard (.ofDep p)) := by
  induction p
  case binRel rel w a b =>
    rcases rel
    case eq =>
      -- | TODO: extract proof.
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      -- fsmTermEqProof starts here.
      simp [fsmTermEq]
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard pcard b
      have hw := IsGoodNatFSM_mkWidthFSM tcard w
      rw [ha.heq (henv := henv)]
      rw [hb.heq (henv := henv)]
      rw [hw.heq (henv := henv.toHWidthEnv)]
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
        have := congrFun h i
        simp at this
        rw [BitStream.scanAnd_eq_decide] at this
        simp [show ¬ w.toNat wenv ≤ i by omega] at this
        rw [this]
        omega
    case ne =>
      -- | TODO: extract proof.
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      -- fsmTermEqProof starts here.
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard b
      have hw := IsGoodNatFSM_mkWidthFSM tcard w
      simp [fsmTermNe]
      rw [ha.heq (henv := henv)]
      rw [hb.heq (henv := henv)]
      rw [hw.heq (henv := henv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp
        by_cases hw : N < w.toNat wenv
        · simp [hw]
        · simp [hw]
          rw [BitStream.scanOr_eq_decide]
          simp
          by_contra hcontra
          apply h
          simp at hcontra
          apply BitVec.eq_of_getLsbD_eq
          intros i hi
          apply hcontra
          omega
      · intros h
        have := congrFun h
        simp at this
        simp [BitStream.scanOr_eq_decide] at this
        specialize this (w.toNat wenv)
        simp at this
        by_contra hcontra
        rw [hcontra] at this
        obtain ⟨i, h, heq⟩ := this
        contradiction
    case ult =>
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hw := IsGoodNatFSM_mkWidthFSM tcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard b
      rw [hw.heq (henv := henv.toHWidthEnv)]
      -- rw [ha.heq (henv := henv)]
      -- rw [hb.heq (henv := henv)]
      simp [Predicate.toProp]
      constructor
      -- I understand the problem:
      -- I need to build an automata that checks that you are ult
      -- at *that particular width*.
      -- so the way to do this is to create a latch,
      -- that allows the 'ult' circuit to propagate until
      -- we hit that index, and from that index onwards,
      -- we 'hold' our value.
      -- This way, if 'a < b', then we print 111...(until w)<isLt><isLt><isLt>...
      -- jesus this stuff is crazy crazy annoying.
      · intros h
        simp at h
        ext N
        simp
        by_cases hw : N < w.toNat wenv
        · simp [hw]
        · simp [hw]
          rw [eval_fsmTermUlt_eq_decide_lt
              (hafsm := ha)
              (hbfsm := hb)
              (a := a)
              (b := b)
              (tenv := tenv)
              (henv := henv)
          ]
          simp only [decide_eq_true_eq]
          apply BitVec.setWidth_lt_setWidth_of_lt
          · omega
          · rw [← BitVec.ult_iff_lt]; exact h
      · intros h
        obtain h := congrFun h (w.toNat wenv)
        simp at h
        rw [eval_fsmTermUlt_eq_decide_lt
            (hafsm := ha)
            (hbfsm := hb)
            (a := a)
            (b := b)
            (tenv := tenv)
            (henv := henv)
        ] at h
        simp at h
        rw [← BitVec.ult_iff_lt] at h
        exact h
    case ule =>
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hw := IsGoodNatFSM_mkWidthFSM tcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard b
      rw [hw.heq (henv := henv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp
        by_cases hw : N < w.toNat wenv
        · simp [hw]
        · simp [hw]
          rw [eval_fsmTermUle_eq_decide_le
              (hafsm := ha)
              (hbfsm := hb)
              (a := a)
              (b := b)
              (tenv := tenv)
              (henv := henv)
          ]
          simp only [decide_eq_true_eq]
          apply BitVec.setWidth_le_setWidth_of_le
          · omega
          · rw [← BitVec.ule_iff_le]; exact h
      · intros h
        obtain h := congrFun h (w.toNat wenv)
        simp at h
        rw [eval_fsmTermUle_eq_decide_le
            (hafsm := ha)
            (hbfsm := hb)
            (a := a)
            (b := b)
            (tenv := tenv)
            (henv := henv)
        ] at h
        simp at h
        rw [← BitVec.ule_iff_le] at h
        exact h
    case slt =>
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hwfsm := IsGoodNatFSM_mkWidthFSM tcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard pcard b
      rw [hwfsm.heq (henv := henv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp
        by_cases hw : N < w.toNat wenv
        · simp [hw]
        · simp [hw]
          rw [eval_fsmTermSlt_eq_decide_slt
              (hafsm := ha)
              (hbfsm := hb)
              (a := a)
              (b := b)
              (w := w)
              (hwfsm := hwfsm)
              (tenv := tenv)
              (henv := henv)
          ]
          simp only [decide_eq_true_eq]
          apply BitVec.signExtend_slt_signExtend_of_slt
          · omega
          · exact h
      · intros h
        obtain h := congrFun h (w.toNat wenv)
        simp at h
        rw [eval_fsmTermSlt_eq_decide_slt
            (hafsm := ha)
            (hbfsm := hb)
            (hwfsm := hwfsm)
            (a := a)
            (b := b)
            (tenv := tenv)
            (henv := henv)
        ] at h
        simp at h
        exact h
    case sle =>
      constructor
      intros wenv tenv fsmEnv henv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hwfsm := IsGoodNatFSM_mkWidthFSM tcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard pcard b
      rw [hwfsm.heq (henv := henv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros h
        simp at h
        ext N
        simp
        by_cases hw : N < w.toNat wenv
        · simp [hw]
        · simp [hw]
          rw [eval_fsmTermSle_eq_decide_sle
              (hafsm := ha)
              (hbfsm := hb)
              (a := a)
              (b := b)
              (w := w)
              (hwfsm := hwfsm)
              (tenv := tenv)
              (henv := henv)
          ]
          simp only [decide_eq_true_eq]
          apply BitVec.signExtend_sle_signExtend_of_sle
          · omega
          · exact h
      · intros h
        obtain h := congrFun h (w.toNat wenv)
        simp at h
        rw [eval_fsmTermSle_eq_decide_sle
            (hafsm := ha)
            (hbfsm := hb)
            (hwfsm := hwfsm)
            (a := a)
            (b := b)
            (tenv := tenv)
            (henv := henv)
        ] at h
        simp at h
        exact h
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
def mkPredicateFSMNondep (wcard tcard pcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard pcard p) :=
    let fsm := mkPredicateFSMAux wcard tcard pcard p
    { toFsm := ~~~ fsm.toFsm }

def mkPredicateFSMDep {wcard tcard : Nat} {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx pcard) : PredicateFSM wcard tcard pcard (.ofDep p) :=
  mkPredicateFSMNondep wcard tcard pcard (.ofDep p)

section BitStream2BV

variable
  {tctx : Term.Ctx wcard tcard}
  (p : Predicate tctx pcard)

end BitStream2BV

-- | TODO: rename these namespaces.
open ReflectVerif BvDecide Std Tactic BVDecide Frontend in
/-- If the FSM passes the safety and induction certificates,
then the predicate is satisfied.
-/
theorem Predicate.toProp_of_KInductionCircuits
    {wcard tcard pcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    (p : MultiWidth.Predicate tctx pcard)
    (pNondep : Nondep.Predicate)
    (_hpNondep : pNondep = (.ofDep p))
    (fsm : PredicateFSM wcard tcard pcard pNondep)
    (_hfsm : fsm = mkPredicateFSMNondep wcard tcard pcard pNondep)
    (n : Nat)
    (circs : KInductionCircuits fsm.toFsm n)
    (hCircs : circs.IsLawful)
    (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
    (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
    (wenv : WidthExpr.Env wcard)
    (tenv : tctx.Env wenv) :
    p.toProp tenv penv := by
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

open ReflectVerif BvDecide Std Tactic BVDecide Frontend in
theorem Predicate.toProp_of_KInductionCircuits' 
    {wcard tcard pcard : Nat}
    (P : Prop)
    (tctx : Term.Ctx wcard tcard)
    (p : MultiWidth.Predicate tctx pcard)
    (pNondep : Nondep.Predicate)
    (_hpNondep : pNondep = (.ofDep p))
    (fsm : PredicateFSM wcard tcard pcard pNondep)
    (_hfsm : fsm = mkPredicateFSMNondep wcard tcard pcard pNondep)
    (n : Nat)
    (circs : KInductionCircuits fsm.toFsm n)
    (hCircs : circs.IsLawful)
    (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
    (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
    (wenv : WidthExpr.Env wcard)
    (tenv : tctx.Env wenv)
    (hp : p.toProp tenv = P) :
    P := by
  rw [← hp]
  apply Predicate.toProp_of_KInductionCircuits <;> assumption

end MultiWidth
