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

instance : Repr BaseType where 
  reprPrec 
    | .bitvec w, _ => "i" ++ repr w

instance {w : Nat} : Inhabited BaseType := ⟨BaseType.bitvec w⟩

@[simp]
def Bitvec.width {n : Nat} (_ : Bitvec n) : Nat := n

instance : Goedel BaseType where
toType := fun
  | .bitvec w => Option $ Bitvec w

instance : Repr (Bitvec n) where
  reprPrec
    | v, n => reprPrec (Bitvec.toInt v) n

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
| urem (w : Nat) : Op
| srem (w : Nat) : Op
| select (w : Nat) : Op
| add (w : Nat) : Op
| mul (w : Nat) : Op
| sub (w : Nat) : Op
| neg (w: Nat) : Op
| copy (w: Nat) : Op
| sdiv (w : Nat) : Op
| udiv (w : Nat) : Op
| icmp (c : Comparison) (w : Nat) : Op
| const {w : Nat} (val : Bitvec w) : Op
deriving Repr, DecidableEq

@[simp, reducible]
def argUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.add w | Op.mul w | Op.sub w | Op.udiv w | Op.sdiv w 
| Op.srem w | Op.urem w | Op.icmp _ w =>
  .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.not w | Op.neg w | Op.copy w => .base (BaseType.bitvec w)
| Op.select w => .triple (.base (BaseType.bitvec 1)) (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.const _ => .unit

@[simp, reducible]
def outUserType : Op → UserType
| Op.and w | Op.or w | Op.not w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.sub w |  Op.select w | Op.neg w | Op.copy w =>
  .base (BaseType.bitvec w)
| Op.add w | Op.mul w |  Op.sdiv w | Op.udiv w | Op.srem w | Op.urem w =>
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
    | Op.and _ => pairMapM (.&&&.) arg
    | Op.or _ => pairMapM (.|||.) arg
    | Op.xor _ => pairMapM (.^^^.) arg
    | Op.shl _ => pairMapM (fun fst snd => Bitvec.shl fst snd.toNat) arg
    | Op.lshr _ => pairMapM (fun fst snd => Bitvec.ushr fst snd.toNat) arg
    | Op.ashr _ => pairMapM (fun fst snd => Bitvec.sshr fst snd.toNat) arg
    | Op.const c => Option.some c
    | Op.sub _ => pairMapM (.-.) arg
    | Op.add _ => pairMapM (.+.) arg
    | Op.mul _ => pairMapM (.*.) arg
    | Op.sdiv _ => pairBind Bitvec.sdiv? arg
    | Op.udiv _ => pairBind Bitvec.udiv? arg
    | Op.urem _ => pairBind Bitvec.urem? arg
    | Op.srem _ => pairBind Bitvec.srem? arg
    | Op.not _ => Option.map (~~~.) arg
    | Op.copy _ => arg
    | Op.neg _ => Option.map (-.) arg
    | Op.select _ => tripleMapM Bitvec.select arg
    | Op.icmp c _ => match c with
      | Comparison.eq => pairMapM (fun x y => ↑(x == y)) arg
      | Comparison.ne => pairMapM (fun x y => ↑(x != y)) arg
      | Comparison.sgt => pairMapM (fun x y => ↑(decide $ x.toInt > y.toInt)) arg
      | Comparison.sge => pairMapM (fun x y => ↑(decide $ x.toInt ≥ y.toInt)) arg
      | Comparison.slt => pairMapM (fun x y => ↑(decide $ x.toInt < y.toInt)) arg
      | Comparison.sle => pairMapM (fun x y => ↑(decide $ x.toInt ≤ y.toInt)) arg
      | Comparison.ugt => pairMapM (fun x y => ↑(decide $ x.toNat > y.toNat)) arg
      | Comparison.uge => pairMapM (fun x y => ↑(decide $ x.toNat ≥ y.toNat)) arg
      | Comparison.ult => pairMapM (fun x y => ↑(decide $ x.toNat < y.toNat)) arg
      | Comparison.ule => pairMapM (fun x y => ↑(decide $ x.toNat ≤ y.toNat)) arg


instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

open EDSL
syntax "add" term : dsl_op
syntax "and" term : dsl_op
syntax "const" term : dsl_op
syntax "lshr" term : dsl_op
syntax "ashr" term : dsl_op
syntax "not" term : dsl_op
syntax "or" term : dsl_op
syntax "shl" term : dsl_op
syntax "sub" term : dsl_op
syntax "xor" term : dsl_op
syntax "neg" term : dsl_op
syntax "copy" term : dsl_op
syntax "mul" term : dsl_op
syntax "sdiv" term : dsl_op
syntax "udiv" term : dsl_op
syntax "urem" term : dsl_op
syntax "srem" term : dsl_op
syntax "select" term : dsl_op
syntax "icmp eq" term : dsl_op
syntax "icmp ne" term : dsl_op
syntax "icmp ugt" term : dsl_op
syntax "icmp uge" term : dsl_op
syntax "icmp ult" term : dsl_op
syntax "icmp ule" term : dsl_op
syntax "icmp sgt" term : dsl_op
syntax "icmp sge" term : dsl_op
syntax "icmp slt" term : dsl_op
syntax "icmp sle" term : dsl_op

macro_rules
  | `([dsl_op| add $w ]) => `(Op.add $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| const $w ]) => `(Op.const $w)
  | `([dsl_op| lshr $w ]) => `(Op.lshr $w)
  | `([dsl_op| ashr $w ]) => `(Op.ashr $w)
  | `([dsl_op| not $w ]) => `(Op.not $w)
  | `([dsl_op| or $w ]) => `(Op.or $w)
  | `([dsl_op| shl $w ]) => `(Op.shl $w)
  | `([dsl_op| sub $w ]) => `(Op.sub $w)
  | `([dsl_op| xor $w ]) => `(Op.xor $w)
  | `([dsl_op| neg $w ]) => `(Op.neg $w)
  | `([dsl_op| copy $w ]) => `(Op.copy $w)
  | `([dsl_op| sdiv $w ]) => `(Op.sdiv $w)
  | `([dsl_op| udiv $w ]) => `(Op.udiv $w)
  | `([dsl_op| urem $w ]) => `(Op.urem $w)
  | `([dsl_op| srem $w ]) => `(Op.urem $w)
  | `([dsl_op| mul $w ]) => `(Op.mul $w)
  | `([dsl_op| select $w ]) => `(Op.select $w)
  | `([dsl_op| icmp eq $w ]) => `(Op.icmp Comparison.eq $w)
  | `([dsl_op| icmp ne $w ]) => `(Op.icmp Comparison.ne $w)
  | `([dsl_op| icmp ugt $w ]) => `(Op.icmp Comparison.ugt $w)
  | `([dsl_op| icmp uge $w ]) => `(Op.icmp Comparison.uge $w)
  | `([dsl_op| icmp ult $w ]) => `(Op.icmp Comparison.ult $w)
  | `([dsl_op| icmp ule $w ]) => `(Op.icmp Comparison.ule $w)
  | `([dsl_op| icmp sgt $w ]) => `(Op.icmp Comparison.sgt $w)
  | `([dsl_op| icmp sge $w ]) => `(Op.icmp Comparison.sge $w)
  | `([dsl_op| icmp slt $w ]) => `(Op.icmp Comparison.slt $w)
  | `([dsl_op| icmp sle $w ]) => `(Op.icmp Comparison.sle $w)

end InstCombine
