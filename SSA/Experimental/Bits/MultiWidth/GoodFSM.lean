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

instance : HAnd (FSM arity) (FSM arity) (FSM arity) where
  hAnd := composeBinaryAux' FSM.and

theorem FSM.and_eq (a b : FSM arity) : (a &&& b) = composeBinaryAux' FSM.and a b := rfl

@[simp]
theorem FSM.eval_and (a b : FSM arity) : (a &&& b).eval env = a.eval env &&& b.eval env := by
  rw [FSM.and_eq]
  simp

instance : HOr (FSM arity) (FSM arity) (FSM arity) where
  hOr := composeBinaryAux' FSM.or

theorem FSM.or_eq (a b : FSM arity) : (a ||| b) = composeBinaryAux' FSM.or a b := rfl

@[simp]
theorem FSM.eval_or (a b : FSM arity) : (a ||| b).eval env = a.eval env ||| b.eval env := by
  rw [FSM.or_eq]
  simp

instance : HXor (FSM arity) (FSM arity) (FSM arity) where
  hXor := composeBinaryAux' FSM.xor

theorem FSM.xor_eq (a b : FSM arity) : (a ^^^ b) = composeBinaryAux' FSM.xor a b := rfl

@[simp]
theorem FSM.eval_xor (a b : FSM arity) : (a ^^^ b).eval env = a.eval env ^^^ b.eval env := by
  rw [FSM.xor_eq]
  simp

instance : Complement (FSM arity) where
  complement := composeUnaryAux FSM.not

theorem FSM.not_eq (a : FSM arity) : (~~~ a) = composeUnaryAux FSM.not a := rfl

@[simp]
theorem FSM.eval_not (a : FSM arity) : (~~~ a).eval env = ~~~ (a.eval env) := by
  rw [FSM.not_eq]
  simp


