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
def mkWidthFSM (wcard : Nat) (tcard : Nat) (bcard : Nat) (pcard : Nat) (w : Nondep.WidthExpr) :
    (NatFSM wcard tcard bcard pcard w) :=
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
        (mkWidthFSM wcard tcard bcard pcard v).toFsm &&& (mkWidthFSM wcard tcard bcard pcard w).toFsm
      }
  | .max v w =>
        { toFsm :=
        (mkWidthFSM wcard tcard bcard pcard v).toFsm ||| (mkWidthFSM wcard tcard bcard pcard w).toFsm
      }
  | .addK v k =>
    { toFsm :=
        composeUnaryAux (FSM.repeatN true k)  (mkWidthFSM wcard tcard bcard pcard v).toFsm
    }

def IsGoodNatFSM_mkWidthFSM {wcard : Nat} (tcard : Nat) (bcard : Nat) (pcard : Nat)  (w : WidthExpr wcard) :
    HNatFSMToBitstream (mkWidthFSM wcard tcard bcard pcard (.ofDep w)) where
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
theorem eval_fsmMsb_eq {wcard bcard tcard : Nat}
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
    {tctx : Term.Ctx wcard tcard}
    {benv : Term.BoolEnv bcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (w : WidthExpr wcard)
    (x : Term bcard tctx (.bv w))
    (xfsm : TermFSM wcard tcard bcard pcard (.ofDep x))
    (hxfsm : HTermFSMToBitStream xfsm)
    (wfsm : NatFSM wcard tcard bcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmMsb xfsm.toFsmZext wfsm.toFsm).eval fsmEnv = (fun i =>
      BitStream.ofBitVecZext (x.toBV benv tenv) (min i (w.toNat wenv - 1))) := by
  simp [fsmMsb]
  have wfsmEval := hwfsm.heq (henv := htenv.toHWidthEnv)
  have tfsmEval := hxfsm.heq (henv := htenv) (benv := benv)
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
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
    {tctx : Term.Ctx wcard tcard}
    {benv : Term.BoolEnv bcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (w : WidthExpr wcard)
    (x : Term bcard tctx (.bv w))
    (xfsm : TermFSM wcard tcard bcard pcard (.ofDep x))
    (hxfsm : HTermFSMToBitStream xfsm)
    (wfsm : NatFSM wcard tcard bcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmMsb xfsm.toFsmZext wfsm.toFsm).eval fsmEnv =
      BitStream.ofBitVecSext (x.toBV benv tenv) := by
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
  (a : NatFSM wcard tcard bcard pcard (.ofDep v))
  (b : NatFSM wcard tcard bcard pcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
  (a : NatFSM wcard tcard bcard pcard (.ofDep v))
  (b : NatFSM wcard tcard bcard pcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
  (a : NatFSM wcard tcard bcard pcard (.ofDep v))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
def NatFSM.fsmUnaryIndexUle (a : NatFSM wcard tcard bcard pcard v) :
    FSM (StateSpace wcard tcard bcard pcard) :=
  composeUnaryAux (FSM.ls true) a.toFsm

@[simp]
theorem HNatFSMToBitstream.fsmIndexUle_eval_eq
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
def fsmUnaryUle (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard bcard pcard) :=
 composeUnaryAux FSM.scanAnd (b.fsmUnaryIndexUle ||| ~~~ a.fsmUnaryIndexUle)

theorem eval_fsmUnaryUle_eq_decide
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
def fsmEqUnaryUpto (a : NatFSM wcard tcard bcard pcard (.ofDep v))
  (b : NatFSM wcard tcard bcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard bcard pcard) :=
  composeUnaryAux FSM.scanAnd (composeBinaryAux' FSM.nxor
    a.fsmUnaryIndexUle
    b.fsmUnaryIndexUle)


@[simp]
theorem eval_FsmEqUpto_eq_decide
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : HNatFSMToBitstream a) (hb : HNatFSMToBitstream b) :
    ((fsmEqUnaryUpto a b).eval fsmEnv) = fun i =>
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  ext i
  rw [eval_FsmEqUpto_eq_decide (henv := henv) (ha := ha) (hb := hb)]

/-- returns 1 if a is not equal to b. -/
def fsmUnaryNeqUpto (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard bcard pcard) :=
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
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w)) : FSM (StateSpace wcard tcard bcard pcard) :=
  composeBinaryAux' FSM.and (fsmUnaryUle a b) (fsmUnaryNeqUpto a b)

theorem eval_fsmUltUnary_eq_decide
    (a : NatFSM wcard tcard bcard pcard (.ofDep v))
    (b : NatFSM wcard tcard bcard pcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
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


def fsmZext (nFsm wnewfsm : FSM (StateSpace wcard tcard bcard pcard))
    : FSM (StateSpace wcard tcard bcard pcard) :=
  (nFsm) &&& (wnewfsm)


/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmZext_eval_eq
    (wnewFsm : NatFSM wcard tcard bcard pcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    (benv : Term.BoolEnv bcard)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term bcard tctx (.bv w))
    (tFsm : TermFSM wcard tcard bcard pcard (.ofDep t))
    (ht : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmZext tFsm.toFsmZext wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZext ((Term.zext t wnew).toBV benv tenv))) i := by
  ext i
  rw [fsmZext]
  simp only [FSM.eval_and', BitStream.and_eq]
  simp
  rw [ht.heq (henv := htenv) (benv := benv)]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]
  -- rw [hwnew.fsmIndexUle_eval_eq (henv := htenv.toHWidthEnv)]
  simp
  by_cases hi : i < wnew.toNat wenv <;> simp [hi]

/-- the fsmZext builds the correct zero-extended FSM. -/
theorem fsmSext_eval_eq
    (woldFsm : NatFSM wcard tcard bcard pcard (.ofDep wold))
    (wnewFsm : NatFSM wcard tcard bcard pcard (.ofDep wnew))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard bcard pcard → BitStream}
    (hwnew : HNatFSMToBitstream wnewFsm)
    (hwold : HNatFSMToBitstream woldFsm)
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term bcard tctx (.bv wold))
    (tFsm : TermFSM wcard tcard bcard pcard (.ofDep t))
    (htfsm : HTermFSMToBitStream tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmSext tFsm.toFsmZext woldFsm.toFsm  wnewFsm.toFsm).eval fsmEnv = fun i =>
      ((BitStream.ofBitVecZext ((Term.sext t wnew).toBV benv tenv))) i := by
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

