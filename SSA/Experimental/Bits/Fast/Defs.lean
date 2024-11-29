/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream

/-!
# Term Language
This file defines the term language the decision procedure operates on,
and the denotation of these terms into operations on bitstreams -/

/-- A `Term` is an expression in the language our decision procedure operates on,
it represent an infinite bitstream (with free variables) -/
inductive Term : Type
| var : Nat → Term
/-- The constant `0` -/
| zero : Term
/-- The constant `-1` -/
| negOne : Term
/-- The constant `1` -/
| one : Term
/-- Bitwise and -/
| and : Term → Term → Term
/-- Bitwise or -/
| or : Term → Term → Term
/-- Bitwise xor -/
| xor : Term → Term → Term
/-- Bitwise complement -/
| not : Term → Term
/-- Append a single bit the start (i.e., least-significant end) of the bitstream -/
| ls (b : Bool) : Term → Term
/-- Addition -/
| add : Term → Term → Term
/-- Subtraction -/
| sub : Term → Term → Term
/-- Negation -/
| neg : Term → Term
/-- Increment (i.e., add one) -/
| incr : Term → Term
/-- Decrement (i.e., subtract one) -/
| decr : Term → Term
/- `repeatBit` is an operation that will repeat the infinitely repeat the
least significant `true` bit of the input.

That is `repeatBit t` is all-zeroes iff `t` is all-zeroes.
Otherwise, there is some number `k` s.t. `repeatBit t` is all-ones after
dropping the least significant `k` bits  -/
-- | repeatBit : Term → Term

open Term

open BitStream in
/--
Evaluate a term `t` to the BitStream it represents,
given a value for the free variables in `t`.

Note that we don't keep track of how many free variable occur in `t`,
so eval requires us to give a value for each possible variable.
-/
def Term.eval (t : Term) (vars : Nat → BitStream) : BitStream :=
  match t with
  | var n       => vars n
  | zero        => BitStream.zero
  | one         => BitStream.one
  | negOne      => BitStream.negOne
  | and t₁ t₂   => (t₁.eval vars) &&& (t₂.eval vars)
  | or t₁ t₂    => (t₁.eval vars) ||| (t₂.eval vars)
  | xor t₁ t₂   => (t₁.eval vars) ^^^ (t₂.eval vars)
  | not t       => ~~~(t.eval vars)
  | ls b t      => (Term.eval t vars).concat b
  | add t₁ t₂   => (Term.eval t₁ vars) + (Term.eval t₂ vars)
  | sub t₁ t₂   => (Term.eval t₁ vars) - (Term.eval t₂ vars)
  | neg t       => -(Term.eval t vars)
  | incr t      => BitStream.incr (Term.eval t vars)
  | decr t      => BitStream.decr (Term.eval t vars)
 -- | repeatBit t => BitStream.repeatBit (Term.eval t vars)

instance : Add Term := ⟨add⟩
instance : Sub Term := ⟨sub⟩
instance : One Term := ⟨one⟩
instance : Zero Term := ⟨zero⟩
instance : Neg Term := ⟨neg⟩

/-- `t.arity` is the max free variable id that occurs in the given term `t`,
and thus is an upper bound on the number of free variables that occur in `t`.

Note that the upper bound is not perfect:
a term like `var 10` only has a single free variable, but its arity will be `11` -/
@[simp] def Term.arity : Term → Nat
| (var n) => n+1
| zero => 0
| one => 0
| negOne => 0
| Term.and t₁ t₂ => max (arity t₁) (arity t₂)
| Term.or t₁ t₂ => max (arity t₁) (arity t₂)
| Term.xor t₁ t₂ => max (arity t₁) (arity t₂)
| Term.not t => arity t
| ls _ t => arity t
| add t₁ t₂ => max (arity t₁) (arity t₂)
| sub t₁ t₂ => max (arity t₁) (arity t₂)
| neg t => arity t
| incr t => arity t
| decr t => arity t
-- | repeatBit t => arity t

/--
Evaluate a term `t` to the BitStream it represents.

This differs from `Term.eval` in that `Term.evalFin` uses `Term.arity` to
determine the number of free variables that occur in the given term,
and only require that many bitstream values to be given in `vars`.
-/
@[simp] def Term.evalFin (t : Term) (vars : Fin (arity t) → BitStream) : BitStream :=
  match t with
  | var n => vars (Fin.last n)
  | zero    => BitStream.zero
  | one     => BitStream.one
  | negOne  => BitStream.negOne
  | and t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ &&& x₂
  | or t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ||| x₂
  | xor t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ^^^ x₂
  | not t     => ~~~(t.evalFin vars)
  | ls b t    => (t.evalFin vars).concat b
  | add t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | neg t       => -(Term.evalFin t vars)
  | incr t      => BitStream.incr (Term.evalFin t vars)
  | decr t      => BitStream.decr (Term.evalFin t vars)
  -- | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)