-- build an FSM whose output is unary, and is 1 in the beginning, and becomes 0
-- forever after.
-- TODO: I am pretty sure we can just do this with binary encodings as well?
def mkWidthFSM (wcard : Nat) (tcard : Nat) (w : Nondep.WidthExpr) :
    (NatFSM wcard tcard w) :=
  if h : w.toNat < wcard then
    { toFsm :=
      -- composeUnaryAux FSM.scanAnd (FSM.var' (StateSpace.widthVar ⟨w.toNat, h⟩))
      (FSM.var' (StateSpace.widthVar ⟨w.toNat, h⟩))
    }
  else
    { toFsm := FSM.zero.map Fin.elim0 } -- default, should not be used.


def IsGoodNatFSM_mkWidthFSM {wcard : Nat} (tcard : Nat) {w : WidthExpr wcard} :
    IsGoodNatFSM (mkWidthFSM wcard tcard (.ofDep w)) where
  heq := by
    intros wenv fsmEnv henv
    induction w
    case var v =>
      simp [mkWidthFSM]
      have ⟨henv⟩ := henv
      rw [henv]

/--
An FSM that computes the MSB at the current index.
If the index is smaller than the width, then the MSB is 'false'.
At and after the current width, the MSB is whatever the MSB is supposed to be.
-- Takes an input the bitvector, and the width.
-/
def fsmMsbAux: FSM Bool where
  α := Unit
  initCarry := fun () => false
  outputCirc := Circuit.var (positive := true) (.inl ())
  nextStateCirc := fun () =>
    let s : Circuit (Unit ⊕ Bool) := Circuit.var (positive := true) (.inl ())
    let x : Circuit (Unit ⊕ Bool)  := Circuit.var (positive := true) (.inr false)
    let w : Circuit (Unit ⊕ Bool)  := Circuit.var (positive := true) (.inr true)
    -- as long as the width is not exceeded, store into the width.
    Circuit.ite w -- if w
      x -- then x
      s  -- else s

/-- the MSB finite state machine as a composition of the MSB machine. -/
def fsmMsb (x w : FSM α) : FSM α :=
  composeBinaryAux' fsmMsbAux x w

theorem eval_fsmMsb_eq_decide
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard → BitStream}
  {tctx : Term.Ctx wcard tcard}
  (tenv : Term.Ctx.Env tctx wenv)
  (x : Term tctx w)
  (w : WidthExpr wcard)
  (xfsm : TermFSM wcard tcard (.ofDep x))
  (hxfsm : IsGoodTermFSM xfsm)
  (wfsm : NatFSM wcard tcard (.ofDep w)) :
  (fsmMsb xfsm.toFsm wfsm.toFsm).eval env i =
  ((x.toBV tenv).signExtend (w.toNat wenv)).getLsbD i
   := sorry


def fsmUnaryMax (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.or a b

@[simp]
theorem eval_fsmUnaryMax_eq_decide
  (a : NatFSM wcard tcard (.ofDep v))
  (b : NatFSM wcard tcard (.ofDep w))
  {wenv : WidthExpr.Env wcard}
  {fsmEnv : StateSpace wcard tcard → BitStream}
  (henv : HWidthEnv fsmEnv wenv)
  (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
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
  (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
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
  (ha : IsGoodNatFSM a) :
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
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmUnaryUle a.toFsm b.toFsm).eval fsmEnv) i =
    decide (min i (v.toNat wenv) ≤ min i (w.toNat wenv)) := by
  simp [fsmUnaryUle]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  induction w generalizing v
  case var w =>
    induction v
    case var v =>
      simp [BitStream.scanAnd_eq_decide]
      by_cases hiv : i ≤ wenv v
      case pos =>
        by_cases hiw : i ≤ wenv w
        case pos =>
          simp [hiw]
          intros j
          omega
        case neg =>
          simp [hiw]
          by_cases hvw : wenv v ≤ wenv w
          case pos =>
            simp [hvw]
            intros j
            omega
          case neg =>
            simp [hvw]
            exists i
            omega
      case neg =>
        by_cases hiw : i ≤ wenv w
        case pos =>
          simp [hiw]
          omega
        case neg =>
          simp [hiw]
          by_cases hvw : wenv v ≤ wenv w
          case pos =>
            simp [hvw]
            omega
          case neg =>
            simp [hvw]
            exists (wenv v)
            omega

@[simp]
theorem eval_fsmUnaryUle_eq_lt_or_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
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
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmEqUnaryUpto a.toFsm b.toFsm).eval fsmEnv) i =
    decide (min i (v.toNat wenv) = min i (w.toNat wenv)) := by
  simp [fsmEqUnaryUpto]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  induction w generalizing v
  case var w =>
    induction v
    case var v =>
      simp [BitStream.scanAnd_eq_decide]
      constructor
      · intros hi
        -- | think about what the heck this is saying.
        by_cases hiv : wenv v ≤ i
        · have hiv' := hi (wenv v) hiv
          have := hiv'.mp (by simp)
          simp [hiv]
          by_cases hiw : wenv w ≤ i
          · simp [hiw]
            have hiw' := hi (wenv w) hiw
            have := hiw'.mpr (by simp)
            omega
          · simp [hiw]
            have hiv' := hi i (by simp) |>.mpr (by omega)
            omega
        · simp [hiv]
          apply hi .. |>.mp <;> omega
      · intros hivw j hj
        omega

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
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmUnaryNeqUpto a.toFsm b.toFsm).eval fsmEnv) i =
    (decide (min i (v.toNat wenv) ≠ min i (w.toNat wenv))) := by
  simp [fsmUnaryNeqUpto]
  rw [ha.heq (henv := henv)]
  rw [hb.heq (henv := henv)]
  induction w generalizing v
  case var w =>
    induction v
    case var v =>
      simp [BitStream.scanOr_eq_decide]
      rw [not_decide_eq_decide_lnot]
      rw [decide_eq_eq_decide_iff_decide]
      rw [decide_eq_true_iff]
      constructor
      · intros hi
        obtain ⟨j, hj₁, hj₂⟩ := hi
        by_cases hiv : wenv v < i
        · simp only [not_le, hiv, min_eq_of_not_le]
          omega
        · simp only [not_lt] at hiv
          simp only [hiv, inf_of_le_left, left_eq_inf, not_le]
          omega
      · intros hivw
        simp only [not_iff, not_le]
        by_cases hiv : i < (wenv v)
        · simp only [not_le, hiv, min_eq_of_not_le', left_eq_inf] at hivw ⊢
          exists i
          omega
        · simp only [not_lt] at hiv; simp [hiv] at hivw
          by_cases hiw : i < (wenv w)
          · simp only [not_le, hiw, min_eq_of_not_le'] at hivw
            have hiv' : (wenv v) ≤ i := by omega
            exists i
            omega
          · simp only [not_lt] at hiw; simp [hiw] at hivw
            by_cases hvw : wenv v < wenv w
            · exists (wenv w)
              simp only [le_refl, iff_true]
              omega
            · simp only [not_lt] at hvw
              exists (wenv v)
              omega

def fsmUnaryIncrK
    (k : Nat)
    (a : NatFSM wcard tcard (.ofDep v))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) : FSM  (StateSpace wcard tcard) :=
  match k with
  | 0 => a.toFsm
  | k + 1 => composeUnaryAux (FSM.ls true) (fsmUnaryIncrK k a henv ha)

theorem eval_fsmUnaryIncrK_eq_decide
    (k : Nat)
    (a : NatFSM wcard tcard (.ofDep v))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) :
    ((fsmUnaryIncrK k a henv ha).eval fsmEnv) i =
    decide (i ≤ v.toNat wenv + k) := by
  induction k generalizing i
  case zero =>
    simp [fsmUnaryIncrK]
    rw [ha.heq (henv := henv)]
  case succ k ih =>
    simp [fsmUnaryIncrK]
    simp [BitStream.concat]
    rcases i with rfl | i
    · simp only [BitStream.concat_zero, zero_le, decide_true]
    · simp only [BitStream.concat_succ]
      rw [ih]
      simp
      omega

