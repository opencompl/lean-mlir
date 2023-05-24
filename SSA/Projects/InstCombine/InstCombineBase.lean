import SSA.Core.WellTypedFramework
import SSA.Core.Util
import SSA.Projects.InstCombine.ForMathlib

namespace InstCombine

abbrev Width := ℕ+

instance {n : Nat} [inst : NeZero n] : OfNat Width n where
  ofNat := ⟨n, (by have h : n ≠ 0 := inst.out; cases n <;> aesop )⟩

inductive BaseType
  | bitvec (w : Width) : BaseType
  | poison : BaseType
  | ub : BaseType
  deriving DecidableEq

instance {w : Width} : Inhabited BaseType := ⟨BaseType.bitvec w⟩

@[simp]
def Bitvec.width {n : Nat} [hNeZero : NeZero n] (_ : Bitvec n) : Width := ⟨n, by sorry⟩



instance : Goedel BaseType where
toType := fun
  | .bitvec w => Bitvec w
  | .poison => Unit
  | .ub => Unit

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
| and (w : Width) : Op
| or (w : Width) : Op
| xor (w : Width) : Op
| shl (w : Width) : Op
| lshr (w : Width) : Op
| ashr (w : Width) : Op
| select (w : Width) : Op
| add (w : Width) : Op
| mul (w : Width) : Op
| sub (w : Width) : Op
| sdiv (w : Width) : Op
| icmp (c : Comparison) (w : Width) : Op
| const {w : Width} (val : Bitvec w) : Op
deriving Repr, DecidableEq

@[simp, reducible]
def argUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.add w | Op.mul w | Op.sub w | Op.sdiv w | Op.icmp _ w =>
  .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.select w => .triple (.base (BaseType.bitvec 1)) (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.const _ => .unit

@[simp, reducible]
def outUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.add w | Op.mul w | Op.sub w | Op.sdiv w | Op.select w =>
  .base (BaseType.bitvec w)
| Op.icmp _ _ => .base (BaseType.bitvec 1)
| @Op.const width _ => .base (BaseType.bitvec width)

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

-- TODO: compare with LLVM semantics
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
    | Op.sub _ => uncurry Bitvec.sub arg
    | Op.add _ => uncurry Bitvec.add arg
    | Op.mul _ => uncurry Bitvec.mul arg
    | _ => sorry

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

/-
Optimization: InstCombineShift: 279
  %Op0 = lshr %X, C
  %r = shl %Op0, C
=>
  %r = and %X, (-1 << C)
-/

open EDSL
syntax "lshr" term : dsl_op
syntax "shl" term : dsl_op
syntax "and" term : dsl_op
syntax "const" term : dsl_op
macro_rules
  | `([dsl_op| lshr $w ]) => `(Op.lshr $w)
  | `([dsl_op| shl $w ]) => `(Op.shl $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| const $w ]) => `(Op.const $w)

end InstCombine
