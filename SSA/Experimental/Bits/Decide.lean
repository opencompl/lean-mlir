/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Experimental.Bits.Propagate

open Fintype Term

instance decidableEvalEq (t₁ t₂ : Term) :
    Decidable (t₁.eval = t₂.eval) := by
  let p := termEvalEqPropagate (t₁.xor t₂)
  letI := p.i
  let c := 2 ^ card p.α
  let ar := arity (t₁.xor t₂)
  refine' decidable_of_iff
    (∀ (seq : Fin ar → Fin c → Bool)
      (i : Fin c),
      (t₁.xor t₂).eval
      (λ i j => if hij : i < ar ∧ j < c
        then seq ⟨i, hij.1⟩ ⟨j, hij.2⟩ else false) i = false) _
  rw [eval_eq_iff_xor_eq_zero, p.good, PropagateStruc.eval]
  rw [Function.funext_iff, propagate_eq_zero_iff]
  simp only [← evalFin_eq_eval, p.good]
  constructor
  { intro h seq i hi
    rw [← h (λ i j => seq i j) ⟨i, hi⟩]
    apply propagate_eq_of_seq_eq_le
    intro b j hj
    rw [dif_pos ]
    have := (lt_of_le_of_lt hj hi)
    refine' ⟨b.2, this⟩ }
  { intro h seq i
    rw [PropagateStruc.eval, h]
    exact i.2 }


def decide (t₁ t₂ : Term) : Bool :=
  t₁.eval = t₂.eval

def x := Term.var 0
def y := Term.var 1

example : ((and x y) + (or x y)).eval = (x + y).eval := by
  native_decide

example : ((or x y) - (xor x y)).eval = (and x y).eval := by
  native_decide

-- Checking if the operations satisfy the defining identities

/-- info: true -/
#guard_msgs in #eval decide (x + -x) 0
/-- info: true -/
#guard_msgs in #eval decide (incr x) (x + 1)
/-- info: true -/
#guard_msgs in #eval decide (decr x) (x - 1)
--/-- info: true -/
--#guard_msgs in #eval decide (x + -y) (x - y)
/-- info: true -/
#guard_msgs in #eval decide (x + 0) (var 0)
/-- info: true -/
#guard_msgs in #eval decide (x + y) (y + x)

-- Equalities from Zulip

/-- info: true -/
#guard_msgs in #eval decide (-x) (not x).incr
/-- info: true -/
#guard_msgs in #eval decide (-x) (not x.decr)
/-- info: true -/
#guard_msgs in #eval decide (not x) (-x).decr
/-- info: true -/
#guard_msgs in #eval decide (-not x) x.incr
-- /-- info: true -/
-- #guard_msgs in #eval decide (x + y) (x - not y).decr
-- /-- info: true -/
-- #guard_msgs in #eval decide (x + y) ((xor x y) + (and x y).ls false)
/-- info: true -/
#guard_msgs in #eval decide (x + y) (or x y + and x y)
-- /-- info: true -/
-- #guard_msgs in #eval decide (x + y) ((or x y).ls false - (xor x y))
-- /-- info: true -/
-- #guard_msgs in #eval decide (x - y) (x + not y).incr
-- /-- info: true -/
-- #guard_msgs in #eval decide (x - y) (xor x y - (and (not x) y).ls false)
/-- info: true -/
#guard_msgs in #eval decide (x - y) (and x (not y) - (and (not x) y))
--/-- info: true -/
--#guard_msgs in #eval decide (x - y) ((and x (not y)).ls false - (xor x y))
/-- info: true -/
#guard_msgs in #eval decide (xor x y) ((or x y) - (and x y))
/-- info: true -/
#guard_msgs in #eval decide (and x (not y)) (or x y - y)
/-- info: true -/
#guard_msgs in #eval decide (and x (not y)) (x - and x y)

-- /-- info: true -/
-- #guard_msgs in #eval decide (not (x - y)) (y - x).decr
/-- info: true -/
#guard_msgs in #eval decide (not (x - y)) (not x + y)
/-- info: true -/
#guard_msgs in #eval decide (not (xor x y)) (and x y - (or x y)).decr
/-- info: true -/
#guard_msgs in #eval decide (not (xor x y)) (and x y + not (or x y))
/-- info: true -/
#guard_msgs in #eval decide (or x y) (and x (not y) + y)
/-- info: true -/
#guard_msgs in #eval decide (and x y) (or (not x) y - not x)
