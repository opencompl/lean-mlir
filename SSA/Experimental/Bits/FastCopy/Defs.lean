/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.FastCopy.BitStream

namespace Copy
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
/-- Addition -/
| add : Term → Term → Term
/-- Subtraction -/
| sub : Term → Term → Term
/-- Negation -/
| neg : Term → Term
-- /-- Increment (i.e., add one) -/
-- | incr : Term → Term
-- /-- Decrement (i.e., subtract one) -/
-- | decr : Term → Term
/-- shift left by `k` bits. -/
| shiftL : Term → Nat → Term
-- /-- logical shift right by `k` bits. -/
-- | lshiftR : Term → Nat → Term
-- bollu: I don't think we can do ashiftr, because it's output is 'irregular',
--   hence, I don't anticipate us implementing it.
deriving Repr

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
  | var n       => vars.getD n default
  | zero        => BitStream.zero
  | one         => BitStream.one
  | negOne      => BitStream.negOne
  | ofNat n     => BitStream.ofNat n
  | and t₁ t₂   => (t₁.eval vars) &&& (t₂.eval vars)
  | or t₁ t₂    => (t₁.eval vars) ||| (t₂.eval vars)
  | xor t₁ t₂   => (t₁.eval vars) ^^^ (t₂.eval vars)
  | not t       => ~~~(t.eval vars)
  | add t₁ t₂   => (Term.eval t₁ vars) + (Term.eval t₂ vars)
  | sub t₁ t₂   => (Term.eval t₁ vars) - (Term.eval t₂ vars)
  | neg t       => -(Term.eval t vars)
--   | incr t      => BitStream.incr (Term.eval t vars)
--   | decr t      => BitStream.decr (Term.eval t vars)
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
| add t₁ t₂ => max (arity t₁) (arity t₂)
| sub t₁ t₂ => max (arity t₁) (arity t₂)
| neg t => arity t
-- | incr t => arity t
-- | decr t => arity t
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
  | add t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | neg t       => -(Term.evalFin t vars)
 --  | incr t      => BitStream.incr (Term.evalFin t vars)
 --  | decr t      => BitStream.decr (Term.evalFin t vars)
  | shiftL t n  => BitStream.shiftLeft (Term.evalFin t vars) n
  -- | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)

inductive BinaryPredicate
| eq
| neq
| ult
| ule
| slt
| sle
deriving Repr

inductive WidthPredicate
| eq
| neq
| lt
| le
| gt
| ge
deriving Repr

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
/-- Assert the corresponding relation between `n` and the width. -/
| width (rel : WidthPredicate) (n : Nat) : Predicate
| binary (pred : BinaryPredicate) (t₁ t₂ : Term) : Predicate
| land  (p q : Predicate) : Predicate
| lor (p q : Predicate) : Predicate
deriving Repr

/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalEq (t₁ t₂ : BitStream) : BitStream := (t₁ ^^^ t₂).concat false |>.scanOr
/--
If they have been equal so far, then `BitStream.nxor t₁ t₂`.scanAnd will be 1.
Start by assuming that they are not (not equal) i.e. that they are equal, and the
   initial value of the preciate is false / `1`.
If their values ever differ, then we know that we will have `a[i] == b[i]` to be `false`.
From this point onward, they will always disagree, and thus the predicate should become `0`.
-/
def Predicate.evalNeq (t₁ t₂ : BitStream) : BitStream := (t₁.nxor t₂).concat true |>.scanAnd

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
def Predicate.evalUlt (t₁ t₂ : BitStream) : BitStream := (~~~ (t₁.borrow t₂)).concat true


/--
Returns false if the MSBs are equal.
-/
def Predicate.evalMsbEq (t₁ t₂ : BitStream) : BitStream :=
  (t₁ ^^^ t₂).concat false


private theorem not_not_xor_not (a b : Bool) : ! ((!a).xor (!b)) = (a == b) := by
  revert a b
  decide

/--
info: BitVec.slt_eq_not_carry {w : ℕ} (x y : BitVec w) : (x <ₛ y) = (x.msb == y.msb ^^ BitVec.carry w x (~~~y) true)
-/
#guard_msgs in #check BitVec.slt_eq_not_carry

/--
Evaluate whether `t₁ <ₛ t₂`.
This is defined by computing the most significant bit of `t₁ - t₂`.
IF the `msb is 1`, then `t₁ - t₂ <s 0`, and thus `t₁ <s t₂`.

