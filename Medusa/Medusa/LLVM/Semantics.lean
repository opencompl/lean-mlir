/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Lean

/- NOTE: copied and adapted from InstCombine.LLVM to be bitblastable. -/

notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

namespace LLVM

structure PoisonOr (α : Type) where
  val : α
  poisonous : Bool
deriving Inhabited, DecidableEq

instance: Monad PoisonOr where
  pure x := ⟨x, false⟩
  bind x f :=
    let y := f x.val
    ⟨y.val, x.poisonous || y.poisonous⟩

def PoisonOr.value {α : Type} (x : α) : PoisonOr α := ⟨x, false⟩ 
def PoisonOr.poison {α : Type} [Inhabited α] : PoisonOr α := ⟨default, false⟩ 

/- @[match_pattern] def poison : PoisonOr α := ⟨_, true⟩ -/
/- @[match_pattern] def value : α → PoisonOr α := (⟨some ·⟩) -/

def IntW w := PoisonOr <| BitVec w

namespace IntW

instance : Inhabited (IntW w) := by unfold IntW; infer_instance
instance : DecidableEq (IntW w) := by unfold IntW; infer_instance

end IntW

/--
The ‘and’ instruction returns the bitwise logical and of its two operands.
-/
def and? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x &&& y

def and {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  and? x' y'

/--
The ‘or’ instruction returns the bitwise logical inclusive or of its two
operands.
-/
def or? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x ||| y

structure DisjointFlag where
  disjoint : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

def or {w : Nat} (x y : IntW w)  (flag : DisjointFlag := {disjoint := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.disjoint ∧ x' &&& y' != 0 then
    .poison
  else
    or? x' y'

/--
The ‘xor’ instruction returns the bitwise logical exclusive or of its two
operands.  The xor is used to implement the “one’s complement” operation, which
is the “~” operator in C.
-/
def xor? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x ^^^ y

def xor {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  xor? x' y'

/--
The value produced is the integer sum of the two operands.
If the sum has unsigned overflow, the result returned is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
def add? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x + y

structure NoWrapFlags where
  nsw : Bool := false
  nuw : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

def add {w : Nat} (x y : IntW w) (flags : NoWrapFlags := {nsw := false , nuw := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flags.nsw ∧ BitVec.saddOverflow x' y' then
    .poison
  else if flags.nuw ∧ BitVec.uaddOverflow x' y' then
    .poison
  else
    add? x' y'

/--
The value produced is the integer difference of the two operands.
If the difference has unsigned overflow, the result returned is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
def sub? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x - y

def sub {w : Nat} (x y : IntW w) (flags : NoWrapFlags := {nsw := false , nuw := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flags.nsw ∧ BitVec.ssubOverflow x' y' then
    .poison
  else if flags.nuw ∧ BitVec.usubOverflow x' y' then
    .poison
  else
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
def mul? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x * y

def mul {w : Nat} (x y : IntW w) (flags : NoWrapFlags := {nsw := false , nuw := false}) : IntW w := do
  let x' ← x
  let y' ← y

  if flags.nsw ∧ BitVec.smulOverflow x' y' then
    .poison
  else if flags.nuw ∧ BitVec.umulOverflow x' y' then
    .poison
  else
    mul? x' y'

/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
def udiv? {w : Nat} (x y : BitVec w) : IntW w :=
  if y = 0 then
    .poison
  else
    .value <| x / y

structure ExactFlag where
  exact : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

def udiv {w : Nat} (x y : IntW w) (flag : ExactFlag := {exact := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.exact ∧ x'.umod y' ≠ 0 then
    .poison
  else
    udiv? x' y'

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
-- is no magnitude to overflow.
def sdiv? {w : Nat} (x y : BitVec w) : IntW w :=
  if y == 0 || (w != 1 && x == (BitVec.intMin w) && y == -1) then
    .poison
  else
    .value (x.sdiv y)

def sdiv {w : Nat} (x y : IntW w) (flag : ExactFlag := {exact := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.exact ∧ x'.smod y' ≠ 0 then
    .poison
  else
    sdiv? x' y'

/--
This instruction returns the unsigned integer remainder of a division. This instruction always performs an unsigned division to get the remainder.
Note that unsigned integer remainder and signed integer remainder are distinct operations; for signed integer remainder, use ‘srem’.
Taking the remainder of a division by zero is undefined behavior.
-/
def urem? {w : Nat} (x y : BitVec w) : IntW w :=
  if y = 0 then
    .poison
  else
    .value <| x % y

def urem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  urem? x' y'

def _root_.Int.rem (x y : Int) : Int :=
  if x ≥ 0 then (x % y) else ((x % y) - y.natAbs)

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
def srem? {w : Nat} (x y : BitVec w) : IntW w :=
  if y == 0 || (w != 1 && x == (BitVec.intMin w) && y == -1) then
    .poison
  else
    .value <| BitVec.srem x y

def srem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  srem? x' y'

def sshr (a : BitVec n) (s : Nat) := BitVec.sshiftRight a s

/--
Shift left instruction.
The value produced is op1 * 2^op2 mod 2n, where n is the width of the result.
If op2 is (statically or dynamically) equal to or larger than the number of
bits in op1, this instruction returns a poison value.
-/
def shl? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1 <<< op2)


def shl {w : Nat} (x y : IntW w) (flags : NoWrapFlags := {nsw := false , nuw := false}) : IntW w := do
  let x' ← x
  let y' ← y
    -- "If the nsw keyword is present, then the shift produces a poison value if it shifts out any bits that disagree with the resultant sign bit."
  if flags.nsw ∧ ((x' <<< y').sshiftRight'  y' ≠ x') then
    .poison
  else if flags.nuw ∧ ((x' <<< y') >>> y' ≠ x') then
    .poison
  else
    shl? x' y'

/--
This instruction always performs a logical shift right operation.
The most significant bits of the result will be filled with zero bits after
the shift.

If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
this instruction returns a poison value.

Corresponds to `Std.BitVec.ushiftRight` in the `value` case.
-/
def lshr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1 >>> op2)

def lshr {w : Nat} (x y : IntW w) (flag : ExactFlag := {exact := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.exact ∧(x' >>> y') <<< y' ≠ x' then
    .poison
  else
    lshr? x' y'

/--
This instruction always performs an arithmetic shift right operation,
The most significant bits of the result will be filled with the sign bit of op1.

If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
this instruction returns a poison value.

Corresponds to `Std.BitVec.sshiftRight` in the `value` case.
-/
def ashr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1.sshiftRight' op2)

def ashr {w : Nat} (x y : IntW w) (flag : ExactFlag := {exact := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.exact ∧ (x' >>> y') <<< y' ≠ x' then
    .poison
  else
    ashr? x' y'

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def select {w : Nat} (c? : IntW 1) (x? y? : IntW w ) : IntW w := do
  let c ← c?
  if c = 1#1 then x? else y?

inductive IntPred where
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
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

instance : ToString IntPred where
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
def icmp' {w : Nat} (c : IntPred) (x y : BitVec w) : Bool :=
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
Wrapper around `icmp` (this cannot become `poison` on its own).

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
def icmp? {w : Nat} (c : IntPred) (x y : BitVec w) : IntW 1 :=
  .value <| .ofBool (icmp' c x y) 

def icmp {w : Nat} (c : IntPred) (x y : IntW w) : IntW 1 := do
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
def const? (w : Nat) (i : Int): IntW w :=
  .value <| BitVec.ofInt w i

def not? {w : Nat} (x : BitVec w) : IntW w := do
  .value (~~~x)

def not {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  not? x'

def neg? {w : Nat} (x : BitVec w) : IntW w := do
  .value <| (-.) x

def neg {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  neg? x'


def trunc? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.truncate w' x)

def trunc {w: Nat} (w': Nat) (x: IntW w) (noWrapFlags : NoWrapFlags := {nsw := false , nuw := false}) : IntW w' := do
  let x' <- x
  if noWrapFlags.nsw ∧ ((x'.truncate w').signExtend w ≠ x') then
    .poison
  else if noWrapFlags.nuw ∧ ((x'.truncate w').zeroExtend w ≠ x') then
    .poison
  else
    trunc? w' x'

structure NonNegFlag where
  nneg : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

def zext? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.zeroExtend w' x)

def zext {w: Nat} (w': Nat) (x: IntW w) (flag : NonNegFlag := {nneg := false}) : IntW w' := do
  let x' <- x
  if flag.nneg ∧ x'.msb then
    .poison
  else
    zext? w' x'

def sext? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.signExtend w' x)

def sext {w: Nat} (w': Nat) (x: IntW w) : IntW w' := do
  let x' <- x
  sext? w' x'

end LLVM
