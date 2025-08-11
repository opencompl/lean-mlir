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

instance : HAnd (FSM α) (FSM α) (FSM α) where
  hAnd := composeBinaryAux' FSM.and

theorem FSM.and_eq (a b : FSM α) : (a &&& b) = composeBinaryAux' FSM.and a b := rfl

@[simp]
theorem FSM.eval_and (a b : FSM α) : (a &&& b).eval env = a.eval env &&& b.eval env := by
  rw [FSM.and_eq]
  simp

instance : HOr (FSM α) (FSM α) (FSM α) where
  hOr := composeBinaryAux' FSM.or

theorem FSM.or_eq (a b : FSM α) : (a ||| b) = composeBinaryAux' FSM.or a b := rfl

@[simp]
theorem FSM.eval_or (a b : FSM α) : (a ||| b).eval env = a.eval env ||| b.eval env := by
  rw [FSM.or_eq]
  simp

instance : HXor (FSM α) (FSM α) (FSM α) where
  hXor := composeBinaryAux' FSM.xor

theorem FSM.xor_eq (a b : FSM α) : (a ^^^ b) = composeBinaryAux' FSM.xor a b := rfl

@[simp]
theorem FSM.eval_xor (a b : FSM α) : (a ^^^ b).eval env = a.eval env ^^^ b.eval env := by
  rw [FSM.xor_eq]
  simp

instance : Complement (FSM α) where
  complement := composeUnaryAux FSM.not

theorem FSM.not_eq (a : FSM α) : (~~~ a) = composeUnaryAux FSM.not a := rfl

@[simp]
theorem FSM.eval_not (a : FSM α) : (~~~ a).eval env = ~~~ (a.eval env) := by
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

-- when we compute 'a - b', if the borrow bit is zero,
-- then we know that 'a' is greater than or equal to 'b'.
-- if the borrow bit is one, then we know that 'a' is less than 'b'.
-- a ≤ b ↔ b[i] = 0 → a[i] = 0
-- if b = 1, we are done.
-- Otherwise, if b=0,then a=0

-- alternatively, a[i] = 1 → b[i] = 1.
-- if a is high, then b must be high for it to be ≤.
def fsmUleUnary (a : FSM α) (b : FSM α) : FSM α :=
 composeUnaryAux FSM.scanAnd (b ||| ~~~ a)

theorem eval_fsmUleUnary_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmUleUnary a.toFsm b.toFsm).eval fsmEnv) i =
    decide (min i (v.toNat wenv) ≤ min i (w.toNat wenv)) := by
  simp [fsmUleUnary]
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
theorem eval_fsmUleUnary_eq_lt_or_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmUleUnary a.toFsm b.toFsm).eval fsmEnv) i =
    decide (i ≤ min (v.toNat wenv) (w.toNat wenv) ∨ (v.toNat wenv) ≤ (w.toNat wenv)) := by
  rw [eval_fsmUleUnary_eq_decide (wenv := wenv) (henv := henv) (ha := ha) (hb := hb)]
  simp
  by_cases hiv : i ≤ v.toNat wenv
  · simp [hiv]
  · simp [hiv]
    omega
/--
info: 'MultiWidth.eval_fsmUleUnary_eq_decide' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms eval_fsmUleUnary_eq_decide

-- returns 1 if a is equal to b.
def fsmEqUnaryUpto (a : FSM α) (b : FSM α) : FSM α :=
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

/-- returns 1 if a is not equal to b. -/
def fsmNeqUnaryUpto (a b : FSM α) : FSM α :=
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
theorem eval_fsmNeqUnaryUpto_eq_decide
    (a : NatFSM wcard tcard (.ofDep v))
    (b : NatFSM wcard tcard (.ofDep w))
    {wenv : WidthExpr.Env wcard}
    {fsmEnv : StateSpace wcard tcard → BitStream}
    (henv : HWidthEnv fsmEnv wenv)
    (ha : IsGoodNatFSM a) (hb : IsGoodNatFSM b) :
    ((fsmNeqUnaryUpto a.toFsm b.toFsm).eval fsmEnv) i =
    (decide (min i (v.toNat wenv) ≠ min i (w.toNat wenv))) := by
  simp [fsmNeqUnaryUpto]
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

-- | if 'cond' is true, then return 't', otherwise return 'e'.
def ite (cond : FSM α) (t : FSM α) (e : FSM α) : FSM α :=
  (cond &&& t) ||| (~~~ cond &&& e)

@[simp]
theorem eval_ite_eq_decide
    (cond t e : FSM α)
    (env : α → BitStream) :
    (ite cond t e).eval env i =
    if (cond.eval env i) then t.eval env i else e.eval env i := by
  simp [ite]
  by_cases hcond : cond.eval env i <;> simp [hcond]

def fsmUltUnary (a b : FSM α) : FSM α :=
  composeBinaryAux' FSM.and (fsmUleUnary a b) (fsmNeqUnaryUpto a b)

private theorem BitVec.getLsbD_zeroExtend_eq_getLsbD (x : BitVec wold) (wnew : Nat) :
    (x.zeroExtend wnew).getLsbD i = if (i < wnew) then x.getLsbD i else false := by
    simp

def fsmZext (a wold wnew : FSM (StateSpace wcard tcard))
    : FSM (StateSpace wcard tcard) :=
  ite (fsmUleUnary wold wnew) a (FSM.zero.map Fin.elim0)


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
  ite (fsmUleUnary wnew wold)
    /- wnew ≤ wold, so it's the same as zext. -/
    (fsmZext a wold wnew)
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
      let wold := a.width
      let afsm := mkTermFSM wcard tcard a
      let woldFsm := mkWidthFSM wcard tcard wold
      let wnewFsm := mkWidthFSM wcard tcard wnew
      { toFsm := fsmZext afsm.toFsm woldFsm.toFsm wnewFsm.toFsm }
  | .sext a v =>
    let wold := a.width
    let afsm := mkTermFSM wcard tcard a
    let woldFsm := mkWidthFSM wcard tcard wold
    let vFsm := mkWidthFSM wcard tcard v
    { toFsm := fsmSext afsm.toFsm woldFsm.toFsm vFsm.toFsm }

def IsGoodTermFSM_mkTermFSM {wcard tcard : Nat} (tctx : Term.Ctx wcard tcard) {w : WidthExpr wcard} (t : Term tctx w)  :
    (IsGoodTermFSM (mkTermFSM wcard tcard (.ofDep t))) where
  heq := by
    intros wenv tenv fsmEnv htenv
    induction t generalizing wenv tenv fsmEnv
    case var v =>
      obtain htenv_term := htenv.heq_term
      obtain htenv_width := htenv.heq_width
      simp only [Nondep.Term.ofDep_var, mkTermFSM, Fin.is_lt, ↓reduceDIte, Fin.eta, FSM.eval_var',
        htenv_term, Term.toBitstream, Term.toBV_var]
    case add v p q hp hq =>
      simp [Term.toBitstream, Nondep.Term.ofDep, mkTermFSM]
      simp [Term.toBV]
      sorry
    case zext w' a b c  =>
      simp [Term.toBitstream, Nondep.Term.ofDep, mkTermFSM]
      simp [fsmZext]
      simp [ite]
      sorry
    case sext w' a b => sorry

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
