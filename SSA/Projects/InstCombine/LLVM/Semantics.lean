/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Tactic.SimpSet
import SSA.Core.Util.Poison
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.LLVM.SimpSet

--TODO: are any of these imports actually needed in this file?
import Mathlib.Tactic.Cases
import Mathlib.Tactic.SplitIfs
import Mathlib.Tactic.Tauto
import Aesop


namespace LLVM

def IntW w := PoisonOr <| BitVec w

namespace IntW

scoped instance : Refinement (BitVec w) := .ofEq
instance : HRefinement (IntW w) (IntW w) :=
  inferInstanceAs <| HRefinement (PoisonOr _) (PoisonOr _)

@[simp_llvm_poison]
theorem isRefinedBy_iff (x y : LLVM.IntW w) :
    x ⊑ y ↔ @HRefinement.IsRefinedBy (PoisonOr _) (PoisonOr _) _ x y := by
  rfl

/-- Under the scoped instance above, refinement on BitVecs is just equality -/
@[simp_llvm_poison]
theorem bitvec_isRefinedBy_iff (x y : BitVec w) :
    x ⊑ y ↔ x = y := by rfl

/-- Refinement of `IntW`s is reflexive -/
@[simp_llvm_poison]
theorem isRefinedBy_refl (x : PoisonOr (BitVec w)) : x ⊑ x :=
  PoisonOr.isRefinedBy_refl (fun _ => rfl) x

end IntW

open PoisonOr (value poison)

/--
The ‘and’ instruction returns the bitwise logical and of its two operands.
-/
@[simp_llvm_ops]
def and? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x &&& y

