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
/-- `repeatBit` is an operation that will repeat the infinitely repeat the
least significant `true` bit of the input.

That is `repeatBit t` is all-zeroes iff `t` is all-zeroes.
Otherwise, there is some number `k` s.t. `repeatBit t` is all-ones after
dropping the least significant `k` bits  -/
| repeatBit : Term → Term

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
  | repeatBit t => BitStream.repeatBit (Term.eval t vars)

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
| repeatBit t => arity t

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
  | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)
