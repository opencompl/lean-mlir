/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.ForStd
import Mathlib.Tactic.Cases
import Mathlib.Tactic.SplitIfs
import Mathlib.Tactic.Tauto
import Aesop
import SSA.Projects.InstCombine.LLVM.SimpSet


namespace LLVM


def IntW w := Option <| BitVec w

/--
The ‘and’ instruction returns the bitwise logical and of its two operands.
-/
@[simp_llvm]
def and? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x &&& y

@[simp_llvm_option]
theorem and?_eq : LLVM.and? a b  = .some (BitVec.and a b) := rfl

@[simp_llvm_option]
def and {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  and? x' y'

/--
The ‘or’ instruction returns the bitwise logical inclusive or of its two
operands.
-/
@[simp_llvm]
def or? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x ||| y

@[simp_llvm_option]
theorem or?_eq : LLVM.or? a b  = .some (BitVec.or a b) := rfl

@[simp_llvm_option]
def or {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  or? x' y'

/--
The ‘xor’ instruction returns the bitwise logical exclusive or of its two
operands.  The xor is used to implement the “one’s complement” operation, which
is the “~” operator in C.
-/
@[simp_llvm]
def xor? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x ^^^ y

@[simp_llvm_option]
theorem xor?_eq : LLVM.xor? a b  = .some (BitVec.xor a b) := rfl

@[simp_llvm_option]
def xor {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  xor? x' y'

/--
The value produced is the integer sum of the two operands.
If the sum has unsigned overflow, the result returned is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
@[simp_llvm]
def add? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x + y

@[simp_llvm_option]
theorem add?_eq : LLVM.add? a b  = .some (BitVec.add a b) := rfl

@[simp_llvm_option]
def add {w : Nat} (x y : IntW w) (nswnuw : Bool × Bool := ⟨ false , false ⟩ ) : IntW w := do
  let x' ← x
  let y' ← y
  let nsw := nswnuw.1
  let nuw := nswnuw.2
  if (nsw ∧  (x'.toInt + y'.toInt) < -(2^(w-1)) ∧ (x'.toInt + y'.toInt) ≥ 2^w) ∨ (nuw ∧  (x'.toNat + y'.toNat) ≥ 2^w) then
    none
  else
    add? x' y'

set_option allowUnsafeReducibility true
@[simp, reducible]
theorem add_reduce (x y : IntW w) :  add x y = match x , y with
  | .none , _ => .none
  | _ , .none => none
  | .some a , .some b  => .some (a + b) := by
  rcases x
  all_goals (cases y)
  all_goals (try simp ; try rfl)
/--
The value produced is the integer difference of the two operands.
If the difference has unsigned overflow, the result returned is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
@[simp_llvm]
def sub? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x - y

@[simp_llvm_option]
theorem sub?_eq : LLVM.sub? a b  = .some (BitVec.sub a b) := rfl

@[simp_llvm_option]
def sub {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  sub? x' y'

/--
The value produced is the integer product of the two operands.
If the result of the multiplication has unsigned overflow, the result returned
is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, and the result
is the same width as the operands, this instruction returns the correct
result for both signed and unsigned integers.

If a full product (e.g. i32 * i32 -> i64) is needed, the operands should be
sign-extended or zero-extended as appropriate to the width of the full product.
-/
@[simp_llvm]
def mul? {w : Nat} (x y : BitVec w) : IntW w :=
  pure <| x * y

@[simp_llvm_option]
theorem mul?_eq : LLVM.mul? a b  = .some (BitVec.mul a b) := rfl

@[simp_llvm_option]
def mul {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  mul? x' y'

/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
@[simp_llvm]
def udiv? {w : Nat} (x y : BitVec w) : IntW w :=
  match y.toNat with
    | 0 => none
    | _ => pure <| BitVec.ofInt w (x.toNat / y.toNat)

@[simp_llvm_option]
def udiv {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  udiv? x' y'

def intMin (w : Nat) : BitVec w :=
  - BitVec.ofNat w (2^(w - 1))

def intMax (w : Nat) : BitVec w := intMin w - 1

theorem intMin_minus_one {w : Nat} : (intMin w - 1) = intMax w := rfl

/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.

Notes
-----

The rounding is round to zero, not round to -infty.
at width 1, -1 / -1 is considered -1
at width 2, -4 / -1 is considered overflow!

-/
-- only way overflow can happen is (INT_MIN / -1).
-- but we do not consider overflow when `w=1`, because `w=1` only has a sign bit, so there
-- is no magniture to overflow.
@[simp_llvm]
def sdiv? {w : Nat} (x y : BitVec w) : IntW w :=
  if y == 0 || (w != 1 && x == (intMin w) && y == -1)
  then .none
  else pure (BitVec.sdiv x y)

theorem sdiv?_denom_zero_eq_none {w : Nat} (x : BitVec w) :
  LLVM.sdiv? x 0 = none := by
  simp [LLVM.sdiv?, BitVec.sdiv]

theorem sdiv?_eq_pure_of_neq_allOnes {x y : BitVec w} (hy : y ≠ 0)
    (hx : LLVM.intMin w ≠ x) : LLVM.sdiv? x y = pure (BitVec.sdiv x y) := by
  simp [LLVM.sdiv?]
  tauto

@[simp_llvm_option]
def sdiv {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  sdiv? x' y'

-- Probably not a Mathlib worthy name, not sure how you'd mathlibify the precondition
@[simp_llvm]
theorem sdiv?_eq_div_if {w : Nat} {x y : BitVec w} :
    sdiv? x y =
    if (y = 0) ∨ ((w ≠ 1) ∧ (x = intMin w) ∧ (y = -1))
      then none
    else pure <| BitVec.sdiv x y
    := by
  simp [sdiv?]; split_ifs <;> try tauto

/--
This instruction returns the unsigned integer remainder of a division. This instruction always performs an unsigned division to get the remainder.
Note that unsigned integer remainder and signed integer remainder are distinct operations; for signed integer remainder, use ‘srem’.
Taking the remainder of a division by zero is undefined behavior.
-/
@[simp_llvm]
def urem? {w : Nat} (x y : BitVec w) : IntW w :=
  if y.toNat = 0
  then none
  else pure <| BitVec.ofNat w (x.toNat % y.toNat)

@[simp_llvm_option]
def urem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  urem? x' y'

@[simp_llvm]
def _root_.Int.rem (x y : Int) : Int :=
  if x ≥ 0 then (x % y) else ((x % y) - y.natAbs)

theorem _root_.Int.rem_sign_dividend :
  ∀ x y, Int.rem x y < 0 ↔ x < 0 :=  by
  intro x y
  apply Iff.intro
  <;> simp [Int.rem]; split_ifs <;> by_cases (y = 0) <;> rename_i hx hy
  · rw [hy, Int.emod_zero]; tauto
  · intro hcontra; exfalso
    apply (Int.not_le.2 hcontra)
    exact Int.emod_nonneg x hy
  · rw [hy, Int.emod_zero]; simp [Int.natAbs]
  · rw [Int.not_le] at hx; intro _; exact hx
  · intro hx
    have hnx := Int.not_le.2 hx
    simp [hnx]
    by_cases (y = 0)
    case pos hy => simp[hy]; exact hx
    case neg hy =>
      suffices hynat : x % y < ↑y.natAbs by omega
      by_cases (0 < y)
      case pos hypos =>
        have hyleq : 0 ≤ y := by omega
        rw [← Int.eq_natAbs_of_zero_le hyleq]; exact Int.emod_lt_of_pos x hypos
      case neg hynonneg =>
        have hmyneg : 0 < -y := by omega
        have hmynnonpos : 0 ≤ -y := by omega
        rw [← Int.emod_neg, ← Int.natAbs_neg]
        rw [← Int.eq_natAbs_of_zero_le hmynnonpos]; exact Int.emod_lt_of_pos x hmyneg

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

The fundamental equation of div/rem is: x = (x/y) * y + x%y
=> x%y = x - (x/y)
We use this equation to define srem.
-/
@[simp_llvm]
def srem? {w : Nat} (x y : BitVec w) : IntW w :=
  (sdiv? x y).map (fun div => x - div * y)

@[simp_llvm_option]
def srem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  srem? x' y'

@[simp_llvm]
def sshr (a : BitVec n) (s : Nat) := BitVec.sshiftRight a s

/--
Shift left instruction.
The value produced is op1 * 2^op2 mod 2n, where n is the width of the result.
If op2 is (statically or dynamically) equal to or larger than the number of
bits in op1, this instruction returns a poison value.
-/
@[simp_llvm]
def shl? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  let bits := op2.toNat -- should this be toInt?
  if bits >= n then .none
  else pure (op1 <<< op2)


@[simp_llvm_option]
def shl {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  shl? x' y'

/--
This instruction always performs a logical shift right operation.
The most significant bits of the result will be filled with zero bits after
the shift.

If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
this instruction returns a poison value.

Corresponds to `Std.BitVec.ushiftRight` in the `pure` case.
-/
@[simp_llvm]
def lshr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  let bits := op2.toNat -- should this be toInt?
  if bits >= n then .none
  else pure (op1 >>> op2)

@[simp_llvm_option]
def lshr {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  lshr? x' y'

/--
This instruction always performs an arithmetic shift right operation,
The most significant bits of the result will be filled with the sign bit of op1.

If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
this instruction returns a poison value.

Corresponds to `Std.BitVec.sshiftRight` in the `pure` case.
-/
@[simp_llvm]
def ashr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  let bits := op2.toNat -- should this be toInt?
  if bits >= n then .none
  else pure (op1 >>>ₛ op2)

@[simp_llvm_option]
def ashr {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  ashr? x' y'

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.

 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
@[simp_llvm_option]
def select {w : Nat} (c? : IntW 1) (x? y? : IntW w ) : IntW w :=
  match c? with
  | none => none
  | some true => x?
  | some false => y?

inductive IntPredicate where
  | eq
  | ne
  | ugt
  | uge
  | ult
  | ule
  | sgt
  | sge
  | slt
  | sle
deriving Inhabited, DecidableEq, Repr

instance : ToString IntPredicate where
  toString
  | .eq => "eq"
  | .ne => "ne"
  | .ugt => "ugt"
  | .uge => "uge"
  | .ult => "ult"
  | .ule => "ule"
  | .sgt => "sgt"
  | .sge => "sge"
  | .slt => "slt"
  | .sle => "sle"


/--
The ‘icmp’ instruction takes three operands.
The first operand is the condition code indicating the kind of comparison to perform. It is not a value, just a keyword.
The possible condition codes are:

  - eq: equal
  - ne: not equal
  - ugt: unsigned greater than
  - uge: unsigned greater or equal
  - ult: unsigned less than
  - ule: unsigned less or equal
  - sgt: signed greater than
  - sge: signed greater or equal
  - slt: signed less than
  - sle: signed less or equal

The remaining two arguments must be integer. They must also be identical types.
-/
@[simp_llvm]
def icmp' {w : Nat} (c : IntPredicate) (x y : BitVec w) : Bool :=
  match c with
    | .eq => (x == y)
    | .ne => (x != y)
    | .sgt => (x >ₛ y)
    | .sge => (x ≥ₛ y)
    | .slt => (x <ₛ y)
    | .sle => (x ≤ₛ y)
    | .ugt => (x >ᵤ y)
    | .uge => (x ≥ᵤ y)
    | .ult => (x <ᵤ y)
    | .ule => (x ≤ᵤ y)


/--
Wrapper around `icmp` (this cannot become `none` on its own).

The ‘icmp’ instruction takes three operands.
The first operand is the condition code indicating the kind of comparison to perform. It is not a value, just a keyword.
The possible condition codes are:

  - eq: equal
  - ne: not equal
  - ugt: unsigned greater than
  - uge: unsigned greater or equal
  - ult: unsigned less than
  - ule: unsigned less or equal
  - sgt: signed greater than
  - sge: signed greater or equal
  - slt: signed less than
  - sle: signed less or equal

The remaining two arguments must be integer. They must also be identical types.
-/
@[simp_llvm]
def icmp? {w : Nat} (c : IntPredicate) (x y : BitVec w) : IntW 1 :=
  pure ↑(icmp' c x y)

@[simp]
theorem icmp?_ult_eq {w : Nat} {a b : BitVec w} :
  icmp? .ult a b =  Option.some (BitVec.ofBool (a <ᵤ b)) := rfl

@[simp]
theorem icmp?_slt_eq {w : Nat} {a b : BitVec w} :
  icmp? .slt a b =  Option.some (BitVec.ofBool (a <ₛ b)) := rfl

@[simp]
theorem icmp?_sgt_eq {w : Nat} {a b : BitVec w} :
  icmp? .sgt a b =  Option.some (BitVec.ofBool (a >ₛ b)) := rfl

@[simp_llvm_option]
def icmp {w : Nat} (c : IntPredicate) (x y : IntW w) : IntW 1 := do
  let x' ← x
  let y' ← y
  icmp? c x' y'

/--
Unlike LLVM IR, MLIR does not have first-class constant values.
Therefore, all constants must be created as SSA values before being used in other
operations. llvm.mlir.constant creates such values for scalars and vectors.
It has a mandatory value attribute, which must be an integer
(currently the only supported type in these semantics).

The type of the attribute is one of the corresponding MLIR builtin types.
The operation produces a new SSA value of the specified LLVM IR dialect type.
The type of that value must correspond to the attribute type converted to LLVM IR.

This interprets the value as a signed bitvector.
If the bitwidth is not enough it will be reduced, returning
the value `(2^w + (i mod 2^w)) mod 2^w`.

TODO: double-check that truncating works the same as MLIR (signedness, overflow, etc)
-/
@[simp_llvm]
def const? (i : Int): IntW w :=
  pure <| BitVec.ofInt w i

@[simp_llvm_option]
theorem LLVM.const?_eq : LLVM.const? i = .some (BitVec.ofInt w i) := rfl

@[simp_llvm]
def not? {w : Nat} (x : BitVec w) : IntW w := do
  pure (~~~x)

@[simp_llvm_option]
theorem LLVM.not?_eq : LLVM.not? a = .some (BitVec.not a) := rfl

@[simp_llvm_option]
def not {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  not? x'

@[simp_llvm]
def neg? {w : Nat} (x : BitVec w) : IntW w := do
  pure <| (-.) x

@[simp_llvm_option]
theorem LLVM.neg?_eq : LLVM.neg? a = .some (BitVec.neg a) := rfl

@[simp_llvm_option]
def neg {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  neg? x'

end LLVM
