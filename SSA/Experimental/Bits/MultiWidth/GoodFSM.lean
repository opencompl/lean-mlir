/-
This file builds the FSMs whose
verification implies the correctness of the
multi-width bitstream semantics.
-/
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars
import SSA.Experimental.Bits.MultiWidth.Defs

namespace MultiWidth


instance : HAnd (FSM α) (FSM α) (FSM α) where
  hAnd := composeBinaryAux' FSM.and

instance : HOr (FSM α) (FSM α) (FSM α) where
  hOr := composeBinaryAux' FSM.or

instance : HXor (FSM α) (FSM α) (FSM α) where
  hXor := composeBinaryAux' FSM.xor

instance : Complement (FSM α) where
  complement := composeUnaryAux FSM.not


-- build an FSM whose output is unary, and is 1 in the beginning, and becomes 0
-- forever after.
-- TODO: I am pretty sure we can just do this with binary encodings as well?
def mkWidthFSM (wcard : Nat) (tcard : Nat)  (w : Nondep.WidthExpr) : Option (NatFSM wcard tcard w) :=
  if h : w.toNat < wcard then
    some { fsm := composeUnaryAux FSM.scanAnd (FSM.var' (StateSpace.widthVar ⟨w.toNat, h⟩)) }
  else 
    -- some { fsm := FSM.zero.map Fin.elim0 }
    none


-- when we compute 'a - b', if the borrow bit is zero,
-- then we know that 'a' is greater than or equal to 'b'.
-- if the borrow bit is one, then we know that 'a' is less than 'b'.
-- a: 0 <= b: 0 = 1
-- a: 0 <= b: 1 = 1
-- a: 1 <= b: 0 = 0
-- a: 1 <= b: 1 = 1
def fsmUltUnary (a : FSM α) (b : FSM α) : FSM α :=
  a ||| ~~~ b

-- returns 1 if a is equal to b.
def fsmEqBitwise (a : FSM α) (b : FSM α) : FSM α :=
  composeUnaryAux FSM.scanAnd <| composeBinaryAux' FSM.nxor a  b

-- returns 1 if a is less than or equal to b.
def fsmUleUnary (a : FSM α) (b : FSM α) : FSM α :=
  (fsmUltUnary a b) &&& (fsmEqBitwise a b)

-- | if 'cond' is true, then return 't', otherwise return 'e'.
def ite (cond : FSM α) (t : FSM α) (e : FSM α) : FSM α :=
  (cond &&& t) ||| (~~~ cond &&& e)

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
    Option (TermFSM wcard tcard t) :=
  match t with
  | .var v _w =>
    if h : v < tcard then
      some { 
      fsm := composeUnaryAux
        FSM.scanAnd (FSM.var' (StateSpace.termVar ⟨v, h⟩))
      }
    else
      none
      -- some { fsm := FSM.zero.map Fin.elim0 }
  | .add a b => do
    let fsmA ← mkTermFSM wcard tcard a
    let fsmB ← mkTermFSM wcard tcard b
    return { fsm := (composeBinaryAux' FSM.add fsmA.fsm fsmB.fsm) }
  | .zext a wnew => do
      let wold := a.width
      let afsm ← mkTermFSM wcard tcard a
      let woldFsm ← mkWidthFSM wcard tcard wold
      let wnewFsm ← mkWidthFSM wcard tcard wnew
      return { fsm := fsmZext afsm.fsm woldFsm.fsm wnewFsm.fsm }
  | .sext a v => do
    let wold := a.width
    let afsm ← mkTermFSM wcard tcard a
    let woldFsm ← mkWidthFSM wcard tcard wold
    let vFsm ← mkWidthFSM wcard tcard v
    return { fsm := fsmSext afsm.fsm woldFsm.fsm vFsm.fsm }

def mkPredicateFSMAux (wcard tcard : Nat) (p : Nondep.Predicate) :
  Option (PredicateFSM wcard tcard p) := do
  match p with
  | .binRel .eq a b =>
    let fsmA ← mkTermFSM wcard tcard a
    let fsmB ← mkTermFSM wcard tcard b
    return { fsm := fsmEqBitwise fsmA.fsm fsmB.fsm }
  | .or p q  =>
    let fsmP ←  mkPredicateFSMAux wcard tcard p
    let fsmQ ←  mkPredicateFSMAux wcard tcard q
    return { fsm := composeUnaryAux FSM.scanAnd (fsmP.fsm ||| fsmQ.fsm) }
  | .and p q =>
    let fsmP ← mkPredicateFSMAux wcard tcard p
    let fsmQ ← mkPredicateFSMAux wcard tcard q
    return { fsm := composeUnaryAux FSM.scanAnd (fsmP.fsm &&& fsmQ.fsm) }
  | .not p =>
    let fsmP ← mkPredicateFSMAux wcard tcard p
    return { fsm := composeUnaryAux FSM.scanAnd (~~~ fsmP.fsm) }

/-- Negate the FSM so we can decide if zeroes. -/
def mkPredicateFSM (wcard tcard : Nat) (p : Nondep.Predicate) :
  Option (PredicateFSM wcard tcard p) := do
    let fsm ← mkPredicateFSMAux wcard tcard p
    return { fsm := ~~~ fsm.fsm }

end MultiWidth
