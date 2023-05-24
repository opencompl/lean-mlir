import SSA.Core.WellTypedFramework
import SSA.Core.Util

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

structure BitVector (width : Width) where
  (bits : LengthIndexedList Bool width)
  deriving Repr, DecidableEq

@[simp]
def BitVector.width {width : Width} (_ : BitVector width) : Width := width

instance (width : Width) : Inhabited (BitVector width) :=
  ⟨⟨by convert LengthIndexedList.fromList (List.replicate width true); simp⟩⟩

def BitVectorFun {width : Width} := Fin width.val → Bool

def BitVectorFun.fromList {width : Width} (l : LengthIndexedList Bool width.val) : @BitVectorFun width :=
  fun i => l[i]

def BitVectorFun.fromBitVector {width : Width} (bv : BitVector width) : @BitVectorFun width :=
  BitVectorFun.fromList bv.bits

def BitVectorFun.toList {width : Width} (f : @BitVectorFun width) : LengthIndexedList Bool width.val :=
  let indices := LengthIndexedList.finRange width.val
  indices.map f

def BitVectorFun.toBitVector {width : Width} (f : @BitVectorFun width) : BitVector width := ⟨BitVectorFun.toList f⟩

instance {width : Width} : Coe (@BitVectorFun width) (BitVector width) := ⟨BitVectorFun.toBitVector⟩
instance {width : Width} : Coe (BitVector width) (@BitVectorFun width) := ⟨BitVectorFun.fromBitVector⟩

theorem BitVectorFun.toListFromList {width : Width} (l : LengthIndexedList Bool width.val) :
  BitVectorFun.toList (BitVectorFun.fromList l) = l := by
    simp [BitVectorFun.toList, BitVectorFun.fromList]
    sorry

theorem BitVectorFun.toBitVectorFromBitVector {width : Width} (l : BitVector width) :
  BitVectorFun.toBitVector (BitVectorFun.fromBitVector l) = l := by
  simp [BitVectorFun.toBitVector, BitVectorFun.fromBitVector]
  try apply BitVectorFun.toListFromList
  sorry

def nextSignificantBit (val : Nat) (b : Bool) := 2 * val + if (b = true) then 1 else 0

def RawBitVectorVal {w : Width} (x : LengthIndexedList Bool w) : Nat :=
  x.foldl nextSignificantBit 0

def BitVector.asRawUInt {w : Width} (x : BitVector w) : Nat :=
  RawBitVectorVal x.bits

def BitVector.asUInt {w : Width} (x : BitVector w) : (Fin $ 2^w) :=
  ⟨x.asRawUInt, sorry⟩

def BitVector.twosCompliment {w : Width} (x : BitVector w) : Int :=
  match w, x.bits with
    | ⟨.succ n, _⟩, .cons s rest  =>
      let sign := if s = true then -1 else 1
      if h : n > 0 then
        let abs : BitVector ⟨n, h⟩ := ⟨rest⟩
        sign * (2^w.val - abs.asRawUInt)
      else
        0

def BitVector.asSInt {w : Width} (x : BitVector w) : Int :=
  x.twosCompliment

theorem nextSignificantBitTrue {val : Nat} : nextSignificantBit val true = 2 * val + 1 := by
  simp [nextSignificantBit]

theorem nextSignificantBitFalse {val : Nat} : nextSignificantBit val false = 2 * val := by
  simp [nextSignificantBit]

theorem RawBitVectorFalse {w : Width} {x : LengthIndexedList Bool w} :
  (LengthIndexedList.cons false x).foldl nextSignificantBit 0 = x.foldl nextSignificantBit 0 := by simp[LengthIndexedList.foldl, nextSignificantBitFalse]

theorem foldNextSignificantBit {w : Nat} {x : LengthIndexedList Bool w} {v : Nat} :
  x.foldl nextSignificantBit n = 2^w + x.foldl nextSignificantBit 0 := sorry


-- theorem RawBitVectorValGrowth {w : Width} (x : LengthIndexedList Bool (w - 1)) : ∀ b : Bool, RawBitVectorVal (x.cons b) ≤ 2 * RawBitVectorVal x + 1 := by
--   intro b; cases b with
--    | false => simp [RawBitVectorVal]; rw [Nat.two_mul]
--               apply Nat.le_add_left
--    | true => simp [RawBitVectorVal]; unfold LengthIndexedList.foldl <;> cases w


theorem BitVector.valRawLT {w : Width} (x : LengthIndexedList Bool w) : RawBitVectorVal x < 2^w := by
  simp [RawBitVectorVal]
  sorry

def BitVector.unsigned {w : Width} (x : BitVector w) : Fin (2^w) :=
  ⟨x.asRawUInt, BitVector.valRawLT x.bits⟩

instance : Goedel BaseType where
toType := fun
  | .bitvec w => BitVector w
  | .poison => Unit
  | .ub => Unit