def mkTermFSM (wcard tcard bcard pcard : Nat) (t : Nondep.Term) :
    (TermFSM wcard tcard bcard pcard t) :=
  match t with
  | .ofNat w n =>
    let fsmW  := (mkWidthFSM wcard tcard bcard pcard w)
    let fsmN : FSM (StateSpace wcard tcard bcard pcard) := (FSM.ofNat n).map Fin.elim0
    {
      toFsmZext := fsmW.toFsm &&& fsmN,
      width := fsmW
    }
  | .var v w =>
    let wfsm := mkWidthFSM wcard tcard bcard pcard w
    if h : v < tcard then
      let varFsm : FSM (StateSpace wcard tcard bcard pcard) :=
       (FSM.var' (StateSpace.termVar ⟨v, h⟩))
      {
        toFsmZext := varFsm &&& wfsm.toFsm,
        width := wfsm
      }
    else
      -- default, should not be ued.
      { toFsmZext := FSM.zero.map Fin.elim0, width := mkWidthFSM wcard tcard bcard pcard w }
  | .add w a b =>
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    { toFsmZext :=
      composeBinaryAux' FSM.and
        fsmW.toFsm
        (composeBinaryAux' FSM.add fsmA.toFsmZext fsmB.toFsmZext),
      width := fsmW
    }
  | .zext a wnew =>
      -- let wold := a.width
      let afsm := mkTermFSM wcard tcard bcard pcard a
      -- let woldFsm := mkWidthFSM wcard tcard wold
      let wnewFsm := mkWidthFSM wcard tcard bcard pcard wnew
      { toFsmZext := fsmZext afsm.toFsmZext wnewFsm.toFsm, width := wnewFsm }
  | .sext a v =>
    let wold := a.width
    let afsm := mkTermFSM wcard tcard bcard pcard a
    let woldFsm := mkWidthFSM wcard tcard bcard pcard wold
    let vFsm := mkWidthFSM wcard tcard bcard pcard v
    { toFsmZext := fsmSext afsm.toFsmZext woldFsm.toFsm vFsm.toFsm, width := vFsm }
  | .band w a b =>
      let aFsm := mkTermFSM wcard tcard bcard pcard a
      let bFsm := mkTermFSM wcard tcard bcard pcard b
      {
        toFsmZext :=
            (composeBinaryAux' FSM.and aFsm.toFsmZext bFsm.toFsmZext),
        width := mkWidthFSM wcard tcard bcard pcard w

      }
  | .bor w a b =>
    let aFsm := mkTermFSM wcard tcard bcard pcard a
    let bFsm := mkTermFSM wcard tcard bcard pcard b
    {   toFsmZext := (composeBinaryAux' FSM.or aFsm.toFsmZext bFsm.toFsmZext) ,
        width := mkWidthFSM wcard tcard bcard pcard w
    }
  | .bxor w a b =>
    let aFsm := mkTermFSM wcard tcard bcard pcard a
    let bFsm := mkTermFSM wcard tcard bcard pcard b
    { toFsmZext := (composeBinaryAux' FSM.xor aFsm.toFsmZext bFsm.toFsmZext),
      width := mkWidthFSM wcard tcard bcard pcard w
    }
  | .bnot w a =>
    let aFsm := mkTermFSM wcard tcard bcard pcard a
    let wFsm := mkWidthFSM wcard tcard bcard pcard w
    { toFsmZext :=
          composeBinaryAux' FSM.and wFsm.toFsm
            (composeUnaryAux FSM.not aFsm.toFsmZext),
      width := wFsm
    }
  | .boolVar v =>
    if h : v < bcard then
      let varFsm : FSM (StateSpace wcard tcard bcard pcard) :=
       (FSM.var' (StateSpace.boolVar ⟨v, h⟩))
      {
        toFsmZext := varFsm,
        width := mkWidthFSM wcard tcard bcard pcard (.const 1)
      }
    else
      -- default, should not be used.
      { toFsmZext := FSM.zero.map Fin.elim0, width := mkWidthFSM wcard tcard bcard pcard (.const 1) }

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


def IsGoodTermFSM_mkTermFSM (wcard tcard bcard pcard : Nat) {tctx : Term.Ctx wcard tcard}
    {wold : WidthExpr wcard}
    (t : Term bcard tctx (.bv wold)) :
    (HTermFSMToBitStream (mkTermFSM wcard tcard bcard pcard (.ofDep t))) := by
  cases t
  case ofNat n =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    have hwgood :=
      IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (bcard := bcard) (pcard := pcard) wold
    simp [mkTermFSM, Nondep.Term.ofDep]
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    by_cases hi : i < wold.toNat wenv
    · simp [hi]
      rw [BitVec.getElem_eq_testBit_toNat]
      simp
      omega
    · simp [hi]
      apply BitVec.getLsbD_of_ge
      omega
  case var v =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    have hwgood := IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (bcard := bcard) (pcard := pcard) (tctx v)
    simp [Nondep.Term.ofDep_var, mkTermFSM, htenv_term]
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    intros hi
    have := BitVec.lt_of_getLsbD hi
    omega
  case add p q =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp only [Nondep.Term.ofDep, mkTermFSM, composeBinaryAux'_eval, FSM.eval_add, cond_true,
      cond_false]
    have hp := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard p
    rw [hp.heq (henv := htenv)]
    have hq := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard q
    rw [hq.heq (henv := htenv)]
    rw [Term.toBV_add] -- TODO: why does this just not rewrite?
    simp
    have hwgood :=
      IsGoodNatFSM_mkWidthFSM (wcard := wcard) (tcard := tcard) (bcard := bcard) (pcard := pcard) wold
    rw [hwgood.heq (henv := htenv.toHWidthEnv)]
    ext i
    simp
    by_cases hi : i < wold.toNat wenv
    · simp [hi]
      rw [BitStream.EqualUpTo_ofBitVecZext_add]
      · rfl
      · exact hi
    · simp [hi]
      apply BitVec.getLsbD_of_ge
      omega
  case zext wold' a  =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    let hwold' := IsGoodNatFSM_mkWidthFSM tcard bcard (pcard := pcard) wold'
    let hwold := IsGoodNatFSM_mkWidthFSM tcard bcard (pcard := pcard) wold
    rw [fsmZext_eval_eq (htenv := htenv) (benv := benv) (tenv := tenv)
      (wnew := wold) (ht := ha) (hwnew := hwold)]
    simp
    ext i
    simp
  -- TODO: cleanup this wold/wnew terminology.
  -- The index is the *new* (output) width.
  -- Maybe rename to wout / win.
  case sext wold' a =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    let hwold := IsGoodNatFSM_mkWidthFSM tcard bcard (pcard := pcard) wold
    let hwold' := IsGoodNatFSM_mkWidthFSM tcard bcard (pcard := pcard) wold'
    simp [Nondep.Term.ofDep, mkTermFSM]
    -- | TODO: why does this not unify?
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    rw [MultiWidth.Nondep.Term.width_ofDep_eq_ofDep]
    rw [fsmSext_eval_eq (htenv := htenv) (tenv := tenv) (benv := benv)
      (wold := wold') (wnew := wold) (t := a) (htfsm := ha)
      (hwnew := hwold) (hwold := hwold')]
    simp
  case band a b  =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
    rw [ha.heq (henv := htenv) (benv := benv)]
    rw [hb.heq (henv := htenv) (benv := benv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bor a b =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
    rw [ha.heq (henv := htenv) (benv := benv)]
    rw [hb.heq (henv := htenv) (benv := benv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bxor a b =>
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
    rw [ha.heq (benv := benv) (henv := htenv)]
    rw [hb.heq (benv := benv) (henv := htenv)]
    simp [Term.toBV]
    ext i
    rcases i with rfl | i <;> simp
  case bnot a =>
    let hw := IsGoodNatFSM_mkWidthFSM tcard bcard (pcard := pcard) wold
    have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
    constructor
    intros wenv benv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [ha.heq (henv := htenv) (benv := benv)]
    ext i
    simp [Term.toBV]
    rw [hw.heq (henv := htenv.toHWidthEnv)]


/--
info: 'MultiWidth.IsGoodTermFSM_mkTermFSM' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms IsGoodTermFSM_mkTermFSM

def fsmTermEq {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  -- (ha : IsGoodTermFSM afsm)
  -- (hb : IsGoodTermFSM bfsm)
  : FSM (StateSpace wcard tcard bcard pcard) :=
    composeUnaryAux FSM.scanAnd
    (composeBinaryAux' FSM.nxor afsm.toFsmZext  bfsm.toFsmZext)

/--
FSM for not equals. Two terms are not equal if they fail to match
at any index.
-/
def fsmTermNe {wcard tcard : Nat}
  {a b : Nondep.Term}
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  : FSM (StateSpace wcard tcard bcard pcard) :=
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
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  : FSM (StateSpace wcard tcard bcard pcard) :=
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
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term bcard tctx (.bv w))
    (b : Term bcard tctx (.bv w))
    (afsm : TermFSM wcard tcard bcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard bcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermUlt
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV benv tenv).setWidth i) < ((b.toBV benv tenv).setWidth i)) := by
  have := BitVec.ult_eq_not_carry
    ((a.toBV benv tenv).setWidth i)
    ((b.toBV benv tenv).setWidth i)
  simp [← BitVec.ult_iff_lt]
  rw [this]
  clear this
  simp [fsmTermUlt]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.setWidth i (Term.toBV benv tenv a))
      (y' := ~~~ BitVec.setWidth i (Term.toBV benv tenv b))]
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
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  : FSM (StateSpace wcard tcard bcard pcard) :=
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
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term bcard tctx (.bv w))
    (b : Term bcard tctx (.bv w))
    (afsm : TermFSM wcard tcard bcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard bcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermUle
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV benv tenv).setWidth i) ≤ ((b.toBV benv tenv).setWidth i)) := by
  have := BitVec.ule_eq_carry
    ((a.toBV benv tenv).setWidth i)
    ((b.toBV benv tenv).setWidth i)
  simp [← BitVec.ule_iff_le]
  rw [this]
  clear this
  simp [fsmTermUle]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.setWidth i (Term.toBV benv tenv b))
      (y' := ~~~ BitVec.setWidth i (Term.toBV benv tenv a))]
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
  (wfsm : NatFSM wcard tcard bcard pcard w)
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  : FSM (StateSpace wcard tcard bcard pcard) :=
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
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (w : WidthExpr wcard)
    (a : Term bcard tctx (.bv w))
    (b : Term bcard tctx (.bv w))
    (wfsm : NatFSM wcard tcard bcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (afsm : TermFSM wcard tcard bcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard bcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermSlt
      wfsm
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV benv tenv).signExtend i).slt
          ((b.toBV benv tenv).signExtend i)) := by
  simp [fsmTermSlt]
  have := BitVec.slt_eq_not_carry
    (x := (a.toBV benv tenv).signExtend i)
    (y := (b.toBV benv tenv).signExtend i)
  rw [this]
  clear this
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext
        (hxfsm := hafsm) (hwfsm := hwfsm)
        (benv := benv)
        (tenv := tenv) (htenv := henv)]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
    (benv := benv)
    (tenv := tenv) (htenv := henv)]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.signExtend i (Term.toBV benv tenv a))
      (y' := ~~~ BitVec.signExtend i (Term.toBV benv tenv b))]
  -- simp [fsmMsbEq]
  · rcases i with rfl | i
    · simp
      simp [BitVec.of_length_zero]
      simp [fsmMsbEq]
    · simp [fsmMsbEq]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext
            (hxfsm := hafsm) (hwfsm := hwfsm)
            (benv := benv)
            (tenv := tenv) (htenv := henv)]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
        (benv := benv)
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
  (wfsm : NatFSM wcard tcard bcard pcard w)
  (afsm : TermFSM wcard tcard bcard pcard a)
  (bfsm : TermFSM wcard tcard bcard pcard b)
  : FSM (StateSpace wcard tcard bcard pcard) :=
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
    (wfsm : NatFSM wcard tcard bcard pcard (.ofDep w))
    (hwfsm : HNatFSMToBitstream wfsm)
    (a : Term bcard tctx (.bv w))
    (b : Term bcard tctx (.bv w))
    (afsm : TermFSM wcard tcard bcard pcard (.ofDep a))
    (hafsm : HTermFSMToBitStream afsm)
    (bfsm : TermFSM wcard tcard bcard pcard (.ofDep b))
    (hbfsm : HTermFSMToBitStream bfsm)
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (henv : HTermEnv fsmEnv tenv)
    :
    ((fsmTermSle
      wfsm
      afsm
      bfsm)).eval fsmEnv i =
       decide (((a.toBV benv tenv).signExtend i).sle
       ((b.toBV benv tenv).signExtend i)) := by
  have := BitVec.sle_eq_carry
    (x := (a.toBV benv tenv).signExtend i)
    (y := (b.toBV benv tenv).signExtend i)
  rw [this]
  clear this
  simp [fsmTermSle]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
        (benv := benv) (tenv := tenv) (htenv := henv)]
  simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
    (benv := benv) (tenv := tenv) (htenv := henv)]
  rw [BitStream.carry'_eq_carry
      (x' := BitVec.signExtend i (Term.toBV benv tenv b))
      (y' := ~~~ BitVec.signExtend i (Term.toBV benv tenv a))]
  simp [fsmMsbEq]
  · rcases i with rfl | i
    · simp
      simp [BitVec.of_length_zero]
    · simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hafsm) (hwfsm := hwfsm)
            (benv := benv) (tenv := tenv) (htenv := henv)]
      simp [eval_fsmMsb_eq_BitStream_ofBitVecSext (hxfsm := hbfsm) (hwfsm := hwfsm)
        (benv := benv) (tenv := tenv) (htenv := henv)]
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


def fsmWidthEq (a b : FSM α) : FSM α :=
  composeUnaryAux FSM.scanAnd (composeBinaryAux' FSM.nxor a b)

-- a ≤ b ↔ b[0] => a[0]
-- a ≤ b ↔ ! b[0] || a[0]
def fsmWidthUle (a b : FSM α) : FSM α :=
  composeUnaryAux FSM.scanAnd (b ||| ~~~ a)

def fsmWidthNe (a b : FSM α) : FSM α :=
  composeUnaryAux FSM.scanOr (composeBinaryAux' FSM.xor a b)
/--
info: 'MultiWidth.eval_fsmTermSle_eq_decide_sle' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms eval_fsmTermSle_eq_decide_sle

-- fSM that returns 1 ifthe predicate is true, and 0 otherwise -/
def mkPredicateFSMAux (wcard tcard bcard pcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard bcard pcard p) :=
  match p with
  | .var x =>
    if hx : x < pcard then
      { toFsm := FSM.var' (StateSpace.predVar ⟨x, hx⟩) }
    else
      { toFsm := FSM.zero' } -- default, should not be used.
  | .binWidthRel .eq a b =>
    let fsmA := mkWidthFSM wcard tcard bcard pcard a
    let fsmB := mkWidthFSM wcard tcard bcard pcard b
    { toFsm := fsmWidthEq fsmA.toFsm fsmB.toFsm }
  | .binWidthRel .le a b =>
    let fsmA := mkWidthFSM wcard tcard bcard pcard a
    let fsmB := mkWidthFSM wcard tcard bcard pcard b
    { toFsm := fsmWidthUle fsmA.toFsm fsmB.toFsm }
  | .binRel .eq w a b =>
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    { toFsm := ~~~ fsmW.toFsm ||| fsmTermEq fsmA fsmB }
  | .binRel .ne w a b =>
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    { toFsm := fsmW.toFsm ||| fsmTermNe fsmA fsmB }
  | .binRel .ult w a b =>
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermUlt fsmA fsmB)
    }
  | .binRel .ule w a b =>
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermUle fsmA fsmB)
    }
  | .binRel .slt w a b =>
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermSlt fsmW fsmA fsmB)
    }
  | .binRel .sle w a b =>
    let fsmA := mkTermFSM wcard tcard bcard pcard a
    let fsmB := mkTermFSM wcard tcard bcard pcard b
    let fsmW := mkWidthFSM wcard tcard bcard pcard w
    { toFsm :=
      -- upto 'w', don't make a decision, then
      -- spit out what fsmTermUlt believes.
      -- TODO: try to replace with a 'latchImmediate',
      -- since that should be a much more long-term solution.
      fsmW.toFsm ||| (fsmTermSle fsmW fsmA fsmB)
    }
  | .or p q  =>
    let fsmP :=  mkPredicateFSMAux wcard tcard bcard pcard p
    let fsmQ :=  mkPredicateFSMAux wcard tcard bcard pcard q
    let fsmP := composeUnaryAux FSM.scanAnd fsmP.toFsm
    let fsmQ := composeUnaryAux FSM.scanAnd fsmQ.toFsm
    { toFsm := (fsmP ||| fsmQ) }
  | .and p q =>
    let fsmP := mkPredicateFSMAux wcard tcard bcard pcard p
    let fsmQ := mkPredicateFSMAux wcard tcard bcard pcard q
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

private theorem eq_of_lt_iff_lt_of_le  (h : ∀ (a i : ℕ), i ≤ a → (i < v' ↔ i < w')) :
    v' = w' := by
  specialize h (max v' w') (min v' w')
  simp at h
  omega


def isGoodPredicateFSM_mkPredicateFSMAux {wcard tcard bcard pcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate bcard tctx pcard) :
    HPredFSMToBitStream (mkPredicateFSMAux wcard tcard bcard pcard (.ofDep p)) := by
  induction p
  case var v =>
    constructor
    intros wenv benv tenv penv fsmEnv htenv hpenv
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep, Predicate.toProp]
    obtain ⟨hpenv⟩ := hpenv
    simp [hpenv v]
  case binWidthRel rel v w =>
    cases rel
    case eq =>
      -- | TODO: refactor into separate toplevel lemma
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      simp [fsmWidthEq]
      have hv := IsGoodNatFSM_mkWidthFSM tcard bcard pcard v
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      rw [hw.heq (henv := htenv.toHWidthEnv)]
      rw [hv.heq (henv := htenv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros heq
        ext i
        rw [BitStream.scanAnd_eq_decide]
        simp
        intros j hj
        rw [heq]
      · intros heq
        have hv := IsGoodNatFSM_mkWidthFSM tcard bcard pcard v
        have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
        have := congrFun heq
        simp [BitStream.scanAnd_eq_decide] at this
        specialize this (max (v.toNat wenv) (w.toNat wenv)) (min (v.toNat wenv) (w.toNat wenv))
        simp at this
        omega
    case le =>
      -- | TODO: refactor into separate toplevel lemma
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      simp [fsmWidthUle]
      have hv := IsGoodNatFSM_mkWidthFSM tcard bcard pcard v
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      rw [hw.heq (henv := htenv.toHWidthEnv)]
      rw [hv.heq (henv := htenv.toHWidthEnv)]
      simp [Predicate.toProp]
      constructor
      · intros heq
        ext i
        rw [BitStream.scanAnd_eq_decide]
        simp
        intros j hj
        omega
      · intros heq
        have hv := IsGoodNatFSM_mkWidthFSM tcard bcard pcard v
        have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
        have := congrFun heq
        simp [BitStream.scanAnd_eq_decide] at this
        specialize this (max (v.toNat wenv) (w.toNat wenv)) (min (v.toNat wenv) (w.toNat wenv))
        simp at this
        omega
  case binRel rel w a b =>
    rcases rel
    case eq =>
      -- | TODO: refactor into separate toplevel lemma
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      -- fsmTermEqProof starts here.
      simp [fsmTermEq]
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      rw [ha.heq (henv := htenv) (benv := benv)]
      rw [hb.heq (henv := htenv) (benv := benv)]
      rw [hw.heq (henv := htenv.toHWidthEnv)]
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
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      -- fsmTermEqProof starts here.
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      simp [fsmTermNe]
      rw [ha.heq (henv := htenv) (benv := benv)]
      rw [hb.heq (henv := htenv) (benv := benv)]
      rw [hw.heq (henv := htenv.toHWidthEnv)]
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
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      rw [hw.heq (henv := htenv.toHWidthEnv)]
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
              (henv := htenv)
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
            (henv := htenv)
        ] at h
        simp at h
        rw [← BitVec.ult_iff_lt] at h
        exact h
    case ule =>
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hw := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      rw [hw.heq (henv := htenv.toHWidthEnv)]
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
              (henv := htenv)
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
            (henv := htenv)
        ] at h
        simp at h
        rw [← BitVec.ule_iff_le] at h
        exact h
    case slt =>
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hwfsm := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      rw [hwfsm.heq (henv := htenv.toHWidthEnv)]
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
              (henv := htenv)
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
            (henv := htenv)
        ] at h
        simp at h
        exact h
    case sle =>
      constructor
      intros wenv benv tenv penv fsmEnv htenv hpenv
      simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
      have hwfsm := IsGoodNatFSM_mkWidthFSM tcard bcard pcard w
      have ha := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard a
      have hb := IsGoodTermFSM_mkTermFSM wcard tcard bcard pcard b
      rw [hwfsm.heq (henv := htenv.toHWidthEnv)]
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
              (henv := htenv)
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
            (henv := htenv)
        ] at h
        simp at h
        exact h
  case or p q hp hq =>
    constructor
    intros wenv benv tenv penv fsmEnv htenv hpenv
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    simp [Predicate.toProp]
    rw [hp.heq (htenv := htenv) (hpenv := hpenv)]
    rw [hq.heq (htenv := htenv) (hpenv := hpenv)]
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
    intros wenv benv tenv penv fsmEnv htenv hpenv
    simp [Predicate.toProp]
    rw [hp.heq (htenv := htenv) (hpenv := hpenv)]
    rw [hq.heq (htenv := htenv) (hpenv := hpenv)]
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
def mkPredicateFSMNondep (wcard tcard bcard pcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard bcard pcard p) :=
    let fsm := mkPredicateFSMAux wcard tcard bcard pcard p
    { toFsm := ~~~ fsm.toFsm }

