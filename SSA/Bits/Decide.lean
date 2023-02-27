import SSA.Bits.Lemmas

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
  rw [eval_eq_iff_xorSeq_eq_zero, p.good, PropagateStruc.eval]
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

-- Checking if the operations satisfy the defining identities
-- #eval decide (x + -x) 0
-- #eval decide (incr x) (x + 1)
-- #eval decide (decr x) (x - 1)
-- #eval decide (x + - y) (x - y)
-- #eval decide (neg_one) (-1)
-- #eval decide (x + 0) (var 0)
-- #eval decide (x + y) (y + x)

-- -- Equalities from Zulip
-- #eval decide (-x) (not x).incr
-- #eval decide (-x) (not x.decr)
-- #eval decide (not x) (-x).decr
-- #eval decide (-not x) x.incr
-- #eval decide (x + y) (x - not y).decr
-- #eval decide (x + y) ((xor x y) + (and x y).ls)
-- #eval decide (x + y) (or x y + and x y)
-- #eval decide (x + y) ((or x y).ls - (xor x y))
-- #eval decide (x - y) (x + not y).incr
-- #eval decide (x - y) (xor x y - (and (not x) y).ls)
-- #eval decide (x - y) (and x (not y) - (and (not x) y))
-- #eval decide (x - y) ((and x (not y)).ls - (xor x y))
-- #eval decide (xor x y) ((or x y) - (and x y))
-- #eval decide (and x (not y)) (or x y - y)
-- #eval decide (and x (not y)) (x - and x y)

-- #eval decide (not (x - y)) (y - x).decr
-- #eval decide (not (x - y)) (not x + y)
-- #eval decide (not (xor x y)) (and x y - (or x y)).decr
-- #eval decide (not (xor x y)) (and x y + not (or x y))
-- #eval decide (or x y) (and x (not y) + y)
-- #eval decide (and x y) (or (not x) y - not x)

