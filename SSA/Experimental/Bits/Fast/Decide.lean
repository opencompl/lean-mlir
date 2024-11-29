import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Lemmas

instance (t₁ t₂ : Term) : Decidable (t₁.eval = t₂.eval) :=
  decidable_of_iff
    (decideIfZeros (termEvalEqFSM (t₁.xor t₂)).toFSM) $ by
  rw [decideIfZeros_correct, ← (termEvalEqFSM (t₁.xor t₂)).good]
  simp only [eval_eq_iff_xor_eq_zero]
  rw [forall_swap]
  simp only [← funext_iff]

instance (p : Predicate) : Decidable (∀ (n : ℕ) (x : Fin p.arity → BitStream) , p.evalFin x n = false) :=
  decidable_of_iff
    (decideIfZeros (predicateEvalEqFSM p).toFSM) $ by
  rw [decideIfZeros_correct, ← (predicateEvalEqFSM p).good]


/-
We can decide that the evaluation of a predicate is forever false,
which is to say, that it is true for all bitwidths.
-/
instance (p : Predicate) : Decidable (∀ (n : ℕ) (x : ℕ → BitStream) , p.eval x n = false) :=
  decidable_of_iff
    (decideIfZeros (predicateEvalEqFSM p).toFSM) $ by
  rw [decideIfZeros_correct, ← (predicateEvalEqFSM p).good]
  constructor
  · intro h n
    intros x
    specialize (h n (fun i => x i))
    rw [Predicate.evalFin_eq_eval] at h
    exact h
  · intros h n
    intros x
    let env := (fun j => if hj : j < (p.arity) then x ⟨j, hj⟩ else fun _ => false)
    specialize h n env
    rw [← h]
    have hx : x = (fun (i : Fin p.arity) => env i) := by simp [env]
    rw [hx]
    rw [Predicate.evalFin_eq_eval]

open Term

def run_decide (t₁ t₂ : Term) : IO Bool := do
  pure (t₁.eval = t₂.eval)

def decide (t₁ t₂ : Term) : IO Bool :=
  --timeit "" (run_decide t₁ t₂)
  (run_decide t₁ t₂)


section testDecide

def x := Term.var 0
def y := Term.var 1
def z := Term.var 2

example : ((and x y) + (or x y)).eval = (x + y).eval := by
  native_decide

example : ((or x y) - (xor x y)).eval = (and x y).eval := by
  native_decide


/-
Note that we use `#eval!` instead of `#eval`, since our
proof of `decide` currently contains a `sorry`. We should elminate the `sorry`,
and then switch to `#eval`.
-/

/--
info: 'Decidable.decide' does not depend on any axioms
---
info: 'decide' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms decide

/-- info: true -/
#guard_msgs in #eval! decide (x + -x) 0

/-- info: true -/
#guard_msgs in #eval! decide (incr x) (x + 1)

/-- info: true -/
#guard_msgs in #eval! decide (decr x) (x - 1)

/-- info: true -/
#guard_msgs in #eval! decide (x + -y) (x - y)

/-- info: true -/
#guard_msgs in #eval! decide (x + 0) (var 0)

/-- info: true -/
#guard_msgs in #eval! decide (x + y) (y + x)

/-- info: true -/
#guard_msgs in #eval! decide (x + (y + z)) (x + y + z)

/-- info: true -/
#guard_msgs in #eval! decide (x - x) 0

/-- info: true -/
#guard_msgs in #eval! decide (x + 0) x

/-- info: true -/
#guard_msgs in #eval! decide (0 + x) x

/-- info: true -/
#guard_msgs in #eval! decide (-x) (not x).incr

/-- info: true -/
#guard_msgs in #eval! decide (-x) (not x.decr)

/-- info: true -/
#guard_msgs in #eval! decide (not x) (-x).decr

/-- info: true -/
#guard_msgs in #eval! decide (-not x) (x + 1)

/-- info: true -/
#guard_msgs in #eval! decide (x + y) (x - not y - 1)

/-- info: true -/
#guard_msgs in #eval! decide (x + y) ((xor x y) + (and x y).ls false)

/-- info: true -/
#guard_msgs in #eval! decide (x + y) (or x y + and x y)

/-- info: true -/
#guard_msgs in #eval! decide (x + y) ((or x y).ls false - (xor x y))

/-- info: true -/
#guard_msgs in #eval! decide (x - y) (x + not y).incr

/-- info: true -/
#guard_msgs in #eval! decide (x - y) (xor x y - (and (not x) y).ls false)

/-- info: true -/
#guard_msgs in #eval! decide (x - y) (and x (not y) - (and (not x) y))

/-- info: true -/
#guard_msgs in #eval! decide (x - y) ((and x (not y)).ls false - (xor x y))

/-- info: true -/
#guard_msgs in #eval! decide (xor x y) ((or x y) - (and x y))

/-- info: true -/
#guard_msgs in #eval! decide (and x (not y)) (or x y - y)

/-- info: true -/
#guard_msgs in #eval! decide (and x (not y)) (x - and x y)

/-- info: true -/
#guard_msgs in #eval! decide (not (x - y)) (y - x).decr

/-- info: true -/
#guard_msgs in #eval! decide (not (x - y)) (not x + y)

/-- info: true -/
#guard_msgs in #eval! decide (not (xor x y)) (and x y - (or x y)).decr

/-- info: true -/
#guard_msgs in #eval! decide (not (xor x y)) (and x y + not (or x y))

/-- info: true -/
#guard_msgs in #eval! decide (or x y) (and x (not y) + y)

/-- info: true -/
#guard_msgs in #eval! decide (and x y) (or (not x) y - not x)
end testDecide
