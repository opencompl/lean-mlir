/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Frontend.Defs

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


/--
Evaluate a term `t` to the BitStream it represents,
given a value for the free variables in `t`.

Note that we don't keep track of how many free variable occur in `t`,
so eval requires us to give a value for each possible variable.
-/
def BTerm.eval (t : BTerm) (vars : List BitStream) : BitStream :=
  match t with
  | tru => BitStream.negOne
  | fals => BitStream.zero
  | xor a b => a.eval vars ^^^ b.eval vars
  | msb x => x.eval vars
  | var n => vars.getD n default

def BTerm.evalFin (t : BTerm) (vars : Fin (arity t) → BitStream) : BitStream :=
  match t with
  | tru => BitStream.negOne
  | fals => BitStream.zero
  | xor a b =>
    let x₁ := a.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := b.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    x₁ ^^^ x₂
  | msb x => x.evalFin vars
  | var n => vars (Fin.last n)

/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalBitstreamEq (t₁ t₂ : BitStream) : BitStream := (t₁ ^^^ t₂) |>.scanOr

/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalBitstreamNeq (t₁ t₂ : BitStream) : BitStream := (t₁.nxor t₂) |>.scanAnd

/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalBVEq (t₁ t₂ : BitStream) : BitStream := (t₁ ^^^ t₂).concat false |>.scanOr
/--
If they have been equal so far, then `BitStream.nxor t₁ t₂`.scanAnd will be 1.
Start by assuming that they are not (not equal) i.e. that they are equal, and the
   initial value of the preciate is false / `1`.
If their values ever differ, then we know that we will have `a[i] == b[i]` to be `false`.
From this point onward, they will always disagree, and thus the predicate should become `0`.
-/
def Predicate.evalBVNeq (t₁ t₂ : BitStream) : BitStream := (t₁.nxor t₂).concat true |>.scanAnd

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
info: BitVec.slt_eq_not_carry {w : ℕ} {x y : BitVec w} : (x <ₛ y) = (x.msb == y.msb ^^ BitVec.carry w x (~~~y) true)
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
  /- boolean operations. -/
  | boolBinary .eq t₁ t₂ => Predicate.evalBitstreamEq (t₁.eval vars) (t₂.eval vars)
  | boolBinary .neq t₁ t₂ => Predicate.evalBitstreamNeq (t₁.eval vars) (t₂.eval vars)
  /- bitstream operations. -/
  | binary .eq t₁ t₂ => Predicate.evalBVEq (t₁.eval vars) (t₂.eval vars)
  /-
  If it is ever not equal, then we want to stay not equals for ever.
  So, if the 'a = b' returns 'false' at some index 'i', we will stay false
  for all indexes '≥ i'.
  -/
  | binary .neq t1 t2 => Predicate.evalBVNeq (t1.eval vars) (t2.eval vars)
  | binary .ult t₁ t₂ => Predicate.evalUlt (t₁.eval vars) (t₂.eval vars)
  | binary .ule t₁ t₂ =>
     Predicate.evalLor
       (Predicate.evalBVEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalUlt (t₁.eval vars) (t₂.eval vars))
  | binary .slt t₁ t₂ => Predicate.evalSlt (t₁.eval vars) (t₂.eval vars)
  | binary .sle t₁ t₂ => Predicate.evalLor
       (Predicate.evalBVEq (t₁.eval vars) (t₂.eval vars))
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
| .boolBinary .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalBitstreamEq x₁ x₂
| .boolBinary .neq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalBitstreamNeq x₁ x₂
    -- ~~~ (x₁ ^^^ x₂)
| .binary .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalBVEq x₁ x₂
| .binary .neq t₁ t₂  =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalBVNeq x₁ x₂
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
  Predicate.evalLor (Predicate.evalSlt x₁ x₂) (Predicate.evalBVEq x₁ x₂)
| .binary .ult p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (Predicate.evalUlt x₁ x₂)
| .binary .ule p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor (Predicate.evalUlt x₁ x₂) (Predicate.evalBVEq x₁ x₂)