def mkPredicateFSMDep {wcard tcard bcard pcard : Nat} {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate bcard tctx pcard) : PredicateFSM wcard tcard bcard pcard (.ofDep p) :=
  mkPredicateFSMNondep wcard tcard bcard pcard (.ofDep p)

section BitStream2BV

variable
  {bcard : Nat}
  {tctx : Term.Ctx wcard tcard}
  (p : Predicate tbcard ctx pcard)

end BitStream2BV

-- | TODO: rename these namespaces.
open ReflectVerif BvDecide Std Tactic BVDecide Frontend in
/-- If the FSM passes the safety and induction certificates,
then the predicate is satisfied.
-/
theorem Predicate.toProp_of_KInductionCircuits
    {wcard tcard bcard pcard : Nat}
    (tctx : Term.Ctx wcard tcard)
    (p : MultiWidth.Predicate bcard tctx pcard)
    (pNondep : Nondep.Predicate)
    (_hpNondep : pNondep = (.ofDep p))
    (fsm : PredicateFSM wcard tcard bcard pcard pNondep)
    (_hfsm : fsm = mkPredicateFSMNondep wcard tcard bcard pcard pNondep)
    (n : Nat)
    (circs : KInductionCircuits fsm.toFsm n)
    (hCircs : circs.IsLawful)
    (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
    (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
    (wenv : WidthExpr.Env wcard)
    (penv : Predicate.Env pcard)
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    :
    p.toProp benv tenv penv := by
  have hGoodPredicateFSM := isGoodPredicateFSM_mkPredicateFSMAux p
  rw [hGoodPredicateFSM.heq (tenv := tenv)
    (fsmEnv := HTermEnv.mkFsmEnvOfTenv tenv benv penv)]
  · subst _hpNondep _hfsm
    simp [mkPredicateFSMNondep] at circs
    apply ReflectVerif.BvDecide.KInductionCircuits.eval_eq_negOne_of_mkIndHypCycleBreaking_eval_eq_false_of_mkSafetyCircuit_eval_eq_false'
      (circs := circs) (hCircs := hCircs) (envBitstream := (HTermEnv.mkFsmEnvOfTenv tenv benv penv))
      (hSafety := Circuit.eval_eq_false_of_verifyCircuit hs)
      (hIndHyp := Circuit.eval_eq_false_of_verifyCircuit hind)
  · simp
  · simp

/--
info: 'MultiWidth.Predicate.toProp_of_KInductionCircuits'
depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms Predicate.toProp_of_KInductionCircuits

open ReflectVerif BvDecide Std Tactic BVDecide Frontend in
theorem Predicate.toProp_of_KInductionCircuits'
    {wcard tcard bcard pcard : Nat}
    (P : Prop)
    (tctx : Term.Ctx wcard tcard)
    (p : MultiWidth.Predicate bcard tctx pcard)
    (pNondep : Nondep.Predicate)
    (_hpNondep : pNondep = (.ofDep p))
    (fsm : PredicateFSM wcard tcard bcard pcard pNondep)
    (_hfsm : fsm = mkPredicateFSMNondep wcard tcard bcard pcard pNondep)
    (n : Nat)
    (circs : KInductionCircuits fsm.toFsm n)
    (hCircs : circs.IsLawful)
    (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
    (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
    (wenv : WidthExpr.Env wcard)
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (penv : Predicate.Env pcard)
    (hp : p.toProp benv tenv penv = P) :
    P := by
  rw [← hp]
  apply Predicate.toProp_of_KInductionCircuits <;> assumption

/--
info: 'MultiWidth.Predicate.toProp_of_KInductionCircuits''
depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms Predicate.toProp_of_KInductionCircuits'

end MultiWidth
