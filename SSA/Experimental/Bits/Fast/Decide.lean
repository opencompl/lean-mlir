import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Lemmas

instance (t₁ t₂ : Term) : Decidable (t₁.eval = t₂.eval) :=
  decidable_of_iff
    (decideIfZeros (termEvalEqFSM (t₁.xor t₂)).toFSM) $ by
  rw [decideIfZeros_correct,
    ← (termEvalEqFSM (t₁.xor t₂)).good]
  simp only [Function.funext_iff, evalFin_eq_eval,
    eval_eq_iff_xorSeq_eq_zero, zeroSeq]
  exact forall_swap

open Term

def run_decide (t₁ t₂ : Term) : IO Bool := do
  pure (t₁.eval = t₂.eval)

def decide (t₁ t₂ : Term) : IO Bool :=
  timeit "" (run_decide t₁ t₂)

def x := Term.var 0
def y := Term.var 1
def z := Term.var 2

--example : ((and x y) + (or x y)).eval = (x + y).eval := by
--  native_decide

--example : ((or x y) - (xor x y)).eval = (and x y).eval := by
--  native_decide

--set_option trace.profiler true
--Checking if the operations satisfy the defining identities
--#eval decide (x + -x) 0
--#eval decide (incr x) (x + 1)
--#eval decide (decr x) (x - 1)
--#eval decide (x + - y) (x - y)
--#eval decide (x + 0) (var 0)
--#eval decide (x + y) (y + x)
--#eval decide (x + (y + z)) (x + y + z)
--#eval decide (x - x) 0
--#eval decide (x  + 0) x
--#eval decide (0 + x) x
---- Equalities from Zulip
--#eval decide (-x) (not x).incr
--#eval decide (-x) (not x.decr)
--#eval decide (not x) (-x).decr
--#eval decide (-not x) (x + 1)
--#eval decide (x + y) (x - not y - 1)
--#eval decide (x + y) ((xor x y) + (and x y).ls false)
--#eval decide (x + y) (or x y + and x y)
--#eval decide (x + y) ((or x y).ls false - (xor x y))
--#eval decide (x - y) (x + not y).incr
--#eval decide (x - y) (xor x y - (and (not x) y).ls false)
--#eval decide (x - y) (and x (not y) - (and (not x) y))
--#eval decide (x - y) ((and x (not y)).ls false - (xor x y))
--#eval decide (xor x y) ((or x y) - (and x y))
--#eval decide (and x (not y)) (or x y - y)
--#eval decide (and x (not y)) (x - and x y)
--
--#eval decide (not (x - y)) (y - x).decr
--#eval decide (not (x - y)) (not x + y)
--#eval decide (not (xor x y)) (and x y - (or x y)).decr
--#eval decide (not (xor x y)) (and x y + not (or x y))
--#eval decide (or x y) (and x (not y) + y)
--#eval decide (and x y) (or (not x) y - not x)
