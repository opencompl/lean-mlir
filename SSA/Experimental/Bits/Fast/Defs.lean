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
/-- The constant `n` from a bitvector expression -/
| ofNat (n : Nat) : Term
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
/-- shift left by `k` bits. -/
| shiftL : Term → Nat → Term 
-- /-- logical shift right by `k` bits. -/
-- | lshiftR : Term → Nat → Term
-- bollu: I don't think we can do ashiftr, because it's output is 'irregular',
--   hence, I don't anticipate us implementing it.

open Term

open BitStream in
/--
Evaluate a term `t` to the BitStream it represents,
given a value for the free variables in `t`.

Note that we don't keep track of how many free variable occur in `t`,
so eval requires us to give a value for each possible variable.
-/
def Term.eval (t : Term) (vars : List BitStream) : BitStream :=
  match t with
  | var n       => vars[n]!
  | zero        => BitStream.zero
  | one         => BitStream.one
  | negOne      => BitStream.negOne
  | ofNat n     => BitStream.ofNat n
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
  | shiftL t n  => BitStream.shiftLeft (Term.eval t vars) n
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
| ofNat _ => 0
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
| shiftL t .. => arity t
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
  | ofNat n => BitStream.ofNat n
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
  | shiftL t n  => BitStream.shiftLeft (Term.evalFin t vars) n
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
/-- Assert that the bitwidth equals `n` -/
| widthEq (n : Nat) : Predicate
/-- Assert that the bitwidth does not equal `n` -/
| widthNeq (n : Nat) : Predicate
/-- Assert that the bitwidth is less than 'n' -/
| widthLt (n : Nat) : Predicate
/-- Assert that the bitwidth is less than or equal to 'n' -/
| widthLe (n : Nat) : Predicate
/-- Assert that the bitwidth is greater than 'n' -/
| widthGt (n : Nat) : Predicate
/-- Assert that the bitwidth is greater than or equal to 'n' -/
| widthGe (n : Nat) : Predicate
| eq (t₁ t₂ : Term) : Predicate
| neq (t₁ t₂ : Term) : Predicate
| ult (t₁ t₂ : Term) : Predicate
| ule (t₁ t₂ : Term) : Predicate
| slt (t₁ t₂ : Term) : Predicate
| sle (t₁ t₂ : Term) : Predicate
| land  (p q : Predicate) : Predicate
| lor (p q : Predicate) : Predicate



/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalEq (t₁ t₂ : BitStream) : BitStream := (t₁ ^^^ t₂).scanOr
/--
If they have been equal so far, then `BitStream.nxor t₁ t₂`.scanAnd will be 1.
Start by assuming that they are not (not equal) i.e. that they are equal, and the 
   initial value of the preciate is false / `1`.
If their values ever differ, then we know that we will have `a[i] == b[i]` to be `false`.
From this point onward, they will always disagree, and thus the predicate should become `0`.
-/
-- def Predicate.evalNeq (t₁ t₂ : BitStream) : BitStream := (BitStream.nxor t₁ t₂).scanAnd
def Predicate.evalNeq (t₁ t₂ : BitStream) : BitStream := 
  let bs : BitStream := fun i => if t₁ i != t₂ i then false else true
  bs.scanAnd

/-
If they have been `0` so far, then `t1 &&& t2 |>.scanOr` will be `1`.
-/
def Predicate.evalLor (t₁ t₂ : BitStream) : BitStream := (t₁ &&& t₂)

-- | And does not seem to work?
def Predicate.evalLand (t₁ t₂ : BitStream) : BitStream := (t₁ ||| t₂)


/-- 
Evaluate whether 't₁ <ᵤ t₂'.
This is defined by computing the borrow bit of 't₁ - t₂'.
If the borrow bit is `1`, then we know that `t₁ < t₂', so we return a `0`.
Otherwise, we know that 't₁ ≥ t₂'.
-/
def Predicate.evalUlt (t₁ t₂ : BitStream) : BitStream := ~~~ (t₁.borrow t₂)

/-- 
Evaluate whether 't₁ <s t₂'.
This is defined by computing the most significant bit of 't₁ - t₂'.
IF the `msb is 1`, then `t₁ - t₂ <s 0`, and thus `t₁ <s t₂'.
-/
def Predicate.evalSlt (t₁ t₂ : BitStream) : BitStream := ~~~ (t₁ - t₂)

