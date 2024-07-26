import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Lemmas

instance (t₁ t₂ : Term) : Decidable (t₁.eval = t₂.eval) :=
  decidable_of_iff
    (decideIfZeros (termEvalEqFSM (t₁.xor t₂)).toFSM) $ by
  rw [decideIfZeros_correct,
    ← (termEvalEqFSM (t₁.xor t₂)).good]
  simp only [eval_eq_iff_xor_eq_zero]
  rw [forall_swap]
  simp only [← Function.funext_iff]


open Term

def run_decide (t₁ t₂ : Term) : IO Bool := do
  pure (t₁.eval = t₂.eval)

def decide (t₁ t₂ : Term) : IO Bool :=
  --timeit "" (run_decide t₁ t₂)
  (run_decide t₁ t₂)

def x := Term.var 0
def y := Term.var 1
def z := Term.var 2

example : ((and x y) + (or x y)).eval = (x + y).eval := by
  native_decide

example : ((or x y) - (xor x y)).eval = (and x y).eval := by
  native_decide

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
