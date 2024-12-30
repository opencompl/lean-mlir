import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Lemmas

instance (p : Predicate) : 
    Decidable (∀ (n : ℕ) (x : Fin p.arity → BitStream) , p.evalFin x n = false) :=
  decidable_of_iff
    (decideIfZeros (predicateEvalEqFSM p).toFSM) $ by
  rw [decideIfZeros_correct]
  simp only [FSM.eval_simplify]
  rw [← (predicateEvalEqFSM p).good]

/--
We can decide that the evaluation of a predicate is forever false,
which is to say, that it is true for all bitwidths.
-/
instance (p : Predicate) :
    Decidable (∀ (n : ℕ) (x : List BitStream) , p.eval x n = false) :=
  decidable_of_iff
    (decideIfZeros (predicateEvalEqFSM p).toFSM) $ by
  rw [decideIfZeros_correct]
  simp only [FSM.eval_simplify]
  rw [← (predicateEvalEqFSM p).good]
  constructor
  · intros h  n x
    sorry
  · sorry
    -- specialize h n (fun i => x[i])
    -- rw [← Predicate.evalFin_eq_eval] at h

instance DecideFixedWidthPredicateEvalFin  (p : Predicate) (n : ℕ) : 
    Decidable (∀ (x : Fin p.arity → BitStream) , p.evalFin x n = false) :=
  decidable_of_iff
    (decideIfZerosAtIx (predicateEvalEqFSM p).toFSM n) $ by
  rw [decideIfZeroesAtIx_correct, ← (predicateEvalEqFSM p).good]

/-
instance DecideFixedWidthPredicateEval (p : Predicate) (n : ℕ) : 
    Decidable (∀ (x : List BitStream) , p.eval x n = false) :=
  decidable_of_iff
    (decideIfZerosAtIx (predicateEvalEqFSM p).toFSM n) $ by
  rw [decideIfZeroesAtIx_correct, ← (predicateEvalEqFSM p).good]
  constructor <;> sorry
-/

open Term