-- | leq (t₁ t₂ : Term) : Predicate -> simulate in terms of lt and eq
open BitStream in
/--
Evaluate a term predicate `p` to the BitStream it represents,
where the predicate is `true` at index `i` if and only if the predicate,
when truncated to index `i`, is true.
-/
def Predicate.eval (p : Predicate) (vars : List BitStream) : BitStream :=
  match p with
  | widthEq n => BitStream.falseIffEq n
  | widthNeq n => BitStream.falseIffNeq n
  | widthLt n => BitStream.falseIffLt n
  | widthLe n => BitStream.falseIffLe n
  | widthGt n => BitStream.falseIffGt n
  | widthGe n => BitStream.falseIffGe n
  | eq t₁ t₂ => Predicate.evalEq (t₁.eval vars) (t₂.eval vars)
  /-
  If it is ever not equal, then we want to stay not equals for ever.
  So, if the 'a = b' returns 'false' at some index 'i', we will stay false
  for all indexes '≥ i'.
  -/
  | neq t1 t2 => Predicate.evalNeq (t1.eval vars) (t2.eval vars)
  | lor p q => Predicate.evalLor (p.eval vars) (q.eval vars)
  | land p q => Predicate.evalLand (p.eval vars) (q.eval vars)
  | ult t₁ t₂ => Predicate.evalUlt (t₁.eval vars) (t₂.eval vars)
  | ule t₁ t₂ => 
     Predicate.evalLor 
       (Predicate.evalEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalUlt (t₁.eval vars) (t₂.eval vars))
  | slt t₁ t₂ => Predicate.evalSlt (t₁.eval vars) (t₂.eval vars)
  | sle t₁ t₂ => Predicate.evalLor 
       (Predicate.evalEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalSlt (t₁.eval vars) (t₂.eval vars))

@[simp]
theorem Bool.xor_false_iff_eq : ∀ (a b : Bool), (a ^^ b) = false ↔ a = b := by decide

section Predicate
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

end Predicate

@[simp] def Predicate.arity : Predicate → Nat
| .widthEq _ | .widthNeq _ | .widthGe _ | .widthGt _ | .widthLt _ | .widthLe _ => 0
| .eq t1 t2 => max t1.arity t2.arity
| .lor p q => max p.arity q.arity
| .land p q => max p.arity q.arity
| .neq t₁ t₂ => max t₁.arity t₂.arity
| .ult t₁ t₂ => max t₁.arity t₂.arity
| .ule t₁ t₂ => max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity)
| .slt t₁ t₂ => max t₁.arity t₂.arity
| .sle t₁ t₂ => max (max t₁.arity t₂.arity) (max t₁.arity t₂.arity)

@[simp]
def Predicate.evalFinLor (x₁ x₂ : BitStream) : BitStream := 
    (x₁ &&& x₂)

@[simp]
def Predicate.evalFinLand (x₁ x₂ : BitStream) : BitStream := 
  (x₁ ||| x₂)

@[simp]
def Predicate.evalFinEq (x₁ x₂ : BitStream) : BitStream := 
    -- width 0, stuff is always equal
    BitStream.concat false (x₁ ^^^ x₂) |>.scanOr

@[simp]
def Predicate.evalFinSlt (x₁ x₂ : BitStream) : BitStream := 
  -- width 0, nothing is less than
  BitStream.concat true (~~~ (x₁ - x₂))

@[simp]
def Predicate.evalFinUlt (x₁ x₂ : BitStream) : BitStream := 
  -- width 0, nothing is less than
  BitStream.concat true (~~~ (x₁.borrow x₂))

/-- Denote a predicate into a bitstream, where the ith bit tells us if it is true in the ith state -/
@[simp] def Predicate.evalFin (p : Predicate) (vars : Fin (arity p) → BitStream) : BitStream :=
match p with
| widthEq n => BitStream.falseIffEq n
| widthNeq n => BitStream.falseIffNeq n
| widthLt n => BitStream.falseIffLt n
| widthLe n => BitStream.falseIffLe n
| widthGt n => BitStream.falseIffGt n
| widthGe n => BitStream.falseIffGe n
| .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalFinEq x₁ x₂
| .neq t₁ t₂  =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    (x₁.nxor x₂)
| .land p q =>
  -- if both `p` and `q` are logically true (i.e. the predicate is `false`),
  -- only then should we return a `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalFinLand x₁ x₂
| .lor p q =>
  -- If either of the predicates are `false`, then result is `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalFinLor x₁ x₂
| .slt p q => 
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalFinSlt x₁ x₂
| .sle p q => 
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalFinLor (Predicate.evalFinSlt x₁ x₂) (Predicate.evalFinEq x₁ x₂)
| .ult p q => 
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (Predicate.evalFinUlt x₁ x₂)
| .ule p q => 
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalFinLor (Predicate.evalFinUlt x₁ x₂) (Predicate.evalFinEq x₁ x₂)