-- | if 'cond' is true, then return 't', otherwise return 'e'.
def ite (cond : FSM arity) (t : FSM arity) (e : FSM arity) : FSM arity :=
  (cond &&& t) ||| (~~~ cond &&& e)

@[simp]
theorem eval_ite_eq_decide
    (cond t e : FSM arity)
    (env : arity → BitStream) :
    (ite cond t e).eval env i =
    if (cond.eval env i) then t.eval env i else e.eval env i := by
  simp [ite]
  by_cases hcond : cond.eval env i <;> simp [hcond]

def fsmUltUnary (a b : FSM arity) : FSM arity :=
  composeBinaryAux' FSM.and (fsmUnaryUle a b) (fsmUnaryNeqUpto a b)

theorem eval_fsmUltUnary_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
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
    (ha : IsGoodNatFSM a) :
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
    (hwnew : IsGoodNatFSM wnewFsm)
    {tctx : Term.Ctx wcard tcard}
    (tenv : Term.Ctx.Env tctx wenv)
    (t : Term tctx w)
    (tFsm : TermFSM wcard tcard (.ofDep t))
    (ht : IsGoodTermFSM tFsm)
    (htenv : HTermEnv fsmEnv tenv) :
    (fsmZext tFsm.toFsm wnewFsm.toFsm).eval fsmEnv = fun i =>
      (BitStream.zeroExtend (t.toBitstream tenv) (wnew.toNat wenv)) i := by
  ext i
  rw [fsmZext]
  simp
  rw [ht.heq (henv := htenv)]
  rw [hwnew.heq (henv := htenv.toHWidthEnv)]


/-- The inputs given to the sext fsm. -/
inductive fsmSext.inputs
| a
| a0
| wold
| wnew

def fsmSext.inputs.toFin : fsmSext.inputs → Fin 4
| .a => 0
| .a0 => 1
| .wold => 2
| .wnew => 3


def fsmSext (a wold wnew : FSM (StateSpace wcard tcard))
    : FSM (StateSpace wcard tcard) :=
  ite (fsmUnaryUle wnew wold)
    /- wnew ≤ wold, so it's the same as zext. -/
    (fsmZext a wnew)
    /- wnew > wold. -/
  (composeQuaternaryAux'
    (composer.map fsmSext.inputs.toFin)
    a
    (composeUnaryAux (FSM.ls false) a)
    wold
    wnew)
  where
    -- precondition: wnew > wold.
    composer : FSM fsmSext.inputs := {
      α := Unit,
      initCarry := fun () => false,
      outputCirc :=
        .ite (.var true (.inr fsmSext.inputs.wold)) -- i ≤ wold < wnew
          (.var true (.inr fsmSext.inputs.a)) -- return the bit of a.
          -- else: wold < i ≤ wnew
          (.ite (.var true (.inr fsmSext.inputs.wnew))
            (.var true (.inl ())) -- return our state bit.
            -- else: wnew < i.
            .fals
          )
      nextStateCirc :=
        /- while we are i ≤ wold, store the bit from a. -/
        /- otherwise, save the old bit. -/
        fun () =>
          .ite (.var true (.inr fsmSext.inputs.wold))
            (.var true (.inr fsmSext.inputs.a)) -- i ≤ wold
            (.var true (.inl ())) -- i > wold
    }


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

