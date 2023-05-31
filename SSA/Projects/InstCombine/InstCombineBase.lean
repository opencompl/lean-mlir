import SSA.Core.WellTypedFramework
import SSA.Core.Util
import SSA.Projects.InstCombine.ForMathlib

namespace InstCombine

-- allow to create constants of width 0 too, so that type unification doesn't fail because of coercionbbrev Width := ℕ+
-- abbrev Width := ℕ+
-- instance {n : Nat} [inst : NeZero n] : OfNat Width n where
--   ofNat := ⟨n, (by have h : n ≠ 0 := inst.out; cases n <;> aesop )⟩

inductive BaseType
  | bitvec (w : Nat) : BaseType
  deriving DecidableEq

instance {w : Nat} : Inhabited BaseType := ⟨BaseType.bitvec w⟩

@[simp]
def Bitvec.width {n : Nat} (_ : Bitvec n) : Nat := n

instance : Goedel BaseType where
toType := fun
  | .bitvec w => Bitvec w

abbrev UserType := SSA.UserType BaseType

/--
    eq: yields true if the operands are equal, false otherwise. No sign interpretation is necessary or performed.
    ne: yields true if the operands are unequal, false otherwise. No sign interpretation is necessary or performed.
    ugt: interprets the operands as unsigned values and yields true if op1 is greater than op2.
    uge: interprets the operands as unsigned values and yields true if op1 is greater than or equal to op2.
    ult: interprets the operands as unsigned values and yields true if op1 is less than op2.
    ule: interprets the operands as unsigned values and yields true if op1 is less than or equal to op2.
    sgt: interprets the operands as signed values and yields true if op1 is greater than op2.
    sge: interprets the operands as signed values and yields true if op1 is greater than or equal to op2.
    slt: interprets the operands as signed values and yields true if op1 is less than op2.
    sle: interprets the operands as signed values and yields true if op1 is less than or equal to op2.
-/
inductive Comparison
    | eq -- equal
    | ne -- not equal
    | ugt -- unsigned greater than
    | uge --  unsigned greater or equal
    | ult -- unsigned less than
    | ule -- unsigned less or equal
    | sgt -- signed greater than
    | sge -- signed greater or equal
    | slt -- signed less than
    | sle -- signed less or equal
  deriving Repr, DecidableEq

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
| and (w : Nat) : Op
| or (w : Nat) : Op
| not (w : Nat) : Op
| xor (w : Nat) : Op
| shl (w : Nat) : Op
| lshr (w : Nat) : Op
| ashr (w : Nat) : Op
| select (w : Nat) : Op
| add (w : Nat) : Op
| mul (w : Nat) : Op
| sub (w : Nat) : Op
| sdiv (w : Nat) : Op
| udiv (w : Nat) : Op
| icmp (c : Comparison) (w : Nat) : Op
| const {w : Nat} (val : Bitvec w) : Op
deriving Repr, DecidableEq

@[simp, reducible]
def argUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.add w | Op.mul w | Op.sub w | Op.udiv w | Op.sdiv w | Op.icmp _ w =>
  .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.not w => .base (BaseType.bitvec w)
| Op.select w => .triple (.base (BaseType.bitvec 1)) (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.const _ => .unit

@[simp, reducible]
def outUserType : Op → UserType
| Op.and w | Op.or w | Op.not w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.sub w |  Op.select w =>
  .base (BaseType.bitvec w)
 -- @goens: please keep this 'bitvec', and model the option inside it, because
 -- that is how it works in LLVM (and in Alive). The type is that of bit vectors,
 -- and bitvectors might have poison (ie, a special bottom / .none value.)
| Op.add w | Op.mul w |  Op.sdiv w | Op.udiv w  =>
  .base (BaseType.bitvec w)
| Op.icmp _ _ => .base (BaseType.bitvec 1)
| @Op.const width _ => .base (BaseType.bitvec width)

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

-- TODO: compare with LLVM semantics
-- TODO, @goens: Make everything take 'Option Bitvec', and handle the poison case.
@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
    | Op.and _ => uncurry Bitvec.and arg
    | Op.or _ => uncurry Bitvec.or arg
    | Op.xor _ => uncurry Bitvec.xor arg
    | Op.shl _ => match arg with
      | (arg₁,arg₂) => Bitvec.shl arg₁ arg₂.toNat
    | Op.lshr _ => match arg with
      | (arg₁,arg₂) => Bitvec.ushr arg₁ arg₂.toNat
    | Op.ashr _ => match arg with
      | (arg₁,arg₂) => Bitvec.sshr arg₁ arg₂.toNat
    | Op.const c => c
    | Op.sub _ => (uncurry Bitvec.sub arg)
    | Op.add _ => sorry  --(uncurry Bitvec.add? arg)
    | Op.mul _ => sorry  --(uncurry Bitvec.mul? arg)
    | Op.sdiv _ => sorry  --(uncurry Bitvec.sdiv? arg)
    | Op.udiv _ => sorry -- (uncurry Bitvec.udiv? arg)
    | _ => sorry

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

/-- Create a bitvector in the two's complement representation from an `int`
  We need such a coercion to keep the bit-width the same, as compared to the
  Mathlib version which adds an extra bit!
  @goens: can you figure out how to do this properly? Once again,
  the API I define below is what I would expect in LLVM!
-/
-- protected def ofInt : ∀ n : ℕ, Int → Bitvec (succ n)
def Bitvec.ofInt' (n : ℕ) (i : Int) : Bitvec n :=
  Bitvec.ofNat n (Int.toNat i)


/-
Optimization: InstCombineShift: 279
  %Op0 = lshr %X, C
  %r = shl %Op0, C
=>
  %r = and %X, (-1 << C)
-/

open EDSL
syntax "add" term : dsl_op
syntax "and" term : dsl_op
syntax "const" term : dsl_op
syntax "lshr" term : dsl_op
syntax "not" term : dsl_op
syntax "or" term : dsl_op
syntax "shl" term : dsl_op
syntax "sub" term : dsl_op
syntax "xor" term : dsl_op
macro_rules
  | `([dsl_op| add $w ]) => `(Op.add $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| const $w ]) => `(Op.const $w)
  | `([dsl_op| lshr $w ]) => `(Op.lshr $w)
  | `([dsl_op| not $w ]) => `(Op.not $w)
  | `([dsl_op| or $w ]) => `(Op.or $w)
  | `([dsl_op| shl $w ]) => `(Op.shl $w)
  | `([dsl_op| sub $w ]) => `(Op.sub $w)
  | `([dsl_op| xor $w ]) => `(Op.xor $w)
  
end InstCombine