/--
The fragment of predicate logic that we support in `bv_automata`.
Currently, we support equality, conjunction, disjunction, and negation.
This can be expanded to also support arithmetic constraints such as unsigned-less-than.

Meaning of the denotation:

`p w = false` iff the predicate holds *at* width w
-/
-- a < b <=> a - b < 0
-- a <= 0 <=> a < 0 ∨ a = 0
-- a > b <=> b < a <=> b - a < 0
inductive Predicate : Type where
| eq (t₁ t₂ : Term) : Predicate
| neq (t₁ t₂ : Term) : Predicate
| isNeg (t : Term) : Predicate
| land  (p q : Predicate) : Predicate
| lor (p q : Predicate) : Predicate


-- | leq (t₁ t₂ : Term) : Predicate -> simulate in terms of lt and eq
open BitStream in
/--
Evaluate a term predicate `p` to the BitStream it represents,
where the predicate is `true` at index `i` if and only if the predicate,
when truncated to index `i`, is true.
-/
def Predicate.eval (p : Predicate) (vars : Nat → BitStream) : BitStream :=
  match p with
  | eq t1 t2 => (t1.eval vars ^^^ t2.eval vars)
  | isNeg t => t.eval vars
  /-
  If it is ever not equal, then we want to stay not equals for ever.
  So, if the 'a = b' returns 'false' at some index 'i', we will stay false
  for all indexes '≥ i'.
  -/
  | neq t1 t2 => ((t1.eval vars).nxor (t2.eval vars)).scanAnd
  | lor p q => (p.eval vars) ||| (q.eval vars)
  | land p q => (p.eval vars) &&& (q.eval vars)

@[simp]
theorem Bool.xor_false_iff_eq : ∀ (a b : Bool), (a ^^ b) = false ↔ a = b := by decide

section Predicate
/-- If the two bitstreams are equal, the Predicate.eq will be always zero -/
lemma eq_iff_all_zeroes (t₁ t₂ : Term) :
    (t₁.eval = t₂.eval) ↔ (∀ n x, (Predicate.eq t₁ t₂).eval x n = false) := by
  constructor
  · intros heq
    intros n x
    induction n generalizing x t₁ t₂
    case zero => simp [Predicate.eval, heq]
    case succ n ih =>
      simp [Predicate.eval] at ih ⊢
      rw [heq]
  · intros heq
    ext x n
    specialize (heq n x)
    simp only [Predicate.eval, BitStream.xor_eq, bne_eq_false_iff_eq] at heq
    exact heq

/-- If something is always true, then it is eventually always true. -/
theorem eventually_all_zeroes_of_all_zeroes (b : BitStream) (h : ∀ n, b n = false) : ∃ (N : Nat), ∀ n ≥ N, b n = false := by
  exists Nat.zero
  simp [h]


/-- If the scanOr of something is eventually always zeroes, then it must be all zeroes. -/
theorem all_zeroes_of_scanOr_eventually_all_zeroes (b : BitStream) (h : ∃ (N : Nat), ∀ n ≥ N, b.scanOr n = false) : ∀ n, b n = false := by
  intros n
  have ⟨N, h⟩ := h
  simp [BitStream.scanOr_false_iff] at h
  apply h (n := max N n) <;> omega

/-- Terms are equal if the 'eq' predicate at width 'x' returns 'false' -/
lemma Predicate.eq_iff_toBitVec_eval_eq :
    ((t₁.eval x).toBitVec w = (t₂.eval x).toBitVec w) ↔ ((Predicate.eq t₁ t₂).eval x w = false) := by
  constructor
  · intros h
    sorry
  · intros h
    sorry

end Predicate

@[simp] def Predicate.arity : Predicate → Nat
| .eq t1 t2 => max t1.arity t2.arity
| .lor p q => max p.arity q.arity
| .land p q => max p.arity q.arity
| .isNeg t => t.arity
| .neq t₁ t₂ => max t₁.arity t₂.arity

/-- Denote a predicate into a bitstream, where the ith bit tells us if it is true in the ith state -/
@[simp] def Predicate.evalFin (p : Predicate) (vars : Fin (arity p) → BitStream) : BitStream :=
match p with
| .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    (x₁ ^^^ x₂).scanOr
| .neq t₁ t₂  =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    (x₁.nxor x₂).scanAnd
| .land p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (x₁ &&& x₂)
| .lor p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (x₁ &&& x₂)
| .isNeg t  =>
  let x₁ := t.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  x₁