abbrev UserType := SSA.UserType BaseType



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
| const (val : BitVector w) : Op
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
| Op.const c => .base (BaseType.bitvec c.width)

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

theorem Nat.zero_lt_pow {m n : Nat} : (0 < n) → 0 < n^m := by
induction m with
| zero => simp
| succ m ih =>
  intro h
  rw [Nat.pow_succ]
  exact Nat.mul_pos (ih h) h

theorem _root_.PNat.zero_lt_pow_2 {w : Width} : 0 < 2^w.val := by
have h : 0 < 2 := Nat.zero_lt_succ 1
exact @Nat.zero_lt_pow w.val 2 h

def _root_.PNat.nat_pow (n : Nat) (w : Width) : Nat :=
n ^ w

theorem Nat.gt_of_lt {a b : Nat} : a < b → b > a := by simp

def _root_.Nat.toFinPNat (n : Nat) (w : Width) : Fin (2^w.val) :=
 { val := n % (2^w), isLt := (Nat.mod_lt n w.zero_lt_pow_2) }

def _root_.Fin.toBitVectorFun {w : Width} (x : Fin (2^w.val)) : @BitVectorFun w :=
  fun i => x.val.testBit i.val

def _root_.Fin.toBitVector {w : Width} (x : Fin (2^w.val)) : BitVector w :=
  x.toBitVectorFun.toBitVector

def _root_.Int.toBitVector {w : Width} (x : Int) : BitVector w :=
   Nat.toFinPNat x.natAbs w |>.toBitVector

def BitVector.and {w : Width} (x y : BitVector w) : BitVector w := x.asUInt &&& y.asUInt |>.toBitVector
def BitVector.or {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ||| y.asUInt |>.toBitVector
def BitVector.xor {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ^^^ y.asUInt |>.toBitVector
def BitVector.shl {w : Width} (x y : BitVector w) : BitVector w := x.asUInt <<< y.asUInt |>.toBitVector
def BitVector.lshr {w : Width} (x y : BitVector w) : BitVector w := x.asUInt >>> y.asUInt |>.toBitVector
def BitVector.ashr {w : Width} (x y : BitVector w) : BitVector w := default -- x.twosCompliment >>> y.twosCompliment |>.toBitVector

def BitVector.add {w : Width} (x y : BitVector w) : Option $ BitVector w :=
  let res := x.asUInt.1 + y.asUInt.1
  if h : res < 2^w then
    some (⟨res, h⟩ : Fin (2^w)).toBitVector
  else
    none

def BitVector.mul {w : Width} (x y : BitVector w) : Option $ BitVector w :=
  let res := x.asUInt.1 * y.asUInt.1
  if h : res < 2^w then
    some (⟨res, h⟩ : Fin (2^w)).toBitVector
  else
    none

/--
The value produced is the integer difference of the two operands.
If the difference has unsigned overflow, the result returned is the mathematical result modulo 2ⁿ, where n is the bit width of the result.
Because LLVM integers use a two’s complement representation, this instruction is appropriate for both signed and unsigned integers.
-/
def BitVector.sub {w : Width} (x y : BitVector w) : BitVector w := x.asUInt - y.asUInt |>.toBitVector

/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
def BitVector.udiv {w : Width} (x y : BitVector w) : Option $ BitVector w :=
  if y.asUInt ≠ 0 then
    some $ x.asUInt / y.asUInt |>.toBitVector
  else
    none


/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.
-/
def BitVector.sdiv {w : Width} (x y : BitVector w) : Option $ BitVector w := panic! -- TODO

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
def BitVector.icmp {w : Width} (c : Comparison) (x y : BitVector w) : BitVector 1 :=
  match c with
  | .eq => if x.asUInt = y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .ne => if x.asUInt ≠ y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .ugt => if x.asUInt > y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .uge => if x.asUInt ≥ y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .ult => if x.asUInt < y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .ule => if x.asUInt ≤ y.asUInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .sgt => if x.asSInt > y.asSInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .sge => if x.asSInt ≥ y.asSInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .slt => if x.asSInt < y.asSInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩
  | .sle => if x.asSInt ≤ y.asSInt then ⟨LengthIndexedList.fromList [true]⟩ else ⟨LengthIndexedList.fromList [false]⟩


/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def BitVector.select {w : Width} (c : BitVector 1) (x y : BitVector w) : BitVector w :=
    if c.bits = LengthIndexedList.fromList [true] then x else y

@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
    | Op.and _ => uncurry BitVector.and arg
    | Op.or _ => uncurry BitVector.or arg
    | Op.xor _ => uncurry BitVector.xor arg
    | Op.shl _ => uncurry BitVector.shl arg
    | Op.lshr _ => uncurry BitVector.lshr arg
    | Op.ashr _ => uncurry BitVector.ashr arg
    | Op.const c => c
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
