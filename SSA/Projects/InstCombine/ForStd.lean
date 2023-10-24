import Std.Data.BitVec

open Std

namespace Std.BitVec

def ofBool : Bool -> Std.BitVec 1
 | true   => 1
 | false  => 0

notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y
notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x

notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y
notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def select {w : Nat} (c : BitVec 1) (x y : BitVec w) : BitVec w :=
  cond (c.toNat != 0) x y

-- A lot of this should probably go to a differet file here and not Mathlib
inductive Refinement {α : Type u} : Option α → Option α → Prop
  | bothSome {x y : α } : x = y → Refinement (some x) (some y)
  | noneAny {x? : Option α} : Refinement none x?

@[simp]
theorem Refinement.some_some {α : Type u} {x y : α} :
  Refinement (some x) (some y) ↔ x = y :=
  ⟨by intro h; cases h; assumption, Refinement.bothSome⟩

@[simp]
theorem Refinement.none_left :
  Refinement none x? := .noneAny

namespace Refinement

@[simp]
theorem refl {α: Type u} : ∀ x : Option α, Refinement x x := by
  intro x ; cases x
  apply Refinement.noneAny
  apply Refinement.bothSome; rfl

theorem trans {α : Type u} : ∀ x y z : Option α, Refinement x y → Refinement y z → Refinement x z := by
  intro x y z h₁ h₂
  cases h₁ <;> cases h₂ <;> try { apply Refinement.noneAny } ; try {apply Refinement.bothSome; assumption}
  rename_i x y hxy y h
  rw [hxy, h]; apply refl

instance {α : Type u} [DecidableEq α] : DecidableRel (@Refinement α) := by
  intro x y
  cases x <;> cases y
  { apply isTrue; exact Refinement.noneAny}
  { apply isTrue; exact Refinement.noneAny }
  { apply isFalse; intro h; cases h }
  { rename_i val val'
    cases (decEq val val')
    { apply isFalse; intro h; cases h; contradiction }
    { apply isTrue; apply Refinement.bothSome; assumption }
  }

end Refinement

infix:50 (priority:=low) " ⊑ " => Refinement

/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
def udiv? {w : Nat} (x y : BitVec w) : Option $ BitVec w :=
  match y.toNat with
    | 0 => none
    | _ => some $ BitVec.ofNat w (x.toNat / y.toNat)

/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.
-/
def sdiv? {w : Nat} (x y : BitVec w) : Option $ BitVec w :=
  if y.toInt = 0
  then none
  else
    let div := (x.toInt / y.toInt)
    if div < Int.ofNat (2^w)
      then some $ BitVec.ofInt w div
      else none

/--
This instruction returns the unsigned integer remainder of a division. This instruction always performs an unsigned division to get the remainder.
Note that unsigned integer remainder and signed integer remainder are distinct operations; for signed integer remainder, use ‘srem’.
Taking the remainder of a division by zero is undefined behavior.
-/
def urem? {w : Nat} (x y : BitVec w) : Option $ BitVec w :=
  if y.toNat = 0
  then none
  else some $ BitVec.ofNat w (x.toNat % y.toNat)

def _root_.Int.rem (x y : Int) : Int :=
  if x ≥ 0 then (x % y) else ((x % y) - y.natAbs)

-- TODO: prove this to make sure it's the right implementation!
theorem _root_.Int.rem_sign_dividend :
  ∀ x y, Int.rem x y < 0 ↔ x < 0 :=  by sorry

/--
This instruction returns the remainder of a division (where the result is either zero or has the same sign as the dividend, op1),
not the modulo operator (where the result is either zero or has the same sign as the divisor, op2) of a value.
For more information about the difference, see The Math Forum.
For a table of how this is implemented in various languages, please see Wikipedia: modulo operation.
Note that signed integer remainder and unsigned integer remainder are distinct operations; for unsigned integer remainder, use ‘urem’.
Taking the remainder of a division by zero is undefined behavior.
For vectors, if any element of the divisor is zero, the operation has undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example,
by taking the remainder of a 32-bit division of -2147483648 by -1.
(The remainder doesn’t actually overflow, but this rule lets srem be implemented using instructions that return both the result
of the division and the remainder.)
-/
def srem? {w : Nat} (x y : BitVec w) : Option $ BitVec w :=
  if y.toInt = 0
  then none
  else
    let div := (x.toInt / y.toInt)
    if div < Int.ofNat (2^w)
      then some $ BitVec.ofInt w (x.toInt.rem y.toInt)
      else none

instance : Coe Bool (BitVec 1) := ⟨ofBool⟩

instance decPropToBitvec1 (p : Prop) [Decidable p] : CoeDep Prop p (BitVec 1) where
  coe := ofBool $ decide p

def sshr (a : BitVec n) (s : Nat) := BitVec.sshiftRight a s
