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
instance DecidableForallPredicateEvalEqFalse (p : Predicate) :
    Decidable (∀ (n : ℕ) (x : List BitStream) , p.eval x n = false) :=
  decidable_of_iff
    (decideIfZeros (predicateEvalEqFSM p).toFSM) $ by
  rw [decideIfZeros_correct] -- correct
  simp only [FSM.eval_simplify] -- correct
  rw [← (predicateEvalEqFSM p).good] -- correct:
  constructor
  · intros h n xs
    rw [← Predicate.evalFin_eq_eval p xs]
    · apply h
    · exact fun i => if hi : i < xs.length then xs[i] else default
    · intros i
      simp
      by_cases hi : i < xs.length
      · simp [hi]
      · simp only [hi, ↓reduceDIte]
        rw [List.getElem?_eq_none (by omega)]
        simp
  · intros h n xs
    specialize h n
    rw [Predicate.evalFin_eq_eval p  (List.ofFn xs) xs]
    · apply h
    · simp

/--
info: 'DecidableForallPredicateEvalEqFalse' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms DecidableForallPredicateEvalEqFalse

instance DecideFixedWidthPredicateEvalFin  (p : Predicate) (n : ℕ) :
    Decidable (∀ (x : Fin p.arity → BitStream) , p.evalFin x n = false) :=
  decidable_of_iff
    (decideIfZerosAtIx (predicateEvalEqFSM p).toFSM n) $ by
  rw [decideIfZeroesAtIx_correct, ← (predicateEvalEqFSM p).good]

open Term