consider the cases:
  evalMsbEq | evalUlt |
  F         | F       | F (it's correct. MSBs are equal, and they are ULT)

-/
def Predicate.evalSlt (t₁ t₂ : BitStream) : BitStream :=
    (((Predicate.evalUlt t₁ t₂)) ^^^ (Predicate.evalMsbEq t₁ t₂))

open BitStream in
/--
Evaluate a term predicate `p` to the BitStream it represents,
where the predicate is `true` at index `i` if and only if the predicate,
when truncated to index `i`, is true.
-/
def Predicate.eval (p : Predicate) (vars : List BitStream) : BitStream :=
  match p with
  | .width .eq n => BitStream.falseIffEq n
  | .width .neq n => BitStream.falseIffNeq n
  | .width .lt n => BitStream.falseIffLt n
  | .width .le n => BitStream.falseIffLe n
  | .width .gt n => BitStream.falseIffGt n
  | .width .ge n => BitStream.falseIffGe n
  | lor p q => Predicate.evalLor (p.eval vars) (q.eval vars)
  | land p q => Predicate.evalLand (p.eval vars) (q.eval vars)
  | binary .eq t₁ t₂ => Predicate.evalEq (t₁.eval vars) (t₂.eval vars)
  /-
  If it is ever not equal, then we want to stay not equals for ever.
  So, if the 'a = b' returns 'false' at some index 'i', we will stay false
  for all indexes '≥ i'.
  -/
  | binary .neq t1 t2 => Predicate.evalNeq (t1.eval vars) (t2.eval vars)
  | binary .ult t₁ t₂ => Predicate.evalUlt (t₁.eval vars) (t₂.eval vars)
  | binary .ule t₁ t₂ =>
     Predicate.evalLor
       (Predicate.evalEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalUlt (t₁.eval vars) (t₂.eval vars))
  | binary .slt t₁ t₂ => Predicate.evalSlt (t₁.eval vars) (t₂.eval vars)
  | binary .sle t₁ t₂ => Predicate.evalLor
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
| .width _ _ => 0
| .binary .eq t1 t2 => max t1.arity t2.arity
| .lor p q => max p.arity q.arity
| .land p q => max p.arity q.arity
| .binary .neq t₁ t₂ => max t₁.arity t₂.arity
| .binary .ult t₁ t₂ => max t₁.arity t₂.arity
| .binary .ule t₁ t₂ => t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity)
| .binary .slt t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity))
| .binary .sle t₁ t₂ => (t₁.arity ⊔ t₂.arity ⊔ (t₁.arity ⊔ t₂.arity) ⊔ (t₁.arity ⊔ t₂.arity))

/-- Denote a predicate into a bitstream, where the ith bit tells us if it is true in the ith state -/
-- TODO: remove this from the @[simp] set.
@[simp] def Predicate.evalFin (p : Predicate) (vars : Fin (arity p) → BitStream) : BitStream :=
match p with
| .width .eq n => BitStream.falseIffEq n
| .width .neq n => BitStream.falseIffNeq n
| .width .lt n => BitStream.falseIffLt n
| .width .le n => BitStream.falseIffLe n
| .width .gt n => BitStream.falseIffGt n
| .width .ge n => BitStream.falseIffGe n
| .binary .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalEq x₁ x₂
| .binary .neq t₁ t₂  =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalNeq x₁ x₂
| .land p q =>
  -- if both `p` and `q` are logically true (i.e. the predicate is `false`),
  -- only then should we return a `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLand x₁ x₂
| .lor p q =>
  -- If either of the predicates are `false`, then result is `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor x₁ x₂
| .binary .slt p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalSlt x₁ x₂
| .binary .sle p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor (Predicate.evalSlt x₁ x₂) (Predicate.evalEq x₁ x₂)
| .binary .ult p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (Predicate.evalUlt x₁ x₂)
| .binary .ule p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor (Predicate.evalUlt x₁ x₂) (Predicate.evalEq x₁ x₂)

/-- toBitVec a Term into its underlying bitvector -/
def Term.denote (w : Nat) (t : Term) (vars : List (BitVec w)) : BitVec w :=
  match t with
  | ofNat n => BitVec.ofNat w n
  | var n => vars.getD n default
  | zero => 0#w
  | negOne => -1#w
  | one  => 1#w
  | and a b => (a.denote w vars) &&& (b.denote w vars)
  | or a b => (a.denote w vars) ||| (b.denote w vars)
  | xor a b => (a.denote w vars) ^^^ (b.denote w vars)
  | not a => ~~~ (a.denote w vars)
  | add a b => (a.denote w vars) + (b.denote w vars)
  | sub a b => (a.denote w vars) - (b.denote w vars)
  | neg a => - (a.denote w vars)
  -- | incr a => (a.denote w vars) + 1#w
  -- | decr a => (a.denote w vars) - 1#w
  | shiftL a n => (a.denote w vars) <<< n

def Predicate.denote (p : Predicate) (w : Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .width .ge k => k ≤ w -- w ≥ k
  | .width .gt k => k < w -- w > k
  | .width .le k => w ≤ k
  | .width .lt k => w < k
  | .width .neq k => w ≠ k
  | .width .eq k => w = k
  | .binary .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .binary .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars
  | .binary .sle  t₁ t₂ => ((t₁.denote w vars).sle (t₂.denote w vars)) = true
  | .binary .slt  t₁ t₂ => ((t₁.denote w vars).slt (t₂.denote w vars)) = true
  | .binary .ule  t₁ t₂ => ((t₁.denote w vars) ≤ (t₂.denote w vars))
  | .binary .ult  t₁ t₂ => (t₁.denote w vars) < (t₂.denote w vars)