@[simp_llvm_ops]
def and {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  and? x' y'

/--
The ‘or’ instruction returns the bitwise logical inclusive or of its two
operands.
-/
@[simp_llvm_ops]
def or? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x ||| y

structure DisjointFlag where
  disjoint : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def xor? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x ^^^ y

@[simp_llvm_ops]
def xor {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  xor? x' y'

/--
The value produced is the integer sum of the two operands.
If the sum has unsigned overflow, the result returned is the mathematical result modulo 2n, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
@[simp_llvm_ops]
def add? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x + y

structure NoWrapFlags where
  nsw : Bool := false
  nuw : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def sub? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x - y

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def mul? {w : Nat} (x y : BitVec w) : IntW w :=
  .value <| x * y

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def udiv? {w : Nat} (x y : BitVec w) : IntW w :=
  if y = 0 then
    .poison
  else
    .value <| x / y

structure ExactFlag where
  exact : Bool := false
  deriving Repr, DecidableEq, Lean.ToExpr

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def sdiv? {w : Nat} (x y : BitVec w) : IntW w :=
  if y == 0 || (w != 1 && x == (BitVec.intMin w) && y == -1) then
    .poison
  else
    .value (x.sdiv y)

theorem sdiv?_denom_zero_eq_poison {w : Nat} (x : BitVec w) :
  LLVM.sdiv? x 0 = .poison := by
  simp [LLVM.sdiv?, BitVec.sdiv]

theorem sdiv?_eq_value_of_neq_allOnes {x y : BitVec w} (hy : y ≠ 0)
    (hx : BitVec.intMin w ≠ x) : LLVM.sdiv? x y = .value (BitVec.sdiv x y) := by
  simp [LLVM.sdiv?]
  tauto

@[simp_llvm_ops]
def sdiv {w : Nat} (x y : IntW w) (flag : ExactFlag := {exact := false}) : IntW w := do
  let x' ← x
  let y' ← y
  if flag.exact ∧ x'.smod y' ≠ 0 then
    .poison
  else
    sdiv? x' y'

-- Probably not a Mathlib worthy name, not sure how you'd mathlibify the precondition
-- @[simp_llvm_ops] TODO: do we need this lemma?
theorem sdiv?_eq_div_if {w : Nat} {x y : BitVec w} :
    sdiv? x y =
    if (y = 0) ∨ ((w ≠ 1) ∧ (x = BitVec.intMin w) ∧ (y = -1))
      then .poison
    else .value <| BitVec.sdiv x y
    := by
  simp [sdiv?]; split_ifs <;> try tauto

/--
This instruction returns the unsigned integer remainder of a division. This instruction always performs an unsigned division to get the remainder.
Note that unsigned integer remainder and signed integer remainder are distinct operations; for signed integer remainder, use ‘srem’.
Taking the remainder of a division by zero is undefined behavior.
-/
@[simp_llvm_ops]
def urem? {w : Nat} (x y : BitVec w) : IntW w :=
  if y = 0 then
    .poison
  else
    .value <| x % y

@[simp_llvm_ops]
def urem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  urem? x' y'

@[simp_llvm_ops]
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
        rw [← Int.eq_natAbs_of_nonneg hyleq]; exact Int.emod_lt_of_pos x hypos
      case neg hynonneg =>
        have hmyneg : 0 < -y := by omega
        have hmynnonpos : 0 ≤ -y := by omega
        rw [← Int.emod_neg, ← Int.natAbs_neg]
        rw [← Int.eq_natAbs_of_nonneg hmynnonpos]; exact Int.emod_lt_of_pos x hmyneg

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
@[simp_llvm_ops]
def srem? {w : Nat} (x y : BitVec w) : IntW w :=
  if y == 0 || (w != 1 && x == (BitVec.intMin w) && y == -1) then
    .poison
  else
    .value <| BitVec.srem x y

@[simp_llvm_ops]
def srem {w : Nat} (x y : IntW w) : IntW w := do
  let x' ← x
  let y' ← y
  srem? x' y'

@[simp_llvm_ops]
def sshr (a : BitVec n) (s : Nat) := BitVec.sshiftRight a s

/--
Shift left instruction.
The value produced is op1 * 2^op2 mod 2n, where n is the width of the result.
If op2 is (statically or dynamically) equal to or larger than the number of
bits in op1, this instruction returns a poison value.
-/
@[simp_llvm_ops]
def shl? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1 <<< op2)


@[simp_llvm_ops]
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
@[simp_llvm_ops]
def lshr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1 >>> op2)

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def ashr? {n} (op1 : BitVec n) (op2 : BitVec n) : IntW n :=
  if op2 >= n
  then .poison
  else .value (op1.sshiftRight' op2)

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def select {w : Nat} (c? : IntW 1) (x? y? : IntW w ) : IntW w := do
  let c ← c?
  if c = 1#1 then x? else y?

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
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

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
@[simp_llvm_ops]
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
@[simp_llvm_ops]
def icmp? {w : Nat} (c : IntPredicate) (x y : BitVec w) : IntW 1 :=
  .value ↑(icmp' c x y)

@[simp]
theorem icmp?_ult_eq {w : Nat} {a b : BitVec w} :
  icmp? .ult a b =  .value (BitVec.ofBool (a <ᵤ b)) := rfl

@[simp]
theorem icmp?_slt_eq {w : Nat} {a b : BitVec w} :
  icmp? .slt a b =  .value (BitVec.ofBool (a <ₛ b)) := rfl

@[simp]
theorem icmp?_sgt_eq {w : Nat} {a b : BitVec w} :
  icmp? .sgt a b =  .value (BitVec.ofBool (a >ₛ b)) := rfl

@[simp_llvm_ops]
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
@[simp_llvm_ops]
def const? (w : Nat) (i : Int): IntW w :=
  .value <| BitVec.ofInt w i

@[simp_llvm_ops]
def not {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  .value (~~~x')

@[simp_llvm_ops]
def neg {w : Nat} (x : IntW w) : IntW w := do
  let x' ← x
  .value <| -x'


@[simp_llvm_ops]
def trunc? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.truncate w' x)

@[simp_llvm_ops]
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

@[simp_llvm_ops]
def zext? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.zeroExtend w' x)

@[simp_llvm_ops]
def zext {w: Nat} (w': Nat) (x: IntW w) (flag : NonNegFlag := {nneg := false}) : IntW w' := do
  let x' <- x
  if flag.nneg ∧ x'.msb then
    .poison
  else
    zext? w' x'

@[simp_llvm_ops]
def sext? {w: Nat} (w': Nat) (x: BitVec w) : IntW w' := do
  .value <| (BitVec.signExtend w' x)

@[simp_llvm_ops]
def sext {w: Nat} (w': Nat) (x: IntW w) : IntW w' := do
  let x' <- x
  sext? w' x'



#exit

/-! ## `PoisonOr.ofParts` lemmas-/
section OfParts
open PoisonOr
variable {xPoison yPoison : Bool} {x y : BitVec w}


theorem ofParts_and :
    LLVM.and (ofParts xPoison x) (ofParts yPoison y)
    = ofParts (xPoison || yPoison) (x &&& y) := by
  rw [← ofParts_isPoison_getValue (and ..)]
  simp only [and, and?, isPoison_ofParts_bind, isPoison_value, Bool.or_false]
  rw [ofParts_eq_iff]
  and_intros
  · rfl
  · simp only [Bool.or_eq_false_iff, and_imp]
    repeat rintro rfl
    simp



theorem ofParts_add {flags} :
    LLVM.add (ofParts xPoison x) (ofParts yPoison y) flags
    = ofParts (
        xPoison || yPoison
        || flags.nsw && BitVec.saddOverflow x y
        || flags.nuw && BitVec.uaddOverflow x y) (x + y) := by
  rw [← ofParts_isPoison_getValue (add _ _ _)]
  simp only [add, add?,
    isPoison_ofParts_bind, isPoison_ite_poison,
    Bool.decide_and,
    Bool.decide_eq_true, isPoison_value, Bool.or_false]
  repeat rw [ofParts_getValue_bind_eq (by bv_decide)]



  conv in ofParts _ _ => {
    arg 1
    tactic => ac_nf
  }
  rw [ofParts_eq_iff]
  and_intros
  · ac_nf
  · simp only [Bool.or_eq_false_iff, and_imp]
    repeat rintro rfl
    simp

end OfParts

end LLVM