axiom AxSext {P : Prop} : P
axiom AxAdd {P : Prop} : P

def IsGoodTermFSM_mkTermFSM {wcard tcard : Nat} {tctx : Term.Ctx wcard tcard} {w : WidthExpr wcard} (t : Term tctx w)  :
    (IsGoodTermFSM (mkTermFSM wcard tcard (.ofDep t))) := by
  induction t
  case var v =>
    constructor
    intros wenv tenv fsmEnv htenv
    obtain htenv_term := htenv.heq_term
    obtain htenv_width := htenv.heq_width
    simp only [Nondep.Term.ofDep_var, mkTermFSM,
      Fin.is_lt, ↓reduceDIte, Fin.eta, FSM.eval_var', htenv_term]
  case add v p q hp hq =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    exact AxAdd
  case zext w' a wnew ha  =>
    constructor
    intros wenv tenv fsmEnv htenv
    simp [Nondep.Term.ofDep, mkTermFSM]
    rw [fsmZext_eval_eq (htenv := htenv)]
    · apply IsGoodNatFSM_mkWidthFSM (w := wnew) (tcard := tcard)
    · apply ha
  case sext w' a b =>
    exact AxSext

/-- fSM that returns 1 ifthe predicate is true, and 0 otherwise -/
def mkPredicateFSMAux (wcard tcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard p) :=
  match p with
  | .binRel .eq a b =>
    let fsmA := mkTermFSM wcard tcard a
    let fsmB := mkTermFSM wcard tcard b
    { toFsm := fsmEqUnaryUpto fsmA.toFsm fsmB.toFsm }
  | .or p q  =>
    let fsmP :=  mkPredicateFSMAux wcard tcard p
    let fsmQ :=  mkPredicateFSMAux wcard tcard q
    { toFsm := composeUnaryAux FSM.scanAnd (fsmP.toFsm ||| fsmQ.toFsm) }
  | .and p q =>
    let fsmP := mkPredicateFSMAux wcard tcard p
    let fsmQ := mkPredicateFSMAux wcard tcard q
    { toFsm := composeUnaryAux FSM.scanAnd (fsmP.toFsm &&& fsmQ.toFsm) }
  | .not p =>
    let fsmP := mkPredicateFSMAux wcard tcard p
    { toFsm := composeUnaryAux FSM.scanAnd (~~~ fsmP.toFsm) }

def isGoodPredicateFSM_mkPredicateFSMAux {wcard tcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx) :
    IsGoodPredicateFSM p (mkPredicateFSMAux wcard tcard (.ofDep p)) := by
  induction p
  case binRel eq a b =>
    constructor
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    sorry
  case or p q hp hq =>
    constructor
    intros wenv tenv fsmEnv
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    sorry
  case and p q hp hq =>
    constructor
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    sorry
  case not p hp =>
    constructor
    simp [mkPredicateFSMAux, Nondep.Predicate.ofDep]
    sorry


/-- Negate the FSM so we can decide if zeroes. -/
def mkPredicateFSMNondep (wcard tcard : Nat) (p : Nondep.Predicate) :
  (PredicateFSM wcard tcard p) :=
    let fsm := mkPredicateFSMAux wcard tcard p
    { toFsm := ~~~ fsm.toFsm }

def mkPredicateFSMDep {wcard tcard : Nat} {tctx : Term.Ctx wcard tcard}
    (p : MultiWidth.Predicate tctx) : PredicateFSM wcard tcard (.ofDep p) :=
  mkPredicateFSMNondep wcard tcard (.ofDep p)

axiom AxGoodFSM {P : Prop} : P


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
   (_hCircs : circs.IsLawful)
   (sCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
   (_hs : Circuit.verifyCircuit (circs.mkSafetyCircuit) sCert = true)
   (indCert : Lean.Elab.Tactic.BVDecide.Frontend.LratCert)
   (_hind : Circuit.verifyCircuit (circs.mkIndHypCycleBreaking) indCert = true)
   (wenv : WidthExpr.Env wcard)
   (tenv : tctx.Env wenv) :
  p.toProp tenv := by exact AxGoodFSM

end MultiWidth
